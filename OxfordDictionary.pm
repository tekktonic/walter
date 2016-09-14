package OxfordDictionary;
use strict;
use v5.10;
use Exporter;
use Module::Load;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(define);

our @EXPORT = qw(init needs);

sub define {
    autoload "LWP::Simple";
    autoload "XML::Twig";
        autoload "HTML::Strip";
    my $query = "\"" . join(" ", @_) . "\"";
    
my $html_strip = HTML::Strip->new();
my $twig = XML::Twig->new(twig_handlers => {
    "sru_dc:dc" => sub {
        my ($xml, $thing) = @_;
        binmode(STDOUT, ":utf8");
        say (($thing->first_child_text('dc:title')) . ":");
        say ($html_strip->parse($thing->first_child_text('dc:description')));
    }});
    
    $twig->parse(get("http://www.oed.com/srupage?operation=searchRetrieve&query=cql.serverChoice+=+" . $query . "&maximumRecords=100&startRecord=1"));
}

sub init {
    my $hashref = shift;
    $hashref->{"define"} = \&OxfordDictionary::define;
}

sub needs {
    return qw(LWP::Simple XML::Twig HTML::Strip);
}
