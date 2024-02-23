#! /usr/bin/perl -w

# copyright 2008 Fastpath Logic 
# all rights reserved

use Getopt::Long;
use strict;
use Data::Dumper;

my $hierFileName   = "";
my $cslGenFileName = "";
my $ifcFileName    = "";

my $fname          = "";
my $fn             = "";


my @stack;
my %treeHash; # hierarchy tree
my %unitHash; # list of units
my %instHash; # list of instances
my %instHIDPathHash; # list of instance/numeric HID mappings
my @hidPathStack; # current HID numeric path
my @hidPathWithUnitInstNameStack; # current HID numeric path
my @parentUnitList; #list of units that are parents
my %unitChildrenHash;
my %fromIfcHash;
my %toIfcHash;
my %unitIfcHash;
my @connectionList;
my %fromPortHashRev;
my %toPortHashRev;
my %fromPortHash;
my %toPortHash;

my $rootUnitName = "";
my $rootInstName = "";

#............................................................
# Main
#............................................................

&main();

sub main {

    &readCmdLineArgs();

    push @stack, \%treeHash; # initialize the stack

    print Dumper(\%treeHash);

    &readHierFile($hierFileName, 0);

    &readCSVFile();

    &printCSL();

}

#............................................................
#
#............................................................

sub readHierFile {
    my ($hierFileName, $depth) = @_;

    if (! -e $hierFileName) { return; }
    else { print "Opening hier file : $hierFileName\n"; }


    my $HIERFILE;

#  open design hierarchy file
    open ($HIERFILE, $hierFileName) or die "----$hierFileName : $! \n";

    my $unitName = "";
    my $instName = "";
    my @parents;

    my $instCnt = 0;
    while(<$HIERFILE>){
        chomp;

        if (m/^\#/) { next; } # skip lines with comments

        s/(\s*)//;
        my $unitNinstN = $_;
        print "HIER $instCnt hier line = $_\n";
        if ($rootUnitName eq "") {
            m/([^\{]+)\{\s*([^\}]+)/; 
            $rootUnitName = $1;
            $rootInstName = $2;
            push @hidPathStack, $rootUnitName;

# make a string with the unit and instance names
            $unitName = $1;
            $instName = $2;
            $unitName =~ s/\s+//;
            $instName =~ s/\s+//;                                                                                                     
            push @hidPathStack, $instName; # add the current line element to the children at hidPathStack[hidPathStack.depth] and add the hidPathStack element to the hidPathStack

            my $pathHID = $unitName . "($instName)";
            push @hidPathWithUnitInstNameStack, $pathHID;
            push @hidPathWithUnitInstNameStack, $pathHID;
            print "ZZZ hidPathWithUnitInstNameStack = @hidPathWithUnitInstNameStack\n";

            $instHIDPathHash{$pathHID} = $instName;# create the map of instNames to HID paths
            
            $unitHash{$unitName} = 1;
            $instHash{$instName} = $unitName;
            print "HIER added inst name /$instName/\n";
            $instCnt++;
        }
        
#adding children from top unit
        if($unitNinstN =~ m/^(\|)([^\|]+)\s*(.*)/ ) {

            s/^(\|)//;
            my $stackDepth = $depth + length($1); #count the number of '|' chars which is the tree depth of the element
            print "stackDepth = $stackDepth stack # = $#stack stack = @stack  \n";
            
            if (0 == $stackDepth) { next;}
            splice @stack, $stackDepth; # pop n elements off of the stack

            # add the current line element to the children at stack[stack.depth] and add the stack element to the stack
            push   @stack, $stack[$#stack]->{$_} = {}; 
            
            my $unitNameInstanceName = $_;
            if ( $unitNameInstanceName =~ m/([^\{]+)\{\s*([^\}]+)\}/ ) {   
                $unitName = $1;
                $instName = $2;
                $unitName =~ s/\s+//;
                $instName =~ s/\s+//;
# create the instance hash with the single name
                splice @hidPathStack, $stackDepth; # pop n elements off of the hidPathStack
                push   @hidPathStack, $instName; # add the current line element to the children at hidPathStack[hidPathStack.depth] and add the hidPathStack element to the hidPathStack
                
                my @hidPathStackTmp = @hidPathStack;
                shift @hidPathStackTmp;
                my $hidPath = join("\.", @hidPathStackTmp);
                print "instName = $instName \t\thidPath = $hidPath\n";
                $instHash{$hidPath} = $unitName; # create the map of instNames to HID paths
                
# create the stack with the a(a).b(b) paths
                splice @hidPathWithUnitInstNameStack, $stackDepth; # pop n elements off of the hidPathWithUnitInstNameStack
                push   @hidPathWithUnitInstNameStack,$unitName . "($instName)"; # add the current line element to the children at hidPathWithUnitInstNameStack[hidPathWithUnitInstNameStack.depth] and add the hidPathWithUnitInstNameStack element to the hidPathWithUnitInstNameStack
                print "ZZZ hidPathWithUnitInstNameStack = @hidPathWithUnitInstNameStack\n";
                
                my @hidPathWithUnitInstNameStackTmp = @hidPathWithUnitInstNameStack;
               # shift @hidPathWithUnitInstNameStackTmp;
                my $hidUnitInstPath = join("\.", @hidPathWithUnitInstNameStackTmp);
                print "ZZZX instName = $instName \t\t hidUnitInstPath = $hidUnitInstPath\n";
                $instHIDPathHash{$hidUnitInstPath} = $unitName; # create the map of instNames to HID paths                

                if (! defined ($unitHash{$unitName}) ) { $unitHash{$unitName} = 1; } 
                
                my $hierFileName = $unitName . ".hier";
                if ($depth < $stackDepth) { # at the first level in the file so do not look for file again
                    &readHierFile($hierFileName, $stackDepth);
                }
                $instHash{$instName} = $unitName;
                print "HIER added inst name /$instName/\n";
                print "HIER added unit name /$unitName/\n";
                $instCnt++;
            }            
            else { die "ERROR in hier file line = $_"; }
        }
        
#adding children from units in the top unit

        if($unitNinstN =~ m/^(\|\|)([^\{]+)\{([^\}]+)\}/) {

            s/^(\|\|)//;
            my $stackDepth = $depth + length($1); #count the number of '||' chars which is the tree depth of the element
            print "stackDepth = $stackDepth stack # = $#stack stack = @stack \n";
            
            if (0 == $stackDepth) { next;}
            splice @stack, $stackDepth; # pop n elements off of the stack
            push   @stack, $stack[$#stack]->{$_} = {}; # add the current line element to the children at stack[stack.depth] and add the stack element to the stack

            my $unitNameInstanceName = $_;
            if ( $unitNameInstanceName =~ m/([^\{]+)\{\s*([^\}]+)\}/ ) {   
                $unitName = $1;
                $instName = $2;
                $unitName =~ s/\s+//;
                $instName =~ s/\s+//;
                splice @hidPathStack, $stackDepth; # pop n elements off of the hidPathStack
                push   @hidPathStack, $instName; # add the current line element to the children at hidPathStack[hidPathStack.depth] and add the hidPathStack element to the hidPathStack
                
                my @hidPathStackTmp = @hidPathStack;
                shift @hidPathStackTmp;
                my $hidPath = join("\.", @hidPathStackTmp);
                print "instName = $instName \t\thidPath = $hidPath\n";
                $instHash{$hidPath} = $unitName; # create the map of instNames to HID paths
                
# create the stack with the a(a).b(b) paths
                splice @hidPathWithUnitInstNameStack, $stackDepth; # pop n elements off of the hidPathWithUnitInstNameStack
                push   @hidPathWithUnitInstNameStack,$unitName . "($instName)"; # add the current line element to the children at hidPathWithUnitInstNameStack[hidPathWithUnitInstNameStack.depth] and add the hidPathWithUnitInstNameStack element to the hidPathWithUnitInstNameStack
                print "ZZZ hidPathWithUnitInstNameStack = @hidPathWithUnitInstNameStack\n";
                
                my @hidPathWithUnitInstNameStackTmp = @hidPathWithUnitInstNameStack;
               # shift @hidPathWithUnitInstNameStackTmp;
                my $hidUnitInstPath = join("\.", @hidPathWithUnitInstNameStackTmp);
                print "ZZZX instName = $instName \t\t hidUnitInstPath = $hidUnitInstPath\n";
                $instHIDPathHash{$hidUnitInstPath} = $unitName; # create the map of instNames to HID paths

                if (! defined ($unitHash{$unitName}) ) {
                    $unitHash{$unitName} = 1;
                } 
                
                my $hierFileName = $unitName . ".hier";
                if ($depth < $stackDepth) { # at the first level in the file so do not look for file again
                    &readHierFile($hierFileName, $stackDepth);
                }
                $instHash{$instName} = $unitName;
                print "HIER added inst name /$instName/\n";
                print "HIER added unit name /$unitName/\n";
                
                $instCnt++;
            }            
            else { die "ERROR in hier file line = $_"; }           
        }
    }
    close($HIERFILE);


    foreach my $k (@stack) {
        print "stack:: $k\n";
    }

    print "Begin unitHash\n"; 
    foreach my $k (sort keys %unitHash) {
        print "$k\n";
    }

    print "End unitHash\n";

    print "Begin instHash\n";
    my $c = 0;
    foreach my $k (sort keys %instHash) {
        print "$c instHash $k\n";
        $c++;
    }
    print "End instHash\n";

    print "instHash count = " , scalar( keys %instHash), "\n";

    print "Begin instHIDPathHash\n";
    $c = 0;
    foreach my $k (sort keys %instHIDPathHash) {
        print "$c instHIDPathHash $k = $instHIDPathHash{$k}\n";
        $c++;
    }
    print "End instHIDPathHash\n";


    print "instHIDPathHash count = " , scalar( keys %instHIDPathHash), "\n";


    foreach my $k (keys %treeHash) {
        print "k:: $k v:: $treeHash{$k}\n";
#    $unitChildrenHash{$k} = keys %{$treeHash{$k}};

        foreach my $kk (keys %{$treeHash{$k}}) {
            print "  kk:: $kk \n";
        }
    }

    foreach my $k (keys %unitHash) {
        print "UnitHash k:: $k\n";
    }


}

#............................................................
# a pre-order traversal. First we do something ...
# ... and then we recurse the children
#............................................................

sub traverse {
    my ($node, $depth) = @_;
#    print "node = ", $node," depth = $depth keys = ", keys %{$node},"\n";
    my $unitName;
    my $instName;
    
    my @children = ();

    print "keys count = ". scalar(keys %{$node}),"\n";
    foreach my $k (keys %{$node}) {
        print "key = $k\n";  # $k : unit{unit_instance}
        my $c = $node->{$k};  # children for $k : unit{unit_instance}
        print "|" x $depth, $k,"\n";
#	print "|x".$depth.",".$k."\n";

        if ( $k =~ m/([^\{]+)\{\s*([^\}]+)\}/ ) {
            $unitName = $1;
            $instName = $2;

            $unitName =~ s/(\s+)//g;
            $instName =~ s/(\s+)//g;

            $unitHash{$unitName} = 1;
            $instHash{$instName} = $unitName;

        }
        else {die "ERROR could not find unit and inst names c = $c k = /$k/ keys = ", keys %{$node},"";}
        push @children, $instName;
#checking if unit with children has been added to %unitChildrenHash
        if(! defined $unitChildrenHash{$unitName}) {
            $unitChildrenHash{$unitName} = traverse($c, $depth+1);
        }
        else {
            push @{$unitChildrenHash{$unitName}},@{traverse($c, $depth+1)};
        }
    }

    print "children = @children\n"; 
    
    return \@children;
}



################################################################################
# Generate the CSL code
################################################################################

# the bug in the code below is that the first time that an instance of a unit is found the unit is 
# created. If another instance of the unit is found then the unit is not being updated. The interfaces
# are not being added the second time that an instance of the unit is found

sub printCSL {
    my %doneUnits;
    my $unit;

    open (CSLGENFILE, "> $cslGenFileName") or die "$cslGenFileName : $! \n";

    print CSLGENFILE "// Generated by $0 \n";
    print CSLGENFILE "// CSL library filename      = $ifcFileName       \n";
    print CSLGENFILE "// Design Hierarchy filename = $hierFileName\n";
    print CSLGENFILE "// CSL csv filename          = $fname       \n";
    print CSLGENFILE "// Generated CSL filename    = $cslGenFileName\n";
    print CSLGENFILE "\n\n";

    foreach my $k (keys %unitHash) {
        print CSLGENFILE "csl_unit $k;\n";
    }

    foreach my $inst (keys %instHash) {
        if (defined $instHash{$inst}) { $unit = $instHash{$inst}; }
        else { die "instance not defined : $inst\n";}
        
        if ($rootUnitName ne $unit) {
            print "fin inst $inst\n";
            if (! defined $doneUnits{$unit} ) {
                $doneUnits{$unit}  = 1;
                &printCSLUnit($inst, $unit);
            }
        }
    }

    &printCSLUnit($rootInstName, $rootUnitName);
}

###############

sub printCSLUnit {
    my ($inst, $unit) = @_;
    print CSLGENFILE "\n\ncsl_unit $unit {\n"; 
    print  "fin done /$inst/\n";

    if (defined $fromIfcHash{$unit} ) {
        print  "fin if defined fromIfcHash $unit\n";
        foreach my $connection ( @{$fromIfcHash{$unit}}) { 
            my $interfaceType = $connection->[0];
            my $connFromName  = $connection->[1];
            print  "ifcgen interfaceType     =  $interfaceType         \n";
            print  "ifcgen connFromName       =  $connFromName      \n";
            print CSLGENFILE "  $interfaceType $connFromName; // from ifc\n";
        }
    }

    if (defined $toIfcHash{$unit} ) {
        print  "fin if defined toIfcHash $unit\n";
        foreach my $connection ( @{$toIfcHash{$unit}}) {  
            my $interfaceType = $connection->[0];
            my $connToName    = $connection->[1];
            print  "ifcgen interfaceType     =  $interfaceType         \n";
            print  "ifcgen connToName       =  $connToName      \n";
            print  CSLGENFILE "  $interfaceType $connToName; // to ifc\n";
        }
    }
    

    if (defined $fromPortHashRev{$unit} ) {
        print  "fin if defined fromPortHash $unit\n";
        foreach my $connection ( @{$fromPortHashRev{$unit}}) {  
            my $connFromPName  = $connection->[0];
            my $directionP = $connection->[1];
            print  "portgen connFromPNameRev       =  $connFromPName      \n";
            print CSLGENFILE "  csl_port $connFromPName($directionP); // from port\n";
        }
    }

    if (defined $fromPortHash{$unit} ) {
        print  "fin if defined fromPortHash $unit\n";
        foreach my $connection ( @{$fromPortHash{$unit}}) {  
            my $connFromPName  = $connection->[0];
            my $directionP = $connection->[1];
            print  "portgen connFromPName       =  $connFromPName      \n";
            print CSLGENFILE "  csl_port $connFromPName($directionP); // from port\n";
        }
    }
    

    if (defined $toPortHashRev{$unit} ) {
        print  "fin if defined toPortHash $unit\n";
        foreach my $connection ( @{$toPortHashRev{$unit}}) {    
            my $connToPName    = $connection->[0];
            my $directionP = $connection->[1];
            print  "portgen connToPNameRev       =  $connToPName      \n";
            print CSLGENFILE "  csl_port $connToPName($directionP); // to port\n";
        }
    }

    if (defined $toPortHash{$unit} ) {
        print  "fin if defined toPortHash $unit\n";
        foreach my $connection ( @{$toPortHash{$unit}}) {    
            my $connToPName    = $connection->[0];
            my $directionP = $connection->[1];
            print  "portgen connToPName       =  $connToPName      \n";
            print CSLGENFILE "  csl_port $connToPName($directionP); // to port\n";
        }
    }

    foreach my $inst (@{$unitChildrenHash{$unit}}) {
        print CSLGENFILE "  $instHash{$inst} $inst";
        print CSLGENFILE "  ; \n";
    }

    print CSLGENFILE "  $unit () {\n";

    my $fromName = "";
    my $toName = "";
    
    if ($rootUnitName eq $unit) {
        foreach my $conn (@connectionList){
            my $fromInstHID  = $conn->[0];
            my $toInstHID    = $conn->[1];
            my $connFromName = $conn->[2];
            my $connToName   = $conn->[3];
            my $actualName   = $conn->[4];

            $fromName = "";
            if ($fromInstHID ne $rootUnitName) { $fromName = $fromInstHID . ".";}

            $toName = "";
            if ($toInstHID ne $rootUnitName) { $toName = $toInstHID . "."; }

            print CSLGENFILE "    " . $fromName . $connFromName . ".connect_by_name(" . $toName . $connToName;

            if ($actualName ne "" ) { print CSLGENFILE " ," . $actualName; }

            print CSLGENFILE  ");\n";
            print "------$fromInstHID.$connFromName--------$toInstHID.$connToName\n";
        }
    }

    if (defined $toIfcHash{$unit} ) { # fix this can be an array and needs a for loop
        foreach my $conn ( @{$toIfcHash{$unit}}) {                    
            my $connToName = $conn->[1];
            my $fromInstHID = $conn->[2];
            my $toInstHID = $conn->[3];
#if this is a SS connection, reverse the interface
            if($fromInstHID =~ m/$toInstHID/ || $toInstHID eq $rootUnitName) { 
                print "-----CP connection $fromInstHID to $toInstHID\n"; 
            }
            elsif($toInstHID =~ m/$fromInstHID/ || $fromInstHID eq $rootUnitName) {
                print "-----PC connection $fromInstHID to $toInstHID\n"; 
            }
            else {
                print "-----SS connection $fromInstHID to $toInstHID\n"; 
                print  "revifc connToName       =  $connToName      \n";
                print  CSLGENFILE "    $connToName.reverse(); // this is an endpoint so reverse the interface\n";
            }
        }
    }

    if (defined $toPortHashRev{$unit}) { # fix this can be an array and needs a for loop
        foreach my $ports (@{$toPortHashRev{$unit}}) {
            my $toDir = $ports->[1];
            my $toName =  $ports->[0];
            my $fromInstHID = $ports->[2];
            my $toInstHID = $ports->[3];

            if($fromInstHID =~ m/$toInstHID/ || $toInstHID eq $rootUnitName) { 
                print "-----CP connection $fromInstHID to $toInstHID\n"; 
            }
            elsif($toInstHID =~ m/$fromInstHID/ || $fromInstHID eq $rootUnitName) {
                print "-----PC connection $fromInstHID to $toInstHID\n"; 
            }
            else { #if this is a SS connection, reverse the port
                print "-----SS connection $fromInstHID to $toInstHID\n"; 
                print  CSLGENFILE "    $toName.reverse(); // this is an endpoint so reverse the port\n";
            }
        }
    }
    
    print CSLGENFILE "  }\n";
    print CSLGENFILE "};\n";
}

#............................................................
# get the value in the line in array at position $num
#............................................................

sub getCellValue {
    my ($num, $linein) = @_;

    my $cellValue = $linein->[$num];

    print "getCellValue:: linein = ", @{$linein}," cellValue = $cellValue\n";

    $cellValue =~ s/\"//g;

    return $cellValue;
}

#............................................................
#  get command line options
#............................................................

sub readCmdLineArgs {
    my $invokemessage = "
to invoke :
csl_ifc_csv_gen.pl -f FILENAME -i FILENAME -d FILENAME

  where :
   -h           prints this message
   -f FILENAME  FILENAME of input csv file {required}
   -i FILENAME  FILENAME of input CSL interface library file {required}
   -d FILENAME  FILENAME of design hierarchy file {required}

";

    my $opt_f = "";      # CSL csv input filename
    my $opt_i = "";      # CSL interface library filename
    my $opt_d = "";      # Design hierarchy filename
    my $opt_h = "";      # print help

#print "BEFORE: opt_f = $opt_f\n";
#my $getops = getopts('hf:i:d:');

    my $getops = GetOptions(
        'h'    => \$opt_h, 
        'help' => \$opt_h, 
        'i:s'  => \$opt_i,             
        'd:s'  => \$opt_d,             
        'f:s'  => \$opt_f             
        );

    print "AFTER : opt_f = $opt_f\n";
    if ( (! $getops) or (! $opt_f)  or (! $opt_i) or (! $opt_d)  )  {
        die "$invokemessage";
    }

    $fname = $opt_f;
    $fname =~ s/^(.*)\.csv$/$1/ ; # remove .csv
    $fn = $fname . '.csv';
    $fname =~ s/^.*\\//;

    $cslGenFileName =  $fname . ".csl";  #added by Monica
    $hierFileName = $opt_d;
    $fname .= '.csv';

    print "CSL library filename      = $opt_i       \n";
    print "Design Hierarchy filename = $hierFileName\n";
    print "CSL csv filename          = $fname       \n";
    print "Generated CSL filename    = $cslGenFileName\n";

}


#............................................................
# read the CSL interface library file 
# check that each interface used in the CSV file exists in the library file
#............................................................


sub readCSVFile {
    my $treeInstCnt = scalar(keys %instHash);

    $unitChildrenHash{$rootUnitName} = &traverse($stack[0], 0); #children from root unit

    open (CSVFILE, $fn) or die "$fn : $! \n";

    my @rowLabels; # the names of the units in the left hand row

    my $linein;
    my $cnt = 0;
    my $lineNum = 0;

#............................................................
# fields in the csv file row
#............................................................

    my $csl_type;	
    my $type_decl;	
    my $from_instance_name;	
    my $from_connect_obj_inst_name;	
    my $to_instance_name;	
    my $to_connect_obj_inst_name;	
    my $actual_name;

    $lineNum = 0;

    while (defined($linein = <CSVFILE>)) {
        print "CSV File $lineNum linein = $linein\n";
        $lineNum++;

        if    ($linein =~ m/\"csl_type\"\s*,\s*\"type_decl\"/) { next;} # found the header row
        elsif ($linein =~ m/^\s*\#/                          ) { next;} # found a comment

        chomp $linein;

        if (!($linein =~ m/,/)) { die "ERROR: csv file does not have commas";}

        my @linein = split (/,/, $linein);

        print "$lineNum linein = @linein\n";

        foreach my $t (@linein) {
            print "t = $t\n";
        }

        $csl_type                   = &getCellValue( 0, \@linein);	
        $type_decl                  = &getCellValue( 1, \@linein);	
        $from_instance_name         = &getCellValue( 2, \@linein);	
        $from_connect_obj_inst_name = &getCellValue( 3, \@linein);	
        $to_instance_name           = &getCellValue( 4, \@linein);	
        $to_connect_obj_inst_name   = &getCellValue( 5, \@linein);	
        $actual_name                = &getCellValue( 6, \@linein);
        
        $csl_type                   =~ s/\s+//;	
        $type_decl                  =~ s/\s+//;	
        $from_instance_name         =~ s/\s+//;	
        $from_connect_obj_inst_name =~ s/\s+//;	
        $to_instance_name           =~ s/\s+//;	
        $to_connect_obj_inst_name   =~ s/\s+//;	
        $actual_name                =~ s/\s+//;

        my @fromConnection    ;
        my @toConnection      ;
        my @fromPConnectionRev;
        my @toPConnectionRev  ;
        my @fromPConnection   ;
        my @toPConnection     ;

        my $fromIfcUnitName     = "";
        my $toIfcUnitName       = "";
        my $fromPortUnitNameRev = "";
        my $toPortUnitNameRev   = "";
        my $fromPortUnitName    = "";
        my $toPortUnitName      = "";

        print "csl_type = $csl_type\n";

        if ($csl_type eq "interface") {
            
# connectionList convert the instance name to the unit name so that the interface can be added to the unit
            
            if (defined $instHIDPathHash{$from_instance_name} ) { $fromIfcUnitName = $instHIDPathHash{$from_instance_name}; }
            else { die "ERROR csv file line $lineNum from_instance_name /$from_instance_name/ not defined in instHIDPathHash"; }
            
            if (defined $instHIDPathHash{$to_instance_name} ) { $toIfcUnitName = $instHIDPathHash{$to_instance_name}; }
            else { die "ERROR  csv file line $lineNum to_instance_name /$to_instance_name/ not defined in instHIDPathHash"; }
            
            my $fromInstHID = $instHIDPathHash{$from_instance_name};
            my $toInstHID   = $instHIDPathHash{$to_instance_name};
            
# hid connection is used to create the CSL connect statements in the upper level
            my @hidConnection = ($fromInstHID, $toInstHID, $from_connect_obj_inst_name, $to_connect_obj_inst_name, $actual_name);
            
            push @connectionList,  \@hidConnection;
            
            print "*********found interface***********\n";
            @fromConnection = ($type_decl, $from_connect_obj_inst_name);
            @toConnection   = ($type_decl, $to_connect_obj_inst_name, $fromInstHID, $toInstHID);

        }
        elsif($csl_type eq "port") {
            if (defined $instHIDPathHash{$from_instance_name} ) { $fromPortUnitName = $instHIDPathHash{$from_instance_name}; }
            else { die "ERROR csv file line $lineNum from_instance_name /$from_instance_name/ not defined in instHIDPathHash"; }
            
            if (defined $instHIDPathHash{$to_instance_name} ) { $toPortUnitName = $instHIDPathHash{$to_instance_name}; }
            else { die "ERROR  csv file line $lineNum to_instance_name /$to_instance_name/ not defined in instHIDPathHash"; }
            
            
            my $fromInstHID = $instHIDPathHash{$from_instance_name};
            my $toInstHID   = $instHIDPathHash{$to_instance_name};
            
# hid connection is used to create the CSL connect statements in the upper level
            my @hidConnection = ($fromInstHID, $toInstHID, $from_connect_obj_inst_name, $to_connect_obj_inst_name, $actual_name);
            
            push @connectionList,  \@hidConnection;

            print "**********found port***********\n";
            
            @fromPConnection = ($from_connect_obj_inst_name);
            @toPConnection   = ($to_connect_obj_inst_name);
            print "fin = $from_instance_name tin = $to_instance_name from port = @fromPConnection , to port = @toPConnection\n";
        }
        
# check if the interface has already been added to the from unit ifc list
        my $foundFromConnection = 0;
        my $foundToConnection = 0;

        foreach my $connection ( @{$fromIfcHash{$fromIfcUnitName}}) {                    
            if (($connection->[0] eq $fromConnection[0]) && 
                ($connection->[1] eq $fromConnection[1])) {
                $foundFromConnection = 1;
            }   
        }

        if ($foundFromConnection == 0) { # if the connection does not exist in the unit add it
            push(@{ $fromIfcHash{$fromIfcUnitName}}, \@fromConnection);
            print "FROM     ADDING fun = $fromIfcUnitName fin = $from_instance_name connection = @fromConnection\n";
        }
        else {
            print "FROM NOT ADDING fun = $fromIfcUnitName fin = $from_instance_name connection = @fromConnection\n";
        }

#check if port added to the from unit
        
        my $foundFromPConnectionRev = 0;
        my $foundToPConnectionRev = 0;
        my $foundFromPConnection = 0;
        my $foundToPConnection = 0;
        
# why is this checking the first element of the array???

# FIX    foreach my $connection ( @{$fromPortHashRev{$fromPortUnitNameRev}}) {                    
# FIX        print "connection->[0] = $connection->[0] fromPConnectionRev[0] = $fromPConnectionRev[0]\n";
# FIX        if ($connection->[0] eq $fromPConnectionRev[0]) {
# FIX            $foundFromPConnectionRev = 1;
# FIX        }   
# FIX    }
# FIX    foreach my $connection ( @{$fromPortHash{$fromPortUnitName}}) {                    
# FIX        if ($connection->[0] eq $fromPConnection[0]) {
# FIX            $foundFromPConnection = 1;
# FIX        }   
# FIX    }
        
        if ($foundFromPConnectionRev == 0) { # if the connection does not exist in the unit add it
            push(@{ $fromPortHashRev{$fromPortUnitNameRev}}, \@fromPConnectionRev);
            print "FROM     ADDING fun = $fromPortUnitName fin = $from_instance_name connection = @fromPConnectionRev\n";
        }
        else {
            print "FROM NOT ADDING fun = $fromPortUnitName fin = $from_instance_name connection = @fromPConnectionRev\n";
        }

        if ($foundFromPConnection == 0) { # if the connection does not exist in the unit add it
            push(@{ $fromPortHash{$fromPortUnitName}}, \@fromPConnection);
            print "FROM     ADDING fun = $fromPortUnitName fin = $from_instance_name connection = @fromPConnection\n";
        }
        else {
            print "FROM NOT ADDING fun = $fromPortUnitName fin = $from_instance_name connection = @fromPConnection\n";
        }
        
# check if the interface has already been added to the to unit ifc list
        
        $foundFromConnection = 0;
        $foundToConnection   = 0;
        
        foreach my $connection ( @{$toIfcHash{$toIfcUnitName}}) {                    
            if (($connection->[0] eq $toConnection[0]) && 
                ($connection->[1] eq $toConnection[1])) {
                $foundToConnection = 1;
            }   
        }
        
        if ($foundToConnection == 0) { # if the connection does not exist in the unit add it
            push(@{ $toIfcHash  {$toIfcUnitName  }}, \@toConnection);
            print "TO       ADDING tun = $toIfcUnitName tin = $to_instance_name connection = @toConnection\n";
        }
        else {
            print "TO   NOT ADDING tun = $toIfcUnitName tin = $to_instance_name connection = @toConnection\n";
        }
#check if port added to the to unit
        
        $foundFromPConnectionRev = 0;
        $foundToPConnectionRev   = 0;
        $foundFromPConnection = 0;
        $foundToPConnection   = 0;

# why is this here
# it checks the first element of the array

# FIX    foreach my $connection ( @{$toPortHashRev{$toPortUnitNameRev}}) {                    
# FIX        if ($connection->[0] eq $toPConnectionRev[0]) {
# FIX            $foundToPConnectionRev = 1;
# FIX        }   
# FIX    }
# FIX    foreach my $connection ( @{$toPortHash{$toPortUnitName}}) {                    
# FIX        if ($connection->[0] eq $toPConnection[0]) {
# FIX            $foundToPConnection = 1;
# FIX        }   
# FIX    }

        if ($foundToPConnectionRev == 0) { # if the connection does not exist in the unit add it
            push(@{ $toPortHashRev{$toPortUnitNameRev}}, \@toPConnectionRev);
            print "TO       ADDING tun = $toPortUnitName tin = $to_instance_name connection = @toPConnectionRev\n";
        }
        else {
            print "TO   NOT ADDING tun = $toPortUnitName tin = $to_instance_name connection = @toPConnectionRev\n";
        }
        if ($foundToPConnection == 0) { # if the connection does not exist in the unit add it
            push(@{ $toPortHash{$toPortUnitName}}, \@toPConnection);
            print "TO       ADDING tun = $toPortUnitName tin = $to_instance_name connection = @toPConnection\n";
        }
        else {
            print "TO   NOT ADDING tun = $toPortUnitName tin = $to_instance_name connection = @toPConnection\n";
        }
    }


    close CSVFILE;

}
