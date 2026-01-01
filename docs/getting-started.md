# Getting Started with bonsai

This guide will help you set up a minimal OpenBSD desktop environment using bonsai.

## Prerequisites

- OpenBSD 7.4 or later (tested on 7.7+)
- Root access or doas configured
- Internet connection for package installation

## Installation

### Quick Install

```sh
curl -fsSL https://raw.githubusercontent.com/raffaelschneider/bonsai/main/install.sh | sh
```

### Manual Install

```sh
git clone https://github.com/raffaelschneider/bonsai.git ~/bonsai
chmod +x ~/bonsai/bonsai.pl
echo 'export PATH="$PATH:$HOME/bonsai"' >> ~/.profile
```

## First Run

### Option 1: Interactive Setup (Recommended for beginners)

```sh
bonsai.pl --interactive
```

This will prompt you for each setting:
1. Window manager preference
2. Shell choice
3. Browser selection
4. Color theme
5. Display settings

Your choices are saved to `~/.config/bonsai/config.conf`.

### Option 2: Preview First

```sh
bonsai.pl --dry-run
```

This shows what would be installed and configured without making changes.

### Option 3: Default Setup

```sh
bonsai.pl
```

Runs with defaults (cwm, ksh, firefox, nord theme).

## After Setup

1. **Start X**: Run `startx` or enable xenodm for graphical login
2. **Reload shell**: Log out and back in, or run your shell's reload command
3. **Apply Xresources**: Run `xrdb -merge ~/.Xresources`

## Verifying Installation

Check your window manager:
```sh
cat ~/.xinitrc
```

Check installed packages:
```sh
pkg_info | grep -E 'firefox|vim|tmux'
```

Check your shell:
```sh
echo $SHELL
```

## Next Steps

- Read [Customization Guide](customization.md) for tweaking your setup
- See [Troubleshooting](troubleshooting.md) if you encounter issues
- Check [Module Reference](modules.md) for detailed module documentation
