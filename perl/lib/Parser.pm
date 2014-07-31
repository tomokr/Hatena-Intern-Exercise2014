package Parser;
use strict;
use warnings;
use Log;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub parse {
	
	my @parsed_log = ();
	open my $fh, '<', 'log.ltsv' or die $!;
	my @lines = <$fh>;
	foreach my $line(@lines){#1つずつのデータに対するループ
	my $log = Log->new();
	$line =~ s/http:/httpc/;  #URL内の:を"c"に変換 謎の改行？？
	my @line_ar = split(/\t/, $line);
	my %log_ar = map{(split(/:/,$_))[0]=>(split(/:/,$_))[1]}@line_ar;
	$log_ar{"referer"} =~ s/httpc/http:/;
	foreach(keys %log_ar){
		my $Key = $_;
		my $Value = $log_ar{$Key};
		if($Value !~ "-"){
		$log->$Key($Value);
		}
	}
	
	push(@parsed_log, $log);
	
	}
	
	return \@parsed_log;
}

1;
