package OpenWeather;
use strict;
use v5.10;
use Exporter;
use Module::Load;

our $VERSION = 0.01;
our @ISA = qw(Exporter);
our @keywords = qw(weather forecast);

our @EXPORT = qw(init needs);

my $apikey = "9742d9ad74b1a66683b5e35473c8cc18";

sub weather {

    load "LWP::Simple";
    load "JSON";
    
    my $location = shift;
    my $current_weather = JSON::from_json(LWP::Simple::get("http://api.openweathermap.org/data/2.5/weather?q=$location&APIKEY=$apikey"));

    print("\n\nWeather in " . $current_weather->{"name"} . ": " . ((($current_weather->{"weather"})->[0])->{"main"}) . " at " . ((((($current_weather->{"main"})->{"temp"}) -272.150) * 1.8) + 32) . "\n");
}

sub forecast {
    autoload "LWP::Simple";
    autoload "JSON";
    my $location = shift;
    my $forecast = from_json(get("http://api.openweathermap.org/data/2.5/weather?q=$location&APIKEY=$apikey"));
}

sub init {
    my $hashref = shift;
    $hashref->{"weather"} = \&OpenWeather::weather;
    $hashref->{"forecast"} = \&OpenWeather::forecast;
}

sub needs {
    return qw(JSON LWP::Simple);
}
1;
