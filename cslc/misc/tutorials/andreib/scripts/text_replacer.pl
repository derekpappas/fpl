#!/usr/bin/perl
#author: andreib
#Description: This script replaces a string with the contents of a whole file
#Variables are hardwired into script but may be turned to console input arguments

#$file holds the name of the file which gets it's conents to replace the string
$file = "19_table_contents";

open(FILE, "<$file") or die "Cannot open file: $!\n";
@rtable_1 = <FILE>;
close FILE;

#$write_file is the target file where the search and replace operation takes place
$write_file = "sequential_udp_declaration.v";
open(RFILE, "<$write_file") or die "Cannot open file: $!\n";
$intext =  do{local $/; <RFILE>};
close RFILE;

#this regex searches for the "marker" string (i.e. table_19) that will be rerplaced with the contents of $file
$intext =~ s/table_19/@rtable_1/g;


open (WFILE, ">$write_file") or die "Cannot open file: $!\n";
print WFILE $intext;
close WFILE;
print("Done. You can go outside and play now.\n");
