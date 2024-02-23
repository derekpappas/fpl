#!/usr/bin/perl
# vanilla compile script for csim gen
# author(s): Andrei Branzila
# version 0.1

use warnings;
use strict;
use FileHandle;

my $config_file=".csim_user_path";
#user param to be passed to Makefile
my $user_var="";
my $user_dir="";
my $current_dir = `pwd`;
chomp($current_dir);
#print $current_dir;

sub writeConfigFile;
sub handleConfigFile;
sub readConfigFile;
sub executeMake;

&main();


#main function
sub main {

    if( @ARGV > 1){ 
        die "Too many arguments received: please re-run script with one argument or -h for help!\n";
    }
    elsif (@ARGV == 0){
        print "Using stored user path\n";
        if(!-e $config_file || !-r $config_file || !-w $config_file ){
            die "Error: unable to access configuration file in: $config_file. Have you built the project at least once providing the user path?\n";
        }
        else{
            readConfigFile();        
            executeMake("");
        }
        
    }
    elsif ( $ARGV[0] =~ '-clean'){
        print "Running clean project\n";
        if(!-e $config_file || !-r $config_file || !-w $config_file ){
            die "Error: unable to access configuration file in: $config_file. Have you built the project at least once before running clean?\n";
        }
        else{
            readConfigFile();
            executeMake("clean");
        }
    }
    elsif ( $ARGV[0] =~ '-h' || $ARGV[0] =~ '-help' ){
        print "Helpful messages will print here\n";
        exit;
    }
    else {
        $user_dir = `(cd $ARGV[0]; pwd)`;
        chomp($user_dir);
        $user_dir = $user_dir . "/";

        handleConfigFile();
        readConfigFile();
        executeMake("");
    }
}

#function to call make
sub executeMake($){
    my $clean_option = $_[0];
    my $gen_var = "GENPATHOBJ=". $current_dir . "/generated/";
    my $make_var="MAKEPATH=$ENV{WORK}/trunk/build_utils/";
    my $main_var="MAINPATH=$ENV{WORK}/trunk/build_utils/";
    system("make -f $ENV{WORK}/trunk/build_utils/Makefile $make_var $main_var $gen_var $user_var $clean_option");
}


#function to read configuration file
sub readConfigFile{
    open (USER_PATH_FILE, "<", "$config_file");
    while(<USER_PATH_FILE>){
        my $line = $_;
        if($line =~ /USERPATHOBJ=(.)/){
            $user_var = $line;
            chomp($user_var);
            last;
        }
        else{
            die "Invalid configuration file: $config_file\n";
        }
    }
    close(USER_PATH_FILE);
}


#function to set/overwrite user path
sub handleConfigFile{
    if(-e $config_file){
        if(!-r $config_file || !-w $config_file ){
            print "Found config file but have no right to read/write it - Please allow access for current user\n";
        }
        else{
            my $choice = "";
            do {
                print "Overwriting pre-existing user code path. Continue ? Type y or n \n";
                $choice = <STDIN>;
                chomp($choice);
                if($choice =~ /[yY]/){
                    writeConfigFile();
                }
                elsif($choice =~ /[nN]/){
                    die "Terminated\n";
                }
            } until ($choice =~ /[yYnN]/);
        }
    }
    else{
        writeConfigFile();
    } 
}

#function to write to file
sub writeConfigFile{
    open (USER_PATH_FILE, ">", "$config_file");
    print USER_PATH_FILE "USERPATHOBJ=$user_dir";
    close(USER_PATH_FILE);
}
