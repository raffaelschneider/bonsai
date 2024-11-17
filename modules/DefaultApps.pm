package DefaultApps;
use strict;
use warnings;

sub setup {
    print "Installing default applications...\n";
    my @apps = qw(curl vim htop git wget firefox neovim tmux);
    foreach my $app (@apps) {
        system("pkg_add $app");
        print "Installed $app\n";
    }
    print "Default apps installation complete.\n";
}

1;
