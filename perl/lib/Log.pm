package Log;
use strict;
use warnings;

$ENV{'TZ'}= "GMT+0";

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

 sub method{
		my $self = shift;
		
		my @req_ar = split(/ /, $self->{req});
		return $req_ar[0];
    }
	
	
   sub path{
        my $self = shift;
		my @req_ar = split(/ /, $self->{req});
		return $req_ar[1];
        
    }
    
    sub protocol{
        my $self = shift;
		my @req_ar = split(/ /, $self->{req});
		return $req_ar[2];
        
    }
    
    sub uri{
         my $self = shift;
		my @req_ar = split(/ /, $self->{req});
		my @pro_ar = split('/', $req_ar[2]);
		return lc($pro_ar[0])."://".$self->{host}.$req_ar[1];
        
    }
    
    sub time{
        my ($self, $filename) = @_;
		my $ep_time = $self->{epoch}; 
		my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime($ep_time);
		my $mod_year = $year + 1900;
		my $mod_mon = sprintf("%02d",$mon+1);
		my $mod_day = sprintf("%02d",$mday);
		my $mod_hour = sprintf("%02d",$hour);
		my $mod_min = sprintf("%02d",$min);
		my $mod_sec = sprintf("%02d",$sec);
		my $timestr = "$mod_year-$mod_mon-${mod_day}T$mod_hour:$mod_min:$mod_sec";
		return $timestr;
        
    }

1;
