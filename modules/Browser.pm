package Browser;
use strict;
use warnings;

sub setup {
    my ($browser) = @_;
    print "Installing browser: $browser\n";
    system("pkg_add $browser");
    print "Browser setup complete.\n";
}

1;
