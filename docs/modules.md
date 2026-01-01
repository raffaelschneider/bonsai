# Module Reference

Detailed documentation for each bonsai module.

## Overview

bonsai is organized into modules, each handling a specific aspect of desktop setup. All modules follow a consistent pattern:

- Accept configuration parameters and a `$dry_run` flag
- Print status messages during execution
- Skip actions when `$dry_run` is true
- Return gracefully on errors with warnings

## WindowManager.pm

**Purpose**: Configures the window manager and creates X initialization files.

**Config option**: `window_manager`

**Supported values**:
| Value | Package | Notes |
|-------|---------|-------|
| `cwm` | (base) | OpenBSD's native WM, no install needed |
| `spectrwm` | spectrwm | Dynamic tiling |
| `i3` | i3 | Popular tiling WM |
| `dwm` | dwm | Suckless dynamic WM |
| `bspwm` | bspwm | Binary space partitioning |
| `openbox` | openbox | Stacking WM |

**Files created**:
- `~/.xinitrc` - For startx
- Sets correct permissions (755)

**Example output**:
```
Setting up window manager: cwm
cwm is included in OpenBSD base, no installation needed.
Window manager cwm configured. Start X with 'startx' or use xenodm.
```

---

## Xorg.pm

**Purpose**: Configures X display settings and creates Xresources.

**Config options**:
- `xorg_resolution` - Display resolution (informational)
- `xorg_brightness` - Screen brightness (0-100)

**Files created**:
- `~/.Xresources` - Font and display settings
- `~/.xsession` - For xenodm (if doesn't exist)

**Xresources settings**:
- DPI: 96
- Antialiasing: enabled
- Hinting: hintslight
- xterm: 256color, monospace font, no scrollbar

---

## Theming.pm

**Purpose**: Applies color themes to terminal via Xresources.

**Config option**: `theme`

**Supported themes**:

### Nord
Arctic, north-bluish palette.
- Background: `#2e3440`
- Foreground: `#d8dee9`

### Gruvbox
Retro groove colors.
- Background: `#282828`
- Foreground: `#ebdbb2`

### Dracula
Dark theme with vibrant colors.
- Background: `#282a36`
- Foreground: `#f8f8f2`

**Files modified**:
- `~/.Xresources` (appends color definitions)

**Applying changes**:
```sh
xrdb -merge ~/.Xresources
```

---

## Browser.pm

**Purpose**: Installs the chosen web browser.

**Config option**: `browser`

**Supported values**:
| Value | Package | Notes |
|-------|---------|-------|
| `firefox` | firefox | Mozilla Firefox |
| `librewolf` | librewolf | Privacy-focused Firefox fork |
| `chromium` | chromium | VA-API hardware acceleration on OpenBSD |
| `iridium` | iridium | Privacy-focused Chromium |
| `lynx` | lynx | Text-based |
| `w3m` | w3m | Text-based with image support |

---

## Shell.pm

**Purpose**: Installs and sets the default shell.

**Config option**: `shell`

**Supported values**:
| Value | Path | Notes |
|-------|------|-------|
| `ksh` | /bin/ksh | OpenBSD base, no install needed |
| `fish` | /usr/local/bin/fish | Friendly interactive shell |
| `zsh` | /usr/local/bin/zsh | Feature-rich shell |
| `bash` | /usr/local/bin/bash | GNU Bourne-again shell |

**Actions**:
1. Installs shell package (if not ksh)
2. Changes default shell via `chsh`

---

## SSHAgent.pm

**Purpose**: Configures SSH agent using keychain.

**Config option**: Uses `shell` setting to determine config file

**Package installed**: `keychain`

**Files modified** (based on shell):
| Shell | Config file |
|-------|-------------|
| fish | `~/.config/fish/config.fish` |
| zsh | `~/.zshrc` |
| others | `~/.profile` |

**Directories created**:
- `~/.ssh/sockets` (mode 700)

**Features**:
- Checks for existing keychain configuration
- Creates fish config directory if needed
- Uses shell-appropriate syntax

---

## DefaultApps.pm

**Purpose**: Installs essential command-line applications.

**No config options** - always installs the same set.

**Applications installed**:
| Package | Description |
|---------|-------------|
| curl | HTTP client |
| git | Version control |
| vim | Text editor |
| neovim | Modern vim |
| tmux | Terminal multiplexer |
| htop | Process viewer |
| fzf | Fuzzy finder |
| ripgrep | Fast grep |
| fd | Fast find |
| bat | cat with syntax highlighting |
| fastfetch | System info display |

---

## Module Execution Order

bonsai runs modules in this order:

1. **WindowManager** - Creates X init files
2. **Xorg** - Creates Xresources base
3. **Theming** - Appends colors to Xresources
4. **Browser** - Installs browser
5. **Shell** - Installs and sets shell
6. **SSHAgent** - Configures keychain
7. **DefaultApps** - Installs tools

This order ensures:
- Xresources exists before theming appends to it
- Shell is set before SSHAgent configures it
