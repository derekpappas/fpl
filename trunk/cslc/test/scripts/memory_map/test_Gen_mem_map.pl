#!/usr/bin/perl
#Maintainers(s): Ines and Petronela and Derek

&generatenames();

###################################################
#               generate file name                #
###################################################

sub generatenames 
{
    @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    @weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
    ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
    $year = 1900 + $yearOffset;
    $theTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";

    $testType = "mem_map";
    @memMapType = ("flat", "hierarchical", "virtual_page", "virtual_base_address");
    @memMapCmd1 = ("illegal", "reserved", "not_free");
    @memMapCmd2 = ("free", "not_reserved", "legal");

    %memoryMapAdressRange = {};
    $memMapCmd["illegal"     ] = "add_address_range";    
    $memMapCmd["reserved"    ] = "add_reserved_address_range";    
    $memMapCmd["not_free"    ] = "add_address_range";    
    $memMapCmd["free"        ] = "add_address_range";    
    $memMapCmd["not_reserved"] = "add_address_range";    
    $memMapCmd["legal"       ] = "add_address_range";    

    foreach $memMapType (@memMapType) {
        foreach $addrRange1 (@memMapCmd1) {
            foreach $addrRange2 (@memMapCmd2) {
                $testName = $testType . "_" . $memMapType."_".$addrRange1."_".$addrRange2.".csl";
                open(FH, "> $testName");
                print "$testName\n";
                print FH "// Test name: $testName\n";
                print FH "// date: print $theTime\n";
                print FH "// Test memory type is $memMapType\n";
                print FH "// Test adds a $addrRange1 to a $addrRange2\n";
                print FH "
csl_register_file rf {
  rf() {
   set_depth(16);
   set_width(32);
  }
};

csl_unit top {
  rf rf0;
  top () {
  }
};

csl_memory_map_page mpage_1{
  mpage_1(){\n";
print FH "
    $memMapCmd[$addrRange1]";
                if ($addrRange1    eq "illegal" ) {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
                elsif ($addrRange1 eq "reserved") {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
                elsif ($addrRange1 eq "not_free") {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
                print FH "($lowerIndex, $upperIndex);\n";
#print FH "
#    $memMapCmd[$addrRange2]";
                if ($addrRange1    eq "free" ) {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
                elsif ($addrRange1 eq "not_reserved") {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
                elsif ($addrRange1 eq "legal") {
                    $lowerIndex = 5;
                    $upperIndex = 250;
                }
#                print FH "($lowerIndex, $upperIndex);\n";
                print FH "
    add(top.rf0, \"rf\", 64);
  }
};

csl_memory_map mmap{
  mpage_1 mp1;
  mmap(){
    set_type($memMapType);
    set_data_word_width(32);
  }
};
\n";

                close(FH);

            }
        }
    }
}
