#!/usr/bin/perl

use Switch;               # the switch/case command
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command

use strict;

#const for the test name
my $MEMMAPPAGE        = "mmp";
my $SETADDRIGHT       = "_setar";  
my $ADDOBJ            = "_addobj"; 
my $RANGE_OBL         = "_obl";    
my $RANGE_OVL         = "_ovl";    
my $RANGE_IB          = "_ib";     
my $RANGE_OVU         = "_ovu";    
my $RANGE_OBU         = "_obu";    
my $ACCESS_NONE       = "_acc_no"; 
my $ACCESS_READ       = "_acc_rd"; 
my $ACCESS_WRITE      = "_acc_wr"; 
my $ACCESS_READ_WRITE = "_acc_rw"; 
my $SOFTWARE          = "_sw";     
my $HARDWARE          = "_hw";     
my $USER              = "_us";     
my $TEST              = "_ts";     
my $DRIVER            = "_dr";     
my $RESV              = "_addresv";
my $ACCRNG            = "_accrng"; 
my $ONE               = "_1rf";     


#var used in tests
my $classMemoryMap     = "csl_memory_map";
my $memoryMapName      = "mem";
my $classMemoryMapPage = "csl_memory_map_page";
my $memoryMapPageName  = "mempage";
my $addAdrRange        = "add_address_range";
my $addAdrRangeResv    = "add_reserved_address_range";
my $setAccessRights    = "set_access_rights";
my $addObject          = "add";
my $setUnit            = "set_unit_name";
my $classRegisterFile  = "csl_register_file";
my $registerFileName   = "reg";
my $classUnit          = "csl_unit";
my $unitName           = "u";

my $memAdrRange        = " 128,1024";
my $memAdrRangeResv1   = " 128,1024";
my $memAdrRangeResv2   = " 256, 512";
my $memAccessAdrRange  = " 128: 256";
my $rfRange1           = " 200";

my @rangeArray         = (0, 128, 1024);
my @accessRightsType   = ($ACCESS_NONE, $ACCESS_READ, $ACCESS_WRITE, $ACCESS_READ_WRITE);
my @accessCategoryType = ($SOFTWARE, $HARDWARE, $USER, $TEST, $DRIVER);
my @accessRangeType    = ($RANGE_OBL, $RANGE_OVL, $RANGE_IB, $RANGE_OVU, $RANGE_OBU);
my %access_range_mmp ;
   $access_range_mmp{$RANGE_OBL} = "   0";
   $access_range_mmp{$RANGE_OVL} = " 120";
   $access_range_mmp{$RANGE_IB } = " 128";
   $access_range_mmp{$RANGE_OVU} = " 242";                
   $access_range_mmp{$RANGE_OBU} = " 512";                

my %range_mmp ;
   $range_mmp{$RANGE_OBL} = "   0";
   $range_mmp{$RANGE_OVL} = " 120";
   $range_mmp{$RANGE_IB } = " 256";
   $range_mmp{$RANGE_OVU} = "1016";                
   $range_mmp{$RANGE_OBU} = "1098";                

my %rights_mmp ;
   $rights_mmp{$ACCESS_NONE      } = "access_none";
   $rights_mmp{$ACCESS_READ      } = "access_read";
   $rights_mmp{$ACCESS_WRITE     } = "access_write";
   $rights_mmp{$ACCESS_READ_WRITE} = "access_read_write"; 
               
my %category_mmp ;
   $category_mmp{$SOFTWARE} = "sw";
   $category_mmp{$HARDWARE} = "hw";
   $category_mmp{$USER    } = "user";
   $category_mmp{$TEST    } = "test";
   $category_mmp{$DRIVER  } = "driver";

#legend
my %access_rights_description_map;
   $access_rights_description_map {$ACCESS_NONE      } = "the access right is none";
   $access_rights_description_map {$ACCESS_READ      } = "the access right is read only";
   $access_rights_description_map {$ACCESS_WRITE     } = "the access right is write only";
   $access_rights_description_map {$ACCESS_READ_WRITE} = "the access right is read & write";

my %access_category_description_map;
   $access_category_description_map {$SOFTWARE} = "//for the given address range the access category is software,";
   $access_category_description_map {$HARDWARE} = "//for the given address range the access category is hardware,";
   $access_category_description_map {$USER    } = "//for the given address range the access category is user,";
   $access_category_description_map {$TEST    } = "//for the given address range the access category is test,";
   $access_category_description_map {$DRIVER  } = "//for the given address range the access category is driver,";

my %access_range_description_map ;
   $access_range_description_map{$RANGE_OBL} = "//the given base address is completely out of bounds lower address compared to the csl_memory_map_page address range";
   $access_range_description_map{$RANGE_OVL} = "//the given base address is overlapping lower address compared to the csl_memory_map_page address range";
   $access_range_description_map{$RANGE_IB } = "//the given base address is in bounds compared to the csl_memory_map_page address range";
   $access_range_description_map{$RANGE_OVU} = "//the given base address is overlapping upper address compared to the csl_memory_map_page address range";                
   $access_range_description_map{$RANGE_OBU} = "//the given base address is completely out of bounds upper address compared to the csl_memory_map_page address range";  

                    

my $test_name = "";
my $test_type = "";
my $test_date = `date "+%d/%m/%G, %T"`;
my @test_list = ();


#subroutine called
&generate_memory_map_tests;

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

#subroutine to print in the generated file the legend
sub print_legend {
    my $range_type = $_[0];
    my $type       = $_[1];

    #print "print_legend\n";
    print FH "        $access_range_description_map{$range_type}";
    if ($type eq "_addresv") { print FH " reserved\n"; }
    elsif ($type eq "_accrng") { print FH " set with access rights\n"; }    
    else                     { print FH "\n";}
        

}

#subroutine to print in the generated file the header
sub print_header {
    my $test_name = $_[0];

    my $path="$ENV{WORK}/test/csl_cc_gen/";
    &mkDir("$path/mmp_add_Object");
    open (FH, ">$path/mmp_add_Object/$test_name");   

    #print "print_header\n";
    print FH "//Test generated by Ines\n";
    print FH "//Test name: $test_name\n";
    print FH "//Date: $test_date\n\n";
    print FH "// mmp = memory_map_page\n";
    print FH "// setar = set_address_right\n";  
    print FH "// addobj = add_object\n"; 
    print FH "// obl = out_of_bounds_lower\n";    
    print FH "// ovl = overlapping_lower\n";    
    print FH "// ib = in_bounds\n";     
    print FH "// ovu = overlapping_upper\n";    
    print FH "// obu = out_of_bounds_upper\n";    
    print FH "// acc_no = access_none\n"; 
    print FH "// acc_rd = access_read\n"; 
    print FH "// acc_wr = access_write\n"; 
    print FH "// acc_rw = access_read_write\n"; 
    print FH "// sw = software\n";     
    print FH "// hw = hardware\n";     
    print FH "// us = user\n";     
    print FH "// ts = test\n";     
    print FH "// dr = driver\n";     
    print FH "// addresv = add_reserved_address_range\n";
    print FH "// accrng = access_range\n"; 
    print FH "// 1rf = one_register_file\n\n";    
    print FH "//a csl_register_file, csl_unit, csl_memory_map & csl_memory_map_page are created\n";
    print FH "//the csl_memory_map_page has the folowing range of addresses ($memAdrRange)\n";
    print FH "//the csl_memory_map_page has the folowing command addObject() under test\n";
}

#gen tests name
sub generate_memory_map_tests {
    
    #print "generate_memory_map_tests\n";

    foreach my $range (@accessRangeType) {
        $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . $range;
        if ($range eq "_ib") { $test_name = $test_name . "_valid.csl"; }
        else                 { $test_name = $test_name . "_invalid.csl";}        
 
        &print_header($test_name);
        print FH "\n";

        #csl_register
        print FH "$classRegisterFile $registerFileName {\n";
        print FH "    $registerFileName() {\n";
        print FH "        set_width(32);\n";
        print FH "        set_depth(64);\n";
        print FH "    }\n";
        print FH "};\n\n";

        #csl_unit
        print FH "$classUnit $unitName {\n";
        print FH "    $registerFileName $registerFileName;\n";
        print FH "    $unitName() {\n";
        print FH "    }\n";
        print FH "};\n\n";

        #csl_memory_map_page
        print FH "$classMemoryMapPage $memoryMapPageName { \n";
        print FH "    $memoryMapPageName() { \n";
        print FH "        $setUnit($unitName);\n";
        print FH "        $addAdrRange($memAdrRange);\n";
        print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $range_mmp{$range});\n";
        &print_legend($range); 
        print FH "    }\n";
        print FH "};\n\n";
        
        #csl_memory_map
        print FH "$classMemoryMap $memoryMapName { \n";
        # print FH "    $memoryMapPageName $memoryMapPageName; \n";
        # the mem_map_page has auto generated instance
        print FH "    $memoryMapName() { \n";
        print FH "        set_type(hierarchical);\n";
        print FH "    }\n";
        print FH "};\n";
    }
    close(FH);

    foreach my $range (@accessRangeType) {
        $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . $RESV . $range . "_invalid.csl" ;
 
        &print_header($test_name);
        print FH "\n";
        
        #csl_register
        print FH "$classRegisterFile $registerFileName {\n";
        print FH "    $registerFileName() {\n";
        print FH "        set_width(32);\n";
        print FH "        set_depth(64);\n";
        print FH "    }\n";
        print FH "};\n\n";
        
        #csl_unit
        print FH "$classUnit $unitName {\n";
        print FH "    $registerFileName $registerFileName;\n";
        print FH "    $unitName() {\n";
        print FH "    }\n";
        print FH "};\n\n";
        
        #csl_memory_map_page
        print FH "$classMemoryMapPage $memoryMapPageName { \n";
        print FH "    $memoryMapPageName() { \n";
        print FH "        $setUnit($unitName);\n";
        print FH "        $addAdrRange($memAdrRange);\n";
        print FH "        $addAdrRangeResv($memAdrRangeResv1);\n";
        print FH "        //the given address range is reserved in the csl_memory_map_page, then it is accessed for processing\n";
        print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $range_mmp{$range});\n";
        &print_legend($range, $RESV); 
        print FH "    }\n";
        print FH "};\n\n";
        
        #csl_memory_map
        print FH "$classMemoryMap $memoryMapName { \n";
        # print FH "    $memoryMapPageName $memoryMapPageName; \n";
        # the mem_map_page has auto generated instance
        print FH "    $memoryMapName() { \n";
        print FH "        set_type(hierarchical);\n";
        print FH "    }\n";
        print FH "};\n";
    }
    close(FH);

    foreach my $range (@accessRangeType) {
        foreach my $categ (@accessCategoryType) {
            foreach my $right (@accessRightsType) {
                $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . $range . $ACCRNG . $categ . $right ;
                $test_type = $range eq "_obu" || ( $range eq "_ib" &&($right eq "_acc_wr" | $right eq "_acc_rw"));

                if ($test_type) { $test_name = $test_name . "_valid.csl"; }
                else            { $test_name = $test_name . "_invalid.csl";}
  
                &print_header($test_name);
                print FH "\n";
 
                #csl_register
                print FH "$classRegisterFile $registerFileName {\n";
                print FH "    $registerFileName() {\n";
                print FH "        set_width(32);\n";
                print FH "        set_depth(64);\n";
                print FH "    }\n";
                print FH "};\n\n";
 
                #csl_unit
                print FH "$classUnit $unitName {\n";
                print FH "    $registerFileName $registerFileName;\n";
                print FH "    $unitName() {\n";
                print FH "    }\n";
                print FH "};\n\n";
 
                #csl_memory_map_page
                print FH "$classMemoryMapPage $memoryMapPageName { \n";
                print FH "    $memoryMapPageName() { \n";
                print FH "        $setUnit($unitName);\n";
                print FH "        $addAdrRange($memAdrRange);\n";
                print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ}, $rights_mmp{$right});\n";
                print FH "        $access_category_description_map{$categ} $access_rights_description_map{$right}\n";
                print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $access_range_mmp{$range});\n";
                &print_legend($range, $ACCRNG);
                print FH "    }\n";
                print FH "};\n\n";
                
                #csl_memory_map
                print FH "$classMemoryMap $memoryMapName { \n";
                # print FH "    $memoryMapPageName $memoryMapPageName; \n";
                # the mem_map_page has auto generated instance
                print FH "    $memoryMapName() { \n";
                print FH "        set_type(hierarchical);\n";
                print FH "    }\n";
                print FH "};\n";
            }
        }
    }
    close(FH);
    
    
    foreach my $categ (@accessCategoryType) {
        foreach my $right (@accessRightsType) {
            $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . $RESV. $ACCRNG . $categ . $right . "_invalid.csl" ;
   
            &print_header($test_name);
            print FH "\n";
            
            #csl_register
            print FH "$classRegisterFile $registerFileName {\n";
            print FH "    $registerFileName() {\n";
            print FH "        set_width(32);\n";
            print FH "        set_depth(64);\n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_unit
            print FH "$classUnit $unitName {\n";
            print FH "    $registerFileName $registerFileName;\n";
            print FH "    $unitName() {\n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_memory_map_page
            print FH "$classMemoryMapPage $memoryMapPageName { \n";
            print FH "    $memoryMapPageName() { \n";
            print FH "        $setUnit($unitName);\n";
            print FH "        $addAdrRange($memAdrRange);\n";
            print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ}, $rights_mmp{$right});\n";
            print FH "        $access_category_description_map{$categ} $access_rights_description_map{$right}\n";
            print FH "        $addAdrRangeResv($memAdrRangeResv2);\n";
            print FH "        //the given address range is reserved in the csl_memory_map_page, then it is accessed for processing\n";
            print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $rfRange1);\n";
            print FH "        //the given address overlaps upper the address range set with access rights and overlaps lower the reserved address range\n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_memory_map
            print FH "$classMemoryMap $memoryMapName { \n";
            # print FH "    $memoryMapPageName $memoryMapPageName; \n";
            # the mem_map_page has auto generated instance
            print FH "    $memoryMapName() { \n";
            print FH "        set_type(hierarchical);\n";
            print FH "    }\n";
            print FH "};\n";
        }
    }
    
    close(FH);

    foreach my $range (@rangeArray) {
        for (my $u = -6; $u <=6; $u = $u + 2) { 
            my $myRange = $range - $u;
            
            if($myRange < 0) {
                my $myMinusRange = "m" . abs($myRange);
                $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . "_r$myMinusRange" . "_invalid.csl";
            }
            else {
                $test_name = $MEMMAPPAGE . $ADDOBJ . $ONE . "_r$myRange" . "_invalid.csl";
            }
  
            &print_header($test_name);
            print FH "\n";
            
            #csl_register
            print FH "$classRegisterFile $registerFileName {\n";
            print FH "    $registerFileName() {\n";
            print FH "        set_width(2);\n";
            print FH "        set_depth(2);\n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_unit
            print FH "$classUnit $unitName {\n";
            print FH "    $registerFileName $registerFileName;\n";
            print FH "    $unitName() {\n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_memory_map_page
            print FH "$classMemoryMapPage $memoryMapPageName { \n";
            print FH "    $memoryMapPageName() { \n";
            print FH "        $setUnit($unitName);\n";
            print FH "        $addAdrRange($memAdrRange);\n";
            print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $myRange);\n";
            print FH "        //testing the range \n";
            print FH "    }\n";
            print FH "};\n\n";
            
            #csl_memory_map
            print FH "$classMemoryMap $memoryMapName { \n";
            # print FH "    $memoryMapPageName $memoryMapPageName; \n";
            # the mem_map_page has auto generated instance
            print FH "    $memoryMapName() { \n";
            print FH "        set_type(hierarchical);\n";
            print FH "    }\n";
            print FH "};\n";
          }
    }
    close(FH);


#   foreach my $categ1 (@accessCategoryType) {
#       foreach my $categ2 (@accessCategoryType) {
#           foreach my $right (@accessRightsType) {
#               $test_name = $MEMMAPPAGE . $SETADDRIGHT . $RANGE_IB . $categ1 . $categ2 . $right . "_invalid.csl" ;
#
#               &print_header($test_name);
#               print FH "\n";
#
#               #csl_register
#               print FH "$classRegisterFile $registerFileName {\n";
#               print FH "    $registerFileName() {\n";
#               print FH "        set_width(32);\n";
#               print FH "        set_depth(64);\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#
#               #csl_unit
#               print FH "$classUnit $unitName {\n";
#               print FH "    $registerFileName $registerFileName;\n";
#               print FH "    $unitName() {\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#
#               #csl_memory_map_page
#               print FH "$classMemoryMapPage $memoryMapPageName { \n";
#               print FH "    $memoryMapPageName() { \n";
#               print FH "        $setUnit($unitName);\n";        
#               print FH "        $addAdrRange($memAdrRange);\n";
#               print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ1}, $rights_mmp{$right});\n";
#               &print_legend($RANGE_IB, $categ1, $right); 
#               print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ2}, $rights_mmp{$right});\n";
#               &print_legend($RANGE_IB, $categ2, $right); 
#                # print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $range_mmp{$range});\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#               
#               #csl_memory_map
#               print FH "$classMemoryMap $memoryMapName { \n";
#               # print FH "    $memoryMapPageName $memoryMapPageName; \n";
#               # the mem_map_page has auto generated instance
#               print FH "    $memoryMapName() { \n";
#               print FH "        set_type(hierarchical);\n";
#               print FH "    }\n";
#               print FH "};\n";
#           }
#       }
#   }
#   close(FH);
#
#   foreach my $categ (@accessCategoryType) {
#       foreach my $right1 (@accessRightsType) {
#           foreach my $right2 (@accessRightsType) {
#               $test_name = $MEMMAPPAGE . $SETADDRIGHT . $RANGE_IB . $categ . $right1 . $right2 . "_invalid.csl" ;
#
#               &print_header($test_name);
#               print FH "\n";
#
#               #csl_register
#               print FH "$classRegisterFile $registerFileName {\n";
#               print FH "    $registerFileName() {\n";
#               print FH "        set_width(32);\n";
#               print FH "        set_depth(64);\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#
#               #csl_unit
#               print FH "$classUnit $unitName {\n";
#               print FH "    $registerFileName $registerFileName;\n";
#               print FH "    $unitName() {\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#
#               #csl_memory_map_page
#               print FH "$classMemoryMapPage $memoryMapPageName { \n";
#               print FH "    $memoryMapPageName() { \n";
#               print FH "        $setUnit($unitName);\n";
#               print FH "        $addAdrRange($memAdrRange);\n";
#               print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ}, $rights_mmp{$right1});\n";
#               &print_legend($RANGE_IB, $categ, $right1); 
#               print FH "        $setAccessRights($memAccessAdrRange, $category_mmp{$categ}, $rights_mmp{$right2});\n";
#               &print_legend($RANGE_IB, $categ, $right2); 
#               # print FH "        $addObject($unitName.$registerFileName, \"$registerFileName\", $range_mmp{$range});\n";
#               print FH "    }\n";
#               print FH "};\n\n";
#               
#               #csl_memory_map
#               print FH "$classMemoryMap $memoryMapName { \n";
#               # print FH "    $memoryMapPageName $memoryMapPageName; \n";
#               # the mem_map_page has auto generated instance
#               print FH "    $memoryMapName() { \n";
#               print FH "        set_type(hierarchical);\n";
#               print FH "    }\n";
#               print FH "};\n";
#           }
#       }
#   }
#   close(FH);
#



    print "[INFO]Done\n";
}
