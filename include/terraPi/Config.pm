package terraPi::Config;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(cfghandler);
use strict;
use warnings;
use Config::Simple;
our $cfg;

# Initializing Config::Simple Module
$cfg = new Config::Simple(syntax=>'ini');
$cfg->read("../conf.d/terraPi.conf");

sub cfghandler {
        return $cfg->param("config.$_[0]");
}

1;
