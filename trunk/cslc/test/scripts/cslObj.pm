package cslObj;

# Author: cghaba
# Date: May 2, 2008

# Set debug variable

my $debug=0;

#+----------------------------------------------------------------------------------+
#|Create interface                                                                  |
#|                                                                                  |
#|Creates an interface based on the lists of input ports, output ports, interfaces  |
#+   $fileHandle        file handle                                                 |
#|   $ifc_name,         interface name                                              |
#|   $ifci_list,        list of interface instance list (for hierarchical interface)|
#|   $inport_list,      list of input ports                                         |
#|   $inport_br_list,   list of input port bitranges                                |
#|   $outport_list,     list of output ports                                        |
#|   $outport_br_list   list of output port bitranges                               |
#|   $i_body            list of command in interface body (ex. reverse statement)   |         
#|                                                                                  |
#+----------------------------------------------------------------------------------+

sub createInterface{
    my ($fileHandle,$ifc_name, $ifci_list, $inport_list, $inport_br_list, $outport_list, $outport_br_list, $i_body)=@_;
        print $fileHandle "csl_interface $ifc_name {\n";
    my $ifcsize=@{$ifci_list};
       for (my $idx=0; $idx<$ifcsize; $idx++) {
        print $fileHandle "@{$ifci_list}[$idx] ${$ifci_list}[$idx]$idx;\n";
     }
#    &printdbg("input port list @{$tmp_in_list} \n");
    my $ipsize=@{$inport_list};
    &printdbg("Nr. input port : $ipsize \n");
    for (my $idx=0; $idx<$ipsize; $idx++){
        print $fileHandle "csl_port @{$inport_list}[$idx] (input, @{$inport_br_list}[$idx] );\n";
    }
#    &printdbg("output port list @{$tmp_out_list} \n");
    my $opsize=@{$outport_list};
    &printdbg("Nr. input port : $opsize \n");
    for (my $idx=0; $idx<$opsize; $idx++){
        print $fileHandle "csl_port @{$outport_list}[$idx] (output,@{$outport_br_list}[$idx] );\n";
    }
    print $fileHandle "$ifc_name (){ \n @{$i_body} \n } \n }; \n";
}



#+----------------------------------------------------------------------------------+
#|Create interface with names for interface instances                               |
#|                                                                                  |
#|For the case we want to give specific names for the interface instances           |
#|                                                                                  |
#|Creates an interface based on the lists of input ports, output ports, interfaces  |
#+   $fileHandle        file handle                                                 |
#|   $ifc_name,         interface name                                              |
#|   $ifci_list,        list of interface instance list (for hierarchical interface)|
#|   $ifci_name_list,   list of interface instance names list                       |
#|   $inport_list,      list of input ports                                         |
#|   $inport_br_list,   list of input port bitranges                                |
#|   $outport_list,     list of output ports                                        |
#|   $outport_br_list   list of output port bitranges                               |
#|   $i_body            list of command in interface body (ex. reverse statement)   |         
#|                                                                                  |
#+----------------------------------------------------------------------------------+

sub createInterfaceWithNames{
    my ($fileHandle,$ifc_name, $ifci_list, $ifci_name_list,$inport_list, $inport_br_list, $outport_list, $outport_br_list, $i_body)=@_;
        print $fileHandle "csl_interface $ifc_name {\n";
    my $ifcsize=@{$ifci_list};
       for (my $idx=0; $idx<$ifcsize; $idx++) {
           if (${$ifci_name_list}[$idx] eq "")
           {
               print $fileHandle "@{$ifci_list}[$idx] @{$ifci_list}[$idx]$idx;\n";
           }
           else
           {
               print $fileHandle "@{$ifci_list}[$idx] @{$ifci_name_list}[$idx];\n";
           }
       }
#    &printdbg("input port list @{$tmp_in_list} \n");
    my $ipsize=@{$inport_list};
    &printdbg("Nr. input port : $ipsize \n");
    for (my $idx=0; $idx<$ipsize; $idx++){
        print $fileHandle "csl_port @{$inport_list}[$idx] (input, @{$inport_br_list}[$idx] );\n";
    }
#    &printdbg("output port list @{$tmp_out_list} \n");
    my $opsize=@{$outport_list};
    &printdbg("Nr. input port : $opsize \n");
    for (my $idx=0; $idx<$opsize; $idx++){
        print $fileHandle "csl_port @{$outport_list}[$idx] (output,@{$outport_br_list}[$idx] );\n";
    }
    print $fileHandle "$ifc_name (){ \n @{$i_body} \n } \n }; \n";
}



# +-------------------------------------------------------------------------------------+
# |Create unit                                                                          |
# |                                                                                     |
# |Creates a unit based on the lists of input ports, output ports, interfaces, signals  |
# |and units                                                                            |
# |fileHandle          file handle                                                      |
# |unit_name           unit name                                                        |
# |port_in_list        list of input ports                                              |
# |port_in_br_list     list of input port bitranges                                     |
# |port_out_list       list of output ports                                             |
# |port_out_br_list    list of output port bitranges                                    |
# |ifc_list            list of interface instances                                      |
# |sig_list            list of signals                                                  |
# |sig_br_list         list of signal bitranges                                         |
# |u_list              list of unit instances                                           |
# |u_body              list of commands in the unit body (ex. connect, set_attribute,..)|
# |                                                                                     |
# +-------------------------------------------------------------------------------------+

sub createUnit{
    my ($fileHandle,$unit_name,$port_in_list,$port_in_br_list,$port_out_list,$port_out_br_list,$ifc_list,$sig_list,$sig_br_list,$u_list,$u_body)=@_;

# unit declaration
    print $fileHandle "csl_unit $unit_name { \n";
#ports
#input ports
    my $pi_nmb=@{$port_in_list};
    for (my $i=0; $i<$pi_nmb; $i++){
	print $fileHandle "csl_port @{$port_in_list}[$i](input,@{$port_in_br_list}[$i]);\n";
    }
#output ports
    my $po_nmb=@{$port_out_list};
    for (my $i=0; $i<$po_nmb; $i++){
	print $fileHandle "csl_port @{$port_out_list}[$i](output,@{$port_out_br_list}[$i]);\n";
    }
#interface instances
    my $if_nmb=@{$ifc_list};
    my $ifcinmb=0;
	for (my $i=0; $i<$if_nmb; $i++){
	    print $fileHandle "@{$ifc_list}[$i] ifci$ifcinmb;\n";
	    $ifcinmb++;
	}
#signals
#    print "sig_list @sig_list \n";
#    print "sig_br_list @sig_br_list \n";
    my $s_nmb=@{$sig_list};
    for (my $i=0; $i<$s_nmb; $i++){
	print $fileHandle "csl_signal @{$sig_list}[$i](".@{$sig_br_list}[$i].");\n";
    }
#unit instances
    my $u_nmb=@{$u_list};
    my $uinmb=0;
    for (my $i=0; $i<$u_nmb; $i++){
	print $fileHandle "@{$u_list}[$i] ui$uinmb;\n";
    $uinmb++;
    }
#unit body
    print $fileHandle "$unit_name (){\n";
    print $fileHandle @{$u_body};
    print $fileHandle "} \n }; \n"; 
}

# +-------------------------------------------------------------------------------------+
# |Create unit with names for interface and unit instances                              |
# |                                                                                     |
# |Creates a unit based on the lists of input ports, output ports, interfaces, signals  |
# |and units                                                                            |
# |fileHandle          file handle                                                      |
# |unit_name           unit name                                                        |
# |port_in_list        list of input ports                                              |
# |port_in_br_list     list of input port bitranges                                     |
# |port_out_list       list of output ports                                             |
# |port_out_br_list    list of output port bitranges                                    |
# |ifc_list            list of interface instances                                      |
# |ifc_name_list       list of interface instance names                                 |
# |sig_list            list of signals                                                  |
# |sig_br_list         list of signal bitranges                                         |
# |u_list              list of unit instances                                           |
# |u_name_list         list of unit instance names                                      |
# |u_body              list of commands in the unit body (ex. connect, set_attribute,..)|
# |                                                                                     |
# +-------------------------------------------------------------------------------------+

sub createUnitWithNames{
    my ($fileHandle,$unit_name,$port_in_list,$port_in_br_list,$port_out_list,$port_out_br_list,$ifc_list,$ifc_name_list,$sig_list,$sig_br_list,$u_list,$u_name_list,$u_body)=@_;

# unit declaration
    print $fileHandle "csl_unit $unit_name { \n";
#ports
#input ports
    my $pi_nmb=@{$port_in_list};
    for (my $i=0; $i<$pi_nmb; $i++){
	print $fileHandle "csl_port @{$port_in_list}[$i](input,@{$port_in_br_list}[$i]);\n";
    }
#output ports
    my $po_nmb=@{$port_out_list};
    for (my $i=0; $i<$po_nmb; $i++){
	print $fileHandle "csl_port @{$port_out_list}[$i](output,@{$port_out_br_list}[$i]);\n";
    }
#interface instances
    my $if_nmb=@{$ifc_list};
    my $ifcinmb=0;
	for (my $i=0; $i<$if_nmb; $i++){
        if (${$ifc_name_list}[$i] eq "")
        {
            print $fileHandle "${$ifc_list}[$i] ifci$ifcinmb;\n";
        }
        else
{
    print $fileHandle "${$ifc_list}[$i] ${$ifc_name_list}[$i];\n";            
}   
	    $ifcinmb++;
	}
#signals
#    print "sig_list @sig_list \n";
#    print "sig_br_list @sig_br_list \n";
    my $s_nmb=@{$sig_list};
    for (my $i=0; $i<$s_nmb; $i++){
	print $fileHandle "csl_signal @{$sig_list}[$i](".@{$sig_br_list}[$i].");\n";
    }
#unit instances
my $u_nmb=@{$u_list};
my $uinmb=0;
for (my $i=0; $i<$u_nmb; $i++){
    if (${$u_name_list}[$i] eq "")
{   
	print $fileHandle "@{$u_list}[$i] ui$uinmb;\n";
}
        else
{
	print $fileHandle "@{$u_list}[$i] @{$u_name_list}[$i];\n";
}
$uinmb++;
}
#unit body
print $fileHandle "$unit_name (){\n";
print $fileHandle @{$u_body};
print $fileHandle "} \n }; \n"; 
}



#+--------------------------------------------------------------------------------------+
#|Random generate unit                                                                  |
#|                                                                                      |
#|Receives an n-tuple of integers and lists of ports,interfaces,signals and units       |
#|The integers represent nmb of input ports, output ports, interfaces,signals, units to |
#|be randomly extracted from the each corresponding list                                |
#+--------------------------------------------------------------------------------------+

sub createUnitsNtuple{
    my ($fileHandle,$ntuple,$port_in_list,$port_in_br_list,$port_out_list,$port_out_br_list,$ifc_list,$sig_list,$sig_br_list,$u_list)=@_;
    my $nlist=@{$ntuple};
    &printdbg("tuple size: $nlist \n");
    # make copies of lists because elements will be deleted
    my @tmppin=@{$port_in_list};
    my @tmppbrin=@{$port_in_br_list};
    my @tmppo=@{$port_out_list};
    my @tmppbro=@{$port_out_br_list};
    my @tmpsig=@{$sig_list};
    my @tmpsigbr=@{$sig_br_list};
    
    # create the lists with random objects from the lists to be used in the createUnit call
# create empty lists
    my @ppin=();
    my @pbrin=();
    my @ppo=();
    my @pbro=();
    my @pifc=();
    my @psig=();
    my @pbrsig=();
    my @pu=();
#    my $isduplicatename=1;  # to be sure units will have unique names

#    while ($isduplicatename) {
        my $unitnameindex=int(rand(10000))+1;          # create a random name for the generated unit
        my $unitname="uk".$unitnameindex;
#            print " unit name: $unitname ---- @{$u_list} \n";
#        my $y=&isInList($unitname,\@{$u_list});
#    print " Is $y \n";
#        if (&isInList($unitname,\@{$u_list})==0)
#        if ($y==0)
#{
#    print "is not duplicate $isduplicatename \n";
#    $isduplicatename=0;
#}           
#    }

    &printdbg("Nmb. of inputs @{$ntuple}[0] \n");
    &printdbg("tmpin: @tmppin \n");
    my $npin=@tmppin;                                # get input port list size
    for (my $i=0; $i<@{$ntuple}[0];$i++){            # select randomly $ntuple[0] input ports from the input port list 
        &printdbg("npin: $npin \n");
        my $ridx=int(rand($npin));                   # generates random index to select a port from the input port list
        &printdbg("ridx $ridx \n");
        push(@ppin,$tmppin[$ridx]);                  # add port to the random generated input port list
        &printdbg ("tmppin before delete @tmppin \n");
                                                     # the pushed port must be eliminated so no ports with same name will be generated
        delete $tmppin[$ridx];                       # after deleting element, list must be reindexed
        @tmppin=split(" ",(join(" ",@tmppin)));      # re-indexing the list
        &printdbg("tmppin after delete @tmppin \n");
        push(@pbrin,$tmppbrin[$ridx]);               # add the bitrange for the added input port to the input port bitrange list
        delete $tmppbrin[$ridx];                     # delete the added port so no duplicate ports should appear in csl code
        @tmppbrin=split(" ",(join(" ",@tmppbrin)));  # reindex remaining list of input ports
        $npin--;                                     # list size has decreased by one so decrease rand seed
   }
    &printdbg("ppin: @ppin \n");
    &printdbg("pbrin: @pbrin \n");    

    &printdbg("Nmb. of outputs @{$ntuple}[2] \n");
    &printdbg("port_out_list: @{$port_out_list} \n");
    &printdbg("port_out_br_list: @{$port_out_br_list} \n");
        my $npo=@tmppo;     
    for (my $i=0; $i<@{$ntuple}[2];$i++){
       &printdbg("npo: $npo \n");
        my $rodx=int(rand($npo));
        &printdbg("rodx $rodx \n");
        push(@ppo,$tmppo[$rodx]);
        &printdbg ("tmppo before delete @tmppo \n");
        delete $tmppo[$rodx];
        &printdbg ("tmppo after delete @tmppo \n");
        @tmppo=split(" ",(join(" ",@tmppo)));
        push(@pbro,$tmppbro[$rodx]);
        &printdbg ("tmppbro before delete @tmppbro \n");
        delete $tmppbro[$rodx];
        &printdbg ("tmppbro after delete @tmppbro \n");
        @tmppbro=split(" ",(join(" ",@tmppbro)));
        $npo--;                                   
    }
    
    &printdbg("ppo: @ppo \n");
    &printdbg("pbro: @pbro \n");
    

    &printdbg("Nmb. of interfaces @{$ntuple}[4] \n");
    &printdbg("ifc_list: @{$ifc_list} \n");

    for (my $i=0; $i<@{$ntuple}[4];$i++){
        push(@pifc,@{$ifc_list}[int(rand(@{$ifc_list}))]);
    }
    
    &printdbg("pifc: @pifc \n");
    
    my $nsig=@tmpsig;
    for (my $i=0; $i<@{$ntuple}[5];$i++){
        my $rsdx=int(rand($nsig));
        push(@psig,$tmpsig[$rsdx]);
        delete $tmpsig[$rsdx];
        @tmpsig=split(" ",(join(" ",@tmpsig)));
        push(@pbrsig,$tmpsigbr[$rsdx]);
        delete $tmpsigbr[$rsdx];
        @tmpsigbr=split(" ",(join(" ",@tmpsigbr)));
        $nsig--;
    }
    
    &printdbg("psig: @psig \n");
    &printdbg("pbrsig: @pbrsig \n");
    
    for (my $i=0; $i<@{$ntuple}[7];$i++){
        push(@pu,@{$u_list}[int(rand(@{$u_list}))]);
    }
    
    &printdbg("pu: @pu \n");
    &printdbg("Create unit name with ntuple @{$ntuple} \n");
    
    &createUnit($fileHandle,$unitname,\@ppin, \@pbrin, \@ppo, \@pbro, \@pifc, \@psig, \@pbrsig, \@pu);
    &printdbg("End created unit with ntuple @{$ntuple} \n");
    
    return $unitname;  # returns unit name 
}    

#+-------------------------------------------------------------------+
#|Random n-tuple generator                                           |
#|                                                                   |
#|Receives as parameter an n-tuple of maximum values max_0,..,max_n  |
#|Returns an n-tuple of numbers i_0,...,i_n with  1<=i_j<max_j       |
#+-------------------------------------------------------------------+

sub randNtuple{
    my (@max_values)=@_;
    my @rc=();
    my $rd;
    my $imax=@max_values;

    for (my $i=0; $i<$imax; $i++){
    &printdbg("imax is: $imax @max_values[$i]\n");
        $rd=int(rand(@max_values[$i])+1);    
        push(@rc,$rd);
    }
    &printdbg("rc is: @rc \n");
    return @rc;
}


# +---------------------------------------+
# |Print a message only if in debug mode  |
# +---------------------------------------+

sub printdbg{
    my ($debugmsg)=@_;
    if ($debug){
        print "$debugmsg";
    }
}

#+---------------------------------------+
#|Print date                             |
#+---------------------------------------+

sub getTimeandDate {
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
$year = 1900 + $yearOffset;
$theTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";
return $theTime;
}


#+-------------------------------------+
#|Test if a directory exists           |
#+-------------------------------------+

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
}


#+--------------------------------------+
#|Make a directory                      |
#+--------------------------------------+

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

#
# Tests that an element is in list
#

sub isInList {
    my($Element,$List) =@_;

    my $result=0;
    my $ListSize=@{$List};
    for (my $i=0; $i<$ListSize; $i++) {
       # print "i= $i  element= $Element List element= ${$List}[$i] \n";
        if (@{$List}[$i] eq $Element)
        {
            $result=1;
        }
    }
    return $result;
}

1;
