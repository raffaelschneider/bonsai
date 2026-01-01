# bonsai

**bonsai** is a minimalist setup tool for OpenBSD users who want a lean, cohesive daily-driving experience without repetitive configuration. Inspired by the suckless philosophy and curated for simplicity, **bonsai** configures only the essentials—no bloat, just a clean OpenBSD environment.

## Features

- **Modular Setup**: Configure window managers, shells, SSH key management, theming, Xorg, and more.
- **Dry Run Mode**: Preview changes before they're made with `--dry-run`.
- **Interactive Mode**: Choose your preferences with guided prompts using `--interactive`.
- **Config File Support**: Settings are saved to `~/.config/bonsai/config.conf` for reproducibility.
- **Multiple Shells**: Supports ksh (base), fish, zsh, and bash.
- **Color Themes**: Built-in Nord, Gruvbox, and Dracula themes for terminals.
- **Window Managers**: cwm (base), spectrwm, i3, dwm, bspwm, openbox.

## Installation

Install **bonsai** with a single command:

```sh
curl -fsSL https://raw.githubusercontent.com/raffaelschneider/bonsai/main/install.sh | sh
```

This will:
- Clone the bonsai repository to `$HOME/bonsai`
- Add bonsai to your `$PATH`
- Make the `bonsai.pl` script executable

## Usage

```sh
bonsai.pl [options]
```

### Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Show what changes would be made without applying them |
| `--interactive` | Run interactive setup with prompts for each option |
| `--config` | Generate config file only, don't run setup |
| `--help` | Display usage information |
| `--man` | Display the manual page |
| `--version` | Display version information |

### Examples

Run with default settings:
```sh
bonsai.pl
```

Preview what would be configured:
```sh
bonsai.pl --dry-run
```

Interactive setup:
```sh
bonsai.pl --interactive
```

## Configuration

After installation, bonsai saves configuration to `~/.config/bonsai/config.conf`. You can edit this file directly or use `--interactive` mode.

Example `config.conf`:

```conf
# bonsai configuration file

browser = firefox
shell = fish
theme = nord
window_manager = cwm
xorg_brightness = 80
xorg_resolution = 1920x1080
```

### Available Options

| Setting | Options | Default |
|---------|---------|---------|
| `window_manager` | cwm, spectrwm, i3, dwm, bspwm, openbox | cwm |
| `shell` | ksh, fish, zsh, bash | ksh |
| `browser` | firefox, librewolf, chromium, lynx | firefox |
| `theme` | nord, gruvbox, dracula | nord |
| `xorg_resolution` | Any valid resolution | 1920x1080 |
| `xorg_brightness` | 0-100 | 80 |

## What Gets Configured

- **Window Manager**: Creates `.xinitrc` and `.xsession` files
- **Xorg**: Configures `.Xresources` with font settings and DPI
- **Theming**: Applies terminal color scheme to `.Xresources`
- **Browser**: Installs your chosen browser via `pkg_add`
- **Shell**: Installs and sets as default shell
- **SSH Agent**: Configures keychain for SSH key management
- **Default Apps**: Installs essential tools (git, vim, neovim, tmux, htop, fzf, ripgrep, fd, bat, fastfetch)

## Modules

| Module | Purpose |
|--------|---------|
| `WindowManager.pm` | Configures window manager and X init files |
| `Xorg.pm` | Sets up Xresources and display settings |
| `Theming.pm` | Applies color themes |
| `Browser.pm` | Installs web browser |
| `Shell.pm` | Installs and configures shell |
| `SSHAgent.pm` | Sets up keychain for SSH |
| `DefaultApps.pm` | Installs essential applications |

See [docs/modules.md](docs/modules.md) for detailed module documentation.

## Documentation

- [Getting Started](docs/getting-started.md) - First-time setup guide
- [Customization](docs/customization.md) - How to customize your setup
- [Troubleshooting](docs/troubleshooting.md) - Common issues and solutions
- [Module Reference](docs/modules.md) - Detailed module documentation
- [Example Config](config/example.conf) - Annotated configuration file

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Reporting bugs
- Suggesting features
- Submitting pull requests
- Adding new modules

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and release notes.

## Acknowledgments

Inspired by the suckless philosophy and crafted for OpenBSD users.
