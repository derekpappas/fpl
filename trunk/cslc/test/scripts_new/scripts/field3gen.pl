#!/usr/bin/perl

use strict;

my @field0 ;
my @field1 ;

my @fieldIndices ;
my @legalRange0  ; # lower range
my @legalRange1  ;
my @valLeft0  = (255,63);
my @valLeft1  = (100,50);
my @valRight1 = (40,20);

foreach my $val0(@valLeft0){
    foreach my $val1(@valLeft1){
        if($val0>$val1){
          
            foreach my $val2(@valRight1){
                if($val1>$val2){
                    &value($val0,$val1,$val2);
                    &main(@fieldIndices);
                }
            }
        }
    }
}
sub main {
    
    foreach my $upperIndex (@fieldIndices) {
        foreach my $lowerIndex (@fieldIndices) {
            for (my $u = -3; $u <=3; $u++) { 
                for (my $l = -3; $l <=3; $l++) { 
                    my $upperIndexWithOffset = $upperIndex + $u;
                    my $lowerIndexWithOffset = $lowerIndex + $l;
                    my $legalRange = &checkRange($upperIndexWithOffset, $lowerIndexWithOffset);
                    my $test_type = $legalRange ? "_legal" : "_illegal";
                    my $up;
                    my $low;
                    my $fldc; # inserted field
                    my $testName;
                    if($upperIndexWithOffset <0 && $lowerIndexWithOffset<0 ){
                         $up=-$upperIndexWithOffset;$low=-$lowerIndexWithOffset;
                         $fldc = "_fld_i_" ."m$up" . "_m$low";}
                    elsif($upperIndexWithOffset <0){ $up=-$upperIndexWithOffset; $fldc = "_fld_i_" ."m$up" . "_$lowerIndexWithOffset";}
                    elsif($lowerIndexWithOffset<0){ $low=-$lowerIndexWithOffset; $fldc = "_fld_i_" .$upperIndexWithOffset . "_m$low"; }
                    else{ $fldc = "_fld_i_" .$upperIndexWithOffset. "_$lowerIndexWithOffset"; }

                    my $flda = "_fld_p_" . $field0[0] . "_$field0[1]"; # parent field
                    my $fldb = "_fld_c_" . $field1[0] . "_$field1[1]"; # child field
                    if($upperIndexWithOffset-$lowerIndexWithOffset<0) {
                        my $neg="_negw";
                        $testName = "field$flda$fldb$fldc$neg$test_type.csl" ;
                    }
                    elsif($lowerIndexWithOffset<0){ my $negp="_negpos";$testName = "field$flda$fldb$fldc$negp$test_type.csl";}
                    else{ $testName = "field$flda$fldb$fldc$test_type.csl" ;}
                    
#                    print "testName = $testName\n";
                    &createCSlFile($upperIndexWithOffset, $lowerIndexWithOffset, $testName);
                }
            }
        }
    }

}

sub value{
    my $valLeft0  = $_[0];
    my $valRight0 = 0;
    my $valLeft1  = $_[1];
    my $valRight1 = $_[2];
    @field0 = ($valLeft0,$valRight0);
    @field1 = ($valLeft1,$valRight1);
    @fieldIndices = ($field0[0], $field1[0]+1, $field1[0], $field1[1], $field1[1]-1, $field0[1]);
    @legalRange0  = ($field1[1]-1, $field0[1]); # lower range
    @legalRange1  = ($field0[0], $field1[0]+1); # upper range
    
}
sub checkRange {
    my ($upperIndex, $lowerIndex) = @_;
    my $indexInUpperValidRange   = (($legalRange1[0]+1) >= $upperIndex && $legalRange1[1]<=$upperIndex) && ($legalRange1[1] <= $lowerIndex && ($legalRange1[0]+1)>=$lowerIndex)
                                    &&($upperIndex>$lowerIndex);
    my $indexInLowererValidRange = ($legalRange0[0]+1) >= $upperIndex &&  $legalRange0[1] <= $upperIndex && ($legalRange0[0]+1) >= $lowerIndex &&  $legalRange0[1] <= $lowerIndex 
                                    &&($upperIndex>$lowerIndex);
    my $legalRange = $indexInUpperValidRange || $indexInLowererValidRange;

    return $legalRange;
}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

sub createCSlFile {
    my($u, $l, $test_name) = @_;
    my $insertWidth = $u - $l;
    my $path="$ENV{WORK}/test/csl_test_gen/";
    if($test_name=~/(_legal)/){
        &mkDir("$path/field3_valid");
        open(FH,">$path/field3_valid/$test_name");}
    elsif($test_name=~/(_illegal)/) {
        if($test_name=~/(_negw)/){ &mkDir("$path/field3_negWidth_invalid"); open(FH,">$path/field3_negWidth_invalid/$test_name");}
        elsif($test_name=~/(_negpos)/){ &mkDir("$path/field3_negPos_invalid"); open(FH,">$path/field3_negPos_invalid/$test_name");}
        else{ &mkDir("$path/field3_invalid"); open(FH,">$path/field3_invalid/$test_name")}}
    &header($test_name);
    &description($u,$l);
    &legend();
   
    print FH "csl_field fld_i" . "(" . "$insertWidth" . ");\n";        

    my $childWidth =$field1[0]-$field1[1]+1;
    print FH "csl_field fld_c(" . "$childWidth" . ");\n";        

    my $parentWidth = $field0[0]-$field0[1]+1;
    print FH "csl_field fld_p {\n";        
    print FH "  fld_i fld_i_0;\n";        
    print FH "  fld_c fld_c_0;\n";        
    print FH "  fld_p () {\n";        
    print FH "    set_width($parentWidth );\n";        
    print FH "    set_field_position(fld_c_0, $field1[1]);\n";        
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
    print FH "//a child field is created fld_c\n";
    print FH "//a child field is inserted with the upper limit $u and lower limit $l \n \n";
    
     
   
}

sub legend
{
    print FH "//Legend:\n";
    print FH "//fld_p  = parent field\n";
    print FH "//fld_c  = child field\n";
    print FH "//fld_i  = inserted child field\n";
    print FH "//negw   = negative width\n";
    print FH "//negpos = negative position\n";
    print FH "//m      = minus\n\n";
 
}
