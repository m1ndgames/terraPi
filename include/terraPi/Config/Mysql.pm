package terraPi::Config::Mysql;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(sqlhandler);
use strict;
use warnings;
use terraPi::Config;
use DBI;
use Config::Simple;

# Initializing DBI Module
my $sqluser = &cfghandler('sqluser');
my $sqlpass = &cfghandler('sqlpass');
my $sqlhost = &cfghandler('sqlhost');
my $sqldb = &cfghandler('sqldb');
my $sqlport = &cfghandler('sqlport');
my $dsn = "dbi:mysql:$sqldb:$sqlhost:$sqlport";
my %dbattr = ( PrintError=>0, RaiseError=>1);
my $dbh  = DBI->connect($dsn,$sqluser,$sqlpass, \%dbattr);

sub sqlhandler {
	return 1;
}

1;
