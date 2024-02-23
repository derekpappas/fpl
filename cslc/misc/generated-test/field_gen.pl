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
#my $ENUM      = "enum";
#my $ENUM_ITEM = "enum_item";

#var for the test name
my $FIELD       = "f";
my $EN          = "e";
my $EN_IT       = "ei";
my $VAL         = "v";
my $BITRANGE    = "br";
my $PARENT      = "p";
my $CHILD       = "c";
my $SET_OS      = "so";
my $SET_POS     = "sp";
my $SET_W       = "sw";
my $SET_VAL     = "sv";
my $SET_EN      = "se";
my $SET_EN_IT   = "si";
my $RANGE       = "r" ;
my $IB          = "ib";
my $OVU         = "ovu";
my $OBU         = "obu"; 
my $TV          = "tv";
my $TP          = "tp";

my %mapPos;
$mapPos{$IB}  = "0";
$mapPos{$OVU} = "300";
$mapPos{$OBU} = "512";

my %mapVal;
$mapVal{$IB}  = "2";
$mapVal{$OVU} = "262";
$mapVal{$OBU} = "512";

my %mapRange;
$mapRange{$IB} = "0,0";
$mapRange{$OVU}= "0,262";
$mapRange{$OBU}= "13,526";

my @values = ("1","2");

my $UPLOW = "0,212";
my $WIDTH = "512";
my $VALUE = "212";

my %mapDescripP;
$mapDescripP{$IB}  = "the position of the child field is in bounds compared to the parent field width\n";
$mapDescripP{$OBU} = "the position of the child field is completely out of bounds upper compared to the parent width\n";
$mapDescripP{$OVU} = "the position of the child field is overlap upper compared to the parent field width \n";

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
#my @action =($SET_POS,$SET_W);
my @limits =($IB,$OVU,$OBU);

my $test_name = "";
my $test_date = `date "+%d/%m/%G, %T"`;
my $i=1;
my $test = "";
my $classField="csl_field";
my $fieldName="fld";
my $classEnum="csl_enum";
my $enumName ="enn";


#gen tests name and tests
&gen_tests20;
&gen_tests21;

sub gen_tests20
{

    foreach my $actVal(@actionValue){
        if ($actVal eq $SET_EN) {   @limits=($IB,$OBU);}
        else {@limits = ($IB,$OVU,$OBU);}
        foreach my $lim(@limits){
            foreach my $val(@values){
                
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$actVal."_".$TP."_".$lim."_".$val;
                if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                else {$test_name=$test_name.".csl";}
                open(FH,">work/$test_name");
                &header();
                &description($test_name,$lim);
                &legend();
            
                print FH "$classEnum $enumName {\n";
                print FH "           $EN_IT\n";
                print FH "};\n";
            
                switch($test_name){
                    case /(_$FIELD)/{case /(_$FIELD)/{ 
                        print FH "$classField $fieldName$i {\n";
                        print FH "            $fieldName$i() {\n";
                        case /(_$SET_EN)/   {print FH "            $SET_ENUM($enumName);\n";}
                        case /(_$SET_VAL)/  {print FH "            $SET_VALUE($VALUE);\n"; }
                        case /(_$SET_OS)/   {print FH "            $SET_OFFSET($VALUE);\n";}
                    
                    } 
                                 }
                }            
                print FH "      }\n";
                print FH "};\n";
                $i++;
                print FH "$classField $fieldName$i {\n";$i--;
                print FH "           $fieldName$i $fieldName;\n";$i++;
                print FH "           $fieldName$i() {\n";
                print FH "           $SET_WIDTH($WIDTH);\n";
                print FH "           $fieldName.$SET_ENUM_ITEM($EN_IT);\n ";     
                print FH "           $SET_FIELD_POS($fieldName,$mapPos{$lim}+$val);\n";
                print FH "      }\n";
                print FH "};";
                $i++;
            }
    }
}
     @actionValue =($SET_VAL,$SET_OS);
    foreach my $actVal(@actionValue){
        foreach my $lim(@limits){
            foreach my $val(@values){            
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$actVal."_".$TV."_".$lim."_".$val;
                if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                else {$test_name=$test_name.".csl";}
                my $POS = "250";
                open(FH,">work/$test_name");
                &header();
                &description($test_name,$lim);
                &legend();
            
                print FH "$classEnum $enumName {\n";
                print FH "           $EN_IT\n";
                print FH "};\n";
            
                switch($test_name){
                    case /(_$FIELD)/{case /(_$FIELD)/{ 
                        print FH "$classField $fieldName$i {\n";
                        print FH "            $fieldName$i() {\n";
                        case /(_$SET_VAL)/  {print FH "            $SET_VALUE($mapVal{$lim}+$val);\n"; }
                        case /(_$SET_OS)/   {print FH "            $SET_OFFSET($mapVal{$lim}+$val);\n";}
                    
                    } 
                                 }
                }            
                print FH "      }\n";
                print FH "};";
                $i++;
                print FH "$classField $fieldName$i {\n";$i--;
                print FH "           $fieldName$i $fieldName;\n";$i++;
                print FH "           $fieldName$i() {\n";
                print FH "           $SET_WIDTH($WIDTH);\n";
                print FH "           $fieldName.$SET_ENUM_ITEM($EN_IT);\n ";     
                print FH "           $SET_FIELD_POS($fieldName,$POS);\n";
                print FH "      }\n";
                print FH "};\n";
                $i++;
            }
    }
}
}

sub gen_tests21
{
    @limits =($IB,$OVU,$OBU);
    foreach my $value(@arrayValue){
      foreach my $val(@values){
        foreach my $lim(@limits){
            $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$value."_".$TP."_".$lim."_".$val;
            if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
            else {$test_name=$test_name.".csl";}
            open(FH,">work/$test_name");
            &header();
            &description($test_name,$lim);
            &legend();
            print FH "$classEnum $enumName {\n";
            print FH "           $EN_IT\n";
            print FH "};\n";
               
            switch($test_name){    
                case /(_$FIELD)/ {print FH "$classField $fieldName$i {\n";
                                  case /(_$FIELD)/{case /(_$VAL)/{$i++;  print FH "      $classField $fieldName$i ($VALUE);\n";}
                                                   case /(_$RANGE)/{$i++;  print FH "     $classField $fieldName$i ($UPLOW);\n";}
                                                   }
                              }                
            }                 
            
            $i--;
            print FH "      $fieldName$i(){\n";
            print FH "              $SET_WIDTH($WIDTH);\n ";$i++;
            print FH "              $SET_FIELD_POS($fieldName$i,$mapPos{$lim}+$val);\n";
            print FH "      }\n";
            print FH "};";
            
            $i++;
            }
    }
  }


foreach my $value(@arrayValue){
    foreach my $val(@values){
        foreach my $lim(@limits){
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$value."_".$EN."_".$TP."_".$lim."_".$val;
                if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                else {$test_name=$test_name.".csl";}
                open(FH,">work/$test_name");
                &header();
                &description($test_name,$lim);
                &legend();

                print FH "$classEnum $enumName {\n";
                print FH "           $EN_IT\n";
                print FH "};\n";
            
                switch($test_name){    
                    case /(_$FIELD)/ {print FH "$classField $fieldName$i {\n";
                                      case /(_$FIELD)/{case /(_$VAL)/{case /(_$EN)/{$i++; print FH "      $classField $fieldName$i ($VALUE,$enumName);\n";}}
                                                       case /(_$RANGE)/{case /(_$EN)/{$i++; print FH "      $classField $fieldName$i ($UPLOW,$enumName);\n"; }}
                                                   }
                                  }
                }
                
             
                $i--;
                print FH "      $fieldName$i(){\n";
                print FH "              $SET_WIDTH($WIDTH);\n ";$i++;
                print FH "              $SET_FIELD_POS($fieldName$i,$mapPos{$lim}+$val);\n";
                print FH "      }\n";
                print FH "};";
            
                $i++;
            }
    }

}
          my  @limit=($IB,$OVU);

foreach my $value(@arrayValue){
    foreach my $val(@values){
            foreach my $lim(@limit){
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$value."_".$TV."_".$lim."_".$val;
                if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                else {$test_name=$test_name.".csl";}
                my $POS = "250";
                open(FH,">work/$test_name");
                &header();
                &description($test_name,$lim);
                &legend();
            
                if($test_name=~/($EN)\_/)
                {
                    print FH "$classEnum $enumName {\n";
                    print FH "           $EN_IT\n";
                    print FH "};\n";
                }
           
            
                switch($test_name){    
                    case /(_$FIELD)/ {print FH "$classField $fieldName$i {\n";
                                      case /(_$FIELD)/{case /(_$VAL)/{$i++; print FH "      $classField $fieldName$i ($mapVal{$lim}+$val);\n"; }
                                                       case /(_$RANGE)/{$i++; print FH "     $classField $fieldName$i ($mapRange{$lim}+$val);\n";}
                                                   }
                                  }
                }
                
                $i--;
                print FH "      $fieldName$i(){\n";
                print FH "              $SET_WIDTH($WIDTH);\n ";$i++;
                print FH "              $SET_FIELD_POS($fieldName$i,$POS);\n";
                print FH "      }\n";
                print FH "};";
            
                $i++;
            }
        }
}

foreach my $value(@arrayValue){
    foreach my $val(@values){
            foreach my $lim(@limit){
                $test_name = $EN."_".$PARENT."_".$FIELD."_".$SET_W."_".$SET_POS."_".$CHILD."_".$FIELD."_".$value."_".$EN."_".$TV."_".$lim."_".$val;
                if($lim ne "ib") {   $test_name=$test_name."_"."illegal.csl";}
                else {$test_name=$test_name.".csl";}
                my $POS = "250";
                open(FH,">work/$test_name");
                &header();
                &description($test_name,$lim);
                &legend();
       
                print FH "$classEnum $enumName {\n";
                print FH "           $EN_IT\n";
                print FH "};\n";
               
                switch($test_name){    
                    case /(_$FIELD)/ {print FH "$classField $fieldName$i {\n";
                                      case /(_$FIELD)/{case /(_$VAL)/  {case /(_$EN)/{$i++; print FH "      $classField $fieldName$i ($mapVal{$lim}+$val,$enumName);\n"; }}
                                                       case /(_$RANGE)/{case /(_$EN)/{$i++; print FH "     $classField $fieldName$i ($mapRange{$lim}+$val,$enumName);\n";}}
                                                   }
                                  }
                }
               
                $i--;
                print FH "      $fieldName$i(){\n";
                print FH "              $SET_WIDTH($WIDTH);\n ";$i++;
                print FH "             $SET_FIELD_POS($fieldName$i,$POS);\n";
                print FH "      }\n";
                print FH "};";
            
                $i++;
   
            }
        }
            
}

        close(FH);

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
     print FH "//$SET_W=set_width\n";
     print FH "//$SET_VAL=set_value\n";
     print FH "//$SET_EN=set_enum\n";
     print FH "//$SET_EN_IT=set_enum_item\n";
     print FH "//$TV=test value\n";
     print FH "//$TP=test position value\n";
  #   print FH "//$OBL=completely out of bounds lower\n";
  #   print FH "//$OVL=overlap lower\n";
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
    print FH "//a child field is created\n";
    switch($test)
    {
        case /(_$TP)/    {print FH "//$mapDescripP{$lim}";}
        case /(_$VAL)/   {print FH "//$mapDescripV{$lim}";
                          case /(_$EN)/    {print FH "//$mapDescripE{$lim} ";}}
        case /(_$RANGE)/ {print FH "//$mapDescripR{$lim}";
                          case /(_$EN)/    {print FH "//$mapDescripE{$lim} ";}}
    }
   
}

  
       

