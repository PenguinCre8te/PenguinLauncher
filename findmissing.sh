#!/usr/bin/bash
DEB_WORKSPACE="${DEB_WORKSPACE:-.}"
TARGET_LIB_DIR="${DEB_WORKSPACE}/usr/shared/lib"

echo "Checking for files in: $TARGET_LIB_DIR"
echo "--------------------------------------------------"

# Array of all the file patterns from your cleanup list
lib_patterns=(
    # Core C/C++ libraries
    "libc.so.*" "libpthread.so.*" "libdl.so.*" "libm.so.*" "librt.so.*"
    "libsystemd.so.*" "libcap.so.*" "libstdc++.so.*" "libgcc_s.so.*"
    
    # Glib, DBus, and core infrastructure utils
    "libglib-2.0.so.*" "libgmodule-2.0.so.*" "libgobject-2.0.so.*" "libgio-2.0.so.*"
    "libdbus-1.so.*" "libffi.so.*" "libselinux.so.*" "libuuid.so.*" "libacl.so.*" "libblkid.so.*" "libmount.so.*"
    
    # X11, Wayland, and UI Layout definitions
    "libX11.so.*" "libX11-xcb.so.*" "libxcb*.so.*" "libXau.so.*" "libXdmcp.so.*"
    "libwayland*.so.*" "libxkbcommon*.so.*" "libICE.so.*" "libSM.so.*"
    
    # Graphics stacks (Mesa/DRM/Font rendering)
    "libGL*.so.*" "libEGL.so.*" "libOpenGL.so.*" "libgbm.so.*" "libdrm.so.*"
    "libfontconfig.so.*" "libfreetype.so.*"
    
    # Formats, Cryptography, and Archive compressions
    "libz*.so.*" "liblzma.so.*" "liblz4.so.*" "libbz2.so.*"
    "libpng*.so.*" "libjpeg.so.*" "libwebp*.so.*" "libtiff.so.*"
    "libxml2.so.*" "libarchive.so.*" "libexpat.so.*" "libgcrypt.so.*" "libgpg-error.so.*"
)

found_count=0
missing_count=0

# Ensure nullglob is on so unmatched patterns expand to nothing instead of the literal string
shopt -s nullglob

for pattern in "${lib_patterns[@]}"; do
    # Expand the pattern inside the target directory
    files=("$TARGET_LIB_DIR"/$pattern)
    
    if [ ${#files[@]} -gt 0 ]; then
        for file in "${files[@]}"; do
            echo "[FOUND]   $(basename "$file")"
            ((found_count++))
        done
    else
        echo "[MISSING] $pattern"
        ((missing_count++))
    fi
done