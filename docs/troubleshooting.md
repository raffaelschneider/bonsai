# Troubleshooting

Common issues and solutions when using bonsai on OpenBSD.

## Installation Issues

### "Permission denied" when running bonsai.pl

Make sure the script is executable:
```sh
chmod +x ~/bonsai/bonsai.pl
```

### "Can't locate Module.pm" error

Ensure you're running from the bonsai directory or it's in your PATH:
```sh
cd ~/bonsai && ./bonsai.pl
```

Or add to PATH:
```sh
export PATH="$PATH:$HOME/bonsai"
```

## Package Installation Issues

### "pkg_add: no pkg found" errors

1. Check your PKG_PATH is set correctly:
   ```sh
   echo $PKG_PATH
   ```

2. Set it if needed:
   ```sh
   export PKG_PATH="https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(uname -m)/"
   ```

3. Or add to `/etc/installurl`:
   ```sh
   echo "https://cdn.openbsd.org/pub/OpenBSD" | doas tee /etc/installurl
   ```

### Permission denied during pkg_add

bonsai needs root privileges to install packages. Either:

1. Run with doas:
   ```sh
   doas bonsai.pl
   ```

2. Or configure doas for pkg_add (in `/etc/doas.conf`):
   ```
   permit nopass :wheel cmd pkg_add
   ```

## X11 Issues

### startx fails with "no screens found"

1. Check if X is installed:
   ```sh
   ls /usr/X11R6/bin/X
   ```

2. Verify xenocara is installed (should be by default)

3. Check Xorg log:
   ```sh
   cat /var/log/Xorg.0.log | grep EE
   ```

### Black screen after startx

1. Check your `~/.xinitrc`:
   ```sh
   cat ~/.xinitrc
   ```

2. Make sure it's executable:
   ```sh
   chmod +x ~/.xinitrc
   ```

3. Verify the window manager exists:
   ```sh
   which cwm  # or your chosen WM
   ```

### xenodm not starting

1. Enable xenodm:
   ```sh
   doas rcctl enable xenodm
   doas rcctl start xenodm
   ```

2. Check `~/.xsession` exists and is executable

## Shell Issues

### Shell change not taking effect

1. Verify the change:
   ```sh
   grep $USER /etc/passwd
   ```

2. Log out completely and log back in

3. Or manually change:
   ```sh
   chsh -s /usr/local/bin/fish
   ```

### fish: command not found after install

The shell path might not be in `/etc/shells`. Add it:
```sh
echo "/usr/local/bin/fish" | doas tee -a /etc/shells
```

## Theme Issues

### Colors not applying to terminal

1. Reload Xresources:
   ```sh
   xrdb -merge ~/.Xresources
   ```

2. Restart your terminal emulator

3. Check if terminal supports Xresources (xterm does, some others don't)

### Wrong colors in terminal

Some terminals (like alacritty, kitty) use their own config files instead of Xresources.

## SSH Agent Issues

### SSH keys not loading

1. Check keychain is installed:
   ```sh
   which keychain
   ```

2. Verify shell config was updated:
   ```sh
   grep keychain ~/.profile  # or ~/.zshrc, ~/.config/fish/config.fish
   ```

3. Make sure SSH keys exist:
   ```sh
   ls ~/.ssh/*.pub
   ```

4. Manually start keychain:
   ```sh
   eval $(keychain --eval --agents ssh)
   ```

## Re-running bonsai

### Safe to run multiple times?

Yes! bonsai is designed to be idempotent. Running it again will:
- Reinstall packages (pkg_add handles this gracefully)
- Overwrite config files it manages (`.xinitrc`, `.xsession`)
- Append to shell configs (checks for existing keychain config)

### Resetting configuration

To start fresh:
```sh
rm ~/.config/bonsai/config.conf
rm ~/.xinitrc ~/.xsession
bonsai.pl --interactive
```

## Getting Help

If you're still stuck:

1. Check the [OpenBSD FAQ](https://www.openbsd.org/faq/)
2. Search [misc@openbsd.org archives](https://marc.info/?l=openbsd-misc)
3. Open an issue on [GitHub](https://github.com/raffaelschneider/bonsai/issues)
