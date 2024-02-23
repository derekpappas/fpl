#! /usr/bin/perl -w

# copyright 2008 Fastpath Logic 
# all rights reserved

use Getopt::Long;
use strict;

my $invokemessage = "

     to invoke :
csl_ifc_csv_gen.pl -f FILENAME -i FILENAME -d FILENAME

  where :
   -h           prints this message
   -f FILENAME  FILENAME of input csv file {required}
   -i FILENAME  FILENAME of input CSL interface library file {required}
   -d FILENAME  FILENAME of design hierarchy file {required}

  output data is written to STDOUT
  error and informational messages are written to LOGFILE
    LOGFILE name = DEVNAME.log

";

#  get current time
my $day_time = scalar localtime;

# DATA STRUCTURES

#    %loc_nam{Location}  =  signal Name
my %loc_nam  = ();  # Location/PinName hash

# CONSTANTS
my $NoConnect = "z_nc";  #  Pin No Connect signal name

#   hash of column name keys
#   with column number values
my %colnam = ();

#      get command line options

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

my $fname     = $opt_f;
$fname =~ s/^(.*)\.csv$/$1/ ; # remove .csv
my $fn    = $fname . '.csv';
$fname =~ s/^.*\\//;
#$lgn   = "$fname\.log";

my $genDirName = "generated"; 
mkdir ($genDirName);
my $cslGenFileName = $genDirName . "/" . $fname . ".csl";
$fname .= '.csv';

my $lgn   = "$fname\.log";

my $hierFileName = $opt_d;

print "CSL library filename      = $opt_i       \n";
print "Design Hierarchy filename = $hierFileName\n";
print "CSL csv filename          = $fname       \n";
print "Generated CSL filename    = $cslGenFileName\n";

################################################################################
use Data::Dumper;

my @stack;
my %treeHash; # hierarchy tree
my %unitHash; # list of units
my %instHash; # list of instances
my %instHIDPathHash; # list of instance/numeric HID mappings
my @hidPathStack; # current HID numeric path
my @parentUnitList; #list of units that are parents

#my @numericPathStack; # current HID  path
#my %instNUmericIdHash; # list of instance/numeric id mappings

my $rootUnitName = "";
my $rootInstName = "";

push @stack, \%treeHash; # initialize the stack

print Dumper(\%treeHash);


&readHierFile($hierFileName, 0);

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

my %unitChildrenHash;

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


################################################################################
# read the CSL interface library file 
# check that each interface used in the CSV file exists in the library file
################################################################################

# FIX 



################################################################################
#
################################################################################

my $treeInstCnt = scalar(keys %instHash);

#children from root unit
$unitChildrenHash{$rootUnitName} = &traverse($stack[0], 0);

################################################################################


# my @childList;
# foreach my $unit (keys %unitHash) {
#     print "XXX unit: $unit [";
#     @childList = @{$unitChildrenHash{$unit}};
#     print " unitChildrenHash{$unit}  = $unitChildrenHash{$unit} ";
#     print " unitChildrenHash{$unit}  = ", @{$unitChildrenHash{$unit}};
# 
# 
#     foreach my $inst (@childList) {
#         print "$inst ";
#     }
#     print "]\n";
# }


#  open CSV file
open (CSVFILE, $fn) or die "$fn : $! \n";

open (CSLGENFILE, "> $cslGenFileName") or die "$cslGenFileName : $! \n";

open (LOGFILE, ">$lgn") or die "$lgn : $! \n";

print LOGFILE "Input file = $fn\n\n";
#print LOGFILE "Start Time = $day_time\n";
# rm 
# rm my $csv_row;
# rm 
# rm #  READ FIRST LINE OF CSV FILE AND GET COLUMN LABELS
# rm unless (defined($csv_row = <CSVFILE>)) {
# rm 	die "input file<$fn> is empty!\n\n";
# rm }
# rm chomp $csv_row;
# rm my @column_row = split /,/, $csv_row;
# rm 
# rm # / comment to fix major mode formatting/color coding in emacs
# rm shift @column_row;
# rm 
# rm my $nl            = scalar(@column_row); # number of lables
# rm my $err = 0;
# rm 
# rm #print "****************col label count = ", scalar(@column_row), "\n";
# rm #print "Labels ";
# rm 
# rm for (my $i=0;$i<$nl;$i++) {
# rm     my $label = $column_row[$i];
# rm     $column_row[$i] =~ s/\"//g;
# rm 
# rm     print "$i label = $label\n";
# rm     if (defined(${$colnam{$label}})) { # label name previously found?
# rm         print LOGFILE "column label <$label> previously defined\n";
# rm         $err = 1;
# rm     }
# rm     else { 
# rm         ${$colnam{$label}} = $i;
# rm         print "$label :: ";
# rm     }
# rm }
# rm 
# rm print "\n";


my @rowLabels; # the names of the units in the left hand row

my %fromIfcHash;
my %toIfcHash;
my %unitIfcHash;

my %fromPortHashRev;
my %toPortHashRev;
my %fromPortHash;
my %toPortHash;

my $linein;
my $cnt = 0;

my @connectionList;

my $lineNum = 0;

################################################################################
# fields in the csv file row
################################################################################

my $csl_type;	
my $type_decl;	
my $from_instance_name;	
my $from_connect_obj_inst_name;	
my $from_width;	
my $from_direction;	
my $to_instance_name;	
my $to_connect_obj_inst_name;	
my $to_width;	
my $to_direction;	
my $actual_name;


READLINE: while (defined($linein = <CSVFILE>)) {
    if (0 == $lineNum){
        $lineNum++;
        next;
    }

    $lineNum++;

    chomp $linein;

    #print "$lineNum linein = $linein\n";

    if (!($linein =~ m/,/)) { die "ERROR: csv file does not have commas";}

    my @linein = split (/,/, $linein);

    print "$lineNum linein = @linein\n";

    foreach my $t (@linein) {
        print "t = $t\n";
    }

    $csl_type                   = &getCellValue(  0, \@linein);	
    $type_decl                  = &getCellValue(  1, \@linein);	
    $from_instance_name         = &getCellValue(  2, \@linein);	
    $from_connect_obj_inst_name = &getCellValue(  3, \@linein);	
    $from_width                 = &getCellValue(  4, \@linein);	
    $from_direction             = &getCellValue(  5, \@linein);	
    $to_instance_name           = &getCellValue(  6, \@linein);	
    $to_connect_obj_inst_name   = &getCellValue(  7, \@linein);	
    $to_width                   = &getCellValue(  8, \@linein);	
    $to_direction               = &getCellValue(  9, \@linein);	
    $actual_name                = &getCellValue( 10, \@linein);
    
    $csl_type                   =~ s/\s+//;;	
    $type_decl                  =~ s/\s+//;;	
    $from_instance_name         =~ s/\s+//;;	
    $from_connect_obj_inst_name =~ s/\s+//;;	
    $from_width                 =~ s/\s+//;;	
    $from_direction             =~ s/\s+//;;	
    $to_instance_name           =~ s/\s+//;;	
    $to_connect_obj_inst_name   =~ s/\s+//;;	
    $to_width                   =~ s/\s+//;;	
    $to_direction               =~ s/\s+//;;	
    $actual_name                =~ s/\s+//;;
    
   
    my @fromConnection;
    my @toConnection;
    my @fromPConnectionRev;
    my @toPConnectionRev;
    my @fromPConnection;
    my @toPConnection;

    my $fromIfcUnitName = "";
    my $toIfcUnitName = "";
    my $fromPortUnitNameRev = "";
    my $toPortUnitNameRev = "";
    my $fromPortUnitName = "";
    my $toPortUnitName = "";

    if ($csl_type eq "interface") {
	
# connectionList convert the instance name to the unit name so that the interface can be added to the unit
	
	if (defined $instHash{$from_instance_name} ) { $fromIfcUnitName = $instHash{$from_instance_name}; }
	else { die "ERROR csv file line $lineNum from_instance_name /$from_instance_name/ not defined in instHash"; }
	
	
	if (defined $instHash{$to_instance_name} ) { $toIfcUnitName = $instHash{$to_instance_name}; }
	else { die "ERROR  csv file line $lineNum to_instance_name /$to_instance_name/ not defined in instHash"; }
	

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
	
	if($from_direction eq $to_direction) {
# connectionList convert the instance name to the unit name so that the interface can be added to the unit
	    if (defined $instHash{$from_instance_name} ) { $fromPortUnitNameRev = $instHash{$from_instance_name}; }
	    else { die "ERROR csv file line $lineNum from_instance_name /$from_instance_name/ not defined in instHash"; }
	    
	    if (defined $instHash{$to_instance_name} ) { $toPortUnitNameRev = $instHash{$to_instance_name}; }
	    else { die "ERROR  csv file line $lineNum to_instance_name /$to_instance_name/ not defined in instHash"; }
	    
	    
	    my $fromInstHID = $instHIDPathHash{$from_instance_name};
	    my $toInstHID   = $instHIDPathHash{$to_instance_name};
	    
# hid connection is used to create the CSL connect statements in the upper level
	    my @hidConnection = ($fromInstHID, $toInstHID, $from_connect_obj_inst_name, $to_connect_obj_inst_name, $actual_name);
	    
	    push @connectionList,  \@hidConnection;

	    print "**********found port***********\n";

	    @fromPConnectionRev = ($from_connect_obj_inst_name,$from_direction);
	    @toPConnectionRev   = ($to_connect_obj_inst_name,$to_direction, $fromInstHID, $toInstHID);
	    print "fin = $from_instance_name tin = $to_instance_name from port = @fromPConnectionRev , to port = @toPConnectionRev\n";
	}
	   else {

# connectionList convert the instance name to the unit name so that the interface can be added to the unit
	       if (defined $instHash{$from_instance_name} ) { $fromPortUnitName = $instHash{$from_instance_name}; }
	       else { die "ERROR csv file line $lineNum from_instance_name /$from_instance_name/ not defined in instHash"; }
	       
	       if (defined $instHash{$to_instance_name} ) { $toPortUnitName = $instHash{$to_instance_name}; }
	       else { die "ERROR  csv file line $lineNum to_instance_name /$to_instance_name/ not defined in instHash"; }
	       
	       
	       my $fromInstHID = $instHIDPathHash{$from_instance_name};
	       my $toInstHID   = $instHIDPathHash{$to_instance_name};
	       
# hid connection is used to create the CSL connect statements in the upper level
	       my @hidConnection = ($fromInstHID, $toInstHID, $from_connect_obj_inst_name, $to_connect_obj_inst_name, $actual_name);
	       
	       push @connectionList,  \@hidConnection;

	       print "**********found port***********\n";
	       
	       @fromPConnection = ($from_connect_obj_inst_name,$from_direction);
	       @toPConnection   = ($to_connect_obj_inst_name,$to_direction);
	       print "fin = $from_instance_name tin = $to_instance_name from port = @fromPConnection , to port = @toPConnection\n";
	   }
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
    
    foreach my $connection ( @{$fromPortHashRev{$fromPortUnitNameRev}}) {                    
	if ($connection->[0] eq $fromPConnectionRev[0]) {
            $foundFromPConnectionRev = 1;
        }   
    }
    foreach my $connection ( @{$fromPortHash{$fromPortUnitName}}) {                    
	if ($connection->[0] eq $fromPConnection[0]) {
            $foundFromPConnection = 1;
        }   
    }
    
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

    foreach my $connection ( @{$toPortHashRev{$toPortUnitNameRev}}) {                    
        if ($connection->[0] eq $toPConnectionRev[0]) {
            $foundToPConnectionRev = 1;
        }   
    }
    foreach my $connection ( @{$toPortHash{$toPortUnitName}}) {                    
        if ($connection->[0] eq $toPConnection[0]) {
            $foundToPConnection = 1;
        }   
    }

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

################################################################################
# check that the following are the same: 
# -the list of units from the tree, 
# -the list of units from the top column 
# -the list of units from the left row
################################################################################

# rm \if ($#rowLabels  != $#column_row) { die "ERROR row label count not equal to the column label count $#rowLabels  != $#column_row\n"; }
# rm \else {print "CHECK row label count equal to the column label count $#rowLabels  == $#column_row\n"; }
# rm \
# rm \if ($#rowLabels + 1  != $treeInstCnt   ) { die "ERROR row label count not equal to the tree inst count    $#rowLabels  != $treeInstCnt   \n"; }
# rm \else {print "CHECK row label count equal to the tree inst count    $#rowLabels  == $treeInstCnt   \n";}
# rm \
# rm \if ($treeInstCnt != $#column_row + 1 ) { die "ERROR tree inst count not equal to the column label count $treeInstCnt != $#column_row\n"; }
# rm \else { print "CHECK tree inst count equal to the column label count $treeInstCnt == $#column_row\n";}

################################################################################
# Generate the CSL code
################################################################################

print CSLGENFILE "// Generated by $0 \n";
print CSLGENFILE "// CSL library filename      = $opt_i       \n";
print CSLGENFILE "// Design Hierarchy filename = $hierFileName\n";
print CSLGENFILE "// CSL csv filename          = $fname       \n";
print CSLGENFILE "// Generated CSL filename    = $cslGenFileName\n";
print CSLGENFILE "\n\n";
print CSLGENFILE "// predeclare the units\n";

print CSLGENFILE " ;\n";

foreach my $k (keys %unitHash) {
    print CSLGENFILE "csl_unit $k;\n";
}

&printCSL();

###############

$day_time = scalar localtime;
#print LOGFILE "End Time = $day_time\n";

my $csl_csv_gen_end_banner = "

## End CSL_CSV_GENGEN AutoGenerated Stuff

";
print STDOUT $csl_csv_gen_end_banner;

#print LOGFILE "<$dlines> lines with Device [$dname]\n";

close CSVFILE;
#close OUTFILE;
close LOGFILE;

################################################################################
#
################################################################################

sub readHierFile {
    my ($hierFileName, $depth) = @_;

    if (! -e $hierFileName) {
        return;
    }
    else {

        print "Opening hier file : $hierFileName\n";
    }

    my $HIERFILE;

#  open design hierarchy file
    open ($HIERFILE, $hierFileName) or die "----$hierFileName : $! \n";

    my $unitName = "";
    my $instName = "";
    my @parents;

    my $instCnt = 0;
    while(<$HIERFILE>){
        chomp;
        s/(\s*)//;
	my $unitNinstN = $_;
        print "HIER $instCnt hier line = $_\n";
        if ($rootUnitName eq "") {
	    m/([^\{]+)\{\s*([^\}]+)/; 
	    $rootUnitName = $1;
            $rootInstName = $2;
            push @hidPathStack, $rootUnitName;
            $unitName = $1;
            $instName = $2;
	    $unitName =~ s/\s+//;
            $instName =~ s/\s+//;                                                                                                     
            push @hidPathStack, $instName; # add the current line element to the children at hidPathStack[hidPathStack.depth] and add the hidPathStack element to the hidPathStack
            $instHIDPathHash{$instName} = $instName;# create the map of instNames to HID paths
            
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
		$instHIDPathHash{$instName} = $hidPath;# create the map of instNames to HID paths
		    
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
		$instHIDPathHash{$instName} = $hidPath;# create the map of instNames to HID paths
		    
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
}



# a pre-order traversal. First we do something ...
# ... and then we recurse the children
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
#        print "ZZZ unitChildrenHash{$unitName}  = $unitChildrenHash{$unitName} \n";
#        print "ZZZ unitChildrenHash{$unitName}  = ", @{$unitChildrenHash{$unitName}}," \n";
    }

    print "children = @children\n"; 
 
    return \@children;
}


# the bug int he code below is that the first time that an instance of a unit is found the unit is 
# created. If another instance of the unit is found then the unit is not being updated. The interfaces
# are not being added the second time that an instance of the unit is found

sub printCSL {
    my %doneUnits;
    my $unit;

    foreach my $inst (keys %instHash) {
        if (defined $instHash{$inst}) {
            $unit = $instHash{$inst};
        }
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

#     if (defined $fromIfcHash{$unit} ) {
#        print  "fin if defined fromIfcHash $unit\n";
#        foreach my $connection ( @{$fromIfcHash{$unit}}) {                    
#            my $connFromName  = $connection->[1];
#            my $prefix = $connection->[3];
#            print CSLGENFILE  "    $connFromName.set_prefix(\"" . $prefix . "\");\n";
#        }
#    }
#
#    if (defined $toIfcHash{$unit} ) {
#        print  "fin if defined toIfcHash $unit\n";
#        foreach my $connection ( @{$toIfcHash{$unit}}) {                    
#            my $connToName = $connection->[2];
#            my $prefix     = $connection->[3];
#            print CSLGENFILE  "    $connToName.set_prefix(\"" . $prefix . "\");\n";
#         }
#    }


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
            if ($fromInstHID ne $rootUnitName) {
                $fromName = $fromInstHID . "."
            }

            $toName = "";
            if ($toInstHID ne $rootUnitName) {
                $toName = $toInstHID . "."
            }

            print CSLGENFILE "    " . $fromName . $connFromName . ".connect_by_name(" . $toName . $connToName;
            if ($actualName ne "" ) {
                print CSLGENFILE " ," . $actualName;
            }
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
#if this is a SS connection, reverse the port
	    if($fromInstHID =~ m/$toInstHID/ || $toInstHID eq $rootUnitName) { 
		print "-----CP connection $fromInstHID to $toInstHID\n"; 
	    }
	    elsif($toInstHID =~ m/$fromInstHID/ || $fromInstHID eq $rootUnitName) {
		print "-----PC connection $fromInstHID to $toInstHID\n"; 
	    }
	    else {
		print "-----SS connection $fromInstHID to $toInstHID\n"; 
		print  CSLGENFILE "    $toName.reverse(); // this is an endpoint so reverse the port\n";
	    }
	}
    }
    
    print CSLGENFILE "  }\n";
    print CSLGENFILE "};\n";
}

################################################################################
#  get the value in the line in array at position $num
################################################################################

sub getCellValue {
    my ($num, $linein) = @_;

#    print "getCellValue:: num = $num\n";
#    print "getCellValue:: linein = ", @{$linein},"\n";
    print "getCellValue:: linein[$num] = ", $linein->[$num],"\n";

    my $cellValue = $linein->[$num];

#    print "getCellValue:: cellValue = $cellValue\n";

    $cellValue =~ s/\"//g;

    return $cellValue;
}


