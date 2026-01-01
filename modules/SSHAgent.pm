package SSHAgent;
use strict;
use warnings;
use File::Path qw(make_path);

sub setup {
    my ($shell, $dry_run) = @_;
    print "Setting up SSH agent with keychain for $shell shell...\n";

    if ($dry_run) {
        print "[Dry-run] Would install keychain and configure SSH agent for $shell.\n";
        return;
    }

    # Install keychain
    print "Installing keychain...\n";
    system("pkg_add keychain") == 0
        or warn "Warning: Failed to install keychain\n";

    # Create sockets directory if it doesn't exist
    my $ssh_sockets_dir = "$ENV{HOME}/.ssh/sockets";
    unless (-d $ssh_sockets_dir) {
        make_path($ssh_sockets_dir, { mode => 0700 })
            or die "Failed to create sockets directory: $!";
        print "Created SSH sockets directory at $ssh_sockets_dir\n";
    }

    # Configure keychain based on the shell
    my ($config_path, $keychain_cmd);

    if ($shell eq 'fish') {
        $config_path = "$ENV{HOME}/.config/fish/config.fish";
        $keychain_cmd = "if status is-interactive\n    eval (keychain --eval --agents ssh --dir ~/.ssh/sockets)\nend\n";
        # Ensure fish config directory exists
        my $fish_config_dir = "$ENV{HOME}/.config/fish";
        make_path($fish_config_dir) unless -d $fish_config_dir;
    } elsif ($shell eq 'zsh') {
        $config_path = "$ENV{HOME}/.zshrc";
        $keychain_cmd = 'eval $(keychain --eval --agents ssh --dir ~/.ssh/sockets)' . "\n";
    } else {
        # Default to POSIX-style configuration
        $config_path = "$ENV{HOME}/.profile";
        $keychain_cmd = 'eval $(keychain --eval --agents ssh --dir ~/.ssh/sockets)' . "\n";
    }

    # Check if already configured
    if (-e $config_path) {
        open my $rfh, '<', $config_path or die "Could not read $config_path: $!";
        my $content = do { local $/; <$rfh> };
        close $rfh;
        if ($content =~ /keychain/) {
            print "Keychain already configured in $config_path\n";
            return;
        }
    }

    open my $fh, '>>', $config_path
        or die "Could not open $config_path: $!";
    print $fh "\n# SSH agent with keychain - configured by bonsai\n";
    print $fh $keychain_cmd;
    close $fh;

    print "Keychain configured in $config_path\n";
    print "Please reload your shell or restart your session.\n";
}

1;
