#!/usr/bin/perl

use strict;

my @field ;
my @fieldIndices ;
my @legalRanges ;
my @valLeft = (511,63,3);



if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable YO_WORK is not set. Set it to point to TOT/se";
}  

my $totDir     = $ENV{WORK};
&testDirExists($totDir);

foreach my $val(@valLeft)
{
    &value($val);
    &main();
}

 
sub main {
    my $i=$_[0];
    foreach my $upperIndex (@fieldIndices) {
        foreach my $lowerIndex (@fieldIndices) {
            for (my $u = -3; $u <=3; $u++) { 
                for (my $l = -3; $l <=3; $l++) { 
                    my $upperIndexWithOffset = $upperIndex + $u;
                    my $lowerIndexWithOffset = $lowerIndex + $l;
                    my $legalRange = &checkRange($upperIndexWithOffset, $lowerIndexWithOffset);
                    my $test_type = $legalRange ? "_legal" : "_illegal";

                    my $flda = "_fld_p_" . $field[0] . "_$field[1]"; # parent field
                    my $up;my $low;
                    my $fldb; # inserted field
                    if($upperIndexWithOffset <0 && $lowerIndexWithOffset<0 ){
                         $up=-$upperIndexWithOffset;$low=-$lowerIndexWithOffset;
                         $fldb = "_fld_i_" ."m$up" . "_m$low";}
                    elsif($upperIndexWithOffset <0){ $up=-$upperIndexWithOffset; $fldb = "_fld_i_" ."m$up" . "_$lowerIndexWithOffset";}
                    elsif($lowerIndexWithOffset<0){ $low=-$lowerIndexWithOffset; $fldb = "_fld_i_" .$upperIndexWithOffset . "_m$low"; }
                    else{ $fldb = "_fld_i_" .$upperIndexWithOffset. "_$lowerIndexWithOffset"; }
                    my $testName = "field$flda$fldb$test_type.csl" ;
#                    print "testName = $testName\n";
                    &createCSlFile($upperIndexWithOffset, $lowerIndexWithOffset, $testName);
                }
            }
        }
    }

}
sub value {
    my $valLeft= $_[0];
    my $valRight =0;
    @field = ($valLeft,$valRight);
    @fieldIndices = ($field[0], $field[1]);
    @legalRanges  = ($field[0], $field[1]);
}

sub checkRange {
    my ($upperIndex, $lowerIndex) = @_;

    my $indexValidRange   = (($legalRanges[0]+1) >= $upperIndex && $legalRanges[1] <= $upperIndex) && (($legalRanges[0]+1) >= $lowerIndex && $legalRanges[1] <= $lowerIndex )
                                    &&($upperIndex>$lowerIndex);
    my $legalRange = $indexValidRange ;

    return $legalRange;
}


sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
    
}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

sub createCSlFile {
    my($u, $l, $test_name) = @_;
    my $path="$ENV{WORK}/test/csl_test_gen";
    if($test_name=~/(_legal)/){
        &mkDir("$path/field2_valid");
        open(FH,">$path/field2_valid/$test_name");}
    elsif($test_name=~/(_illegal)/) {&mkDir("$path/field2_invalid"); open(FH,">$path/field2_invalid/$test_name")}
    &header($test_name);
    &description($u,$l);
    &legend();
    my $insertWidth = $u - $l;
    print FH "csl_field fld_i" . "(" . "$insertWidth" . ");\n";        

    my $parentWidth = $field[0]-$field[1]+1;
    print FH "csl_field fld_p {\n";        
    print FH "  fld_i fld_i_0;\n";        
    print FH "  fld_p () {\n";        
    print FH "    set_width($parentWidth );\n";           
    print FH "    set_field_position(fld_i_0, $l);\n";        
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";        
    close(FH);

}
 print " Generated path:$ENV{WORK}/test/csl_test_gen/field2_valid \n";

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
    print FH "//a child field is inserted with the upper limit $u and lower limit $l \n \n";
    
     
   
}

sub legend 
{
    print FH "//Legend:\n";
    print FH "//fld_p  = parent field\n";
    print FH "//fld_i  = inserted child field\n";
    print FH "//m      = minus\n\n";
}
