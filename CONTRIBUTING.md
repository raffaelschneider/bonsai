# Contributing to bonsai

Thank you for your interest in contributing to bonsai! This document provides guidelines and information for contributors.

## Code of Conduct

Be respectful and constructive. We're all here to make OpenBSD desktop setups better.

## How to Contribute

### Reporting Bugs

1. Check existing [issues](https://github.com/raffaelschneider/bonsai/issues) to avoid duplicates
2. Use a clear, descriptive title
3. Include:
   - OpenBSD version
   - bonsai version (`bonsai.pl --version`)
   - Steps to reproduce
   - Expected vs actual behavior
   - Relevant error messages

### Suggesting Features

Open an issue with:
- Clear description of the feature
- Use case / why it's useful
- Proposed implementation (optional)

### Submitting Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Test on OpenBSD if possible
5. Commit with clear messages
6. Push and open a PR

## Development Guidelines

### Code Style

- Use `strict` and `warnings` in all Perl modules
- 4-space indentation
- Descriptive variable names
- Comment non-obvious logic

### Module Structure

Each module in `modules/` should follow this pattern:

```perl
package ModuleName;
use strict;
use warnings;

sub setup {
    my ($param, $dry_run) = @_;

    print "Setting up something...\n";

    if ($dry_run) {
        print "[Dry-run] Would do something.\n";
        return;
    }

    # Actual setup logic here

    print "Setup complete.\n";
}

1;
```

### Key Requirements

1. **Dry-run support**: Every module must respect the `$dry_run` flag
2. **Idempotency**: Running setup multiple times should be safe
3. **Error handling**: Use `warn` for non-fatal errors, `die` for fatal ones
4. **User feedback**: Print clear messages about what's happening

### Adding a New Module

1. Create `modules/YourModule.pm`
2. Implement `setup()` with `$dry_run` support
3. Add `use YourModule;` to `bonsai.pl`
4. Add config options if needed
5. Update documentation:
   - `README.md` - Add to modules table and options
   - `bonsai.man` - Add to configuration section
6. Test with `--dry-run` first

### Testing

Before submitting:

```sh
# Syntax check
perl -c bonsai.pl
perl -c modules/*.pm

# Dry run
./bonsai.pl --dry-run

# Interactive mode
./bonsai.pl --interactive --dry-run
```

## Adding Support for New Software

### Window Managers

Edit `modules/WindowManager.pm`:

```perl
my %wm_packages = (
    'newwm' => 'newwm-package',  # Add here
    # ...
);
```

### Shells

Edit `modules/Shell.pm`:

```perl
my %shell_paths = (
    'newshell' => '/usr/local/bin/newshell',  # Add here
    # ...
);
```

### Themes

Edit `modules/Theming.pm`:

```perl
my %themes = (
    'newtheme' => {
        background => '#xxxxxx',
        foreground => '#xxxxxx',
        # ... colors 0-7
    },
    # ...
);
```

### Browsers

Edit `modules/Browser.pm`:

```perl
my %browser_packages = (
    'newbrowser' => 'newbrowser-pkg',  # Add here
    # ...
);
```

## Documentation

- Keep `README.md` updated with any user-facing changes
- Update `bonsai.man` for command-line changes
- Add comments in code for complex logic

## Questions?

Open an issue or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
