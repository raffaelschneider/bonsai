package Browser;
use strict;
use warnings;

my %browser_packages = (
    'firefox'    => 'firefox',
    'librewolf'  => 'librewolf',
    'chromium'   => 'chromium',
    'iridium'    => 'iridium',
    'lynx'       => 'lynx',
    'w3m'        => 'w3m',
);

sub setup {
    my ($browser, $dry_run) = @_;
    print "Setting up browser: $browser\n";

    if ($dry_run) {
        print "[Dry-run] Would install $browser.\n";
        return;
    }

    my $pkg = $browser_packages{$browser} // $browser;
    print "Installing $pkg...\n";
    system("pkg_add $pkg") == 0
        or warn "Warning: Failed to install $pkg\n";

    print "Browser setup complete.\n";
}

1;
