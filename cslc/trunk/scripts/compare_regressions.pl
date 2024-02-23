#################################################################################################
#                                          removeHistoryDirs                                    #
#subroutine for creating history dirs                                                           #
#1. find out how many directories are already present.                                          #
#2. delete the oldest results if it is necessary                                                #
#################################################################################################

sub removeHistoryDirs {

    print "[INFO] removeHistoryDirs: begin \n";

# 10 different directory for the results (date and time in the name of the directory)

#first step: find out how many directories are already present.
    my $DIR;
    opendir($DIR, "$test_parser_dir/reports/");
    my @resultsDirArray = grep { /(results_)/ } readdir($DIR);
    closedir($DIR);
    my @sortedResultsDirArray = sort(@resultsDirArray);
    my $numberOfReports = @sortedResultsDirArray;
    &display_message("[INFO] Number of reports in history = $numberOfReports\n");
    &display_message("[INFO] Directories found: @sortedResultsDirArray\n");

#second step: deleting the oldest results if it is necessary
    if  ( $numberOfReports < 10 ) { &display_message("[INFO] Less than 10... Doing nothing!\n"); } 
    elsif ($numberOfReports > 9 ) {
        &display_message("[INFO] Exactly or more than 10... Deleting the oldest directory!\n");
        #the oldest directory is the first in the list
        if( -e "$test_parser_dir/reports/$sortedResultsDirArray[0]" ) {
            my $rmResult = `rm -rf "$test_parser_dir/reports/$sortedResultsDirArray[0]" `;
            &display_message("[INFO] The result of the remove: $rmResult\n");
        } 
        else { print("[ WARNING ] Directory $test_parser_dir/reports/$sortedResultsDirArray[0] doesn't exist to be removed!\n"); }
    }
    print "[INFO] removeHistoryDirs: end \n";
}

#################################################################################################
#                                      compare_results                                          #
#subroutine for comparing results from 2 different logs                                         #
#################################################################################################

sub compare_results {
    my $File1 = "";
    my $File2 = "";

    print "[INFO] compare_results: begin \n";
    
    open (FH1, "<$File1") or die "[ERROR] compare_results: Can't open the file containing the !\n";
    open (FH1, "<$File2") or die "[ERROR] compare_results: Can't open the file containing the !\n";
    
    foreach my $line (<$File1>) {
        chomp($line);
        
        if( $line =~ m/(^[ \t]*\#)/ ) { #commentary, skipping the entire line
            next;#it's realy not necessary for this line to be here...
            } 
    }
    foreach $k(@StageNamelist){
        $fileStagesErrors{$k} = "";
    }
    close(FH1);
    close(FH2);
    print "[INFO] compare_results: end \n";
}

