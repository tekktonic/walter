package Firefox;
use strict;
use Exporter;
our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(browse);
our @EXPORT = qw(init needs);

sub browse {
    my @args = @_;

    exec("firefox", @args);
}

sub init {
    my $hashref = shift;
    $hashref->{"browse"} = \&Firefox::browse;
}

sub needs {
    return qw();
}
1;
