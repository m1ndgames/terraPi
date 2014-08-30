package terraPi::Config::User;
require Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(checklogin);
use strict;
use warnings;
use terraPi::Config;
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

sub checklogin {
    my $cgi = $_[0];
    my $session =
      new CGI::Session( undef, $cgi, { Directory => '/home/pi/scripts/terraPi/data/sessions' } );
    $session->expire( 'is_logged_in', '+10m' );
    $session->expire('+1h');
    my $auth = new CGI::Session::Auth::DBI(
        {
            CGI      => $cgi,
            Session  => $session,
            DSN      => $dsn,
            DBUser   => $sqluser,
            DBPasswd => $sqlpass,
        }
    );
    $auth->authenticate();
    if ( $auth->loggedIn ) {
        return 1;
    }
    else {
        return 0;
    }
}

1;
