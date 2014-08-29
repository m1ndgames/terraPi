package terraPi::Sensors::Raspberry;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(BMP085);
use strict;
use warnings;

# Raspberry Sensors
# &raspberry('temp')
# &raspberry('volts')
# &raspberry('clock')
sub raspberry {
    my $param = shift;
    if ( $param eq 'temp' ) {
        my @data = `vcgencmd measure_temp`;
        foreach (@data) {
            if ( $_ =~ /temp=(.+)'C/ ) {
                return $1;
            }
        }
    }
    elsif ( $param eq 'volts' ) {
        my @data = `vcgencmd measure_volts`;
        foreach (@data) {
            if ( $_ =~ /volt=(.+)V/ ) {
                return $1;
            }
        }
    }
    elsif ( $param eq 'clock' ) {
        my @data = `vcgencmd measure_clock arm`;
        foreach (@data) {
            if ( $_ =~ /frequency\(45\)=(.+)$/ ) {
                return $1;
            }
        }
    }
}

1;
