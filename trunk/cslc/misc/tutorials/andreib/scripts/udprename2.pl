#!/usr/bin/perl
#program version 0.002
#author: andreib
#program description: script to iteratively rename UDP names in test files. 
#this version does not require the pre existence of an empty output file

$infile = $ARGV[0];
$replacetext = $ARGV[1];
unless ( @ARGV == 2 )
{
	die("This script requires 2 arguments: input_file string_to_replace\n");
}
open IN, $infile or die $!;
$intext = do{local $/; <IN>};
close IN;

$intext =~ s/$replacetext/"${replacetext}_" . ++$counter/mseg;

open OUT, ">$infile" or die $!;
print OUT $intext;
close OUT;
