#! /usr/bin/perl


my @wsList = (1,2,3,5,6,7,9,10,11,12,13);
my $storage = "/storage/users/dist_regress/repo1/cslc";

my $pid = getppid();

$results_date = $ARGV[0];

my $resultsRootDir = "$storage/test/report/$results_date"; 

print "resultsRootDir = $resultsRootDir\n\n";

################################################################################
# copy the regression results from each work station to the server
################################################################################

    foreach my $ws (@wsList) { # the work station numbers are stored a in a list-some are missing-can't just count
        my $scpCmd = "ssh  dist_regress\@fpl64-$ws.fplsrl.com -p 22 svn up $storage";
        print "$ws -> $scpCmd\n";
        `$scpCmd`;
    }

################################################################################
# merge the results files into one summary
# run_regress.pl -no_exec -hdl csl -val -results_dir $resultsRootDir
# build the top level html summary
################################################################################

#    `run_regress.pl -no_exec -hdl csl -results_dir $resultsRootDir`;

