 #!/usr/bin/perl -w
    use strict;
    use Log;
    #Boss->debug(1);

    my $log = Log->new();

    $log->epoch("0000000");
    $log->req("Pichon Alvarez");
    $log->status("Federico Jesus");
    $log->user("Fred");
    $log->referer("47");
    $log->size("Frank", "Felipe", "Faust");
	$log->host("aaa");

  use Data::Dumper;
    print Dumper($log);