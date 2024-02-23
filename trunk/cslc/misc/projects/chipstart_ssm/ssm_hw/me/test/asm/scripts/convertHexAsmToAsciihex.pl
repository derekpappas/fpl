#!/usr/bin/perl -w -I/opt/tools/perl_pm
###############################################################################
use strict;


# create input file with
#for i in $(ls -d * ); do echo i=$i; ls $i/[^0-9]*  > /tmp/$i.taxtree.info.brands; done &> log

my ($QUIET)=2;


#####################################################################
if($#ARGV<0){die"missing argv\n";}

#print "file: $ARGV[0]\n";

parseFile($ARGV[0]);

exit;

################################################################################
sub parseFile {
   my ($inFile)=@_;

   open (INFH,"<$inFile") or die "Unable to open inFile:$inFile. $!\n";
#   print "Reading file: $inFile\n";

   
   while (<INFH>) {
       chop;
       /(@[^ ]+ )(.+)/;
       my $firstWord = $1;
       my $secondWord = $2;

#	   print  "$firstWord : $secondWord\n";

       $secondWord =~ s/_//g;
       $secondWord =~ m/^([^\s]+)\s*/;
     #  $secondWord = "0x" . $secondWord; 

        print  "0x$secondWord\n";

#	   print OUTFH "$firstWord : $secondWord\n";
       
   }

   close INFH;   

}

exit;
