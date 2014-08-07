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
			if($plog->user && $plog->user eq $hash_user){
				push(@logar, $plog);
			}
		}

	$group_by_user_ar{$hash_user} = \@logar;

	}

	return \%group_by_user_ar;
}

##500番台をカウントする
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

##pathでグループわけ
sub group_by_path{
	my $self = shift;
	my @parsed_logs = @{$self->{logs}};
	my @paths = ();

	#パスのリストをつくる
	foreach my $plog (@parsed_logs){
		my $path = $plog->path;
		if($path){
		push(@paths, $path);
		}
	}

	#特定のパスの配列をつくって、パスのハッシュとともに連想配列にいれる
	my %group_by_path_ar = map { $_ => 1 } @paths;

	foreach my $hash_path (keys %group_by_path_ar){
		my @logar = ();

		foreach my $plog (@parsed_logs){
			if($plog->path && $plog->path eq $hash_path){
				#完全に一致は eq をつかう。=~だと含まれるになってしまう
				push(@logar, $plog);
			}
		}
	$group_by_path_ar{$hash_path} = \@logar;
	}

	return %group_by_path_ar;
}

sub status_graph{
	my $self = shift;
	my %logs = $self->group_by_path;

	print "\nSTATUS CODE COUNT FOR EVERY URI (=: POST, *:GET)\n\n";
	foreach my $uri (keys %logs){

	my @parsed_logs = @{$logs{$uri}};

	my (@post_logs, @get_logs);
	foreach (@parsed_logs){#postとgetにわける
		if($_->method eq 'POST'){
			push @post_logs, $_;
		}else{
			push @get_logs, $_;
		}
	}
	my %post_counts = $self->count_every_status(@post_logs);
	my %get_counts = $self->count_every_status(@get_logs);

	print "URI:$uri\n---:    5    10\n";

	foreach my $code (keys %post_counts){
		print "${code}:";
		#POSTの場合
		my $countp = 0;
		while($countp < $post_counts{$code}){
			$countp++;
			print "="
		}
		delete $post_counts{$code};
		#GETの場合
		if($get_counts{$code}){
			my $countg = 0;
			while($countg < $get_counts{$code}){
				$countg++;
				print "*"
			}
		}
		delete $get_counts{$code};
		print "\n";
			}#POSTのハッシュによる展開おわり

		#POSTにないステータスコードをGETがもっていた場合
		if(%get_counts){
			foreach my $hash(keys %get_counts){
				print "${hash}:";
				my $count = 0;
				while($count < $get_counts{$hash}){
				$count++;
				print "*"
				}
			print "\n";
			}
		}
		print "\n";
	}#それぞれのURIに対するループおわり

	print "\n";
	#return \%post_counts;
}

##それぞれのステータスコードの回数をカウント、配列を変数にして渡せる
sub count_every_status {
	my $self = shift;
#	my @parsed_logs = @{$self->{logs}};
	my %counts;

#	foreach my $plog (@parsed_logs){
	foreach my $plog (@_){
		my $status = $plog->status;
		if($counts{$status}){
			$counts{$status}++;
		}else{
			$counts{$status} = 1;
		}
	}
	return %counts;
}

##リクエストタイムの最大値と最小値を得る
sub reqtime_maxmin {
	my $self = shift;
	my @parsed_logs = @{$self->{logs}};
	my $reqtime_max;
	my $reqtime_min;
	$reqtime_max = 0;
	$reqtime_min = 10000000; #ありえないくらい大きい数をいれる必要がある

	foreach my $plog (@parsed_logs){
		my $time = $plog->reqtime_microsec;
		$reqtime_max = $time if $time > $reqtime_max;
		$reqtime_min = $time if $time < $reqtime_min;
	}

	return ($reqtime_max, $reqtime_min);
}

1;
