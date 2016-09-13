package Search;
use v5.20;
use strict;
use Exporter;
our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(search);
our @EXPORT = qw(init);

sub init {
    my $hashref = shift;
    $hashref->{"search"} = \&Browser::browse;
}
