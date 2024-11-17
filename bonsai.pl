#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use FindBin;
use lib "$FindBin::Bin/modules";

use Browser;
use DefaultApps;
use Shell;
use SSHAgent;
use Theming;
use WindowManager;
use Xorg;

# Help and options
my $dry_run = 0;
my $help = 0;
my $man = 0;
GetOptions(
    "dry-run" => \$dry_run,
    "help"    => \$help,
    "man"     => \$man,
) or die("Error in command line arguments\n");

# Display help
if ($help) {
    print "Usage: bonsai.pl [options]\n";
    print "Options:\n";
    print "  --dry-run  : Show what would be done without making changes\n";
    print "  --help     : Display this help message\n";
    print "  --man      : Display the manual page\n";
    exit 0;
}

# Display man page
if ($man) {
    exec("man $FindBin::Bin/bonsai.man");
}

# Default settings
my %settings = (
    window_manager   => 'spectrwm',
    browser          => 'firefox',
    theme            => 'nord',
    shell            => 'fish',
    xorg_resolution  => '1920x1080',
    xorg_brightness  => '80',
);

# Dry-run message
if ($dry_run) {
    print "Running in dry-run mode. No changes will be made.\n";
}

# Run setup modules
WindowManager::setup($settings{window_manager}, $dry_run);
Browser::setup($settings{browser}, $dry_run);
Theming::setup($settings{theme}, $dry_run);
Xorg::setup($settings{xorg_resolution}, $settings{xorg_brightness}, $dry_run);
Shell::setup($settings{shell}, $dry_run);
SSHAgent::setup($settings{shell}, $dry_run);
DefaultApps::setup($dry_run);
