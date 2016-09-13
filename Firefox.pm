package Firefox;
use v5.20;
use strict;
no warnings "redefine";
use Exporter;
our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(browse);
our @EXPORT = qw(init);

sub browse {
    my @args = @_;

    exec("/usr/local/bin/firefox", @args);
}

sub init {
    my $hashref = shift;
    $hashref->{"browse"} = \&Firefox::browse;
}

1;
