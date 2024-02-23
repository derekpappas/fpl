#!/usr/bin/perl
#program version
my $VERSION="0.1";

#print "[@ARGV - $#ARGV]\n";

unless ( @ARGV == 2 )
{ die ("Run this script with two arguments: input_file template_file .....\n"); }

unless (open(inputFile, "<$ARGV[0]")) 
{
    die ("cannot open input file $ARGV[0]\n");
}
else
{
    unless (open(tmplFile, "<$ARGV[1]")) 
    {
	die ("cannot open template file $ARGV[1]\n");
    }
    else
    {
        $j=0;
        $i=0;
        @fileIn = split (/\./, $ARGV[1]);
        $line = <inputFile>;
        @outTmpl = <tmplFile>; 
        $numberOfTests = @fileIn;
        close(tmplFile);
        open(outFile, ">$ARGV[0].v");
        print outFile "module testbench_$ARGV[0];\n";
        foreach $line (<inputFile>)
        {
            print outFile "    $ARGV[0]$i $ARGV[0]_instance$i();\n";
            $i++;
        }
        print outFile "    $ARGV[0]$i $ARGV[0]_instance$i();\n";
        print outFile "endmodule\n//@\n";
        close(inputFile);
        open(inputFile, "<$ARGV[0]");
        foreach $line (<inputFile>) 
        {
            $moduleName="$ARGV[0]".$j++;
            chop($line);
            foreach $l (@outTmpl) 
            {
                $s = $l;
                $s  =~ s/@@@@/$moduleName/g;
                $s  =~ s/####/$line/g; 
                print outFile $s;
            }
	}
	close outFile;
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
