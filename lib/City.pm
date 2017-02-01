package City;

use strict;
use warnings;
use File::CityFile;

=pod 
 init City with params
=cut
sub new{
    my ($class,$args) = @_;
    my $cityinfo = File::CityFile->new('filename' => $args->{'filename'});
    my $self = bless { 
		'filename' 	=> $args->{'filename'},
		'city_info'	=> $cityinfo->{'city_info'},
		'country_info'=> $cityinfo->{'country_info'}
                     }, $class;
}

=pod
 returns name of the file
=cut
sub get_filename
{
   my $self = shift;

   return $self->{'filename'};
}

=pod
 returns countries from DB 
=cut

sub get_countries
{
   my $self = shift;

   return sort keys $self->{'country_info'};
}

=pod
 returns cities from DB 
=cut

sub  get_cities
{
   my $self = shift;

   return sort keys $self->{'city_info'};
}

=pod
 returns cities by given country 
=cut

sub get_cities_by_country
{
   my $self = shift;
   my $country = shift;

   my @city_list;
   
   for my $cit ( sort keys $self->{'city_info'} )
   {
		push @city_list, $cit if $self->{'city_info'}->{$cit}->{'country'} eq $country;
   }
   
   return \@city_list;
}

1;
