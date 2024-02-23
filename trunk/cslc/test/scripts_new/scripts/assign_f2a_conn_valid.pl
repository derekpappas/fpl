#!/usr/bin/perl

#oanab
#assign, f2a and connect methods combined with part select [:] form

use strict;

print "Generated tests path : test/csl_test_gen/assign_f2a_conn_valid/\n";

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

foreach(my $i = 1; $i <= 200; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "assign_f2a_conn".$i."_legal.csl";
   	&createCslFile($test_name, $i, %dir);
}

sub createCslFile {
    my ($test_name, $i, %dir) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $k = int(rand(20)) + int(rand(20));
    my $zero = 0;
    my $one = 1;
    my $two = 2;
    my $tre = 3;
    my $val1 = int(rand(20)) + 2;
    my $val2 = int(rand(100)) + 3;
    my $val3 = int(rand(100)) + 4;
    my $l = int(rand(3))+1;
    my $m = $k + int(rand(10)) + 1;
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_f2a_conn_valid");
        open(FH,">$path/assign_f2a_conn_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_f2a_conn_invalid"); 
        open(FH,">$path/assign_f2a_conn_invalid/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges
    print FH "csl_bitrange br1($val1);\n";
    print FH "csl_bitrange br2($val2);\n";
    print FH "csl_bitrange br3($val3);\n";
    print FH "csl_bitrange br4(".($val2+$val3).");\n";
    print FH "csl_bitrange br5(".($val1+$val3).");\n";
    print FH "csl_bitrange br6(".($val2+$val1).");\n\n";


#ifc k
    if($i > 50 && $i <= 150) {
	print FH "csl_interface ifc$k {\n";
	print FH "  csl_port p_a$i(input,br2);\n";
	print FH "  csl_port p_b$i(output,br4);\n";
	print FH "  csl_port p_c$i(input,br6);\n";
	print FH "  ifc$k () {}\n";
	print FH "};\n\n";
    }

#sg k
    if($i > 50 && $i <= 100) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal p_a$i(br2);\n";
	print FH "  csl_signal p_b$i(br4);\n";
	print FH "  csl_signal p_c$i(br6);\n";
	print FH "  sg$k () {}\n";
	print FH "};\n\n";
    }
 
#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_x$i(input,br4);\n";
	print FH "  csl_port p_y$i(output,".(2*$val1+$val2+$val3).");\n";
	print FH "  csl_signal s_x$i(".($val2+$val3+$val1).");\n";
    }  
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_port p_a$i($dir{$l},br2);\n";
	print FH "  csl_signal s_a$i(".($val2+$val1).");\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  csl_signal s_b$i(br3);\n";
	print FH "  csl_parameter par_a$i(".($val1).");\n";
	print FH "  csl_port p_a$i(input,par_a$i);\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_x$i(input,".(3*$val1+3*$val2).");\n";
	print FH "  csl_signal s_m$i(".(2*$val2+$val3).");\n";
	print FH "  csl_signal s_n$i(br5);\n";
    }
    print FH "  a$k () {\n";
#assign between sig.ps and port
    if($i <= 50) {
	print FH "    s_x$i\[".($val2+$val3+$val1-1)."\:".($val1)."\] = p_x$i;  // assign between sig.ps and port\n";    
    }
#assign between ifc.p.ps and sig
    elsif($i > 100 && $i <= 150) {
	print FH "    ifc$k\_$zero.p_b$i\[".($val2+$val3-1)."\:".($val2)."\] = s_b$i;  // assign between ifc.p.ps and sig\n";
    }
#assign between port and repl expr
    elsif($i > 150 && $i <= 200) {
	print FH "    p_x$i = {3{s_m$i\[".(2*$val2+$val3-1)."\:".($val2+$val3)."\],s_n$i\[".($val3+$val1-1)."\:".($val3)."\]}};  // assign between port and repl expr\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    if($i <= 50) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_signal s_y$i(".(2*$val1+$val2+$val3).");\n";
	print FH "  csl_parameter par_s$i(".(2*$val1+$val2+$val3).");\n";
	print FH "  csl_signal s_m$i(par_s$i);\n";
#f2a : port---sig.ps
	print FH "  a$k a$k\_$one(.p_x$i(s_y$i\[".($val1+$val2+$val3-1)."\:".($val1)."\]),.p_y$i(s_m$i));  // f2a : port---sig.ps, port---spar\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s_a$i(br6);\n";
	print FH "  csl_signal s_b$i(br4);\n";
	print FH "  csl_port p_x$i(input,".($val2+$val1).");\n";
#f2a : port---concat expr
	print FH "  a$k a$k\_$one(.p_a$i({s_a$i\[".($val1+$val2-1)."\:".($val1+1)."\],s_b$i\[".(3)."\]}));  // f2a : port---concat expr\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  a$k a$k\_$zero(.p_a$i(s_m$i));  // f2a : ppar---sig\n";
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  csl_signal s_a$i(".($val1+$val2).");\n";
	print FH "  csl_signal s_m$i(br1);\n";
#f2a : ifc---ifc,port---sig.ps
	print FH "  a$k a$k\_$one(.ifc$k\_$zero(ifc$k\_$zero),.p_a$i(s_a$i\[".($val2+$val1-1)."\:".($val2)."\]));  // f2a : ifc---ifc,port---sig.ps\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_signal s_x$i(".($val2+$val3+3*$val1).");\n";
	print FH "  csl_signal s_y$i(".(2*$val2+2*$val1).");\n";
	print FH "  csl_port p_m$i(output,br3);\n";
    }
    print FH "  b$k () {\n";
#connect_by_name : sig---port (PC)
    if($i <= 50) {
	print FH "    s_y$i.connect_by_name(a$k\_$zero.p_y$i);  // connect_by_name : sig---port (PC)\n";
    }
#connect_by_name : port---concat expr (CP)
    elsif($i > 150 && $i <= 200) {
	print FH "    a$k\_$zero.p_x$i.connect_by_name({s_x$i\[".(3*$val1+$val2-1)."\:".(2*$val1)."\],s_y$i});  // connect_by_name : port---concat expr (CP)\n";
    }
    print FH "  }\n";
    print FH "};\n\n";
    
    
#unit c
    print FH "csl_unit c$k {\n";
    if($i <= 50) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_port p_x$i(input,".($val2+$val3).");\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  csl_port p_x$i(input,".($val2+$val3+$val1).");\n";
#f2a : port---p.ps
	print FH "  b$k b$k\_$one(.p_x$i(p_x$i\[".($val2+$val3+$val1-1)."\:".($val3)."\]));  // f2a : port---p.ps\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  b$k b$k\_$zero(.ifc$k\_$zero(ifc$k\_$zero));\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  b$k b$k\_$zero(.p_m$i(s_y$i));\n";
	print FH "  csl_signal s_m$i(".($val2+2*$val1+$val3).");\n";
	print FH "  csl_signal s_x$i(".(2*$val1+$val3).");\n";
	print FH "  csl_signal s_y$i(br3);\n";
	print FH "  csl_port p_m$i(output,br3);\n";
#f2a : port---op expr
	print FH "  b$k b$k\_$one(.p_m$i(s_x$i\[".(2*$val1+$val3-1)."\:".(2*$val1)."\] & s_y$i));  // f2a : port---op expr\n";
    }
    print FH "  c$k () {\n";
#connect_by_name : port---sig.ps (PC)
    if($i <= 50) {
	print FH "    p_x$i.connect_by_name(b$k\_$zero.s_y$i\[".($val1+$val2+$val3)."\:".($val1+1)."\]);  // connect_by_name : port---sig.ps (PC)\n";
    }
#connect_by_pattern : ifc.port---sig (PC)
    elsif($i > 50 && $i <= 100) {
	print FH "    ifc$k\_$zero.p_c$i.connect_by_pattern(a$k\_$one.s_a$i);  // connect_by_pattern : ifc.port---sig (PC)\n";
	print FH "    ifc$k\_$zero = sg$k\_$zero;  // assign : sg---ifc\n";
    }
#connect_units (PC)
    elsif($i > 100 && $i <= 150) {
	print FH "    b$k\_$zero.connect_units(b$k\_$zero.a$k\_$zero);  // connect_units (PC)\n";
    }
#assign between sig.ps and port
    elsif($i > 150 && $i <= 200) {
	print FH "    s_m$i\[".($val3+$val2+$val1-1)."\:".($val2+$val1)."\] = p_m$i;  // assign between sig.ps and port\n";
    }
    print FH "  }\n";
    print FH "};\n\n";











}