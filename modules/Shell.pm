package Shell;
use strict;
use warnings;

my %shell_paths = (
    'fish'  => '/usr/local/bin/fish',
    'zsh'   => '/usr/local/bin/zsh',
    'bash'  => '/usr/local/bin/bash',
    'ksh'   => '/bin/ksh',  # included in base
);

sub setup {
    my ($shell, $dry_run) = @_;
    print "Setting up shell: $shell\n";

    if ($dry_run) {
        print "[Dry-run] Would install $shell and set it as default.\n";
        return;
    }

    # ksh is in base, others need installation
    if ($shell ne 'ksh') {
        print "Installing $shell...\n";
        system("pkg_add $shell") == 0
            or warn "Warning: Failed to install $shell\n";
    } else {
        print "ksh is included in OpenBSD base.\n";
    }

    my $shell_path = $shell_paths{$shell} // "/usr/local/bin/$shell";
    my $username = $ENV{USER};

    print "Setting $shell as default shell for $username...\n";
    system("chsh -s $shell_path $username") == 0
        or warn "Warning: Failed to change shell. You may need to run: chsh -s $shell_path\n";

    print "Shell setup complete.\n";
}

1;
