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
	open my $fh, '<', 'log2.ltsv' or die $!;
	my @lines = <$fh>;
	foreach my $line(@lines){#1つずつのデータに対するループ
	my $log = Log->new();
	$line =~ s/http:/httpc/;  #URL内の:を"c"に変換
	chomp($line); #行末の改行をとりはらう
	my @line_ar = split(/\t/, $line);
	my %log_ar = map{(split(/:/,$_))[0]=>(split(/:/,$_))[1]}@line_ar;
	if($log_ar{"referer"}){
		$log_ar{"referer"} =~ s/httpc/http:/;
	}
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
