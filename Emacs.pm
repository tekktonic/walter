package Emacs;
use strict;
use Exporter;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(edit);
our @EXPORT = qw(init);

sub edit {
    my @args = @_;

    system("emacs" . " -nw " . join(" ", @args));
}

sub init {
    my $hashref = shift;
    $hashref->{"edit"} = \&Emacs::edit;
}

1;
