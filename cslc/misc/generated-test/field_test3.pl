#!/usr/bin/perl

use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command
use strict;

#var used in tests
my $SET_VALUE      = "set_value";
my $SET_ENUM       = "set_enum";
my $SET_ENUM_ITEM  = "set_enum_item"; 
my $SET_OFFSET     = "set_offset";
my $SET_WIDTH      = "set_width";
my $SET_FIELD_POS  = "set_field_position";
my $SET_PREVIOUS   = "set_previous";
my $SET_NEXT       = "set_next";


#var for the test name
my $FIELD       = "f";
my $EN          = "e";
my $EN_IT       = "ei";
my $VAL         = "v";
my $BITRANGE    = "br";
my $PARENT      = "p";
my $CHILD       = "c";
my $GRANDPARENT = "g";
my $SET_OS      = "so";
my $SET_POS     = "sfp";
my $SET_W       = "sw";
my $SET_PREV    = "spre";
my $SET_N       = "sn";
my $SET_VAL     = "sv";
my $SET_EN      = "se";
my $SET_EN_IT   = "si";
my $RANGE       = "r" ;
my $OBL         = "obl";
my $OVL         = "ovl";
my $IB          = "ib";
my $OVU         = "ovu";
my $OBU         = "obu"; 
my $TV          = "tv";
my $TP          = "tp";

my %mapPos;
$mapPos{$OBL} = "0";
$mapPos{$OVL} = "100";
$mapPos{$IB}  = "300";
$mapPos{$OVU} = "400";
$mapPos{$OBU} = "512";

#my %mapVal;
#$mapVal{$OBL}  = "100";
#$mapVal{$OVL}  = "2";
#$mapVal{$IB}  = "255";
#$mapVal{$OVU} = "262";
#$mapVal{$OBU} = "512";
#
#my %mapRange;
#$mapRange{$IB} = "0,0";
#$mapRange{$OVU}= "0,262";
#$mapRange{$OBU}= "13,526";

my @values = ("1","2");

my $UPLOW = "0,212";
my $WIDTH = "513";
my $VALUE = "212";

my %mapDescripP;
$mapDescripP{$OBL} = "the position of the second child field is completely out of bounds lower compared to the parent field width\n ";
$mapDescripP{$OVL} = "the position of the second child field is overlap lower compared to the parent field width\n";
$mapDescripP{$IB}  = "the positions of the two children fields are in bounds compared to the parent field width\n";
$mapDescripP{$OBU} = "the position of the first child field is completely out of bounds upper compared to the parent width\n";
$mapDescripP{$OVU} = "the position of the first child field is overlap upper compared to the parent field width \n";

my %mapDescripV;
$mapDescripV{$IB} = "the width of the child field is in bounds compared to the parent field width\n";
$mapDescripV{$OVU}= "the width of the child field is overlap upper compared to the parent field width \n ";

my %mapDescripR;
$mapDescripR{$IB} = "the upper and the low index of the child field are in bounds compared to the parent field width\n";
$mapDescripR{$OVU}= "the upper and the low index of the child field are overlap upper compared to the parent field width \n ";

my %mapDescripE;
$mapDescripE{$IB} = "and the enum \n ";
$mapDescripE{$OVU}= "and the enum \n ";

my @arrayValue =($RANGE,$VAL);
my @actionValue =($SET_EN,$SET_VAL,$SET_OS);
my @action =($SET_PREV,$SET_N);
my @limits =($OBL,$OVL,$IB,$OVU,$OBU);

my $test_name = "";
my $test_date = `date "+%d/%m/%G, %T"`;
my $i=1;
my $test = "";
my $classField="csl_field";
my $fieldName="fld";
my $classEnum="csl_enum";
my $enumName ="enn";


#gen tests name and tests
&gen_tests3;

sub gen_tests3
{
    foreach my $val(@arrayValue){
        foreach my $act(@action){
            if($act eq $SET_N){ @limits=($IB,$OVU,$OBU);}
            else { @limits =($OBL,$OVL,$IB,$OVU,$OBU);}
            foreach my $lim(@limits){
                foreach my $nr(@values){
                    $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$act."_".$CHILD."_".$FIELD."_".$CHILD."_".$FIELD."_".$val."_".$TP."_".$lim."_".$nr;
                    if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                    else {$test_name=$test_name.".csl";}
                    open(FH,">$test_name");
                    &header();
                    &description($test_name,$lim);
                    &legend();
                      
                    print FH "$classEnum $enumName {\n";
                    print FH "           $EN_IT\n";
                    print FH "};\n";
                      
                    if($val eq $VAL){
                        print FH "$classField $fieldName$i($VALUE), ";$i++;
                        if($lim eq "$IB"){ print FH "$fieldName$i($VALUE-$nr);\n"; $i++;}
                        else{ print FH "$fieldName$i($VALUE+$nr);\n"; $i++;}
                    }
                    else{ print FH "$classField $fieldName$i($UPLOW), ";$i++;
                        if($lim eq "$IB"){ print FH "$fieldName$i($UPLOW-$nr);\n"; $i++;}
                        else{ print FH "$fieldName$i($UPLOW+$nr);\n"; $i++;}}
                    print FH "$classField $fieldName$i {\n";$i--;$i--;
                    print FH "           $fieldName$i $fieldName$i;\n";$i++;
                    print FH "           $fieldName$i $fieldName$i;\n";$i++;
                    print FH "           $fieldName$i() {\n";
                    print FH "           $SET_WIDTH($WIDTH);\n";$i--;$i--;     
                    print FH "           $SET_FIELD_POS($fieldName$i,$mapPos{$lim});\n";
                    if($act eq "$SET_PREV"){
                        print FH "           $SET_PREVIOUS($fieldName$i, ";$i++;
                        print FH "$fieldName$i);\n";
                    }
                    else {
                        print FH "           $SET_NEXT($fieldName$i, ";$i++;
                        print FH "$fieldName$i);\n";}
                    print FH "      }\n";
                    print FH "};";
                    $i++;
                }
            }
        }
    }

    @action =($SET_PREV,$SET_N,$SET_POS);
    foreach my $act(@action){
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$act."_".$CHILD."_".$FIELD."_".$CHILD."_".$FIELD."_"."dupl"."_"."illegal.csl";
                open(FH,">$test_name");
                my $Pos="212";
                &header();
                &description($test_name,$act);
                &legend();
            
                print FH "$classEnum $enumName {\n";
                print FH "           $EN_IT\n";
                print FH "};\n";
            
                print FH "$classField $fieldName$i($VALUE), ";$i++;
                print FH "$fieldName$i($VALUE);\n";
                print FH "$classField $fieldName$i {\n";$i--;$i--;
                print FH "           $fieldName$i $fieldName$i;\n";$i++;
                print FH "           $fieldName$i $fieldName$i;\n";$i++;
                print FH "           $fieldName$i() {\n";
                print FH "           $SET_WIDTH($WIDTH);\n";$i--;$i--;  
                if($act eq "$SET_POS"){
                    print FH "           $SET_FIELD_POS($fieldName$i,$Pos);\n";
                    print FH "           $SET_FIELD_POS($fieldName$i,$Pos);\n";
                }
                elsif($act eq "$SET_PREV"){
                    print FH "           $SET_PREVIOUS($fieldName$i, ";$i++;
                    print FH "$fieldName$i);\n";$i--;
                    print FH "           $SET_PREVIOUS($fieldName$i, ";$i++;
                    print FH "$fieldName$i);\n";
                }
                else {
                    print FH "           $SET_NEXT($fieldName$i, ";$i++;
                    print FH "$fieldName$i);\n";$i--;
                    print FH "           $SET_NEXT($fieldName$i, ";$i++;
                    print FH "$fieldName$i);\n";}
                print FH "      }\n";
                print FH "};";
                $i++;
            }   
    
}

sub header
{
    print FH "//Test generated by Petronela\n";
    print FH "//Test name: $test_name\n";
    print FH "//Date: $test_date";
    
}

sub legend
{
     print FH "\n//Legend:\n";
     print FH "//$GRANDPARENT=gradparent\n";
     print FH "//$PARENT=parent\n";
     print FH "//$CHILD=child\n";
     print FH "//$FIELD=field\n";
     print FH "//$EN=enum\n";
     print FH "//$EN_IT=enum_item\n";
     print FH "//$VAL=value\n";
     print FH "//$RANGE=lower index,upper index\n";
     print FH "//$BITRANGE=bitrange\n";
     print FH "//$SET_OS=set_offset\n";
     print FH "//$SET_POS=set_field_position\n";
     print FH "//$SET_PREV=set_previous\n";
     print FH "//$SET_N=set_next\n";
     print FH "//$SET_W=set_width\n";
     print FH "//$SET_VAL=set_value\n";
     print FH "//$SET_EN=set_enum\n";
     print FH "//$SET_EN_IT=set_enum_item\n";
     print FH "//$TV=test value\n";
     print FH "//$TP=test position value\n";
     print FH "//$OBL=completely out of bounds lower\n";
     print FH "//$OVL=overlap lower\n";
     print FH "//$IB=in bounds\n";
     print FH "//$OVU=overlap upper\n";
     print FH "//$OBU=completely out of bounds upper\n";
     print FH "\n";
}

sub description
{
    my $test  = $_[0];
    my $lim   = $_[1];
    print FH "\n//Description:\n";
    print FH "//an enum is created\n";     
    print FH "//a parent field is created\n";                 
    print FH "//two children fields are created\n";
                         
    switch($test)
    {
        case /(_$TP)/    {print FH "//$mapDescripP{$lim}";}
        case /(_$VAL)/   {print FH "//$mapDescripV{$lim}";
                          case /(_$EN)/    {print FH "//$mapDescripE{$lim} ";}}
        case /(_$RANGE)/ {print FH "//$mapDescripR{$lim}";
                          case /(_$EN)/    {print FH "//$mapDescripE{$lim} ";}}
        case /(_dupl)/ { print FH  "the method $lim is duplicated;"}
    }
   
}
