<p align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/program_info/org.penguinlauncher.PenguinLauncher.logo-darkmode.svg">
  <source media="(prefers-color-scheme: light)" srcset="/program_info/org.penguinlauncher.PenguinLauncher.logo.svg">
  <img alt="Penguin Launcher" src="/program_info/org.penguinlauncher.PenguinLauncher.logo.svg" width="40%">
</picture>
</p>

<p align="center">
  Penguin Launcher is a custom launcher for Minecraft that allows you to easily manage multiple installations of Minecraft at once.<br />
  <br />This is a <b>fork</b> of the Prism Launcher and is <b>not</b> endorsed by it.
</p>

## Installation

- All downloads and instructions for Penguin Launcher can be found on our [Website](https://penguinlauncher.org/download).
- Last build status can be found in the [GitHub Actions](https://github.com/penguincre8te/PenguinLauncher/actions) tab (this also includes the pull requests status).

### Development Builds

Please understand that these builds are not intended for most users. There may be bugs, and other instabilities. You have been warned.

There are development builds available through:

- [GitHub Actions](https://github.com/penguincre8te/PenguinLauncher/actions) (includes builds from pull requests opened by contributors)
- [nightly.link](https://penguinlauncher.org/nightly) (this will always point only to the latest version of develop)

These have debug information in the binaries, so their file sizes are relatively larger.

Prebuilt Development builds are provided for **Linux**, **Windows** and **macOS**.

## Community & Support

Feel free to create a GitHub issue if you find a bug or want to suggest a new feature.

## Building

If you want to build Penguin Launcher yourself, check the [build instructions](https://penguinlauncher.org/wiki/development/build-instructions).

## Forking/Redistributing/Custom builds policy

You are free to fork, redistribute and provide custom builds as long as you follow the terms of the [license](LICENSE) (this is a legal responsibility), and if you made code changes rather than just packaging a custom build, please do the following as a basic courtesy:

- Make it clear that your fork is not Penguin Launcher and is not endorsed by or affiliated with the Penguin Launcher project (<https://penguinlauncher.org>).
- Go through [CMakeLists.txt](CMakeLists.txt) and change Penguin Launcher's API keys to your own or set them to empty strings (`""`) to disable them (this way the program will still compile but the functionality requiring those keys will be disabled).

If you have any questions or want any clarification on the above conditions please make an issue and ask us.

If you are just building Penguin Launcher for your distribution, please make sure to set the `Launcher_BUILD_PLATFORM` to a slug representing your distribution. Examples are `archlinux`, `fedora` and `nixpkgs`.

Note that if you build this software without removing the provided API keys in [CMakeLists.txt](CMakeLists.txt) you are accepting the following terms and conditions:

- [Microsoft Identity Platform Terms of Use](https://docs.microsoft.com/en-us/legal/microsoft-identity-platform/terms-of-use)
- [CurseForge 3rd Party API Terms and Conditions](https://support.curseforge.com/en/support/solutions/articles/9000207405-curse-forge-3rd-party-api-terms-and-conditions)

If you do not agree with these terms and conditions, then remove the associated API keys from the [CMakeLists.txt](CMakeLists.txt) file by setting them to an empty string (`""`).

## License [![https://github.com/penguincre8te/PenguinLauncher/blob/develop/LICENSE](https://img.shields.io/github/license/PenguinLauncher/PenguinLauncher?label=License&logo=gnu&color=C4282D)](LICENSE)

All launcher code is available under the GPL-3.0-only license.

The logo and related assets are under the CC BY-SA 4.0 license.
