package Shell;
use strict;
use warnings;

sub setup {
    my ($shell, $dry_run) = @_;
    print "Setting up shell: $shell\n";

    if ($dry_run) {
        print "[Dry-run] Would install $shell and set it as default.\n";
        return;
    }

    system("pkg_add $shell");
    my $username = $ENV{USER};
    system("chsh -s /usr/local/bin/$shell $username");
    print "Shell $shell installed and set as default for $username.\n";
}

1;
