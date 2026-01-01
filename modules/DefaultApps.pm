package DefaultApps;
use strict;
use warnings;

my @default_apps = qw(
    curl
    git
    vim
    neovim
    tmux
    htop
    fzf
    ripgrep
    fd
    bat
    fastfetch
);

sub setup {
    my ($dry_run) = @_;
    print "Installing default applications...\n";

    if ($dry_run) {
        print "[Dry-run] Would install: " . join(', ', @default_apps) . "\n";
        return;
    }

    foreach my $app (@default_apps) {
        print "Installing $app...\n";
        system("pkg_add $app") == 0
            or warn "Warning: Failed to install $app\n";
    }

    print "Default apps installation complete.\n";
}

1;
