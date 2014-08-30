package terraPi::Functions;
require Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(timehandler);
use strict;
use warnings;
use Date::Manip;
use Date::Parse;
use terraPi::Config;

sub timehandler {
    my $param = $_[0];
    if ($param eq 'date') { # Returns Date
        return UnixDate('now','%Y/%m/%d');
    } elsif ($param eq 'time') { # Returns Time
        return UnixDate('now','%H:%M:%S');
    } elsif ($param eq 'datetime') { # Returns Date & Time
        return UnixDate('now','%Y-%m-%d %H:%M:%S');
    } elsif ($param eq 'human') { # Returns Date without abbrevation
        my $language = &cfghandler('language');
        Date_Init("Language=$language");
        return UnixDate('now','&A, &d %B &Y');
    } elsif ($param eq 'weekofyear') { # Returns the current week of year
        if (&cfghandler('startweek') eq 'monday') {
        	return UnixDate('now','%W');
        } elsif (&cfghandler('startweek') eq 'sunday') {
                return UnixDate('now','%U');
        }
    } elsif ($param eq 'amount') { # Returns exact amount of time between two $datetime strings
        my $start = $_[1];
        my $end = $_[2];
        return DateCalc($start,$end);
    } elsif ($param eq 'approxamount') { # Returns approximate amount of time between two $datetime strings
        my $start = $_[1];
        my $end = $_[2];
        return DateCalc($start,$end,1);
    } elsif ($param eq 'calc') { # Calculates a Date based on $delta. (e.g.: "12 hours ago", "in 12 hours")
        my $date = $_[1];
        my $delta = $_[2];
        return DateCalc($date,$delta);
    } elsif ($param eq 'unixtime') {
	my $input = $_[1];
	return str2time($input);
    }
}

1;
