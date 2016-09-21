package Python3;
use strict;
use v5.10;
use Exporter;
use Module::Load;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(py3);

our @EXPORT = qw(init needs);

our $dictionary;
sub python3 {
    my $query = "https://docs.python.org/3/search.html?q=" . join("+", @_) . "&check_keywords=yes&area=default";
    my $browse = $dictionary->{"browse"};

    if (!$browse) {
        die("Browser not set");
    }

    &$browse($query);
}

sub init {
    $dictionary = shift;
    $dictionary->{"py3"} = \&Python3::python3;
}

sub needs {
    return qw();
}

1;
