#!/usr/bin/perl
use strict;

my @fileList = `ls */*/build.xml`;
chomp(@fileList);
foreach my $i (@fileList  ) {
  #  print "test : $i";
    my $i_sub = $i;
    $i_sub =~ s/\.[^.]*$//;
    $i_sub = $i_sub . "1.xml";
 #   print "sub : $i_sub\n";

    system "cp $i $i_sub\n"; 

}

