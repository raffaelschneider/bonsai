# bonsai

**bonsai** is a minimalist setup tool for OpenBSD users who want a lean, cohesive daily-driving experience without repetitive configuration. Inspired by the "suckless" philosophy and curated for simplicity, **bonsai** configures only the essentials—no bloat, just a clean OpenBSD environment.

## Features

- **Modular Setup**: Configure window managers, shells, SSH key management, theming, and more.
- **Dry Run Mode**: Preview changes before they’re made.
- **Interactive and Configurable**: Prompts during installation, or customize via `~/.config/bonsai/config.conf`.
- **Support for Multiple Shells**: Choose your shell (Fish, Zsh, etc.), and bonsai will handle the setup.

## Installation

You can install **bonsai** with a single command:

```sh
curl -fsSL https://raw.githubusercontent.com/raffaelschneider/bonsai/main/install.sh | sh
```

This command will:

- Clone the bonsai repository to `$HOME/bonsai`
- Add bonsai to your `$PATH`
- Make the `bonsai.pl` script executable

## Usage

Run the following command to see all available options:

```sh
bonsai.pl --help
```

### Options

- `--dry-run`: Show what changes would be made without applying them.
- `--help`: Display usage information.
- `--man`: Display the manual page for detailed documentation.

### Configuration

After installation, bonsai saves configuration options to `~/.config/bonsai/config.conf`, where you can edit settings like window manager, shell, and theme.

Example `config.conf`:

```conf
window_manager=spectrwm
browser=firefox
theme=nord
shell=fish
xorg_resolution=1920x1080
xorg_brightness=80
```

## Contributing

Contributions are welcome! If you have ideas for new modules or improvements, feel free to submit pull requests or open issues.

## License

This project is licensed under the MIT License.

## Acknowledgments

Inspired by the suckless philosophy and crafted for OpenBSD users.
