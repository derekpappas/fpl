#!/usr/bin/perl
#Maintainers(s): Ines and Petronela and Derek

use Class::Struct;

#&generatenames();

###################################################
#               generate file name                #
###################################################

#sub generatenames 
#{
#    @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
#    @weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
#    ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
#    $year = 1900 + $yearOffset;
#    $theTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";
#
#    $testType = "mem_map";
#    @memMapType = ("flat", "hierarchical", "virtual_page", "virtual_base_address");
#    @memMapCmd1 = ("illegal", "reserved", "not_free");
#    @memMapCmd2 = ("free", "not_reserved", "legal");
#
#    %memoryMapTestComment = {};
#    $memMapCmd["illegal"     ] = "";    
#    $memMapCmd["reserved"    ] = "e";    
#    $memMapCmd["not_free"    ] = "";    
#    $memMapCmd["free"        ] = "";    
#    $memMapCmd["not_reserved"] = "";    
#    $memMapCmd["legal"       ] = "";    
#
#
#
#
#    foreach $memMapType (@memMapType) {
#        foreach $addrRange1 (@memMapCmd1) {
#            foreach $addrRange2 (@memMapCmd2) {
#                $testName = $testType . "_" . $memMapType."_".$addrRange1."_".$addrRange2.".csl";
#                open(FH, "> $testName");
#                print "$testName\n";
#                print FH "// $testName\n";
#                print FH "// Test name: $testName\n";
#                print FH "// date: print $theTime\n";
#                print FH "// Test memory type is $memMapType\n";
#                print FH "// Test adds a $addrRange1 to a $addrRange2\n";
#                print FH "
#csl_register_file rf {
#  rf() {
#   set_depth(16);
#   set_width(32);
#  }
#};
#
#csl_unit top {
#  rf rf0;
#  top () {
#  }
#};
#
#csl_memory_map_page mpage_1{
#  mpage_1(){\n";
#print FH "
#    $memMapCmd[$addrRange1]";
#                if ($addrRange1    eq "illegal" ) {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                elsif ($addrRange1 eq "reserved") {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                elsif ($addrRange1 eq "not_free") {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                print FH "($lowerIndex, $upperIndex);\n";
#print FH "
#    $memMapCmd[$addrRange1]";
#                if ($addrRange1    eq "free" ) {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                elsif ($addrRange1 eq "not_reserved") {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                elsif ($addrRange1 eq "legal") {
#                    $lowerIndex = 5;
#                    $upperIndex = 250;
#                }
#                print FH "($lowerIndex, $upperIndex);\n";
#                print FH "
#    add(top.rf0, \"rf\", 64);
#  }
#};
#
#csl_memory_map mmap{
#  mpage_1 mp1;
#  mmap(){
#    set_type($memMapType);
#    set_data_word_width(32);
#  }
#};
#\n";
#
#                close(FH);
#
#            }
#        }
#    }
#}


sub createFifo {

}

# list of units in design
# every time a unit is created then the unit is addded to the unit list for the design
# if the unit is instantiated in another unit then that unit cannot be instantitaed in a parent unit
# no cycles
# every unit needs a lsit of units at and below it.
# olny one top unit

# need an instance tree
# need functions to creare a tree of units
# need one function to create each of the different obejcts that can be instantiated in a unit
# we do not need ports/interfaces

struct( unit => [
                 unitName  => '$',      
                 instances => "@", 
                 ]);                      

%unitList = {};
%instanceList = {};

struct( unitInstance => [
                         unitName => '$',      
                         instName => '$',      
                         children  => "@", #compilerPhaseResults key: regressName val:result
                         ]);                      

@array = (0,1,2,3,4);

my $tree = &buildTree(0);

$maxLevel = 10;

sub buildTree {
    my($level) = @_;
    print "buildTree level = $level\n";
    my $index   = rand @array;
    my $numChildren = $array[$index];

    print "numChildren = $numChildren\n";
    my $unitName     = generateUnitName();
    my $instanceName = "";   #generateInstanceName($unitName);
    my @instances = ();

    my $instance = 0;

    if ($level < $maxLevel) { 
        for(my $i = 0; $i < $numChildren; $i++ ) {
            $level++;
            $node = buildTree($level);

            if (0 == $node){
                print "ran out of instance names or levels level = $level node = $node\n"; 
                last;
            } # ran out of instance names or levels
            $level--;
            push (@instances, $node);
        }

        $instance = unitInstance->new(  
                                        unitName => "$unitName", 
                                        instName => "$instName",                  
                                        children => \@instances,
                                        );
    }

    return $instance;
}

$uniqueNum = 1;
sub generateUnitName {
    my $name = "";
    print "generateUnitName MAX_UNITS = $MAX_UNITS\n";
    my $MAX_UNITS = 20;

    my $i = 0;
    while ($i < $MAX_UNITS  ) {
        my $randNum = int((rand $scalar) * $MAX_UNITS);
        $name = "unit_$randNum";

        if (!(defined ($unitList{"$name"}))) {
            $unitList{"$name"} = $uniqueNum++;
            print "  IF generateUnitName unitname = $name unitList{$name} = $unitList{$name}\n";
            goto DONE;
        }
        else {
            print "  ELSE generateUnitName unitname = $name\n";
        }
        $i++;
    }

DONE:
    return $name;
}

#sub generateInstanceName {
#    my ($unitName) = @_;
#    my $name = "";
#    print "generateInstanceName\n";
#    my $MAX_INSTANCES = 100;
#
#    while (1) {
#        my $randNum = int((rand $scalar) * $MAX_INSTANCES);
#        $name = "$unitName" . "_$randNum";
#        print "   generateInstanceName unitname = $name\n";
#
#        if (!(defined ($instanceList{$name}))) {
#            last;
#        }
#    }
#
#    $instanceList{$name} = $uniqueNum++;
#
#    return $name;
#}
