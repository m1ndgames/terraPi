#!/usr/bin/perl
use lib "/home/pi/scripts/terraPi/include";
use terraPi::Config;
use terraPi::Config::User;
use terraPi::Mysql;
use terraPi::Graph;
use terraPi::Language;
use terraPi::Sensors::BMP085;
use terraPi::Sensors::Raspberry;
use strict;
use warnings;

write_raspberry();
write_BMP085();

# Raspberry
sub write_raspberry {
	my $sensorid = '1';
	my $t = &raspberry('temp');
	my $v = &raspberry('volts');
	my $c = &raspberry('clock');
	&sql_sensor_write($sensorid,'1','temperature',$t);
	graph_raspberry('1');
	&sql_sensor_write($sensorid,'2','volts',$v);
	graph_raspberry('2');
	&sql_sensor_write($sensorid,'3','clock_speed',$c);
	graph_raspberry('3');
}

# BMP085
sub write_BMP085 {
	my $sensorid = '2';
	my $t = &BMP085('t');
	my $p = &BMP085('p');
	&sql_sensor_write($sensorid,'1','temperature',$t);
	&sql_sensor_write($sensorid,'2','pressure',$p);
}
