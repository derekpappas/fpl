package FplLib;

use File::Path;
#
#our @ISA = qw(Exporter);
#our @EXPORT = qw(
#    testFileExists             
#    testDirExists              
#    mkDir                      
#    copyFile                   
#    file_exists                
#    display_message            
#    regressHdl                 
#    generate_hdl_directory_list
#    getSvnRevision              
#    sortDirectories          
#    );
#
#

#################################################################################################################################################
# helper functions
#################################################################################################################################################

sub testFileExists {
    my($execName) = @_;
    unless(-e $execName) { die "[ERROR] The file $execName does not exist!\n"; }
    # print "[INFO] file $execName exists\n";
}

sub testDirExists {
    my($dirName) = @_;
    unless(-e $dirName) { die "[ERROR] The directory $dirName does not exist!\n"; }
    # print "[INFO] directory $dirName exists\n";
}

sub mkDir {
    my($dirName) = @_;
    unless(-e $dirName)  { mkpath("$dirName"); }
    # print "[INFO] Created directory $dirName\n";
}

sub copyFile {
    my($fileName, $dirName) = @_;
    # print "[INFO] cp $fileName $dirName\n";
    unless(-e "$fileName" && -e "$dirName" ) { `cp $fileName $dirName` };
}

#################################################################################################
#                                          file_exists                                          #
#subroutine for testing if a file exists and gives an warning message                           #
#################################################################################################

sub file_exists {
    my ($name) = @_;
    unless (-e $name) { print ("[ERROR] File doesn't exist: '$name'\n"); return 0;}
    return 1;
}

#################################################################################################
#                                          display_message                                      #
#subroutine for printing a message                                                              #
#################################################################################################

sub display_message {
    my ($message_content) = @_;
#    if( $verbose eq 1 ) {print "$message_content"; }
}


################################################################################
# do not edit below this line
# file must return true
################################################################################

1; 
