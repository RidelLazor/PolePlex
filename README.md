# PolePlex

A minimalist AUR package downloader. fast, simple, dependency-free beyond the basics.

## Features

- **Download AUR packages** via git clone (default) or tarball fallback
- **Search AUR** for packages — `poleplex s <term>`
- **View package info** — `poleplex i <pkg>`
- **Remove** downloaded packages — `poleplex r <pkg>`
- **Update all** downloaded packages — `poleplex u`
- **Short commands** — no dashes needed: `s`, `i`, `d`, `r`, `u`
- **Colorized output** with verbose and quiet modes
- **Configurable** via `~/.config/poleplex/poleplex.conf`

## Dependencies

- `curl` — for AUR RPC queries and tarball downloads
- `git` — for cloning AUR package repos
- `tar` — for extracting tarball fallback

All three are part of the `base-devel` group on Arch Linux.

## Installation

### One-liner (via GitHub Pages)

```bash
curl -fsSL https://anomalyco.github.io/poleplex/install.sh | bash
```

Installs to `~/poleplex`, adds to PATH. Run it again to update.

### From AUR

```bash
# Once PolePlex is on the AUR:
yay -S poleplex
# or
paru -S poleplex
```

### From source

```bash
git clone https://github.com/anomalyco/poleplex
cd poleplex
sudo make install
```

To install to a custom prefix:

```bash
make install PREFIX=~/.local
```

## Usage

```
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

### Examples

```bash
# Search AUR (short form)
poleplex s firefox

# View package info (short form)
poleplex i spotify

# Download a package (short form or bare name)
poleplex d yay
poleplex yay           # same thing, bare name = download

# Download multiple packages to a specific directory
poleplex d -p ~/aur yay paru

# Remove a downloaded package
poleplex r yay

# Use tarball instead of git clone
poleplex d -t firefox-developer

# Update all previously downloaded packages
poleplex u

# Old-style flags still work too:
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

## Project Structure

```
poleplex/
├── poleplex            # Main script
├── PKGBUILD            # AUR package definition
├── poleplex.install    # Install scriptlet for AUR package
├── Makefile            # Install/uninstall targets
├── LICENSE             # MIT License
├── README.md           # This file
├── docs/               # GitHub Pages (anomalyco.github.io/poleplex)
│   ├── index.html      # Landing page
│   └── install.sh      # Bootstrap installer
├── completions/        # Shell completion files
│   ├── poleplex.bash
│   ├── poleplex.zsh
│   └── poleplex.fish
└── man/
    └── poleplex.1      # Man page
```

## License

MIT
