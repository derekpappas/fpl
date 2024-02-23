#!/usr/bin/perl
#program version 0.001
#author: andreib
#program description: script to iteratively rename UDP names in test files. 
#Note: needs a blank file to write contents

$infile = $ARGV[0];
$outfile = $ARGV[1];
$replacetext = $ARGV[2];
unless ( @ARGV == 3 )
{
	die("This script requires 3 arguments: input_file output_file string_to_replace\n");
}
open IN, $infile or die $!;
$intext = do{local $/; <IN>};
close IN;

$intext =~ s/$replacetext/"${replacetext}_" . ++$counter/mseg;

open OUT, ">$outfile" or die $!;
print OUT $intext;
close OUT;
