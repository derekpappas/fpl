#!/usr/bin/perl
#Maintainers(s): Ines and Petronela and Derek

#use Switch;               # the switch/case command
#use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command
use POSIX;                # POSIX functions


&removeHistoryDirs();
&compare_results();

#################################################################################################
#                                          removeHistoryDirs                                    #
#subroutine for creating history dirs                                                           #
#1. find out how many directories are already present.                                          #
#2. delete the oldest results if it is necessary                                                #
#################################################################################################

sub removeHistoryDirs 
{
    print "[INFO] removeHistoryDirs: begin \n";

# 10 different directory for the results (date and time in the name of the directory)

#first step: find out how many directories are already present.
    my $DIR;
    if(! defined $ENV{WORK}){
        die "[ERROR] The environment variable WORK is not set. Set it to point to $TOT/cslc";
    }  
    $totDir             = $ENV{WORK};
    $miscRootDir        = "$totDir/misc";           #initialising the TOT path (root path of the entire project directory)
    $scriptDir          = "$miscRootDir/scripts";
    $testRootDir        = "$miscRootDir/test";  
    $cslTestRootDir     = "$testRootDir/csl";
    $verilogTestRootDir = "$testRootDir/verilog";
    $reportRootDir      = "$testRootDir/report";

    opendir($DIR, "$reportRootDir");
    @resultsDirArray = grep { /(results_)/ } readdir($DIR);
    closedir($DIR);
    @sortedResultsDirArray = sort(@resultsDirArray);
    $numberOfReports = @sortedResultsDirArray;
    print "[INFO] Number of reports in history = $numberOfReports\n";
    print "[INFO] Directories found: @sortedResultsDirArray\n";

#second step: deleting the oldest results if it is necessary
    if  ( $numberOfReports < 10 ) { print "[INFO] Less than 10... Doing nothing!\n"; } 
    elsif ($numberOfReports > 9 ) {
        print("[INFO] Exactly or more than 10... Deleting the oldest directory!\n");
        #the oldest directory is the first in the list
        if( -e "$reportRootDir/$sortedResultsDirArray[0]" ) {
            my $rmResult = `rm -rf "$reportRootDir/$sortedResultsDirArray[0]" `;
            print("[INFO] The result of the remove: $rmResult\n");
        } 
        else { print("[ WARNING ] Directory $reportRootDir/$sortedResultsDirArray[0] doesn't exist to be removed!\n"); }
    }
    print "[INFO] removeHistoryDirs: end \n";
}

#################################################################################################
#                                      compare_results                                          #
#subroutine for comparing results from 2 different logs                                         #
#################################################################################################

sub compare_results {   
 
    print "[INFO] compare_results: begin \n";

    if (-e "result.txt")
    {
        `echo "" >result.txt`;
    }
    open ( RF, ">result.txt");
    my $regressDir1;
    my $regressDir2;
    opendir($regressDir1, "$reportRootDir/$sortedResultsDirArray[$numberOfReports-2]");
    my @currentHdl1 = grep  { /csl(?!_)/ }  readdir($regressDir1);
    closedir($regressDir1);

    opendir($regressDir2, "$reportRootDir/$sortedResultsDirArray[$numberOfReport-1]");
    my @currentHdl2 = grep { /csl(?!_)/ } readdir($regressDir2);
    closedir($regressDir2);
     if ($currentHdl2 eq $currentHdl1)
    {
        opendir($chapterDir1, "$reportRootDir/$sortedResultsDirArray[$numberOfReports-2]/@currentHdl1[0]");
        my @chapterArray1 = sort( grep { !/\./ && !/(log)/ } readdir($chapterDir1));
        closedir($chapterDir1);
        opendir($chapterDir2, "$reportRootDir/$sortedResultsDirArray[$numberOfReports-1]/@currentHdl2[0]");
        my @chapterArray2=  sort( grep { !/\./ }readdir($chapterDir2));
        closedir($chapterDir2);

        foreach $chapter1 (@chapterArray1)
        {
            foreach $chapter2 (@chapterArray2) 
            {
               if ($chapter2 eq $chapter1)
               {
                   opendir($htmlPagesDir1, "$reportRootDir/$sortedResultsDirArray[$numberOfReports-2]/@currentHdl1[0]/$chapter1");
                   my @htmlPagesArray1 = sort( grep { /(.html)/} readdir($htmlPagesDir1));
                   closedir($htmlPagesDir1);
                   opendir($htmlPagesDir2, "$reportRootDir/$sortedResultsDirArray[$numberOfReports-1]/@currentHdl2[0]/$chapter2");
                   my @htmlPagesArray2 = sort( grep { /(.html)/} readdir($htmlPagesDir2));
                   closedir($htmlPagesDir2);

                   my $pattern = "\\\s*<td\\\s*class\\\s*=\\\s*\\\"([^\\\"]+)\\\"\\\s*>\\\s*<\\\s*a\\\s*href\\\s*=\\\s*\\\"[^\\\"]+\\\"\\\s*target\\\s*=\\\s*\\\"mainframe\\\"\\\s*>\\\s*([^\<]+)\<\\\s*\\\/a\\\s*>\\\s*<\\\s*\/td\\\s*>";                   
                   #print "pat = $pattern\n";
                   
                   
                   foreach $htmlPage1 (@htmlPagesArray1)
                   {
                       foreach $htmlPage2 (@htmlPagesArray2)
                       {
                           if ($htmlPage2 eq $htmlPage1) 
                           { 
                               
                               if (-e "$chapter1.txt")
                               {
                                   `echo "" >$chapter1.txt`;
                               }
 
                               print RF "$chapter1\n";

                               `sdiff --width=600 $reportRootDir/$sortedResultsDirArray[$numberOfReports-2]/@currentHdl1[0]/$chapter1/$htmlPage1 $reportRootDir/$sortedResultsDirArray[$numberOfReports-1]/@currentHdl1[0]/$chapter2/$htmlPage2 >>$chapter1.txt`; 

                               open ($listFile, "<$chapter1.txt") or die "[ERROR] Can't open the file containing the errors list!\n";

                               foreach my $line (<$listFile>) {
                                   if ($line =~ m/end_test_result/) {
                                       print "*\n";
#                                           chomp($line);
#                                           if( $line =~ m/$pattern\s+$pattern/ ) { 
#                                               print "1 matched 1 = $1 2 = $2\n";
#                                           } 
#                                           elsif( $line =~ m/$pattern\s+|\s+$pattern/ ) {  
#                                               print "2 matched 1 = $1 2 = $2\n";
#                                           }
#                                           else {
#                                               print "mismatched\n";
#                                           }
#                                       if($line =~ m/<td class="file_name">/) {
#                                           $lastLine = $line;
#                                           break;
#                                       }
#                                           $line++;
##                                       $status = $1;
##                                       if    ($status =~ m/(passed)/) { print RF "1 "; }
##                                       elsif ($status =~ m/(failed)/) { print RF "0 "; }
##                                       else  { print RF "2 "; }
##
#                                       
                                   }
                               }
                           }
                       }
                   }

                   printf "$chapter1 \n";
               }
           }
        }
    }


    print "[INFO] compare_results: end \n";

}


