#!/usr/bin/perl
#program version
my $VERSION="0.2";
use File::Copy;

#print "[@ARGV - $#ARGV]\n";

unless ( @ARGV == 2 )
  { die ("Run this script with two arguments: input_file template_file .....\n"); }

unless (open(inputFile, "<$ARGV[0]")) 
	{
     die ("cannot open input file $ARGV[0]\n");
 	}
else{
    unless (open(tmplFile, "<$ARGV[1]")) 
    	 {
	       die ("cannot open template file $ARGV[1]\n");
  	   }
   else{

#insert a new emplty line at the begining of first argument

open (WFILE, '>>temp_rule');
print WFILE "\n";
while (<inputFile>) {
chomp;
print WFILE "$_\n";
}
close (imputFile);
close (WFILE);

copy('temp_rule',"$ARGV[0]" ) or die "File cannot be copied.";
unlink('temp_rule');
open (inputFile, "<$ARGV[0]");

#end of inserting new empty line

      @fileIn = split (/\//, $ARGV[1]);
      $fileInSize = $#fileIn;
#print "size: ".$fileInSize."\n";
#print "last element: ".@fileIn[$fileInSize]."\n";
#exit;

   	  @fileIn = split (/\./, @fileIn[$fileInSize]);
      #$ARGV[1] = m/(.*)(\/\.csl)/g;
      $line = <inputFile>;
      @outTmpl = <tmplFile>; 
      close(tmplFile);
      $j=0;
    	foreach $line (<inputFile>) { 
                $nameFileOut="$fileIn[0]".$j++."."."$fileIn[1]";
                #$nameFileOut="$]".$j++."."."$fileIn[1]";
               	open(outFile, ">$nameFileOut");
                chop($line);
          foreach $l (@outTmpl) {
              $s = $l;
              $s  =~ s/####/$line/g; 
              print outFile $s;
          }
          close outFile;
	       }
        }
    close(inputFile);
}


__END__

=head1 NAME

filecut - short description of your program

=head1 SYNOPSIS

  Run filecut script with two arguments: FILETOCUT TEMPLATEFILE
   $ ./filecut.pl input_file.xxx template_file
 
=head1 DESCRIPTION

Filecut will extract lines form input_file and generate input_file[1-n].xxx by replacing #### from template_file 
with lines readed from input_file.xxx
Example:
   $ ./filecut.pl a.v mytmpl.txt

If a.v has x lines .. output will be x new files:
   $ ls 
    a0.v a1.v a2.v ... ax.v

=head1 SEE ALSO

Template file can look like this:

    starttext
      othertext ####  moretext
      othertext2 ####
    endtext

  Place "####" anywhere you like in template file
    #### will be relaced with 1 line from the input files (empty if the line is empty in the input file )
    ### - will be ignored
  In case of more than 4 of "#" will be found .. only 4 will be replaced, everything else will remain unchanged.

=head1 AUTHOR

 camarand@bigsursoftware.com

=cut
