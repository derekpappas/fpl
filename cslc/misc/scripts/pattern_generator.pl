#!/usr/bin/perl -w -I/opt/tools/perl_pm
###############################################################################
#
# Run the pattern generator on the file
#  Usage:
#   pattern_generator.pl file
#
# As usual there is no warranty!
#
# Derek
#
# $Header: 
###############################################################################

use strict;
use Switch;
use vars qw($debug @files @inc_dirs @lib_dirs $lib_ext $vdata $m );

# Parse the verilog

my $inFileName = $ARGV[0];
print "ARGV = ", @ARGV, "\n";
open my $INFILE, "<", $inFileName or die $!;

my $outFileName = "$inFileName.gen";
open my $OUTFILE, ">", $outFileName or die $!;
print $OUTFILE "// processed by the pattern generator\n";
print "// inFileName = $inFileName\n";

my $fileContents = <$INFILE>;

undef $/;           # each read is whole file

while (<>) {
    while (m/^(csl.*?;)/gsm) {  # /s makes . span line boundaries
                                    # /m makes ^ match near newlines
        print "chunk $. in $ARGV has <<$1>>\n";
        my $stmt = $1;

        if ($stmt =~ m/\[\[\s*(\d+)\s*---\s*(\d+)\s*\]\]/gs) {
#            print "lowerRange = $1\n";
#            print "upperRange = $2\n";
            my $lowerRange = &min($1,$2);
            my $upperRange = &max($1,$2);

            my $index = $lowerRange;
            while ($index <= $upperRange){
                my $stmtCopy = $stmt;
                $stmtCopy =~ s/\[\[\s*(\d+)\s*---\s*(\d+)\s*\]\]/$index/;
                $index++;
#                print "lowerRange = $lowerRange upperRange = $upperRange index = $index $stmtCopy\n";
                print "$stmtCopy\n";
            }

        }
        elsif ($stmt =~ m/\[\[(([^,]+,)+[^\]]+)\]\]/gs) {
#            print "list = $1\n";
            my $list = $1;
            $list =~ s/ //g;
            my @list = split(/,/, $list); 

            foreach my $element (@list) {
                my $stmtCopy = $stmt;
                $stmtCopy =~ s/\[\[[^\]]+\]\]/$element/;
                print "$stmtCopy\n";
            }
        }
        else {
            print "$stmt\n";
        }
    }
}

# print "DONE\n";

close $OUTFILE;

exit 0;


sub min {
    my ($n1, $n2) = @_;
    return $n1 < $n2 ? $n1 : $n2;
}


sub max {
    my ($n1, $n2) = @_;
    return $n1 >= $n2 ? $n1 : $n2;
}



