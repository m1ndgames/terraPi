#!/usr/bin/perl
use strict;
use warnings;
use lib "/home/pi/scripts/terraPi/include";
use terraPi::Config;
use terraPi::Config::User;
use terraPi::Mysql;
use terraPi::Language;
use terraPi::Sensors::BMP085;
use terraPi::Sensors::Raspberry;
use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Session;
use CGI::Session::Auth;
use CGI::Session::Auth::DBI;
use HTML::Template;

our $q          = CGI->new;
our $site       = $q->param('site');
our $showsensor = $q->param('showsensor');
our $home       = $q->url();
our $logged_in  = &checklogin($q);
our $template;

print $q->header();

if ( $site eq 'index' ) {
    $template =
      HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/index.tmpl' );
}
elsif ( $site eq 'admin' ) {
    if ( &checklogin($q) == 1 ) {
        $template =
          HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/admin.tmpl' );
    }
    else {
        $template =
          HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/login.tmpl' );
    }
}
elsif ( ( $site eq 'sensors') && ($showsensor eq 'overview') ) {
    $template =
      HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/sensoroverview.tmpl',
        die_on_bad_params => 0 );
    $template->param( sensorlist => 1 );
}
elsif ( ( $site eq 'sensors' ) && ( $showsensor eq 'BMP085' ) ) {
    my $sensorid = '1';
    my $t        = &BMP085('t');
    my $p        = &BMP085('p');
    $template =
      HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/BMP085.tmpl' );
    $template->param( SENSORID    => $sensorid );
    $template->param( BMP085TEMP  => $t );
    $template->param( BMP085PRESS => $p );
    $template->param( sensorlist => 1 );
}
elsif ( ( $site eq 'sensors' ) && ( $showsensor eq 'Raspberry' ) ) {
    my $sensorid = '1';
    my $t        = &raspberry('temp');
    my $v        = &raspberry('volts');
    my $c        = &raspberry('clock');
    $template =
      HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/Raspberry.tmpl' );
    $template->param( SENSORID   => $sensorid );
    $template->param( RASPITEMP  => $t );
    $template->param( RASPIVOLTS => $v );
    $template->param( RASPICLOCK => $c );
    $template->param( sensorlist => 1 );
}
else {
    $template =
      HTML::Template->new( filename => '/home/pi/scripts/terraPi/data/web_templates/index.tmpl' );
}

print $template->output();
