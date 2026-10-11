# PolePlex

PolePlex is a small, practical tool for Arch Linux users who want a faster way to browse and install AUR packages without the extra baggage of bigger package managers.

It lets you search the AUR, inspect package details, download package sources, build them locally, and install them when you want.

If you like a simple workflow and want to keep things lightweight, PolePlex is meant to feel straightforward and easy to use.

## Why use PolePlex?

- Search AUR packages quickly
- View package info before you install
- Download packages to a local build directory
- Build and install packages with a single command
- Keep things simple without a heavy dependency stack
- Work well in a shell-first workflow

## Requirements

PolePlex depends on:

- `curl`
- `git`
- `tar`
- `makepkg` / `base-devel` for building packages

On Arch Linux, the usual setup is:

```bash
sudo pacman -S base-devel git curl tar
```

## Install

### Quick install from GitHub

```bash
curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/master/install.sh | bash
```

This installs PolePlex to the default system prefix so the `poleplex` command is ready to use.

### Install to a custom prefix

```bash
curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/master/install.sh | PREFIX=~/.local bash
```

### Install from source

```bash
git clone https://github.com/RidelLazor/PolePlex.git
cd PolePlex
sudo make install
```

Or with a custom prefix:

```bash
make install PREFIX=~/.local
```

### Install from AUR

```bash
yay -S poleplex
# or
paru -S poleplex
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/master/uninstall.sh | bash
```

If you installed it with a custom prefix:

```bash
PREFIX=~/.local bash uninstall.sh
```

## Basic usage

```text
Usage: poleplex <command> [options] [package]...

Commands:
  s, search  <term>     Search AUR for packages
  i, info    <pkg>      Show detailed package info
  d, download <pkg>     Download a package from AUR (default)
  b, build   <pkg>      Download and build a package with makepkg
  x, install <pkg>      Download, build, and install a package
  r, remove  <pkg>      Remove a downloaded package from cache
  u, update  [dir]      Update all downloaded packages
  h, help               Show this help message
  V, version            Show version

Options:
  -p, --path <dir>      Download/remove from a specific directory
  -t, --tarball         Use tarball instead of git clone
  -v, --verbose         Show extra debug output
  -q, --quiet           Suppress color and information output
```

## Examples

Search for a package:

```bash
poleplex s firefox
```

Check package details:

```bash
poleplex i spotify
```

Download a package without installing it:

```bash
poleplex d yay
```

Build a package locally:

```bash
poleplex b yay
```

Build and install a package straight away:

```bash
poleplex x yay
```

Remove a downloaded package from your cache:

```bash
poleplex r yay
```

Update everything in your build directory:

```bash
poleplex u
```

Use a custom download directory:

```bash
poleplex d -p ~/aur yay paru
```

Prefer tarballs instead of git clone:

```bash
poleplex d -t firefox-developer
```

## Configuration

You can create a config file at:

```bash
~/.config/poleplex/poleplex.conf
```

Example:

```bash
# Default download directory
BUILD_DIR="$HOME/aur"

# Use tarball by default
CLONE_MODE=false
```

## How it works

PolePlex uses the AUR RPC API to search for packages and inspect metadata. When you download a package, it either:

- clones the AUR git repository, or
- falls back to the AUR tarball snapshot

If you want to actually install the package, `poleplex x <pkg>` will build it with `makepkg` and install it with `pacman -U`.

This keeps the workflow simple while still matching the usual Arch Linux build process.

## Project structure

```text
PolePlex/
├── poleplex            # Main executable
├── PKGBUILD            # AUR package definition
├── poleplex.install    # Install scriptlet
├── install.sh          # One-line installer
├── uninstall.sh        # One-line uninstaller
├── Makefile            # install/uninstall targets
├── LICENSE             # MIT license
├── README.md           # Project docs
├── docs/               # GitHub Pages files
│   ├── index.html
│   └── install.sh
├── completions/        # Shell completions
│   ├── poleplex.bash
│   ├── poleplex.zsh
│   └── poleplex.fish
├── man/                # Man page
│   └── poleplex.1
├── .gitignore
└── .github/
```

## License

MIT

## Repository

- GitHub: https://github.com/RidelLazor/PolePlex
