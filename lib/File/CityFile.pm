package File::CityFile;
use strict;
use warnings;

=pod 
 init CityFile with params
=cut
our @EXPORT = qw(
	
);

our $VERSION = '0.02';

sub new {
    my $class = shift;
    my %opts  = @_;
    
    my $self = {
    	%opts
    };
    
    bless $self, $class;
    $self->initialize(@_);
    return $self;
}

sub initialize {
    my $self = shift;
    my $val  = shift;
    ( $self->{'city_info'}, $self->{'country_info'} ) = $self->_parse();
}

sub _parse
{
	my $self = shift;
	my %city_info;
	my %country_info;
	my $filename = $self->{filename};
	
	die "Can't use this file '$filename' as city db" unless -e $filename;
	
	my @city_a = split "\n", do { local(@ARGV , $/) = $filename; <> };
	
	for my $cur_city (@city_a)
	{
	 	my ($ID, $name, $country, $population) = ($cur_city =~ /^(\d+\.)\s*(.*),\s*(.*) - \s*(.*)/); 
		next unless $ID;		
	
		$ID =~ s/\.$//;
		next unless $ID > 0;
		
		$population =~ s/[\.|\,]//g;
		
		$country_info{$country}->{'current_max'} 	= 0 unless $country_info{$country}->{'current_max'};
		$country_info{$country}->{'total_population'} 	= 0 unless $country_info{$country}->{'total_population'};
		
		$city_info{$name} = { 'country'=> $country, 'population' => $population};
		
		if  ($country_info{$country}->{'current_max'} < $population)
		{
			my $total_population = $country_info{$country}->{'total_population'} + $population;
			$country_info{$country}	= {'total_population' => $total_population, 'capital' => $name, 'current_max' => $population};
		}
		else
		{
			$country_info{$country}->{total_population} += $population;	
		}	
	}
	
	return (\%city_info, \%country_info);

}

1;
