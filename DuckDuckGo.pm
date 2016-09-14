package DuckDuckGo;
use strict;
use Exporter;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(search);

our @EXPORT = qw(init needs);



our $dictionary;

sub search {
    my $query = "https://duckduckgo.com/?q=" . join("+", @_);
    my $browse = $dictionary->{"browse"};
    if (!$browse)
    {
        die("Browser not set, unable to perform a web search");
    }
    
    &$browse($query);
}

sub init {
    $dictionary = shift;
    $dictionary->{"search"} = \&DuckDuckGo::search;
}

sub needs {
    return qw();
}
1;
