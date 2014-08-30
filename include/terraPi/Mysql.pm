package terraPi::Mysql;
require Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(sql_sensor_write sql_read_sensor graph_raspberry);
use strict;
use warnings;
use terraPi::Config;
use terraPi::Functions;
use terraPi::Graph;
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

sub sql_read_sensor {
        my $duration = $_[0];
        my $sensorid = $_[1];
        my $subsensor = $_[2];
        if ($duration eq 'all') {
                my @dataset;
		my $sth = $dbh->prepare("SELECT `timestamp`, `data` FROM `sensor_data` WHERE `sensor_id` = $sensorid AND `sub_id` = $subsensor");
		$sth->execute;
                while (my $row = $sth->fetchrow_hashref) {
                        push @dataset, { time => &timehandler('unixtime',$row->{timestamp}), value => $row->{data} };
                }
	return @dataset;
        }
}

sub graph_raspberry {
        my $sensorid = "1";
        my $subid = $_[0];
        my @data = &sql_read_sensor('all',$sensorid,$subid);
	open GRAPH, ">", "/home/pi/scripts/terraPi/web/graph/$sensorid\_$subid\_graph.png" or die $!;
        print GRAPH &graph(@data);
	close GRAPH;
}

1;
