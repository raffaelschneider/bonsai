package SSHAgent;
use strict;
use warnings;

sub setup {
    my ($shell) = @_;
    print "Setting up SSH agent with keychain for $shell shell...\n";

    # Install keychain
    system("pkg_add keychain");

    # Create sockets directory if it doesn’t exist
    my $ssh_sockets_dir = "$ENV{HOME}/.ssh/sockets";
    unless (-d $ssh_sockets_dir) {
        mkdir $ssh_sockets_dir or die "Failed to create sockets directory: $!";
        print "Created SSH sockets directory at $ssh_sockets_dir\n";
    }

    # Configure keychain based on the shell
    if ($shell eq 'fish') {
        my $config_fish_path = "$ENV{HOME}/.config/fish/config.fish";
        open my $fh, '>>', $config_fish_path or die "Could not open $config_fish_path: $!";
        print $fh "\n# Configure keychain with SSH sockets for Fish shell\n";
        print $fh "eval (keychain --eval --agents ssh --dir ~/.ssh/sockets)\n";
        close $fh;
    } elsif ($shell eq 'zsh') {
        my $config_zsh_path = "$ENV{HOME}/.zshrc";
        open my $fh, '>>', $config_zsh_path or die "Could not open $config_zsh_path: $!";
        print $fh "\n# Configure keychain with SSH sockets for Zsh shell\n";
        print $fh "eval \$(keychain --eval --agents ssh --dir ~/.ssh/sockets)\n";
        close $fh;
    } else {
        # Default to POSIX-style configuration
        my $config_sh_path = "$ENV{HOME}/.profile";
        open my $fh, '>>', $config_sh_path or die "Could not open $config_sh_path: $!";
        print $fh "\n# Configure keychain with SSH sockets for POSIX shell\n";
        print $fh "eval \$(keychain --eval --agents ssh --dir ~/.ssh/sockets)\n";
        close $fh;
    }

    print "Keychain configured with SSH sockets for $shell shell. Please reload your shell or restart your session.\n";
}

1;
