#!/usr/bin/perl
use strict;
use warnings;
use lib "../include";
use terraPi::Config;
use terraPi::Config::Mysql;
use terraPi::Language;
use CGI;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI::Session;
use CGI::Session::Auth;
use CGI::Session::Auth::DBI;
use HTML::Template;

our $q = CGI->new;
my $session = new CGI::Session(undef, $q, {Directory=>'../data/sessions'});
my $auth = new CGI::Session::Auth::DBI({
      CGI => $q,
      Session => $session,
      DSN => ("dbi:mysql:host=" . &cfghandler('sqlhost') . ",database=" . &cfghandler('db')),
});
  $auth->authenticate();
  
  if ($auth->loggedIn) {
}
  else {
}

our $site = $q->param('site');
our $home = $q->url();

sub print_html_header {
    print "Content-type:  text/html\n\n";
    my $jquery = 'http://code.jquery.com/jquery-1.4.4.min.js';
    print "<head>\n";
    print "<link rel='stylesheet' type='text/css' href='/themes/" . &cfghandler('css') . ".css'>\n";
    print "<script src='$jquery'  type='text/javascript'></script>\n";
    print "</head>\n";
}

sub print_html_top {
        print "<body>\n";
        print $q->center($q->a({href=>"$home"},"Home") . " - " . $q->a({href=>"$home?site=admin"},"Admin") . $q->br . $q->hr);
}


sub print_html_body {
	if ($site eq 'admin') {
		print $q->startform;
		print $q->user_field(-name=>'log_username',
		-size=>35,
		-maxlength=>50);
                print $q->password_field(-name=>'log_password',
                -size=>35,
                -maxlength=>50);
		print $q->submit(-value=>'Submit');
		print $q->endform;
	} elsif (($site eq 'admin') && (param('passwd') eq &cfghandler('adminpass'))) {
		print "yay\n";
	}
}

sub print_html_footer {
        print $q->hr;
        print $q->end_html;
}

# Print Page
&print_html_header();

&print_html_top();

&print_html_body();

&print_html_footer();
