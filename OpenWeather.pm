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

sub fahrenheit_of_kelvin($) {
    my $temp = shift;
    return ((($temp - 272.150) * 1.8) + 32);
}


sub weather {

    load "LWP::Simple";
    load "JSON";
    
    my $location = shift;
    my $current_weather = JSON::from_json(LWP::Simple::get("http://api.openweathermap.org/data/2.5/weather?q=$location&APIKEY=$apikey"));

    print("Weather in " . $current_weather->{"name"} . ": " . ((($current_weather->{"weather"})->[0])->{"main"}) . " at " . (fahrenheit_of_kelvin(($current_weather->{"main"})->{"temp"})) . "\n");
}

sub forecast {
    autoload "LWP::Simple";
    autoload "JSON";

    my $location = shift;
    my $forecast = from_json(get("http://api.openweathermap.org/data/2.5/forecast?q=$location&APIKEY=$apikey"));

    print("$location 5 day forecast: " );
    my @forecasts = @{$forecast->{"list"}};

    my @days = ();
    
    foreach my $entry (@forecasts) {
        print("| " . $entry->{"weather"}->[0]->{"main"} . " " . sprintf("%.0f", fahrenheit_of_kelvin($entry->{"main"}->{"temp_min"})) . "-" . sprintf("%.0f", fahrenheit_of_kelvin($entry->{"main"}->{"temp_max"})) . " ");
    }
    print("|\n");
}

sub init {
    my $hashref = shift;
    $hashref->{"weather"} = \&OpenWeather::weather;
#    $hashref->{"forecast"} = \&OpenWeather::forecast;
}

sub needs {
    return qw(JSON LWP::Simple);
}
1;
