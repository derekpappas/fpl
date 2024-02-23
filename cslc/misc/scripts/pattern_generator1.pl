#!/usr/bin/perl -w -I/opt/tools/perl_pm
###############################################################################
# copyright Fastpath Logic, Inc. 2008
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

#undef $/;
#local $/ = ";";
print "ARGV = ", @ARGV, "\n";
my $inFileName = $ARGV[0];

print "// inFileName = $inFileName\n";
open my $INFILE, "<", $inFileName or die $!;

#my $fileContents = <$INFILE>;
#my $fileContents = <>;
my @fileContents = <>;

#foreach my $fileContents (@fileContents) {
#    print $fileContents;
#}
#exit;

my $outFileName = "$inFileName.gen";
open my $OUTFILE, ">", $outFileName or die $!;
print $OUTFILE "// processed by the pattern generator\n";

# undef $/;           # each read is whole file

my $rangePattern = "\\[\\[\\s*(\\d+)\\s*---\\s*(\\d+)\\s*\\]\\]";
print "rp = $rangePattern\n";

my $listPattern = "\\[\\[(.*?)\\]\\]";

#my $listPattern = "\\[\\[(([^,]+,)+[^\\]]+)\\]\\]";
print "lp = $listPattern\n";

my $rangeListPattern = "\\[\\[(([^,]+,)+[^\\]]+|\\s*(\\d+)\\s*---\\s*(\\d+)\\s*)\\]\\]";
print "rlp = $rangeListPattern\n";

#my $stmtPattern = "^(csl.*?;)";
my $stmtPattern = "([^;]+;)";
print "csp = $stmtPattern\n";

my $commentPattern      = "^(\\s*\\/\\/)"; # match constructors and class decl's
my $openCurlyPattern    = "(.*?{)"; # match constructors and class decl's
my $closeCurlyPattern   = "([^}]+}\\s*;)"; # match constructors and class decl's
my $curlyWithSemiPattern = "(\\s*}\\s*;)"; # match constructors and class decl's
my $stmtWithSemiPattern = "(.*?;)"; # match constructors and class decl's
my $matchVariablePattern = "\\\\\\"; # threefour back slashes followed by a single number

foreach my $fileContents (@fileContents) {
    if ($fileContents =~ m/($commentPattern)/) { # print and remove the closed curly pattern
        print $OUTFILE $fileContents;
    }
#    elsif ($fileContents =~ m/($curlyWithSemiPattern)/) { # print and remove the closed curly pattern
#        print $OUTFILE $fileContents;
#    }
    elsif ($fileContents =~ m/($stmtWithSemiPattern)/) { # print and remove the closed curly pattern
        my $extractedStmt = $1;
        my $stmt = $1;
        print "1 stmtWithSemi $fileContents\n";
# find all patterns in the statement
# put each pattern in an array
# process each pattern in the array by making a new @stmt which contains the stmt which was expanded using the pattern
        my @stmtList;
#        push (@stmtList, $stmt);
        push (@stmtList, $fileContents);

        my $patternNumber = 1;
# remove the patterns from $stmt while expanding the @stmtList array with the expanded statements
        if ($stmt =~ m/$rangeListPattern/) {
        print "2 stmtWithSemi $fileContents\n";
            while ($stmt =~ m/$rangeListPattern/) {  # /s makes . span line boundaries
        print "3 stmtWithSemi $fileContents\n";
                my @newStmtList;

                if($stmt =~ m/$rangePattern/) { # remove the next pattern
                    print "Matched rp $stmt\n";
                    $stmt =~ s/($rangePattern)//;
                    foreach my $s (@stmtList) {
                        if ($s =~ m/$rangePattern/) {
                            push( @newStmtList , &generateRange($s, $patternNumber));
                        }
                    }
                }
                elsif($stmt =~ m/$listPattern/) { # remove the next pattern
                    print "Matched list pattern\n";
                    print "MLP Before stmt = $stmt\n";
                    $stmt =~ s/($listPattern)//;
                    print "MLP After stmt = $stmt\n";

                    foreach my $s (@stmtList) {
                        if ($s =~ m/$listPattern/) {
                            print "Matched lp s = $s\n";
                            push( @newStmtList , &generateList($s, $patternNumber));
                        }
                    }
                }

                @stmtList = @newStmtList;
                print "slist BEFORE\n";
                foreach my $s (@stmtList) {
                    print "slist = $s\n";
                }
                print "slist AFTER\n";
                $patternNumber++;
            }
            foreach my $s (@stmtList) {
                print $OUTFILE $s, "\n";
            }
        }
        else {
            print $OUTFILE $fileContents;
        }
    }
    else {
        print $OUTFILE $fileContents;
    }
}

# print "DONE\n";

close $OUTFILE;

exit 0;


sub min{
    my ($n1, $n2) = @_;
    return $n1 < $n2 ? $n1 : $n2;
}


sub max {
    my ($n1, $n2) = @_;
    return $n1 >= $n2 ? $n1 : $n2;
}

sub generateRange {
    my ($stmt, $patternNumber) = @_;

    my @stmtList;

    if ($stmt =~ m/$rangePattern/) {
        my $lowerRange = &min($1,$2);
        my $upperRange = &max($1,$2);
        my $index = $lowerRange;
        my $reverseIndex = $upperRange;
        my $plusIndex = $lowerRange + 1;

        while ($index <= $upperRange){
            my $stmtCopy = $stmt;
            $stmtCopy =~ s/$rangePattern/$index/;
            my $pattern = "\\\\" . "$patternNumber";
            my $reversePattern = "\\\\r" . "$patternNumber";
            my $plusPattern = "\\\\p" . "($patternNumber)";
            my $plusIncPattern = "\\\\i" . "($patternNumber)" . "i(\\d+)";
            print "IF before : pip= $plusIncPattern index: $index pattern: $pattern $stmtCopy\n";
            if ($stmtCopy =~ m/($pattern)/) { # the stmt is using the pattern else where a[[0---9]] = b\1;
                print "loop before: $stmtCopy\n";
                $stmtCopy =~ s/$pattern/$index/g; # replace the \1 with the current index
                print "loop after: $stmtCopy\n";
            }
            if ($stmtCopy =~ m/($reversePattern)/) { # the stmt is using the pattern else where a[[0---9]] = b\1;
                print "loop before: $stmtCopy\n";
                $stmtCopy =~ s/$reversePattern/$reverseIndex/g; # replace the \r1 with the current index
                print "loop after: $stmtCopy\n";
            }
            if ($stmtCopy =~ m/($plusIncPattern)/) { # the stmt is using the pattern else where a[[0---9]] = b\1;
                my $inc = $2 + $plusIndex;
                print "pip loop before: inc = $inc  pip = $plusIncPattern $stmtCopy\n";
                $stmtCopy =~ s/$plusIncPattern/$inc/g; # replace the \r1 with the current index
                print "pip loop after: $stmtCopy\n";
            }
            if ($stmtCopy =~ m/($plusPattern)/) { # the stmt is using the pattern else where a[[0---9]] = b\1;
                print "loop before: $stmtCopy\n";
                $stmtCopy =~ s/$plusPattern/$plusIndex/g; # replace the \r1 with the current index
                print "loop after: $stmtCopy\n";
            }
            print "indices $stmtCopy i = $index ri = $reverseIndex\n";
            $index++;
            $plusIndex++;
            $reverseIndex--;
            push (@stmtList, $stmtCopy);
        }
    }
    else {
        die "Called generateRange with bad pattern match\n   $stmt\n";
    }

    foreach my $s (@stmtList) {
        print "generateRange $s\n";
    }

    return @stmtList;
}

sub generateList {
    my ($stmt, $patternNumber) = @_;

    my @stmtList;

    if ($stmt =~ m/$listPattern/) {
        print "list = $1\n";
        my $list = $1;
        $list =~ s/ //g;
        my @list = split(/,/, $list); 

        my $pattern = "\\\\" . "$patternNumber";
        print "1 before: pattern: $pattern $stmt\n";
        foreach my $element (@list) {
            my $stmtCopy = $stmt;
            $stmtCopy =~ s/($listPattern)/$element/;
            print "1 before: element: $element pattern: $pattern $stmtCopy\n";
            if ($stmtCopy =~ m/($pattern)/) { # the stmt is using the pattern else where a[[0---9]] = b\1;
                print "loop before: $stmtCopy\n";
                $stmtCopy =~ s/$pattern/$element/g; # replace the \1 with the current element
                print "loop after: $stmtCopy\n";
            }
            push (@stmtList, $stmtCopy);
        }
    }
    else {
        die "Called generateList with bad pattern match\n   $stmt\n";
    }

    foreach my $s (@stmtList) {
        print "generateList $s\n";
    }

    return @stmtList;
}
