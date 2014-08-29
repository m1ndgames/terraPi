package terraPi::Sensors::BMP085;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(BMP085);
use strict;
use warnings;

# BMP085 - Humidity / Temperature Sensor
# &BMP085('temperature')
# &BMP085('humidity')
sub BMP085 {
    my @data =
      `../include/Adafruit-Raspberry-Pi-Python-Code/Adafruit_BMP085/bmp085.py`;
    my ( $temperature, $humidity );
    foreach (@data) {
        if ( ( $_ =~ /Temp: (.+) C/ ) && ( $_[0] eq 't' ) ) {
            return $1;
        }
        elsif ( ( $_ =~ /Pressure: (.+) hPa/ ) && ( $_[0] eq 'h' ) ) {
            return $1;
        }
    }
}

1;
