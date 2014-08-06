use strict;
use warnings;

use Data::Dumper;

use Parser;

my $parser = Parser->new( filename => 'log2.ltsv' );
warn Dumper $parser->parse;
