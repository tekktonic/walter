package Template;

use strict;
use Exporter;
use Data::Dumper;
use File::Copy::Recursive qw(rcopy);

use v5.10;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(template);
our @EXPORT = qw(init);

our $home = $ENV{"HOME"} . "/.walter/Template/";

sub template {
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
1;
