package Theming;
use strict;
use warnings;

sub setup {
    my ($theme, $shell) = @_;
    print "Applying theme: $theme\n";

    # Apply theme to .Xresources, terminals, and other tools here.

    # Example: Shell-specific configuration
    if ($shell eq 'fish') {
        # Theme-related setup in Fish shell
    } elsif ($shell eq 'zsh') {
        # Theme-related setup in Zsh shell
    }

    print "Theme setup complete.\n";
}

1;
