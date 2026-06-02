#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
INSTALL_DIR="/opt/PenguinLauncher"
DESKTOP_ENTRY="org.penguinlauncher.PenguinLauncher.desktop"
API_URL="https://api.github.com/repos/PenguinCre8te/PenguinLauncher/releases/latest"

# Binary and Symlink paths
LAUNCHER_BIN="$INSTALL_DIR/bin/penguinlauncher"
UPDATER_BIN="$INSTALL_DIR/bin/penguinlauncher_updater"
LAUNCHER_LINK="/usr/bin/penguinlauncher"
UPDATER_LINK="/usr/bin/penguinlauncher_updater"

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script as root or with sudo." >&2
    exit 1
fi

# Ensure required dependencies are installed
for cmd in curl jq tar; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' is not installed." >&2
        exit 1
    fi
done

# Detect system architecture
ARCH=$(uname -m)
echo "Target architecture detected: $ARCH"

# Fetch release data from GitHub API
echo "Fetching latest release information from GitHub..."
API_RESPONSE=$(curl -s "$API_URL")

# Verify the API response contains valid asset data
if echo "$API_RESPONSE" | grep -q "message.*Not Found"; then
    echo "Error: Repository or release not found via GitHub API." >&2
    exit 1
fi

# Filter the appropriate download URL using jq based on architecture
if [ "$ARCH" = "x86_64" ]; then
    # Matches the standard x86_64 tarball (excludes aarch64)
    DOWNLOAD_URL=$(echo "$API_RESPONSE" | jq -r '.assets[] | select(.name | test("Linux-Qt6-Portable.*\\.tar\\.gz$")) | .browser_download_url')
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    # Matches the aarch64 tarball
    DOWNLOAD_URL=$(echo "$API_RESPONSE" | jq -r '.assets[] | select(.name | test("Linux-aarch64-Qt6-Portable.*\\.tar\\.gz$")) | .browser_download_url')
else
    echo "Error: Unsupported architecture ($ARCH). Only x86_64 and aarch64 are supported." >&2
    exit 1
fi

# Verify a URL was successfully extracted
if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" = "null" ]; then
    echo "Error: Could not find a matching download asset for architecture '$ARCH' in the latest release." >&2
    exit 1
fi

echo "Found asset URL: $DOWNLOAD_URL"

# Create a temporary directory for downloading and extracting
TMP_DIR=$(mktemp -d)
printf "Created temporary directory at %s\n" "$TMP_DIR"

# Clean up temporary directory on script exit
trap 'rm -rf "$TMP_DIR"' EXIT

# Download the tarball
echo "Downloading PenguinLauncher..."
curl -L "$DOWNLOAD_URL" -o "$TMP_DIR/launcher.tar.gz"

# Prepare the installation directory
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing installation at $INSTALL_DIR..."
    rm -rf "$INSTALL_DIR"
fi
mkdir -p "$INSTALL_DIR"

# Extract the archive directly into the installation directory
echo "Extracting archive to $INSTALL_DIR..."
tar -xzf "$TMP_DIR/launcher.tar.gz" -C "$INSTALL_DIR"

# Remove portable.txt to ensure system-wide behavior
if [ -f "$INSTALL_DIR/portable.txt" ]; then
    echo "Removing portable.txt..."
    rm "$INSTALL_DIR/portable.txt"
fi

# Configure and install the desktop entry
DESKTOP_SRC="$INSTALL_DIR/share/applications/$DESKTOP_ENTRY"
DESKTOP_DEST="/usr/share/applications/$DESKTOP_ENTRY"

if [ -f "$DESKTOP_SRC" ]; then
    echo "Installing desktop entry..."
    cp "$DESKTOP_SRC" "$DESKTOP_DEST"
    chmod 644 "$DESKTOP_DEST"
    
    # Update the Exec path in the .desktop file if it isn't fully qualified
    if grep -q "Exec=PenguinLauncher" "$DESKTOP_DEST"; then
        sed -i "s|Exec=PenguinLauncher|Exec=$LAUNCHER_BIN|g" "$DESKTOP_DEST"
    fi
else
    echo "Warning: Desktop entry file not found at $DESKTOP_SRC"
fi

# Make binaries executable
echo "Setting executable permissions..."
if [ -f "$LAUNCHER_BIN" ]; then
    chmod +x "$LAUNCHER_BIN"
else
    echo "Warning: Launcher binary not found at $LAUNCHER_BIN"
fi

if [ -f "$UPDATER_BIN" ]; then
    chmod +x "$UPDATER_BIN"
else
    echo "Warning: Updater binary not found at $UPDATER_BIN"
fi

# Create symbolic links in /usr/local/bin
echo "Creating symbolic links..."
if [ -f "$LAUNCHER_BIN" ]; then
    ln -sf "$LAUNCHER_BIN" "$LAUNCHER_LINK"
fi

if [ -f "$UPDATER_BIN" ]; then
    ln -sf "$UPDATER_BIN" "$UPDATER_LINK"
fi

echo "Installation completed successfully."