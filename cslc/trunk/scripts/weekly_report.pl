#! /usr/bin/perl
use DBI;

&init;
&processExternalArgs;
&getSystemInfo;
&retrieveBugzillaStats;
&createXMlReport;
#&drawGnuPlotGraphs;


sub processExternalArgs {#processing the external arguments
    use Getopt::Long;

    #with =s it gets the string from the command line
    #without =s it sets the value to 1 if -myOption is typed or to 0 otherwise
    $result = GetOptions( 'v' => \$verbose,
                'hdl:s' => \$hdlExtParam,
                #'f:s' => \$testlist_filename,
                'dir:s' => \$dir,
                'reports:s' => \$reports_dir_copy,
                #'path:s' => \$all_sources_within_path,
                'h' => \$help,
                'valgrind:s' => \$valgrind,
                'vparser:s' => \$vparserPath,
                'vpreproc:s' => \$vpreprocPath,
                'root:s' => \$root,
                'nohistory' => \$nohistory,
                'cp:s' => \$copyTo,
                'list:s' => \$quickList,
                'version' => \$version
                );
     #if there is any argument left unfiltered (after filtering the options in the lines above) then it is an invalid use of the script
  unless( @ARGV==0 ) { die("[ERROR] Invalid use of this script. Type -h for details\n"); }
 
}

sub init {
    $reportsDir = ".";
}

sub getSystemInfo {

    $test_date_start = `date "+%d/%m/%G, %T"`;#getting the date and time for this regression run
    $test_nrsec_start = time();
    
    #create the hdl list if is set to 'all'
    if( $hdlExtParam eq all ) {
      @hdlList = ('preprocessor', 'v1995', 'v2001');
    } else {#else it is set to the command line option
      @hdlList = ( $hdlExtParam );
    }

    chomp( $arch = `arch` );#getting information about the current system
	
	$operatingSystem = `uname -o`;
    chomp($operatingSystem); 
    $cpu_speed = `cat /proc/cpuinfo|grep MHz`;
    $cpu_bogomips = `cat /proc/cpuinfo|grep bogomips`;
    $cpu_model = `cat /proc/cpuinfo|grep \"model name\"`;
    @mem = `cat /proc/meminfo|grep MemTotal` =~ /[0-9]+/g;
    $total_ram = int @mem[0]/1024;
    $gccVersionCmdOutput = `gcc -v 2<&1`;
    $gccVersionCmdOutput =~ /gcc[\s]+version[\s]+([\d]+\.[\d]+\.[\d]+)/g;
    $gcc_version = $1;
    $xml_header = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
    $xsl_include = "<?xml-stylesheet type=\"text/xsl\" href=\"xml_transform.xsl\"?>";
    $full_current_time=`date +%Y%m%d%H%M%S`;
    chomp($full_current_time);
    &display_message($cpu_speed);
    &display_message($cpu_bogomips);
    &display_message($cpu_model);
    &display_message($test_date_start);
    &display_message($operatingSystem);
    &display_message($gcc_version);
  

sub createXMlReport {
    open(xml_file,"+>$reportsDir/$full_current_time.xml");
    print(xml_file $xml_header."\n");
    print(xml_file $xsl_include."\n");
    print(xml_file "<weekly_report>"."\n");
    
    print(xml_file "<cpu_speed>$cpu_speed</cpu_speed>"."\n");
    print(xml_file "<operating_system>$operatingSystem</operating_system>"."\n");
    print(xml_file "<cpu_bogomips>$cpu_bogomips</cpu_bogomips>"."\n");
    print(xml_file "<cpu_model>$cpu_model</cpu_model>"."\n");
    print(xml_file "<test_date>$test_date_start</test_date>"."\n");
    print(xml_file "<gccVersion>$gcc_version</gccVersion>\n");

    print(xml_file "<totalBugs>$totalBugsNumber</totalBugs>\n");
    print(xml_file "<resolvedBugs>$totalResolvedBugs</resolvedBugs>\n");
    print(xml_file "<unresolvedBugs>$unresolvedBugsNumber</unresolvedBugs>\n");

    print(xml_file "</weekly_report>"."\n");    
    close(xml_file);
}
}

sub display_message {
    my( $message_content ) = @_;
    if( $verbose eq 1 ) {
        print"$message_content";
    }

}

sub connectToDb {

#############################################################
#connecting to bugzilla with perl dbi
#############################################################
    my $userName = "visitor";
    my $password = "bigsursoftware";
    my $host = "main";
    my $databaseName = "bugs";
    $dbHandler = DBI->connect("dbi:mysql:database=$databaseName;host=$host",$userName,$password) or die "couldn't connect to database: $DBI::errstr \n";

}

sub disconnectFromDb{
    $dbHandler->disconnect or die $DBI::errstr;
}

sub retrieveBugzillaStats{
    &connectToDb;
    $countAllBugsSQLCmd = "select count(bug_id) from bugs";
    $countUnresolvedBugsSQLCmd="select count(*) from bugs where bug_status=\"NEW\"";
    
    $statementHandler = $dbHandler->prepare ($countAllBugsSQLCmd);
    $statementHandler->execute();
    $totalBugsNumber = $statementHandler->fetchrow_array();
    &display_message("\ntotal bugs number:     $totalBugsNumber");
    
    $statementHandler=$dbHandler->prepare($countUnresolvedBugsSQLCmd);
    $statementHandler->execute();
    $unresolvedBugsNumber=$statementHandler->fetchrow_array();
    &display_message("\nunresolved bugs number: $unresolvedBugsNumber");
    $statementHandler->finish();
   

    $totalResolvedBugs=$totalBugsNumber-$unresolvedBugsNumber;
    &display_message("\nresolved bugs number : $totalResolvedBugs\n");
    &disconnectFromDb;
}

#sub drawGnuPlotGraphs {
 #   $gnuPlotConfigFileContent = "
#set term png small color
#set data style steps
#set grid
##set yrange [ 0 : 200 ]
#set title \"Bugzilla Statistics Graph\"
#set xlabel \"Time\"
#set ylabel \"Bugz Number\"
#plot\"plot-file.tmp\" using 1:2 title \"Total Bugs Number\"\
#, \"plot-file.tmp\" using 1:3 title \"New Bugs Number\"\
#, \"plot-file.tmp\" using 1:4 title \"Resolved Bugs Number\"\

#";
#if GNUPlot config file does not exist create it
 #   if (-e "gnuplot_config") {
	#$gnuPlotCmd = `gnuplot gnuplot_config > bugs_graph.png`;
   # } else {
	#print "Cannot open mydatafile!\n"."We are creating this file now...";
	#$createFile= `touch gnuplot_config`;
	#$createFileContent=$gnuPlotConfigFileContent> gnuplot_config;
   # }
#}


