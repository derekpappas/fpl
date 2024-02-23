#!/usr/bin/perl


use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command

use strict;

#const for the test name
my $MEMMAPPAGE        = "mmp";
my $SETUNIT           = "_setu";
my $NOUNIT            = "_0u";
my $ONEUNIT           = "_1u";
my $TWOUNIT           = "_2u";
my $ONEMMP            = "_1mmp";
my $TWOMMP            = "_2mmp";
my $ADDOBJ            = "_addobj";

#var used in tests
my $classMemoryMap     = "csl_memory_map";
my $memoryMapName      = "mem";
my $classMemoryMapPage = "csl_memory_map_page";
my $memoryMapPageName1 = "mempage1";
my $memoryMapPageName2 = "mempage2";
my $addAdrRange        = "add_address_range";
#my $addAdrRangeResv    = "add_reserved_address_range";
#my $setAccessRights    = "set_access_rights";
my $addObject          = "add";
my $setUnit            = "set_unit_name";
my $classRegisterFile  = "csl_register_file";
my $registerFileName1  = "reg1";
my $registerFileName2  = "reg2";
my $classUnit          = "csl_unit";
my $unitName1          = "u1";
my $unitName2          = "u2";


my $memAdrRange        = " 128, 1024";
my $memAdrRangeResv    = " 128, 1024";
my $rfRange1           = " 200";

my $test_name = "";
my $test_date = `date "+%d/%m/%G, %T"`;
my @test_list = ();


#subroutine called
&generate_memory_map_tests;

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

#subroutine to print in the generated file the header
sub print_header {
    my $test_name = $_[0];

    my $path="$ENV{WORK}/test/csl_cc_gen/";
    &mkDir("$path/mmp_set_unit_name");
    open (FH, ">$path/mmp_set_unit_name/$test_name");

    #print "print_header\n";
    print FH "//Test generated by Ines\n";
    print FH "//Test name: $test_name\n";
    print FH "//Date: $test_date\n";
    print FH "//a csl_register_file, csl_unit, csl_memory_map & csl_memory_map_page are created\n";
    print FH "//the csl_memory_map_page has the folowing range of addresses ($memAdrRange)\n";
    print FH "//the csl_memory_map_page has the folowing command set_unit_name() under test\n";
}

#subroutine gen tests name
sub generate_memory_map_tests {
    
    #print "generate_memory_map_tests\n";

    $test_name = $MEMMAPPAGE . $SETUNIT . "_valid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //only one unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH);   

    $test_name = $MEMMAPPAGE . $SETUNIT . $ONEUNIT . $TWOMMP . "_invalid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //only one unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName2 { \n";
    print FH "    $memoryMapPageName2() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //the same unit is added to the second csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH); 

    $test_name = $MEMMAPPAGE . $SETUNIT . $TWOUNIT . $ONEMMP . "_invalid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_unit
    print FH "$classUnit $unitName2 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName2() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        $setUnit($unitName2); \n";
    print FH "        //two units are added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH);   

    $test_name = $MEMMAPPAGE . $SETUNIT . $ONEUNIT . "hier" . $ONEMMP . "_invalid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_unit
    print FH "$classUnit $unitName2 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1 $unitName1; \n";
    print FH "    $unitName2() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //one hierarchical unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH);   

    $test_name = $MEMMAPPAGE . $SETUNIT . $ONEUNIT . "hier" . $ONEMMP . $ADDOBJ . "_invalid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_unit
    print FH "$classUnit $unitName2 {\n";
    print FH "    $unitName1 $unitName1; \n";
    print FH "    $unitName2() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //one hierarchical unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName2.$unitName1.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "        //one register file is added from a hierarchical unit \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH);  

    $test_name = $MEMMAPPAGE . $SETUNIT . $ONEUNIT . $ONEMMP . $ADDOBJ . "_invalid.csl" ;

    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_unit
    print FH "$classUnit $unitName2 {\n";
    print FH "    $unitName2() { \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName1); \n";
    print FH "        //one hierarchical unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName2.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "        //one register file is added from a hierarchical unit \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";
    
    close(FH);  

    $test_name = $MEMMAPPAGE . $SETUNIT . $NOUNIT . $ONEMMP . $ADDOBJ . "_invalid.csl" ;
 
    &print_header($test_name);
    print FH "\n";
    
    #csl_register
    print FH "$classRegisterFile $registerFileName1 { \n";
    print FH "    $registerFileName1() { \n";
    print FH "        set_width(32); \n";
    print FH "        set_depth(64); \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_unit
    print FH "$classUnit $unitName1 {\n";
    print FH "    $registerFileName1 $registerFileName1; \n";
    print FH "    $unitName1() { \n";
    print FH "    } \n";
    print FH "}; \n\n";

    #csl_memory_map_page
    print FH "$classMemoryMapPage $memoryMapPageName1 { \n";
    print FH "    $memoryMapPageName1() { \n";
    print FH "        $setUnit($unitName2); \n";
    print FH "        //one unexisting unit is added to the csl_memory_map_page \n";
    print FH "        $addAdrRange($memAdrRange); \n";
    print FH "        $addObject($unitName2.$registerFileName1, \"$registerFileName1\", $rfRange1); \n";
    print FH "        //one register file is added from an unexisting unit \n";
    print FH "    } \n";
    print FH "}; \n\n";
    
    #csl_memory_map
    print FH "$classMemoryMap $memoryMapName { \n";
    # print FH "    $memoryMapPageName $memoryMapPageName; \n";
    # the mem_map_page has auto generated instance
    print FH "    $memoryMapName() { \n";
    print FH "        set_type(hierarchical); \n";
    print FH "    }\n";
    print FH "}; \n";

    print "[INFO]Done\n";
}