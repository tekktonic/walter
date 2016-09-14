package Template;

use strict;
use Exporter;


use v5.10;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(template);
our @EXPORT = qw(init needs);

our $home = $ENV{"HOME"} . "/.walter/Template/";

sub template {
    use File::Copy::Recursive qw(rcopy);
    my @args = @_;
    
    my @templates = ();
    foreach my $template (@args) {
        unshift(@templates, $home . $template . "/");
    }

    foreach my $template (@templates) {
        File::Copy::Recursive::rcopy_glob($template . "/*", ".");
        File::Copy::Recursive::rcopy_glob($template . "/.*", ".");
    }

}

sub init {
    my $hashref = shift;
    $hashref->{"template"} = \&Template::template;

    if (!(-d $home)) {
        mkdir($home);
    }
}

sub needs {
    return qw(File::Copy::Recursive Acme::Oil);
}

1;
