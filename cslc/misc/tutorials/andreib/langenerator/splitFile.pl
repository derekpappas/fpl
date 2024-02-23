#!/usr/bin/perl

unless ( @ARGV == 2 ) {
  die ('Run this script with two arguments: templateFile inputFile');
}

unless ( open(tmplFile, "<$ARGV[0]") )  {
  die ("Cannot open template file $ARGV[0]\n");
}

unless ( open(inFile, "<$ARGV[1]") ) {
  die ("cannot open input file $ARGV[1]\n");
}

@parts = split (/\./, $ARGV[0]);
$outFileName ="$parts[0]".'_'."$parts[1]";

unless ( open(outFile, ">$outFileName") ) {
  die ("Cannot create output file $outputFile\n");
}

@tFile = <tmplFile>;
close tmpFile;

$" = '';
$tFileStr = "@tFile";

$j = 0;
foreach $line (<inFile>) {
  $tCopy = $tFileStr;
  chomp($line);
  $inc = '_'.$j++;
  $tCopy =~ s/#1/$inc/g;
  $tCopy =~ s/#2/$line/g;
  print outFile "$tCopy\n";
}

close inFile;
close outFile;