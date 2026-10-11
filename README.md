# PolePlex

A minimalist Arch Linux AUR package downloader built for speed, simplicity, and convenience.

PolePlex helps you search for, inspect, download, and update AUR packages without the overhead of larger package managers.

## Features

- Search AUR packages with `poleplex s <term>`
- View package metadata with `poleplex i <pkg>`
- Download packages with `poleplex d <pkg>` or just `poleplex <pkg>`
- Remove cached packages with `poleplex r <pkg>`
- Update all downloaded packages with `poleplex u`
- Use git clone or tarball fallback for downloads
- Works with short commands: `s`, `i`, `d`, `r`, `u`
- Colorized output with verbose and quiet modes
- Configurable via `~/.config/poleplex/poleplex.conf`

## Requirements

PolePlex depends on:

- `curl`
- `git`
- `tar`

These are typically available as part of the Arch `base-devel` group.

## Quick install

### Install directly from GitHub

```bash
curl -fsSL https://raw.githubusercontent.com/RidelLazor/PolePlex/master/install.sh | bash
```

This installs PolePlex to the system default prefix and makes the `poleplex` command available immediately.

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

To install to a custom prefix:

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

To uninstall from a custom prefix:

```bash
PREFIX=~/.local bash uninstall.sh
```

## Usage

```text
Usage: poleplex <command> [options] [package]...

Commands:
  s, search  <term>     Search AUR for packages
  i, info    <pkg>      Show detailed package info
  d, download <pkg>     Download a package from AUR (default)
  r, remove  <pkg>      Remove a downloaded package from cache
  u, update  [dir]      Update all downloaded packages
  h, help               Show this help message
  V, version            Show version

Options:
  -p, --path <dir>      Download/remove from specific directory
  -t, --tarball         Use tarball instead of git clone
  -v, --verbose         Verbose output
  -q, --quiet           Suppress color and info output
```

## Examples

```bash
# Search AUR
poleplex s firefox

# View package info
poleplex i spotify

# Download a package
poleplex d yay
poleplex yay

# Download multiple packages to a specific directory
poleplex d -p ~/aur yay paru

# Remove a downloaded package
poleplex r yay

# Use tarball instead of git clone
poleplex d -t firefox-developer

# Update all previously downloaded packages
poleplex u

# Legacy flags still work
poleplex -s firefox
poleplex -i spotify
poleplex -p ~/builds yay paru
poleplex -u
```

## Configuration

Create `~/.config/poleplex/poleplex.conf` to override defaults:

```bash
# Default download directory
BUILD_DIR="$HOME/aur"

# Use tarball by default
CLONE_MODE=false
```

## Project structure

```text
PolePlex/
├── poleplex            # Main executable
├── PKGBUILD            # AUR package definition
├── poleplex.install    # Install scriptlet
├── install.sh          # One-line installer
├── uninstall.sh        # One-line uninstaller
├── Makefile            # System installation targets
├── LICENSE             # MIT license
├── README.md           # Project documentation
├── docs/               # GitHub Pages content
│   ├── index.html
│   └── install.sh
├── completions/        # Shell completions
│   ├── poleplex.bash
│   ├── poleplex.zsh
│   └── poleplex.fish
├── man/                # Man page
│   └── poleplex.1
└── .gitignore
```

## License

MIT

## Repository

- GitHub: https://github.com/RidelLazor/PolePlex
