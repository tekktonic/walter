package Python2;
use strict;
use v5.10;
use Exporter;
use Module::Load;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(py2);

our @EXPORT = qw(init needs);

our $dictionary;
sub python2 {
    my $query = "https://docs.python.org/2/search.html?q=" . join("+", @_) . "&check_keywords=yes&area=default";
    my $browse = $dictionary->{"browse"};

    if (!$browse) {
        die("Browser not set");
    }

    &$browse($query);
}

sub init {
    $dictionary = shift;
    $dictionary->{"py2"} = \&Python2::python2;
}

sub needs {
    return qw();
}

1;
