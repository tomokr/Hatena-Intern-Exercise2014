package LogCounter;
use strict;
use warnings;
use Parser;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
	my $self = shift;
	my @parsed_logs = @{$self->{logs}};
	my @users = ();
	
	#ユーザーのリストをつくる
	foreach my $plog (@parsed_logs){
		my $user = $plog->user;
		if($user){
		push(@users, $user);
		}
	}
	
	#特定のユーザーの配列をつくって、ユーザー名のハッシュとともに連想配列にいれる
	my %group_by_user_ar = map { $_ => 1 } @users;
		
	#ユーザー名がない人の処理
	my @logar = ();
		foreach my $plog (@parsed_logs){
			if(!$plog->user){
				push(@logar, $plog);
			}
		}
	$group_by_user_ar{"guest"} = \@logar;
	
	
	#ユーザー名がある人の処理
	foreach my $hash_user (@users){
		my @logar = ();
		foreach my $plog (@parsed_logs){
			if($plog->user && $plog->user =~ $hash_user){
				push(@logar, $plog);
			}
		}
		
	$group_by_user_ar{$hash_user} = \@logar;
	
	}
	
	return \%group_by_user_ar;
}

sub count_error {
	my $self = shift;
	my @parsed_logs = @{$self->{logs}};
	my $count = 0;
			
	foreach my $plog (@parsed_logs){
		my $status = $plog->status;
		my $mod_status = $status -500;
		if($mod_status>=0 && $mod_status <100){ #$status/100 == 5でうまくいかなかった
			$count++;
		}
	}
	return $count;
}

1;
