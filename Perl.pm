package Perl;
use strict;
use v5.10;
use Exporter;
use Module::Load;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(perl);

our @EXPORT = qw(init needs);

sub perl {
    exec("perldoc", @_);
}

sub init {
    my $hashref = shift;
    $hashref->{"perl"} = \&Perl::perl;
}

sub needs {
    return qw();
}

1;
