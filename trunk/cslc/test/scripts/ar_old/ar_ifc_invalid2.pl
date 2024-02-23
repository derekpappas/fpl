#!/usr/bin/perl

#oanab
#connecting an interface with ifc.p,ifc.ifc.p,ifc.ifc.p.ps,sg.sig,sg.sig.ps,sg.sg.sig,sg.sg.sig.ps
#connecting an ifc.ifc with ifc.p,ifc.ifc.p,ifc.ifc.p.ps,sg.sig,sg.sig.ps,sg.sg.sig,sg.sg.sig.ps
use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

my $totDir     = $ENV{WORK};
&testDirExists($totDir);

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
    
}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

foreach(my $i = 1; $i <= 400; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my $j = $_[1];
    my $m = $_[2];
    my $n = $_[3];
    $j = int(rand(20))+1; # for ifc1
    $m = int(rand(20))+2; # for ifc2
    $n = int(rand(20))+3; # for ifc3
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "ar_ifc".$i."_illegal.csl";
    if($j != $m && $j != $n && $m != $n) {
	&createCslFile($test_name, $i, $j, $m, $n, %dir);
    }
    else {
	&createCslFile($test_name, $i, $j+1, $m+2, $n+3, %dir);
    }
}
sub createCslFile {
    my ($test_name, $i, $j, $m, $n, %dir) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
    my $k = int(rand(20)) + int(rand(20));
    my $zero = 0;
    my $one = 1;
    my $two = 2;
    my $tre = 3;
    my $val1 = int(rand(100))+1;
    my $val2 = int(rand(100))+1;
    my $val3 = int(rand(100))+6;
    my $l = int(rand(3))+1;
    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_ifc_valid");
        open(FH,">$path/ar_ifc_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ar_ifc_invalid2"); 
        open(FH,">$path/ar_ifc_invalid2/$test_name");
    }
    print FH "//Generated by oanab\n\n";
    
#declaring bitrange br1   
    if($val1 >= 7) { 
	print FH "csl_bitrange br1($val1);\n\n";
    }
    else {
	$val1 = $val1 + 7;
	print FH "csl_bitrange br1($val1);\n\n";
    }
	
#declaring bitrange br2
    if($val2 >= 7) {
	print FH "csl_bitrange br2($val2);\n\n";
    }
    else {
	$val2 = $val2 + 7;
	print FH "csl_bitrange br2($val2);\n\n";
    }
    
#interface ifc1
    print FH "csl_interface ifc$j {\n";
#100 tests with 2 ports
    if($i <= 100) {
	    print FH "  csl_port p_a$i($dir{$l},$val3);\n"; 
	    if($l < 3) {
		print FH "  csl_port p_b$i($dir{$l+1},br2);\n";
	    }
	    else {
		print FH "  csl_port p_b$i($dir{$l-1},br2);\n";
	    }
	}                  
#150 tests have 3 ports                                                                        
	elsif($i > 100 && $i <= 250) {
	    if($l < 3) {
		print FH "  csl_port p_a$i($dir{$l+1},br1);\n"; 
	    }
	    else {
		print FH "  csl_port p_a$i($dir{$l-1},br1);\n";
	    }
	    print FH "  csl_port p_b$i($dir{$l},br2);\n";
	    if($l == 1) {
		print FH "  csl_port p_c$i($dir{$l+2},$val3);\n";
	    }
	    else {
		print FH "  csl_port p_c$i($dir{$l-1},$val3);\n";
	    }
	} 
#the rest of the tests have 5 ports
	elsif($i > 250) {
	    if($l < 3) {
		print FH "  csl_port p_a$i($dir{$l+1},br2);\n"; 
	    }
	    else {
		print FH "  csl_port p_a$i($dir{$l-1},br2);\n";
	    }
	    print FH "  csl_port p_b$i($dir{$l},br1);\n";
	    if($l == 1) {
		print FH "  csl_port p_c$i($dir{$l+2},$val2);\n";
	    }
	    else {
		print FH "  csl_port p_c$i($dir{$l-1},$val2);\n";
	    }
	    if($l == 2) {
		print FH "  csl_port p_d$i($dir{$l+1},$val3);\n";
	    }
	    else {
		print FH "  csl_port p_d$i($dir{$l},$val3);\n";
	    }
	    if($l > 1) {
		print FH "  csl_port p_e$i($dir{$l-1},$val1);\n";
	    }
	    else {
		print FH "  csl_port p_e$i($dir{$l+1},$val1);\n";	
	    }
	}
	print FH "  ifc$j () {}\n";
	print FH "};\n\n";
	
	
#interface ifcm
	if($i <= 100 || $i > 150 && $i <= 400) {
	    print FH "csl_interface ifc$m {\n";
#5 tests with one port
	    if($i <= 100 || $i > 250 && $i <= 275) {
		print FH "  ifc$j ifc$j\_$zero;\n";
		print FH "  csl_port p_l$i($dir{$l},br2);\n";
		if($l < 3) {
		    print FH "  csl_port p_k$i($dir{$l+1},$val3);\n";
		}
		else {
		    print FH "  csl_port p_k$i($dir{$l-1},$val3);\n";
		}
	    }
#170 tests have ifc1 instantiated in ifc2
	    elsif($i > 100 && $i <= 300 || $i > 325 && $i <= 350) {
		print FH "  ifc$j ifc$j\_$zero;\n";
		print FH "  csl_port p_$i($dir{$l},$val3);\n";
	    }
#25 tests have ifc1 instantiated in ifc2 and 2 ports
	    elsif($i > 300 && $i <= 325 || $i > 375 && $i <= 400) {
		print FH "  ifc$j ifc$j\_$one;\n";
		print FH "  csl_port p_a$i($dir{$l},$val3);\n";
		if($l < 3) {
		    print FH "  csl_port p_b$i($dir{$l+1},br2);\n";
		}
		else {
		    print FH "  csl_port p_b$i($dir{$l-1},br2);\n";
		}   
	    }
	    print FH "  ifc$m () {}\n";
	    print FH "};\n\n";
	}
	
	
#ifcn interface
	if($i > 50 && $i <= 100 || $i > 125 && $i <= 150 || $i > 225 && $i <= 300 || $i > 350 && $i <= 375) {
	    print FH "csl_interface ifc$n {\n";
#125 tests have ifc1 and ifc2 instantiated in ifc3
	    if($i <= 100 || $i > 250 && $i <= 275 || $i > 350 && $i <= 375) {
		print FH "  ifc$j ifc$j\_$one;\n";
		print FH "  ifc$m ifc$m\_$two;\n";
	    }
#25 tests have 2 ports in ifc3
	    elsif($i > 125 && $i <= 150) {
		print FH "  csl_port p_x$i(input,$val2);\n";
		print FH "  csl_port p_y$i(input,$val3);\n";
	    }
#25 tests have ifc2 instantiated in unit c and 2 ports
	    elsif($i > 225 && $i <= 250 || $i > 275 && $i <= 300) {
		print FH "  ifc$m ifc$m\_$two;\n";
		print FH "  csl_port p_l$i(input,$val2);\n";
		print FH "  csl_port p_m$i(input,$val3);\n";
	}
	    print FH "  ifc$n () {}\n";
	    print FH "};\n\n";
	}
	
#25 tests have a sg1 signal group
	if($i > 100 && $i <= 200 || $i > 300 && $i <= 400) {
	    print FH "csl_signal_group sg$j {\n";
	    print FH "  csl_signal s_a$i(br2);\n";
	    print FH "  csl_signal s_b$i($val3);\n";
	    if($i > 150 && $i <= 175) {
		print FH "  csl_signal s_c$i(br1);\n";
	    }
	    print FH "  sg$j () {}\n";
	    print FH "};\n\n";
	}
	
#50 tests have sg2
	if($i > 150 && $i <= 200 || $i > 350 && $i <= 400) {
	    print FH "csl_signal_group sg$m {\n";
	    print FH "  sg$j sg$j\_$zero;\n";
	    if($i <= 175 || $i > 350 && $i <= 375) {
		print FH "  csl_signal s_x($val2);\n";
		print FH "  csl_signal s_y($val3);\n"
		}
	    elsif($i > 175 && $i <= 200 || $i > 375 && $i <= 400) {
		print FH "  sg$j sg$j\_$one;\n";
	    }
	    print FH "  sg$m () {}\n";
	    print FH "};\n\n";
	}
	
#unit a
	print FH "csl_unit a$k {\n";
	print FH "  ifc$j ifc$j\_$one;\n";
#25 tests have ifc3 instantiated in unit a
	if($i > 50 && $i <= 75) {
	    print FH "  ifc$n ifc$n\_$zero;\n";
	}
#25 tests have sg1 instantiated in unit a
	elsif($i > 100 && $i <= 125 || $i > 325 && $i <= 350) {
	    print FH "  sg$j sg$j\_$zero;\n";
	}
#25 tests have sg2 instantiated in unit a
	elsif($i > 150 && $i <= 175) {
	    print FH "  sg$m sg$m\_$zero;\n";
	}
#25 tests have ifc2 instantiated in unit a
	elsif($i > 175 && $i <= 200 || $i > 250 && $i <= 275 || $i > 375 && $i <= 400) {
	    print FH "  ifc$m ifc$m\_$zero;\n";
	}
#25 tests have ifc3 instantiated in unit a
	if($i > 350 && $i <= 375) {
	    print FH "  ifc$n ifc$n\_$zero;\n";
	    print FH "  sg$m sg$m\_$zero;\n";
	}
	print FH "  a$k () {\n"; 
	print FH "  }\n";
	print FH "};\n\n"; 
	
	
#unit b    
	print FH "csl_unit b$k {\n";  
	print FH "  a$k a$k\_$zero;\n";
#25 tests have ifc2 instantiated in unit b
	if($i > 25 && $i <= 50 || $i > 275 && $i <= 300) {
	    print FH "  ifc$m ifc$m\_$one;\n";
	}
#25 tests have ifc1 instantiated in unit b
	elsif($i > 100 & $i <= 125) {
	    print FH "  ifc$j ifc$j\_4;\n";
	}
#25 tests have sg1 instantiated in unit b
	elsif($i > 300 & $i <= 325) {
	    print FH "  sg$j sg$j\_$zero;\n";
	}
	print FH "  b$k () {\n";
	print FH "  }\n";
	print FH "};\n\n";        
	
	
#unit c 
	print FH "csl_unit c$k {\n";
	print FH "  b$k b$k\_$zero;\n";
#25 tests have ifc2 instantiated in unit c
	if($i <= 25 || $i > 50 && $i <= 75) {
	    print FH "  ifc$m ifc$m\_$zero;\n";
	}
#25 tests have sg1 instantiated in unit c
	elsif($i > 125 && $i <= 150) {
	    print FH "  sg$j sg$j\_$one;\n";
	}
#25 tests have ifc1 instantiated in unit c
	elsif($i > 150 && $i <= 175) {
	    print FH "  ifc$j ifc$j\_$two;\n";
	}
#25 tests have ifc2 instantiated in unit c
	elsif($i > 200 && $i <= 225 || $i > 325 && $i <= 350) {
	    print FH "  ifc$m ifc$m\_$one;\n";
	}
#25 tests have ifc2 instantiated in unit c
	elsif($i > 250 && $i <= 275) {
	    print FH "  ifc$n ifc$n\_$two;\n";
	}
#25 tests have sg2 instantiated in unit c
	elsif($i > 375 && $i <= 400) {
	    print FH "  sg$m sg$m\_$two;\n";
	}
	print FH "  c$k (){\n";
#25 tests connect an interface with a port from an interface
	if($i <= 25) {
	    print FH "//connect an interface with a port from an interface\n";
	    print FH "    b$k\_$zero.a$k\_$zero.ifc$j\_$one.connect(ifc$m\_$zero.p_l$i);\n";
	}
#25 tests connect an interface with a port from an interface (ifc.ifc)
	elsif($i > 50 && $i <= 75) {
	    print FH "//connect an interface with a port from an interface\n";
	    print FH "    ifc$m\_$zero.connect(b$k\_$zero.a$k\_$zero.ifc$n\_$zero.ifc$m\_$two.p_l$i);\n";
	}
#25 tests connect an interface with a signal from a signal group (sg.sg)
	elsif($i > 150 && $i <= 175) {
	    print FH "//connect an interface with a signal from a signal group\n";
	    print FH "    ifc$j\_$two.connect(b$k\_$zero.a$k\_$zero.sg$m\_$zero.sg$j\_$zero.s_c$i);\n";
	}
#25 tests connect an interface with port from an interface (ifc.ifc)
	elsif($i > 200 && $i <= 225) {
	    print FH "//connect an interface with a port from an interface\n";
	    print FH "    ifc$m\_$one.ifc$j\_$zero.connect(b$k\_$zero.a$k\_$zero.ifc$j\_$one.p_b$i);\n";
	}
#25 tests connect an interface with port from an interface (ifc.ifc, ifc.ifc)
	elsif($i > 250 && $i <= 275) {
	    print FH "//connect an interface with a port from an interface\n";
	    print FH "    b$k\_$zero.a$k\_$zero.ifc$m\_$zero.ifc$j\_$zero.connect(ifc$n\_$two.ifc$j\_$one.p_e$i);\n";
	}
#25 tests connect an interface with a signal part from a signal group (ifc.ifc)
	elsif($i > 325 && $i <= 350) {
	    print FH "//connect an interface with a signal part from a signal group\n";
	    print FH "    ifc$m\_$one.ifc$j\_$zero.connect(b$k\_$zero.a$k\_$zero.sg$j\_$zero.s_b$i\[".($val3)."\:".($val3-5)."\]);\n";
	}
#25 tests connect an interface with a signal part from a signal group (ifc.ifc,sg.sg)
	elsif($i > 375 && $i <= 400) {
	    print FH "//connect an interface with a signal part from a signal group\n";
	    print FH "    b$k\_$zero.a$k\_$zero.ifc$m\_$zero.ifc$j\_$one.connect(sg$m\_$two.sg$j\_$one.s_b$i\[".($val3)."\:".($val3-5)."\]);\n";
	}
	print FH "  }\n";        
	print FH "};\n\n";  
	
	
#unit d
	if($i <= 75 || $i > 100) {
	    print FH "csl_unit d$k {\n";
	    print FH "  c$k c$k\_$zero;\n";
#25 tests have ifc1 instantiated in unit d
	    if($i > 25 && $i <= 50) {
		print FH "  ifc$j ifc$j\_$two;\n";
	    }
#25 tests have a1 instantiated in unit d
	    elsif($i > 100 && $i <= 125 || $i > 350 && $i <= 375) {
		print FH "  a$k a$k\_$one;\n";
	    }
#25 tests have sg2 instantiated in unit d
	    elsif($i > 175 && $i <= 200) {
		print FH "  sg$m sg$m\_$one;\n";
	    }
#25 tests have ifc3 instantiated in unit d
	    if($i > 225 && $i <= 250 || $i > 275 && $i <= 300) {
		print FH "  ifc$n ifc$n\_$one;\n";
		print FH "  b$k b$k\_$two;\n";
	    }
#25 tests have ifc2 instantiated in unit d
	    if($i > 25 && $i <= 50 || $i > 300 && $i <= 325) {
		print FH "  ifc$m ifc$m\_$tre;\n";
	    }
	    print FH "  d$k () { \n";
#25 tests connect an interface with a port part from an interface
	    if($i > 25 && $i <= 50) {
		print FH "//connect an interface with a port part from an interface\n";
		print FH "    ifc$j\_$two.connect(c$k\_$zero.b$k\_$zero.ifc$m\_$one.p_k$i\[".($val3)."\:".($val3-2)."\]);\n";
	    }
#25 tests connect an interface with a signal from a signal group
	    elsif($i > 100 && $i <= 125) {
		print FH "//connect an interface with a signal from a signal group\n";
		print FH "    c$k\_$zero.b$k\_$zero.ifc$j\_4.connect(a$k\_$one.sg$j\_$zero.s_a$i);\n";
	    }
#25 tests connect an interface with a signal part from a signal group (sg.sg)
	    elsif($i > 175 && $i <= 200) {
		print FH "//connect an interface with a signal part from a signal group\n";
		print FH "    c$k\_$zero.b$k\_$zero.a$k\_$zero.ifc$m\_$zero.connect(sg$m\_$one.sg$j\_$one.s_b$i\[".($val3)."\:".($val3-4)."\]);\n";
	    }
#25 tests connect an interface with a port part from an interface (ifc.ifc)
	    if($i > 225 && $i <= 250) {
		print FH "//connect an interface with a port part from an interface\n";
		print FH "    ifc$n\_$one.ifc$m\_$two.connect(b$k\_$two.a$k\_$zero.ifc$j\_$one.p_c$i\[".($val3)."\:".($val3-4)."\]);\n";
	    }
#25 tests connect an interface with a signal from a signal group (ifc.ifc)
	    elsif($i > 300 && $i <= 325) {
		print FH "//connect an interface with a signal from a signal group\n";
		print FH "    ifc$m\_$tre.ifc$j\_$one.connect(c$k\_$zero.b$k\_$zero.sg$j\_$zero.s_a$i);\n";
	    }
#25 tests connect an interface with a signal from a signal group (ifc.ifc,sg,sg)
	    elsif($i > 350 && $i <= 375) {
		print FH "//connect an interface with a signal from a signal group\n";
		print FH "    a$k\_$one.ifc$n\_$zero.ifc$j\_$one.connect(c$k\_$zero.b$k\_$zero.a$k\_$zero.sg$m\_$zero.sg$j\_$zero.s_a$i);\n";
	    }
	    print FH "  }\n";
	    print FH "};\n\n";
	}
	
	
#25 tests have a unit e
	if($i > 75 && $i <= 100 || $i > 125 && $i <= 150 || $i > 275 && $i <= 300) {
	    print FH "csl_unit e$k {\n";
#25 tests have c1 and ifc3 instantiated in unit e
	    if($i > 75 && $i <= 100) {
		print FH "  c$k c$k\_$one;\n";
		print FH "  ifc$n ifc$n\_$one;\n";
	    }
#25 tests have ifc3 and d instantiated in unit e
	    elsif($i > 125 && $i <= 150) {
		print FH "  ifc$n ifc$n\_$one;\n";
		print FH "  d$k d$k\_$zero;\n";
	    }
#25 tests have unit d instantiated twice in unit e
	    elsif($i > 275 && $i <= 300) {
		print FH "  d$k d$k\_$zero;\n";
		print FH "  d$k d$k\_$one;\n";
	    }
	    print FH "  e$k () {\n";
#25 tests connect an interface with a port part from an interface
	    if($i > 75 && $i <= 100) {
		print FH "//connect an interface with a port part from an interface\n";
		print FH "    c$k\_$one.b$k\_$zero.a$k\_$zero.ifc$j\_$one.connect(ifc$n\_$one.ifc$j\_$one.p_a$i\[".($val3)."\:".($val3-2)."\]);\n"; 
	    }
#25 tests connect an interface with a signal part from a signal group
	    elsif($i > 125 && $i <= 150) {
		print FH "//connect an interface with a signal part from a signal group\n";
		print FH "    ifc$n\_$one.connect(d$k\_$zero.c$k\_$zero.sg$j\_$one.s_b$i\[".($val3)."\:".($val3-2)."\]);\n";
	    }
#25 tests connect an interface with a port part from an interface (ifc.ifc, ifc.ifc)
	    if($i > 275 && $i <= 300) {
		print FH "//connect an interface with a port part from an interface\n";
		print FH "    d$k\_$zero.c$k\_$zero.b$k\_$zero.ifc$m\_$one.ifc$j\_$zero.connect(d$k\_$one.ifc$n\_$one.ifc$m\_$two.p_$i\[".($val3)."\:".($val3-5)."\]);\n"; 
	    }
	    print FH "  }\n";
	    print FH "};\n\n";
	}
	
    close(FH);
    
}

