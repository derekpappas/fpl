#!/usr/bin/perl -w
# Change above line to point to your perl binary

use strict;
use lib "$ENV{WORK}/trunk/scripts";
use FplLib;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/cslc";
}  
my $totDir      = $ENV{WORK};
my $mifDir      = "$totDir/misc/docs/lang_manuals/mif";
my $parserDir   = "$totDir/trunk/src/parser/csl";

&FplLib::testDirExists($totDir            );
&FplLib::testDirExists($mifDir            );

&main();

# get the cmd summary
# get the list of cmds
# list the cmd summary
# foreach command in the cmd summary list the file order number of the cmd outside of the cmd summary
# list the commands in the cmd summary which do not appear in the rest of the doc
# list the commands in the cmd summary which appear out of order in the rest of the doc
# foreach command in the cmd summary list the file order number of the cmd outside of the cmd summary
# list the commands in the rest of the doc do not appear in the cmd summary
# list the tests in the cooresponding directory(s) that contain each command


sub main {

# get the list of commands in the lexer
# so that the commands can be looked up
    my $lexerFile = "$parserDir/csl.lexer.g";
    open (FH, $lexerFile) or die "[ERROR] could not open lexer file: $lexerFile\n";
    my @lexerFileLines = <FH>;

    my %lexerCmdMap = ();
    my $cmd = "";
    for ( my $i = 0; $i <= $#lexerFileLines; $i++ ) {
        my $line = $lexerFileLines[$i];

        if ($line =~ m/K_CSL[^=]+=\s*\"([^\"]+)\"\s*;/) {
            $cmd = $1;
            $lexerCmdMap{$cmd} = 0; 
            print "Found Lexer cmd = $cmd\n";
        }
        elsif ($line =~ m/K_SET[^=]+=\s*\"([^\"]+)\"\s*;/) {
            $cmd = $1;
            $lexerCmdMap{$cmd} = 0; 
            print "Found Lexer cmd = $cmd\n";
        }
        elsif ($line =~ m/K_GET[^=]+=\s*\"([^\"]+)\"\s*;/) {
            $cmd = $1;
            $lexerCmdMap{$cmd} = 0; 
            print "Found Lexer cmd = $cmd\n";
        }

    }


    my $ls_cmd = "ls $mifDir/*mif"; #select only the regular files from the current tests dir
    print "[INFO] generate_hdl_directory_list ls_cmd = $ls_cmd\n";
    my $fileList = `$ls_cmd`;
    print "[INFO] generate_hdl_directory_list = $fileList\n";
    my @fileList = split(/\n/, $fileList);
    print "[INFO] generate_hdl_directory_list = @fileList\n";

    my $errorCnt = 0;

    foreach my $mifFile (@fileList) {
        my %cmdInSummaryMap  = ();
        my @cmdInCmdSummaryList = ();

        my %cmdInChapterMap  = ();
        my @cmdInChapterList = ();

        print "mifFile = $mifFile\n";
        open (FH, $mifFile) or die "[ERROR] could not open mif file: $mifFile\n";
        my @lines = <FH>;
        my $cmdSummaryCnt = 0;
        my $cmdCnt = 0;

        for ( my $i = 0; $i <= $#lines; $i++ ) {
            my $line = $lines[$i];
 #           if ($line =~ m/\d+:\s+CSLInstruction:\s+([\']+)\'>/) {
            if ($line =~ m/<MText\s+\`\d+:\s+CSLInstruction:([^;]+);/ ) { 
                my $instr0 = $1;
                $cmdInSummaryMap{$instr0} = $cmdSummaryCnt;
                push(@cmdInCmdSummaryList, $instr0);
                #print "MText: $instr0\n";
                $cmdSummaryCnt++;
            }
            elsif ($line =~ m/<XRefSrcText\s+\`\d+:\s+CSLInstruction:([^;]+);/ ) { 
                my $instr0 = $1;
                $cmdInChapterMap{$instr0} = $cmdCnt;
                push(@cmdInChapterList, $instr0);
                #print "XRefSrcText: $instr0\n";
                $cmdCnt++;
            }
        }
        print "\n";

        $mifFile =~ m/(\w+)\.\w+/;
        my $chapterName = $1;
        print "Command summary command list DIR: chapterName = $chapterName command summary cmds \n\n";
        print "Test to see if the command is found in the chapter\n";
        foreach my $cmd (@cmdInCmdSummaryList) {
            print "Cmd summary Chapter: $chapterName || Command summary cmd $cmd appears in order: $cmdInSummaryMap{$cmd};\t";
            my $found = 0;
            foreach my $c (@cmdInChapterList) {
                if ($c eq $cmd ) {
                    $found = 1;
                    print "|| Cmd summary cmd $cmd appears in chapter in order : $cmdInChapterMap{$cmd} ";
                }
            }
            if ($found == 0) {
                print "[ERROR] summary vs.doc in $chapterName -  order mismatch or command missing : $cmd\n " ; 
            }  

            print "\n";
# check if the cmd in the command summary is in the lexer

            foreach my $lexerCmd (keys %lexerCmdMap){

# Perl pattern match does not like the "[]()" chars so remove them
                #print "Before substitution cmd = $cmd\n";
                $cmd =~ s/([\[\]\(\)])/ /g; # replace all braces and parens with nothing

                #print "After substitution cmd = $cmd\n";
                #print "lexerCmd = $lexerCmd cmd = $cmd\n";

                if ($cmd =~ m/$lexerCmd/) {
                    $lexerCmdMap{$lexerCmd} = 1; 
                    print "Found lexer cmd: $lexerCmd in summary cmd: $cmd\n";
                    goto FOUND;
                }
            }
            FOUND:
        }
        print "\n";

        print "Chapter command list DIR: chapterName = $chapterName commands found in chapter\n\n";
        foreach my $cmd (@cmdInChapterList) {
            print "Cmd Chapter: $chapterName || Command in chapter $cmd appears in chapter in order : $cmdInChapterMap{$cmd}\t";
            foreach my $c (@cmdInCmdSummaryList) {
                if ($c eq $cmd ) {
                    print "|| Chapter cmd in cmd summary appears in order : $cmdInSummaryMap{$cmd} ";
                }
		else {
		    print "[ERROR] doc vs. summary $chapterName order mismatch or command missing c = $c cmd = $cmd\n " ; 
		}  
            }
            print "\n";
        }
        print "\n";

        print "DIR: chapterName = $chapterName command summary commands\n";
        print "Test to see if the command found in the command summary is in the  chapter\n";
        foreach my $cmd (keys %cmdInSummaryMap) {
            if (! defined $cmdInChapterMap{$cmd} ) {
                print "[ERROR] Cmd summary Doc Chk DIR: chapterName = $chapterName Command summary Cmd $cmd NOT defined in chapter commands\n";
                $errorCnt++;
            }
        }
        print "\n";

        print "DIR: chapterName = $chapterName commands\n";
        print "Test to see if the command found in the chapter is in the command summary\n";
        foreach my $cmd (keys %cmdInChapterMap) {
            if (! defined $cmdInSummaryMap{$cmd} ) {
                print "[ERROR] Cmd summary Doc Chk DIR: chapterName = $chapterName Chapter cmd $cmd NOT defined in command summary\n";
                $errorCnt++;
            }
        }
        print "\n";

        $chapterName =~ m/csl_(\w+)/;
        my $componentName = $1;
        print "DIR: chapterName = $chapterName componentName = $componentName tests\n";
        print "Test to see if the command in chapter is found in a csl test\n";
        foreach my $cmd (keys %cmdInChapterMap) {
            my $c = $cmd;
            $cmd =~ s/[^\.]+\.//; # remove everything before the dot
            $cmd =~ s/\(.+$//;    # remove everything after the paren and including the paren
            print "XYZ command is $cmd  and original command is $c \n";

            my $grepCmd = "grep $cmd $totDir/test/csl/*" . $componentName . "*/*.csl";
            my $result = `$grepCmd`;
            my $retVal = $?;



            print "Test check DIR: componentName = $componentName cmd = $c cmd = $cmd grep = $grepCmd\n";

            if ($retVal !=0 ) {
                print "[ERROR] Test check DIR: chapterName = $chapterName cmd: $cmd does NOT appear in any WORK/test/csl tests \n";  
                $errorCnt++;
            }
            else {
                my @list = split(/\n/, $result);

                foreach my $test (@list) {
                    print "Test check DIR: chapterName = $chapterName cmd: $cmd appears in test $test\n";
                }
            }
        }
        print "\n";

        print "Chapter: $chapterName Commands which contain formatting characters which need to be moved out of the command\n";

        for ( my $i = 0; $i <= $#lines; $i++ ) {
            my $line = $lines[$i];
            if ($line =~ m/\\x/ ) { 
                if ($line =~ m/<MText\s+\`\d+:\s+CSLInstruction:([^;]+);/ ) { 
                    print "[ERROR] $chapterName Contains formatting char: line = $line\n";
                    $errorCnt++;
                }
                elsif ($line =~ m/<XRefSrcText\s+\`\d+:\s+CSLInstruction:([^;]+);/ ) { 
                    print "[ERROR] $chapterName Contains formatting char: line = $line\n";
                    $errorCnt++;
                }
            }
        }
    }

# print out the list of cmds in the parser which are not defined in the command summaries

    my $lexerErrorCnt = 0;
    print "List of commands in the lexer which do not appear in the command summary\n";
    foreach my $cmd (keys %lexerCmdMap){
        my $val = $lexerCmdMap{$cmd};
        if (0 == $val) {
            print "[ERROR] Lexer Command missing in cmd summary : $cmd\n"; 
            $lexerErrorCnt++;
        }
    }

    my @lexerCmdList = keys %lexerCmdMap; # get all keys and make an array
    print "Lexer error count = $lexerErrorCnt\n";
    print "Lexer cmd count   = $#lexerCmdList\n";
    print "Total error count = $errorCnt\n";

}
