package terraPi::Language;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(output);
use strict;
use warnings;
use Config::Simple;
use terraPi::Config;

our $langcfg;

# Initializing Language Data
my $language = &cfghandler('language');
$langcfg = new Config::Simple(syntax=>'ini');
$langcfg->read("../data/language.db");

sub output {
        return $langcfg->param("$_[0].line$_[1]");
}

1;
