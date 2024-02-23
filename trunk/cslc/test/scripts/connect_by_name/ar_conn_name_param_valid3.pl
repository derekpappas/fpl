#!/usr/bin/perl

#oanab
#connect_by_name() with param

use strict;

print "Generated tests path : test/csl_test_gen/ar_conn_name_param_valid3/\n";

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

foreach(my $i = 1; $i <= 250; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my $j = $_[1];
    my $m = $_[2];
    my $n = $_[3];
    $j = int(rand(20))+1; 
    $m = int(rand(20))+2; 
    $n = int(rand(20))+3; 
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "ar_conn_name_param".$i."_legal.csl";
    if($j != $m) {
	&createCslFile($test_name, $i, $j, $m, $n, %dir);
    }
    else {
	&createCslFile($test_name, $i, $j+1, $m+2, $n+3, %dir);
    }
}
sub createCslFile {
    my($test_name, $i, $j, $m, $n, %dir) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $k = int(rand(20)) + int(rand(20));
    my $zero = 0;
    my $one = 1;
    my $two = 2;
    my $tre = 3;
    my $val1 = int(rand(100))+2;
    my $val2 = int(rand(100))+1;
    my $val3 = int(rand(100))+8;
    my $l = int(rand(3))+1;
    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_conn_name_param_valid3");
        open(FH,">$path/ar_conn_name_param_valid3/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ar_conn_name_param_invalid1"); 
        open(FH,">$path/ar_conn_name_param_invalid1/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";

#ifcj
    if($i > 50 && $i <= 250) {
	print FH "csl_interface ifc$j {\n";
	if($i > 50 && $i <= 100 || $i > 150 && $i <= 250) {
	    print FH "  csl_parameter par1(".($val1+$val2+$val3-1).");\n";
	    print FH "  csl_parameter par2(".($val2).");\n";
	    print FH "  csl_parameter par3(".($val3+$val2-1).");\n";
	    print FH "  csl_parameter par4(".($val3).");\n";
	}
	print FH "  csl_parameter par_m$i(".($val1+$val2).");\n";
	print FH "  csl_port p_m$i(input,par_m$i);\n";
	print FH "  csl_parameter par_n$i(".($val3+$val2).");\n";
	print FH "  csl_port p_n$i(input,par_n$i);\n";
	print FH "  csl_port p_o$i(input,".($val1+$val2+$val3).");\n";
	print FH "  ifc$j () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#sgj
    if($i > 50 && $i <= 250) {
	print FH "csl_signal_group sg$j {\n";
	if($i > 50 && $i <= 100 || $i > 150 && $i <= 250) {
            print FH "  csl_parameter par1(".($val2+$val3-1).");\n";
            print FH "  csl_parameter par2(".($val2).");\n";
            print FH "  csl_parameter par3(".($val3+$val2-1).");\n";
            print FH "  csl_parameter par4(".($val3).");\n";
        }   
	print FH "  csl_parameter par_m$i(".($val2+$val3).");\n";
	print FH "  csl_signal p_m$i(par_m$i);\n";
	print FH "  csl_parameter par_n$i(".($val3+$val2).");\n";
	print FH "  csl_signal p_n$i(par_n$i);\n";
	print FH "  csl_signal p_o$i(".($val2+$val3).");\n";
	print FH "  sg$j () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }


#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_x$i(input,br2);\n";
	print FH "  csl_port p_n$i(input,br3);\n";
	print FH "  csl_signal s_x$i(br1);\n";
	print FH "  csl_signal s_y$i(br2);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  ifc$j ifc$j\_$zero;\n";
	print FH "  csl_signal s_y$i(br2);\n";
	print FH "  csl_port p_n$i(input,br3);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_parameter par_s$i(".($val1+$val2).");\n";
	print FH "  csl_parameter par_y$i(1);\n";
	print FH "  csl_signal s_y$i(par_s$i);\n";
	print FH "  csl_port p_y$i(input,par_y$i);\n";
	print FH "  ifc$j ifc$j\_$zero;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_parameter par1(".($val2+$val3-1).");\n";
	print FH "  csl_parameter par2(".($val2).");\n";
	print FH "  csl_parameter par$i(".($val2).");\n";
	print FH "  csl_signal s_m$i(par$i);\n";
	print FH "  sg$j sg$j\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_parameter par_p$i(".($val3).");\n";
	print FH "  csl_port p_p$i(input,par_p$i);\n";
	print FH "  csl_parameter par_z$i(".($val1).");\n";
	print FH "  csl_signal s_z$i(par_z$i);\n";
	print FH "  csl_parameter par_c$i(".($val2).");\n";
	print FH "  csl_signal s_c$i(par_c$i);\n";
	print FH "  csl_port p_c$i(input,par_c$i);\n";
    }
    print FH "  a$k () {\n";
    if($i <= 50) {
	print FH "    p_x$i = s_y$i;  // assign : port---sig\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "    sg$j\_$zero.p_m$i\[par1\:par2\] = sg$j\_$zero.p_n$i\[".($val3+$val2-1)."\:".($val2)."\];  // assign : sg.spar.pspar---sg.spar\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    s_z$i\[".($val1-1)."\:".($val1-1)."\]= p_p$i\[".($val3-1)."\-\:".(1)."\];  // assign : spar.ps---ppar.ps\n";
	print FH "    s_c$i = p_c$i;  // assign : spar---ppar\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit b
    print FH "csl_unit b$k {\n";
    if($i <= 50) {
	print FH "  a$k a$k\_$zero(.p_n$i(s_a$i\[".($val2+$val3-1)."\:".($val2)."\]));\n";
	print FH "  a$k a$k\_$one;\n";
	print FH "  csl_parameter par_y$i(".($val1+$val2).");\n";
	print FH "  csl_port p_x$i(input,par_y$i);\n";
	print FH "  csl_port p_y$i(input,par_y$i);\n";
	print FH "  csl_port p_z$i(input,par_y$i);\n";
	print FH "  csl_parameter par1(".($val2+$val1-1).");\n";
	print FH "  csl_parameter par2(".($val1).");\n";
	print FH "  csl_parameter par3(".($val2+$val3-1).");\n";
	print FH "  csl_parameter par4(".($val3).");\n";
	print FH "  csl_signal s_a$i(".($val2+$val3).");\n";
	print FH "  csl_port p_m$i(input,br1);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s_i$i(".($val1+$val2+$val3).");\n";
	print FH "  a$k a$k\_$zero(.ifc$j\_$zero.p_n$i(sg$j\_$zero.p_o$i),.ifc$j\_$zero.p_o$i(s_i$i));\n";
	print FH "  csl_signal s_a$i($val1);\n";
	print FH "  csl_signal s_b$i($val2);\n";
	print FH "  sg$j sg$j\_$zero;\n";
	print FH "  ifc$j ifc$j\_$one;\n";
	print FH "  csl_port p_x$i(input,br3);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  a$k a$k\_$zero(.ifc$j\_$zero.p_n$i(sg$j\_$zero.p_m$i),.ifc$j\_$zero.p_o$i(s_o$i));\n";
	print FH "  csl_parameter par_m$i(".($val1).");\n";
	print FH "  csl_signal s_m$i(par_m$i);\n";
	print FH "  csl_signal s_o$i(".($val1+$val2+$val3).");\n";
	print FH "  sg$j sg$j\_$zero;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_parameter par1(".($val2+$val1-1).");\n";
	print FH "  csl_parameter par2(".($val2).");\n";
	print FH "  csl_signal s_a$i(".($val2+$val1).");\n";
	print FH "  csl_parameter parm_$i(".($val3).");\n";
	print FH "  csl_signal s_m$i(parm_$i);\n";
	print FH "  csl_parameter parn_$i(".($val2).");\n";
	print FH "  csl_port p_n$i(input,parn_$i);\n";
	print FH "  ifc$j ifc$j\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_parameter par_p$i(".($val3+$val2).");\n";
	print FH "  csl_signal s_p$i(par_p$i);\n";
	print FH "  csl_parameter par1(".($val2+$val3-1).");\n";
	print FH "  csl_parameter par2(".($val2).");\n";
	print FH "  csl_port p_n$i(input,par2);\n";
	print FH "  ifc$j ifc$j\_$two;\n";
	print FH "  csl_parameter par_b$i(".($val3).");\n";
	print FH "  csl_port p_b$i(input,par_b$i);\n";
    }
    print FH "  b$k () {\n";
#connect_by_name : ppar.pspar---sig (PC)
    if($i <= 50) {
	print FH "    p_y$i\[par1\:par2\].connect_by_name(a$k\_$one.s_y$i);  // ppar.pspar---sig (PC)\n";
	print FH "    p_z$i\[par1\:par2\].connect_by_name(a$k\_$one.p_x$i);  // ppar.pspar---port (PC)\n";
    }
#connect_by_name : ifc.ppar.ps---sig (CP) and sg.s.pspar---port (PC)
    elsif($i > 50 && $i <= 100) {
	print FH "    a$k\_$zero.ifc$j\_$zero.p_m$i\[".($val1+$val2-1)."\:".($val2)."\].connect_by_name(s_a$i);  // ifc.ppar.ps---sig (CP)\n";
	print FH "    sg$j\_$zero.p_m$i\[par1\:par2\].connect_by_name(a$k\_$zero.p_n$i);  // sg.s.pspar---port (PC)\n";
    }
#connect_by_name : sg.spar.ps---port (PC)
    elsif($i > 100 && $i <= 150) {
	print FH "    sg$j\_$zero.p_n$i\[".($val3-1)."\].connect_by_name(a$k\_$zero.p_y$i);  // sg.spar.ps---port (PC)\n";
	print FH "    sg$j\_$zero.p_m$i = sg$j\_$zero.p_o$i;  // assign : sg.spar---sg.sig\n";
    }
#connect_by_name : sg.s.pspar---ppar (CP) and  ifc.ppar.pspar---ppar (PC)
    elsif($i > 150 && $i <= 200) {
	print FH "    a$k\_$zero.sg$j\_$zero.p_o$i\[par3\:par4\].connect_by_name(p_n$i);  // sg.s.pspar---ppar (CP)\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    ifc$j\_$two.p_n$i\[par3\:par4\].connect_by_name(a$k\_$zero.p_c$i);  // ifc.ppar.pspar---ppar (PC)\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit c
    print FH "csl_unit c$k {\n";
    if($i <= 50) {
	print FH "  b$k b$k\_$zero(.p_y$i(s_a$i),.p_z$i(s_a$i));\n";
	print FH "  csl_parameter par1(".($val2+$val3-1).");\n";
	print FH "  csl_parameter par2(".($val2).");\n";
	print FH "  csl_parameter par_s$i(".($val2+$val3).");\n";
	print FH "  csl_signal s_z$i(par_s$i);\n";
	print FH "  csl_signal s_a$i(".($val1+$val2).");\n";
	print FH "  csl_port p_x$i(input,br2);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  b$k b$k\_$zero(.ifc$j\_$one.p_m$i(s_a$i\[".($val3+$val2+$val1-1)."\:".($val3)."\]),.ifc$j\_$one.p_n$i(ifc$j\_$two.p_n$i));\n";
	print FH "  csl_signal s_a$i(".($val3+$val2+$val1).");\n";
	print FH "  a$k a$k\_$one(.ifc$j\_$zero.p_n$i(ifc$j\_$two.p_n$i),.ifc$j\_$zero.p_o$i(ifc$j\_$two.p_o$i),.p_n$i(s_a$i\[".($val3+$val2+$val1-1)."\-\:".($val3)."\]));\n";
	print FH "  csl_port p_x$i(input);\n";
	print FH "  csl_port p_y$i(input,br2);\n";
	print FH "  ifc$j ifc$j\_$two;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_parameter par_x$i(".($val2).");\n";
	print FH "  csl_port p_x$i(input,par_x$i);\n";
	print FH "  csl_parameter par_y$i(".($val2+$val1+$val3).");\n";
	print FH "  csl_port p_y$i(input,par_y$i);\n";
	print FH "  ifc$j ifc$j\_$one;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  b$k b$k\_$zero(.ifc$j\_$zero.p_m$i(s_a$i\[".($val1+$val2+$val3-1)."\:".($val3)."\]),.ifc$j\_$zero.p_n$i(s_a$i\[".($val1+$val2+$val3-1)."\-\:".($val2+$val3)."\]),.p_n$i(s_a$i\[".($val1+$val2-1)."\:".($val1)."\]));\n";
	print FH "  csl_parameter par_x$i(".($val1).");\n";
	print FH "  csl_port p_x$i(input,par_x$i);\n";
	print FH "  csl_parameter par_y$i(".($val1+$val3).");\n";
	print FH "  csl_port p_y$i(input,par_y$i);\n";
	print FH "  csl_signal s_a$i(".($val1+$val2+$val3).");\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  b$k b$k\_$zero(.ifc$j\_$two.p_m$i(ifc$j\_$one.p_m$i),.ifc$j\_$two.p_o$i(ifc$j\_$one.p_o$i));\n";
	print FH "  a$k a$k\_$one;\n";
	print FH "  csl_parameter par1(".(2*$val2+$val3-1).");\n";
	print FH "  csl_parameter par2(".($val2+$val3).");\n";
	print FH "  csl_parameter par_x$i(".($val3+2*$val2).");\n";
	print FH "  csl_port p_x$i(input,par_x$i);\n";
	print FH "  ifc$j ifc$j\_$one;\n";
    }
    print FH "  c$k () {\n";
#connect_by_name : ppar.ps---port (PC) and s.pspar---port (CP) and spar.pspar---port (PC)
    if($i <= 50) {
	print FH "    b$k\_$zero.p_x$i\[".($val1+$val2-1)."\:".($val1)."\].connect_by_name(b$k\_$zero.a$k\_$zero.p_x$i);  // ppar.ps---port (PC)\n";
	print FH "    b$k\_$zero.s_a$i\[par3\:par4\].connect_by_name(p_x$i);  // s.pspar---port (CP)\n";
	print FH "    s_z$i\[par1\:par2\].connect_by_name(b$k\_$zero.a$k\_$one.p_n$i);  // spar.pspar---port (PC)\n";
	print FH "    p_x$i = s_z$i\[".($val2+$val3-1)."\:".($val3)."\];\n";
    }
#connect_by_name : sg.spar.ps---port (CP) and ifc.p.pspar---sig (SS) and ifc.p.pspar---port (PC)
    elsif($i > 50 && $i <= 100) {
	print FH "    b$k\_$zero.sg$j\_$zero.p_n$i\[".($val3-1)."\].connect_by_name(p_x$i);  // sg.spar.ps---port (CP)\n";
	print FH "  b$k\_$zero.ifc$j\_$one.p_o$i\[par1\-\:par2\].connect_by_name(a$k\_$one.s_y$i);  // ifc.p.pspar---sig (SS)\n";
	print FH "    ifc$j\_$two.p_o$i\[par1\:".($val1+$val2)."\].connect_by_name(b$k\_$zero.p_x$i);  // ifc.p.pspar---port (PC)\n";
    }
#connect_by_name : spar.ps---ppar (CP) and ifc.ppar.ps---spar (CP)
    elsif($i > 100 && $i <= 150) {
	print FH "    b$k\_$zero.a$k\_$zero.s_y$i\[".($val1+$val2-1)."\:".($val1)."\].connect_by_name(p_x$i);  // spar.ps---ppar (CP)\n";
	print FH "    b$k\_$zero.a$k\_$zero.ifc$j\_$zero.p_m$i\[".($val1+$val2-1)."\:".($val2)."\].connect_by_name(b$k\_$zero.s_m$i);  // ifc.ppar.ps---spar (CP)\n";
    }
#connect_by_name : sig.pspar---ppar (CP) and ifc.p.pspar---ppar (CP)
    elsif($i > 150 && $i <= 200) {
	print FH "    b$k\_$zero.s_a$i\[par1\:par2\].connect_by_name(p_x$i);  // sig.pspar---ppar (CP)\n";
	print FH "    b$k\_$zero.ifc$j\_$zero.p_o$i\[par1\:par2\].connect_by_name(p_y$i);  // ifc.p.pspar---ppar (CP)\n";
    }
#connect_by_name : spar.pspar---ppar (SS) and ppar.pspar---ppar (PC)
    elsif($i > 200 && $i <= 250) {
	print FH "    b$k\_$zero.s_p$i\[par1\:par2\].connect_by_name(a$k\_$one.p_p$i);  // spar.pspar---ppar (SS)\n";
	print FH "    p_x$i\[par1\:par2\].connect_by_name(b$k\_$zero.p_n$i);  // ppar.pspar---ppar (PC)\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit d
    print FH "csl_unit d$k {\n";
    if($i <= 50) {
	print FH "  c$k c$k\_$zero;\n";
	print FH "  csl_parameter par1(".($val1+$val2-1).");\n";
	print FH "  csl_parameter par2(".($val2).");\n";
	print FH "  csl_port p_m$i(input,".($val1+$val2).");\n";
	print FH "  csl_port p_n$i(input,".($val1+$val2+$val3).");\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  c$k c$k\_$zero(.ifc$j\_$two.p_m$i(ifc$j\_$zero.p_o$i\[".($val1+$val2+$val3-1)."\:".($val3)."\]),.ifc$j\_$two.p_n$i(sg$j\_$zero.p_m$i),.p_x$i(sg$j\_$zero.p_n$i\[".($val3-1)."\]));\n";
	print FH "  ifc$j ifc$j\_$zero;\n";
#	print FH "  ifc$j ifc$j\_$one;\n";
	print FH "  sg$j sg$j\_$zero;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  c$k c$k\_$zero(.ifc$j\_$one.p_m$i(s_m$i),.ifc$j\_$one.p_o$i(s_o$i));\n";
	print FH "  csl_signal s_m$i(".($val1+$val2).");\n";
	print FH "  csl_signal s_o$i(".($val1+$val2+$val3).");\n";
	print FH "  csl_parameter par_z$i(".($val2).");\n";
	print FH "  csl_port p_z$i(input,par_z$i);\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  c$k c$k\_$zero(.p_y$i({ifc$j\_$one.p_m$i\[".($val2+$val1-1)."\:".($val2)."\],ifc$j\_$one.p_n$i\[par3\:par2\]}));\n";
	print FH "  csl_parameter par1(".($val3+$val2+$val1-1).");\n";
	print FH "  csl_parameter par2(".($val2+$val1).");\n";
	print FH "  csl_parameter par3(".($val2+$val3).");\n";
	print FH "  csl_port p_m$i(input,".($val3+$val2+2*$val1).");\n";
	print FH "  csl_port p_n$i(input,".($val3+$val2+$val1).");\n";
	print FH "  ifc$j ifc$j\_$one;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  c$k c$k\_$zero(.ifc$j\_$one.p_m$i(s_p$i\[".($val1+$val2+$val3-1)."\:par2\]),.ifc$j\_$one.p_o$i({sg$j\_$one.p_n$i\[".($val2+$val3-1)."\:".($val2)."\],sg$j\_$one.p_o$i\[".($val2+$val3-1)."\:".($val3)."\],s_p$i\[par1\:par2\]}));\n";
#	print FH "  csl_parameter par_z$i(1);\n";
#	print FH "  csl_signal s_z$i(par_z$i);\n";
	print FH "  csl_parameter par1(".($val1+$val3-1).");\n";
	print FH "  csl_parameter par2(".($val3).");\n";
	print FH "  csl_parameter par_m$i(".($val3+$val1).");\n";
	print FH "  csl_port p_m$i(input,par_m$i);\n";
	print FH "  csl_signal s_p$i(".($val1+$val2+$val3).");\n";
	print FH "  a$k a$k\_$two;\n";
	print FH "  sg$j sg$j\_$one;\n";
    }
    print FH "  d$k () {\n";
#connect_by_name : p.pspar---port (PC) and p.pspar---sig (PC)
    if($i <= 50) {
	print FH "    p_m$i\[par1\:par2\].connect_by_name(c$k\_$zero.b$k\_$zero.p_m$i);  // p.pspar---port (PC)\n";
	print FH "    p_n$i\[par1\:par2\].connect_by_name(c$k\_$zero.b$k\_$zero.a$k\_$zero.s_x$i); // p.pspar---sig (PC)\n";
    }
#connect_by_name : ifc.ppar.pspar---sig (PC) and ifc.ppar.pspar---port (PC) and sg.s.pspar---port (PC)
    elsif($i > 50 && $i <= 100) {
	print FH "    ifc$j\_$zero.p_n$i\[par3\:par4\].connect_by_name(c$k\_$zero.b$k\_$zero.s_b$i); // ifc.ppar.pspar---sig (PC)\n";
	print FH "    ifc$j\_$zero.p_m$i\[".($val1+$val2-1)."\-\:par2\].connect_by_name(c$k\_$zero.p_y$i); // ifc.ppar.pspar---port (PC)\n";
	print FH "    sg$j\_$zero.p_o$i\[par3\:".($val2)."\].connect_by_name(c$k\_$zero.b$k\_$zero.p_x$i);  // sg.s.pspar---port (PC)\n";
    }
#connect_by_name : ppar.ps---ppar (PC) and ppar.ps---spar (PC) and ifc.ppar.ps---ppar (CP)
    elsif($i > 100 && $i <= 150) {
	print FH "    p_z$i\[".($val2-1)."\:".(0)."\].connect_by_name(c$k\_$zero.p_x$i);  // ppar.ps---ppar (PC)\n";
	print FH "    c$k\_$zero.p_y$i\[".($val1+$val2+$val3-2)."\-\:".($val1+$val2)."\].connect_by_name(c$k\_$zero.b$k\_$zero.a$k\_$zero.s_y$i);  // ppar.ps---spar (PC)\n";
	print FH "    c$k\_$zero.ifc$j\_$one.p_n$i\[".($val2+$val3-1)."\:".($val3)."\].connect_by_name(p_z$i);  // ifc.ppar.ps---ppar (CP)\n";
    }
#connect_by_name : p.pspar---spar (PC) and p.pspar---ppar (PC) and ifc.p.pspar---spar (PC)
    elsif($i > 150 && $i <= 200) {
	print FH "    p_m$i\[par1\:par2\].connect_by_name(c$k\_$zero.b$k\_$zero.s_m$i);  // p.pspar---spar (PC)\n";
	print FH "    p_n$i\[par1\:par3\].connect_by_name(c$k\_$zero.p_x$i);  // p.pspar---ppar (PC)\n";
	print FH "    ifc$j\_$one.p_o$i\[par3\:par4\].connect_by_name(c$k\_$zero.b$k\_$zero.a$k\_$zero.s_m$i);  // ifc.p.pspar---spar (PC)\n";
    }
#connect_by_name : ppar.pspar---spar (PC) and ifc.ppar.pspar---spar (SS) and sg.spar.pspar---ppar (PC)
    elsif($i > 200 && $i <= 250) {
	print FH "    p_m$i\[par1\:par2\].connect_by_name(a$k\_$two.s_z$i);  // ppar.pspar---spar (PC)\n";
	print FH "    c$k\_$zero.ifc$j\_$one.p_n$i\[par3\:par4\].connect_by_name(c$k\_$zero.a$k\_$one.s_c$i);  // ifc.ppar.pspar---spar (SS)\n";
	print FH "    sg$j\_$one.p_m$i\[par1\:par2\].connect_by_name(c$k\_$zero.b$k\_$zero.p_b$i);  // sg.spar.pspar---ppar (PC)\n";
    }
    print FH "  }\n";
    print FH "};\n\n";











}
