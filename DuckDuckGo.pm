package DuckDuckGo;
use v5.20;
use strict;
no warnings "redefine";
use Exporter;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(search);
our @EXPORT = qw(init);

our $dictionary;

sub search (@) {
    my $query = "https://duckduckgo.com/?q=" . join("+", @_);
    my $browse = $dictionary->{"browse"};
    &$browse($query);
}

sub init ($) {
    $dictionary = shift;
    $dictionary->{"search"} = \&DuckDuckGo::search;
}

1;
