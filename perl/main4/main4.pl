use strict;
use warnings;

use Data::Dumper;

use Parser;
use LogCounter;

my $parser = Parser->new( filename => 'log2.ltsv' );
my $counter = LogCounter->new($parser->parse);
#print 'total error size: ' . $counter->count_error . "\n";
#print Dumper $counter->group_by_user;
#print Dumper $counter->group_by_path;
#print Dumper $counter->count_every_status;
#print $counter->reqtime_maxmin;
print $counter->status_graph;