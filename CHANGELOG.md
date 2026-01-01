# Changelog

All notable changes to bonsai will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-01-01

### Added
- `WindowManager.pm` module for configuring window managers and X init files
- `Xorg.pm` module for display settings and .Xresources configuration
- Interactive mode (`--interactive`) for guided setup
- Config file support (`~/.config/bonsai/config.conf`)
- Version flag (`--version`)
- Config-only mode (`--config`) to generate config without running setup
- Real color theme definitions (Nord, Gruvbox, Dracula)
- Support for additional window managers (bspwm, openbox)
- Support for additional browsers (librewolf)
- ksh (OpenBSD base shell) support

### Changed
- Updated default applications list with modern tools:
  - Added: fzf, ripgrep, fd, bat, fastfetch
  - Removed: wget (curl is sufficient), duplicate firefox
- Improved SSH agent configuration with existing config detection
- Better error handling with warnings instead of silent failures
- Complete man page rewrite with proper formatting
- Comprehensive README with tables and examples

### Fixed
- All modules now properly support `--dry-run` flag
- Theming module parameter handling
- Man page format (was missing `.TH` header)
- Shell module now handles base system shells correctly

## [0.1.0] - 2024-xx-xx

### Added
- Initial release
- Basic module structure
- Browser installation
- Shell setup
- SSH agent with keychain
- Basic theming support
- Dry-run mode
- Man page
