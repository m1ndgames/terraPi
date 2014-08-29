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

my $sqluser = &cfghandler('sqluser');
my $sqlpass = &cfghandler('sqlpass');
my $sqlhost = &cfghandler('sqlhost');
my $sqldb = &cfghandler('sqldb');
my $sqlport = &cfghandler('sqlport');
my $dsn = "dbi:mysql:$sqldb:$sqlhost:$sqlport";
my %dbattr = ( PrintError=>0, RaiseError=>1);          
my $dbh  = DBI->connect($dsn,$sqluser,$sqlpass, \%dbattr);

our $q = CGI->new;
our $site = $q->param('site');
our $home = $q->url();

my $session = new CGI::Session(undef, $q, {Directory=>'../data/sessions'});
$session->expire('is_logged_in', '+10m');
$session->expire('+1h');

my $auth = new CGI::Session::Auth::DBI({
      CGI => $q,
      Session => $session,
      DSN => $dsn,
      DBUser => $sqluser,
      DBPasswd => $sqlpass,
});

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

sub language_menu {
	my $default_lang = &cfghandler('language');
	print $q->popup_menu(
        	-name => 'language_menu',
                -values => ['English','Deutsch'],
                -default => $default_lang) . $q->submit(-value=>'Submit');
}

sub print_html_body {
	if ($site eq 'admin') {
		print $q->startform;
		print $q->textfield(-name=>'username',
		-size=>35,
		-maxlength=>50);
                print $q->password_field(-name=>'password',
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

sub checklogin {
	my $auth = new CGI::Session::Auth::DBI({
		CGI => $q,
		Session => $session,
		DSN => $dsn,
		DBUser => $sqluser,
		DBPasswd => $sqlpass,
	});
	$auth->authenticate();
	if ($auth->loggedIn) {
	        return 1;
	}
	else {
        	return 0;
	}
}

# Print Page
&print_html_header();

&print_html_top();

if (&checklogin()) {
	print("User is logged in");
}
else {
	print("User is not logged in");
}

&print_html_body();

&print_html_footer();
