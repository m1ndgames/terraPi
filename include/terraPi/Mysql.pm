package terraPi::Mysql;
require Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(mysqltime sql_sensor_write);
use strict;
use warnings;
use terraPi::Config;
use terraPi::Functions;
use DBI;
use Config::Simple;

# Initializing DBI Module
my $sqluser = &cfghandler('sqluser');
my $sqlpass = &cfghandler('sqlpass');
my $sqlhost = &cfghandler('sqlhost');
my $sqldb   = &cfghandler('sqldb');
my $sqlport = &cfghandler('sqlport');
my $dsn     = "dbi:mysql:$sqldb:$sqlhost:$sqlport";
my %dbattr  = ( PrintError => 0, RaiseError => 1 );
my $dbh     = DBI->connect( $dsn, $sqluser, $sqlpass, \%dbattr );

sub sql_sensor_write {
    my $sensorid = $_[0];
    my $subid = $_[1];
    my $sensortype = $_[2];
    my $sensordata = $_[3];
    my $sth = $dbh->prepare(q{ INSERT INTO sensor_data (sensor_id,sub_id,type,data,date,time)
	VALUES (?,?,?,?,?,?)});
    $sth->execute($sensorid, $subid, $sensortype, $sensordata, &timehandler('date'), &timehandler('time')) or die $DBI::errstr;
    $sth->finish();
}

1;
