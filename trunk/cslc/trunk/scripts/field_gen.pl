#!/usr/bin/perl


use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command

use strict;

#var used in tests
my $SET_VA     = "set_value";
my $SET_EN     = "set_enum";
my $SET_EN_IT  = "set_enum_item"; 

#my @arrayActionValue=($SET_VALUE,$SET_ENUM,$SET_ENUM_ITEM);

my $ENUM      = "enum";
my $ENUM_ITEM = "enum_item";
my $VALUE     = 5;

#my @arrayValue =($ENUM,$ENUM_ITEM,$VALUE);

#var for the test name
my $field         = "f";
my $enum          = "e";
my $enum_item     = "ei";
my $value         = "v";
my $range         = "r";
my $bitrange      = "br";
my $parent        = "p";
my $child         = "c";
my $grandparent   = "g";
my $set_offset    = "so";
my $set_type      = "st";
my $set_range     = "sr";
my $set_value     = "sv";
my $set_enum      = "se";
my $set_enum_item = "sei";


my @arrayValue =($enum,$enum_item,$value);
my @actionValue =($set_enum,$set_enum_item,$set_value);
my @action =($set_type,$set_range,$set_offset);

my $test_name = "";
my $test_date = `date "+%d/%m/%G, %T"`;
my @testlist = ();
my $i=1;
my $test = "";
my $classField="csl_field";
my $fieldName="fld";
my $classEnum="csl_enum";
my $enumName ="enn";

#gen tests name
foreach my $value(@arrayValue){
    foreach my $actVal(@actionValue){
        foreach my $act(@action){
            $test_name = $parent."_".$field."_".$actVal."_".$value."_".$child."_".$field."_".$act.".csl";
            #print "$test_name\n";
            open(FH,">$test_name");
            print FH "//Test name: $test_name\n";
            print FH "//Date: $test_date";
            print FH "//Description: testing the commands $actVal($value) and $act\n";
            print FH "//Legend:\n";
            print FH "//$grandparent=grandparent\n";
            print FH "//$parent=parent\n";
            print FH "//$child=child\n";
            print FH "//$field=field\n";
            print FH "//$enum=enum\n";
            print FH "//$enum_item=enum_item\n";
            print FH "//$value =value\n";
            print FH "//$range=range\n";
            print FH "//$bitrange=bitrange\n";
            print FH "//$set_offset=set_offset\n";
            print FH "//$set_type=set_type\n";
            print FH "//$set_range=set_range\n";
            print FH "//$set_value=set_value\n";
            print FH "//$set_enum=set_enum\n";
            print FH "//$set_enum_item=set_enum_item\n\n";
            if($test_name=~/(_$enum)/)
            {
                print FH "$classEnum $enumName {\n";
                print FH "           $enum_item,\n";
                print FH "};\n";
            }
                
            if($test_name=~/(_$field)/)
            {
                print FH "$classField $fieldName$i {\n";
                
                if($test_name=~/(_$field)/)
                {
                    $i++;
                    print FH "      $classField $fieldName$i ($enumName);\n";
                }
                $i--;
                print FH "      $fieldName$i(){\n";
                print FH "              $SET_EN($enumName);\n";
                print FH "      }\n";
                print FH "};";
            }
            $i++;
           # push(@testlist,$test_name);
        }
    }
    close(FH);
    
}
