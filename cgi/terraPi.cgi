#!/usr/bin/perl
use strict;
use warnings;
use lib "../include";
use terraPi::Config;
use terraPi::Config::Mysql;
use terraPi::Config::User;
use terraPi::Language;
use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Session;
use CGI::Session::Auth;
use CGI::Session::Auth::DBI;
use HTML::Template;

our $q         = CGI->new;
our $site      = $q->param('site');
our $home      = $q->url();
our $logged_in = &checklogin($q);
our $template;

print $q->header();

if ( $site eq 'admin' ) {
    if ( &checklogin($q) == 1 ) {
        $template =
          HTML::Template->new( filename => '../data/web_templates/admin.tmpl' );
    }
    else {
        $template =
          HTML::Template->new( filename => '../data/web_templates/login.tmpl' );
    }
}
elsif ( $site eq 'sensors' ) {
    $template =
      HTML::Template->new( filename => '../data/web_templates/sensors.tmpl' );
}
elsif ( $site eq 'BMP085' ) {
    $template =
      HTML::Template->new( filename => '../data/web_templates/BMP085.tmpl' );
}
elsif ( $site eq 'Raspberry' ) {
    $template =
      HTML::Template->new( filename => '../data/web_templates/Raspberry.tmpl' );
}
else {
    $template =
      HTML::Template->new( filename => '../data/web_templates/index.tmpl' );
}

print $template->output();
