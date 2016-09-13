#!/usr/bin/perl

use strict;
use File::Copy qw(copy);

my $confdir = $ENV{"HOME"} . "/.walter";

mkdir($confdir);

mkdir($confdir . "/modules/");

if (! (-e "$confdir/walter.mods")){
    copy("walter.mods", $confdir . "/") || die "Unable to write to $confdir";
}

foreach my $mod (glob("*.pm")) {
    copy($mod, $confdir . "/modules/") || die "Unable to copy $mod to $confdir" . "/modules/";
}

