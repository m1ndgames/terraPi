package terraPi::Config::Mysql;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(sqlhandler);
use strict;
use warnings;
use DBI;
use Config::Simple;

# Initializing DBI Module
sub sqlhandler {
	my $parameter = $_[0];
	
	my $dbh = DBI->connect("DBI:mysql:database=mydb;host=" . &cfghandler('sqlhost') . ";port=" . &cfghandler('sqlport') . "," . &cfghandler('sqluser'), &cfghandler('sqlpass')) or die $DBI::errstr;
	if ($parameter eq 'read') {
		
	} elsif ($parameter eq 'write') {
		
	}
}

1;
