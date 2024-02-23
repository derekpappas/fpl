#!/usr/bin/perl

use strict;

my @field0 ;
my @field1 ;
my @field2 ;

my @fieldIndices ;
my @legalRange0  ;
my @legalRange1  ;
my @legalRange2  ;

my @valueLeft0  = (255,31);
my @valueLeft1  = (100,21);
my @valueRight1 = (60,15);
my @valueLeft2  = (30,10);
my @valueRight2 = (19,5);

foreach my $valLeft0(@valueLeft0){
    foreach my $valLeft1(@valueLeft1){
        if($valLeft0>$valLeft1){
            foreach my $valRight1(@valueRight1){
                if($valLeft1>$valRight1){
                    foreach my $valLeft2(@valueLeft2){
                        if($valLeft1>$valLeft2 && $valRight1>$valLeft2){
                            foreach my $valRight2(@valueRight2){
                                if($valLeft2>$valRight2){
                                    &value($valLeft0,$valLeft1,$valRight1,$valLeft2,$valRight2);
                                    &main(@fieldIndices);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

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
                    my $up;my $low;
                    my $fldd; # inserted field;
                    my $testName;
                    if($upperIndexWithOffset <0 && $lowerIndexWithOffset<0 ){
                         $up=-$upperIndexWithOffset;$low=-$lowerIndexWithOffset;
                         $fldd = "_fld_i_" ."m$up" . "_m$low";}
                    elsif($upperIndexWithOffset <0){ $up=-$upperIndexWithOffset; $fldd = "_fld_i_" ."m$up" . "_$lowerIndexWithOffset";}
                    elsif($lowerIndexWithOffset<0){ $low=-$lowerIndexWithOffset; $fldd = "_fld_i_" .$upperIndexWithOffset . "_m$low"; }
                    else{ $fldd = "_fld_i_" .$upperIndexWithOffset. "_$lowerIndexWithOffset"; }


                    my $flda = "_fld_p_" . $field0[0] . "_$field0[1]"; # parent field
                    my $fldb = "_fld_c1_" . $field1[0] . "_$field1[1]"; # child field
                    my $fldc = "_fld_c2_" . $field2[0] . "_$field2[1]";#second child field
                    if($upperIndexWithOffset-$lowerIndexWithOffset<0) {
                        my $neg="_negw";
                        $testName = "field$flda$fldb$fldc$fldd$neg$test_type.csl" ;
                    }
                    elsif($lowerIndexWithOffset<0){ my $negp="_negpos";$testName = "field$flda$fldb$fldc$fldd$negp$test_type.csl";}
                    else{ $testName = "field$flda$fldb$fldc$fldd$test_type.csl" ;}
                   # print "testName = $testName\n";
                    &createCSlFile($upperIndexWithOffset, $lowerIndexWithOffset, $testName);
                }
            }
        }
    }

}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

sub value{
    my ($valLeft0,$valLeft1,$valRight1,$valLeft2,$valRight2)  = @_;
    my $valRight0 = 0;
    
    @field0 = ($valLeft0,$valRight0);
    @field1 = ($valLeft1,$valRight1);
    @field2 = ($valLeft2,$valRight2);
    @fieldIndices = ($field0[0], $field1[0]+1, $field1[0], $field1[1], $field1[1]-1,$field2[0]+1, $field2[0], $field2[1], $field2[1]-1, $field0[1]);
    @legalRange0  = ($field2[1]-1, $field0[1]); # lower range
    @legalRange1  = ($field1[1]-1, $field2[0]+1); # middle range
    @legalRange2  = ($field0[0], $field1[0]+1); # upper range

}
sub checkRange {
    my ($upperIndex, $lowerIndex) = @_;
    my $indexInUpperValidRange = ($legalRange2[0]+1) >= $upperIndex &&  $legalRange2[1] <= $upperIndex && ($legalRange2[0]+1) >= $lowerIndex &&  $legalRange2[1] <= $lowerIndex 
                                    &&($upperIndex > $lowerIndex);
    my $indexInMiddleValidRange =( $legalRange1[0]+1) >= $upperIndex &&  $legalRange1[1] <= $upperIndex && ($legalRange1[0]+1) >= $lowerIndex &&  $legalRange1[1] <= $lowerIndex 
                                    &&($upperIndex > $lowerIndex);
    my $indexInLowererValidRange =( $legalRange0[0]+1) >= $upperIndex &&  $legalRange0[1] <= $upperIndex && ($legalRange0[0]+1) >= $lowerIndex &&  $legalRange0[1] <= $lowerIndex 
                                    &&($upperIndex > $lowerIndex);
   
    my $legalRange = $indexInUpperValidRange || $indexInMiddleValidRange || $indexInLowererValidRange;

    return $legalRange;
}

sub createCSlFile {
    my($u, $l, $test_name) = @_;
    my $path="$ENV{WORK}/test/csl_test_gen/";
    if($test_name=~/(_legal)/){
        &mkDir("$path/field4_valid");
        open(FH,">$path/field4_valid/$test_name");}
    elsif($test_name=~/(_illegal)/) { 
         if($test_name=~/(_negw)/){ &mkDir("$path/field4_negWidth_invalid"); open(FH,">$path/field4_negWidth_invalid/$test_name");}
        elsif($test_name=~/(_negpos)/){ &mkDir("$path/field4_negPos_invalid"); open(FH,">$path/field4_negPos_invalid/$test_name");}
        else{ &mkDir("$path/field4_invalid"); open(FH,">$path/field4_invalid/$test_name");}}
         
    &header($test_name);
    &description($u,$l);
    &legend();
    my $insertWidth = $u - $l;
    print FH "csl_field fld_i" . "(" . "$insertWidth" . ");\n";        
    my $childWidth2 =$field2[0]-$field2[1]+1;
    my $childWidth1 =$field1[0]-$field1[1]+1;
    print FH "csl_field fld_c1(" . "$childWidth1" . ");\n";
    print FH "csl_field fld_c2(" . "$childWidth2" . ");\n";

    my $parentWidth = $field0[0]-$field0[1]+1;
    print FH "csl_field fld_p {\n";        
    print FH "  fld_i fld_i_0;\n";        
    print FH "  fld_c1 fld_c1_0;\n";
    print FH "  fld_c2 fld_c2_0;\n";
    print FH "  fld_p () {\n";        
    print FH "    set_width($parentWidth );\n";
    print FH "    set_field_position(fld_c1_0, $field1[1]);\n";
    print FH "    set_field_position(fld_c2_0, $field2[1]);\n";        
    print FH "    set_field_position(fld_i_0, $l);\n";        
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";        
    close(FH);

}

sub header
{
    my $test_name=$_[0];
    my $test_date = `date "+%d/%m/%G, %T"`;
    print FH "//Test generated by Petronela\n";
    print FH "//Test name: $test_name\n";
    print FH "//Date: $test_date\n";
    
}

sub description
{
   
    my($u,$l)=@_;
    print FH "\n//Description:\n";
    print FH "//a parent field is created fld_p\n";                 
    print FH "//two children fields are created fld_c1 fld_c2\n";
    print FH "//a child field is inserted with the upper limit $u and lower limit $l \n \n";     
   
}

sub legend
{
    print FH "//Legend:\n";
    print FH "//fld_p  = parent field\n";
    print FH "//fld_c1 = first child field\n";
    print FH "//fld_c2 = second child field\n";
    print FH "//fld_i  = inserted child field\n";
    print FH "//negw   = negative width\n";
    print FH "//negpos = negative position\n";
    print FH "//m      = minus\n\n";
}
