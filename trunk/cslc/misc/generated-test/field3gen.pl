#!/usr/bin/perl

use strict;

my @field0 = (31,0);
my @field1 = (17,10);

#my @fieldIndices = ($field0[0], $field1[0]+1, $field1[0], $field1[1], $field1[1]-1, $field0[1]);
#my @legalRange0  = ($field1[0]-1, $field0[1]); # lower range
#my @legalRange1  = ($field0[0], $field1[0]);

my @fieldIndices = (31, 18,17,10,9,0);
my @legalRange0  = (9,0); # lower range
my @legalRange1  = (31,18);
my @legalRanges  = (\@legalRange0, \@legalRange1);

&main();

sub main {

    foreach my $upperIndex (@fieldIndices) {
        foreach my $lowerIndex (@fieldIndices) {
            for (my $u = -3; $u <=3; $u++) { 
                for (my $l = -3; $l <=3; $l++) { 
     
                    my $upperIndexWithOffset = $upperIndex + $u;
                    my $lowerIndexWithOffset = $lowerIndex + $l;
                    my $legalRange = &checkRange($upperIndexWithOffset, $lowerIndexWithOffset);
                    my $test_type = $legalRange ? "_legal" : "_illegal";

                    my $flda = "_fld_p_" . $field0[0] . "_$field0[1]"; # parent field
                    my $fldb = "_fld_c_" . $field1[0] . "_$field1[1]"; # child field
                    my $fldc = "_fld_i_" . $upperIndexWithOffset . "_$lowerIndexWithOffset"; # insert field
                    my $testName = "field$flda$fldb$fldc$test_type.csl" ;
                    print "testName = $testName\n";
                    &createCSlFile($upperIndexWithOffset, $lowerIndexWithOffset, $testName);
                }
            }
        }
    }

}

sub checkRange {
    my ($upperIndex, $lowerIndex) = @_;

    my $indexInUpperValidRange   = $legalRange1[1] >= $upperIndex &&  $legalRange1[0] >= $lowerIndex;
    my $indexInLowererValidRange = $legalRange0[1] >= $upperIndex &&  $legalRange0[0] >= $lowerIndex;
    my $legalRange = $indexInUpperValidRange && $indexInLowererValidRange;

    return $legalRange;
}

sub createCSlFile {
    my($u, $l, $test_name) = @_;

    open(FH,">  $test_name");

    my $insertWidth = $u - $l;
    print FH "csl_field fld_i" . "(" . "$insertWidth" . ");\n";        

    my $childWidth = 17 - 10;
    print FH "csl_field fld_c(" . "$childWidth" . ");\n";        

    my $parentWidth = 31 - 0 + 1;
    print FH "csl_field fld_p {\n";        
    print FH "  fld_i fld_i_0;\n";        
    print FH "  fld_c fld_c_0;\n";        
    print FH "  fld_p () {\n";        
    print FH "    set_width($parentWidth );\n";        
    print FH "    set_field_position(fld_c, 10);\n";        
    print FH "    set_field_position(fld_i, $l);\n";        
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";        

}

