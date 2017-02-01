#!/usr/bin/perl
use feature qw(say switch);

use Getopt::Long;

GetOptions (
		"city=s" 	=> \$city,
    		"filename=s"	=> \$file
    	    );

help() unless $city;

use Data::Dumper;

use lib './lib';
use City;

	my $cityinfo = City->new( { filename => $file || './src/fh.txt' } );
	
	if (!$cityinfo->{city_info}->{$city})
	{
		say "City $city not found in Db. Available cities: \n\n \t", join ', ',  $cityinfo->get_cities();
		exit;
	}
	
	my $country 			= $cityinfo->{'city_info'}->{$city}->{'country'};
	my $country_population 		= $cityinfo->{'country_info'}->{$country}->{'total_population'};
	my $population			= $cityinfo->{'city_info'}->{$city}->{'population'};
	
	$country_population 		= pretify( $country_population );
	$population			= pretify( $population );
	
	if ( $cityinfo->{'country_info'}->{$country}->{'capital'} eq $city)
	{
		say "$city is Capital of $country with $country_population peoples total. Population of $city: $population";
		
		my @city_ar = @{ $cityinfo->get_cities_by_country($country) };				
		say "In db we have cities in current country: ". join ', ', @city_ar if scalar @city_ar > 1;
		
	} else{
		say "$city is a small city in the $country. Population of $city: $population. Capital of the $country is ".
		$cityinfo->{'country_info'}->{$country}->{'capital'};
	}

sub help
{
	say "Usage: city_info.pl --city <city name> [--filename <optional filename holding the city info>] ";
	exit;
}

sub pretify {
    my $pop = reverse shift;
    $pop =~ s/(\d{3})(?=\d)(?!\d*\.)/$1./g;
    return scalar reverse $pop
}
