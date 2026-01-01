# Customization Guide

bonsai is designed to be a starting point. Here's how to customize your setup.

## Configuration File

Edit `~/.config/bonsai/config.conf` to change settings:

```sh
vim ~/.config/bonsai/config.conf
```

Then re-run bonsai to apply:
```sh
bonsai.pl
```

## Window Manager Customization

### cwm

cwm reads `~/.cwmrc`. Example configuration:

```
# ~/.cwmrc
borderwidth 1
color activeborder "#81a1c1"
color inactiveborder "#3b4252"
gap 0 0 0 0

# Key bindings
bind-key CM-Return terminal
bind-key CM-w "firefox"
bind-key CM-l lock

# Mouse bindings
bind-mouse M-1 window-move
bind-mouse M-3 window-resize
```

### spectrwm

spectrwm reads `~/.spectrwm.conf`. See `man spectrwm` for options.

### i3

i3 reads `~/.config/i3/config`. Run `i3-config-wizard` for initial setup.

## Shell Customization

### fish

```sh
mkdir -p ~/.config/fish
vim ~/.config/fish/config.fish
```

### zsh

```sh
vim ~/.zshrc
```

Consider adding:
- [Oh My Zsh](https://ohmyz.sh/) for plugins
- [Starship](https://starship.rs/) for a modern prompt

### ksh

```sh
vim ~/.kshrc
```

Make sure `.profile` sources it:
```sh
echo 'export ENV=$HOME/.kshrc' >> ~/.profile
```

## Theme Customization

### Terminal Colors

bonsai writes colors to `~/.Xresources`. To customize:

```sh
vim ~/.Xresources
```

Apply changes:
```sh
xrdb -merge ~/.Xresources
```

### Adding Custom Themes

Edit `modules/Theming.pm` and add to the `%themes` hash:

```perl
'mytheme' => {
    background  => '#1a1a1a',
    foreground  => '#ffffff',
    color0      => '#000000',
    # ... colors 1-7
},
```

## Adding Custom Applications

### Modify Default Apps

Edit `modules/DefaultApps.pm`:

```perl
my @default_apps = qw(
    # Add your apps here
    newsboat
    mpv
    # ...
);
```

### One-off Installation

Just use pkg_add directly:
```sh
doas pkg_add mpv youtube-dl
```

## Xorg Customization

### DPI and Fonts

Edit `~/.Xresources`:

```
Xft.dpi: 120
Xft.antialias: true
Xft.hinting: true
```

### Display Settings

For multi-monitor or custom resolution, create `~/.xsession`:

```sh
#!/bin/sh
xrandr --output HDMI-1 --mode 2560x1440 --rate 60
xrdb -merge ~/.Xresources
exec cwm
```

## Useful OpenBSD Desktop Tips

### Enable tap-to-click on touchpad

Add to `/etc/wsconsctl.conf`:
```
mouse.tp.tapping=1
```

### Adjust keyboard repeat rate

In `~/.xinitrc` or `~/.xsession`:
```sh
xset r rate 200 30
```

### Enable multimedia keys

Most window managers can bind XF86 keys. Example for cwm:
```
bind-key XF86AudioRaiseVolume "sndioctl output.level=+0.1"
bind-key XF86AudioLowerVolume "sndioctl output.level=-0.1"
bind-key XF86AudioMute "sndioctl output.mute=!"
```
