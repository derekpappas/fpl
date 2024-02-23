#!/usr/bin/perl

#oanab
#connect_by_name() method with part select

use strict;

print "Generated tests path : test/csl_test_gen/ar_conn_name_ps_valid/\n";

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

foreach(my $i = 1; $i <= 300; $i++) {
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
    my $test_name = "ar_conn_name_ps".$i."_legal.csl";
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
    my $val1 = int(rand(100)) + 4;
    my $val2 = int(rand(100)) + 3;
    my $val3 = int(rand(100)) + 8;
    my $l = int(rand(3))+1;
    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_conn_name_ps_valid");
        open(FH,">$path/ar_conn_name_ps_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ar_conn_name_ps_invalid"); 
        open(FH,">$path/ar_conn_name_ps_invalid/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";


#ifcj
    if($i > 100 && $i <= 250) {
	print FH "csl_interface ifc$j {\n";
	print FH "  csl_port p_m$i(input,br1);\n";
	print FH "  csl_port p_n$i(output,br3);\n";
	print FH "  csl_port p_o$i(input,br2);\n";
	print FH "  ifc$j () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#ifcm
    if($i > 150 && $i <= 250) {
	print FH "csl_interface ifc$m {\n";
	print FH "  csl_port p_x$i(input,br2);\n";
	print FH "  ifc$j ifc$j\_$zero;\n";
	print FH "  ifc$j ifc$j\_$one;\n";
	print FH "  ifc$m () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#sgj
    if($i > 150) {
	print FH "csl_signal_group sg$j {\n";
	print FH "  csl_signal s_a$i($val2);\n";
	print FH "  csl_signal s_b$i(br1);\n";
	print FH "  csl_signal s_c$i(br3);\n";
	print FH "  csl_signal s_d$i(".($val1+2*$val2).");\n";
	print FH "  sg$j () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#sgm
    if($i > 200 && $i <= 250) {
	print FH "csl_signal_group sg$m {\n";
	print FH "  sg$j sg$j\_$zero;\n";
	print FH "  sg$j sg$j\_$one;\n";
	print FH "  sg$m () {\n";
	print FH "  }\n";
	print FH "};\n\n";
    }


#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_b$i(input,br2);\n";
	print FH "  csl_port p_a(inout,2);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s_x$i(".($val2+$val3).");\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_m$i(input,1);\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_signal s_x$i(".($val2).");\n";
	print FH "  csl_signal s_y$i(".($val3).");\n";
	print FH "  ifc$m ifc$m\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_port p_n$i($dir{$l},1);\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  sg$j sg$j\_$zero;\n";
    }
    print FH "  a$k () {\n";
    if($i > 150 && $i <= 200) {
	print FH "    s_x$i\[".($val2-1)."\:".($val2-1)."\] = s_y$i\[".($val3-1)."\-\:".(1)."\];  // assign : s.ps---s.ps\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "    sg$j\_$zero.s_a$i\[".($val2-1)."\-\:".(1)."\] = sg$j\_$zero.s_c$i\[".($val3-1)."\];  // assign : sg.s.ps---sg.s.ps\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit b
    print FH "csl_unit b$k {\n";
    if($i <= 50) {
	print FH "  a$k a$k\_$zero;\n";
    }
    if($i > 50 && $i <= 100) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_port p_x$i(input,$val2);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  ifc$j ifc$j\_$zero;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  sg$j sg$j\_$zero;\n";
	print FH "  ifc$j ifc$j\_$one;\n";
	print FH "  a$k a$k\_$zero(.ifc$m\_$zero.ifc$j\_$zero(ifc$j\_$one),.ifc$m\_$zero.ifc$j\_$one(ifc$j\_$one));\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_port p_b$i(input,".($val1+$val2+$val3).");\n";
    }
    print FH "  b$k () {\n";
    if($i > 150 && $i <= 200) {
	print FH "    sg$j\_$zero.s_d$i\[".($val1+$val2)."\-\:".($val1+1)."\] = {sg$j\_$zero.s_b$i,sg$j\_$zero.s_c$i\[".($val3-1)."\]};  // assign : sg.sig---concat\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit c
    print FH "csl_unit c$k {\n";
    if($i <= 50) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_port p_c$i(inout,4);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  b$k b$k\_$zero;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  b$k b$k\_$zero(.ifc$j\_$zero.p_m$i(s_n$i\[".($val3+$val1-1)."\:".($val3)."\]),.ifc$j\_$zero.p_o$i(s_o$i));\n";
	print FH "  csl_signal s_n$i(".($val3+$val1).");\n";
	print FH "  csl_signal s_o$i(".($val2).");\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  b$k b$k\_$zero(.ifc$j\_$one(ifc$j\_$two));\n";
	print FH "  ifc$j ifc$j\_$two;\n";
	print FH "  sg$j sg$j\_$one;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  a$k a$k\_$one;\n";
	print FH "  sg$m sg$m\_$zero;\n";
	print FH "  ifc$m ifc$m\_$zero;\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_port p_c$i(input,".($val2+$val3).");\n";
    }
    print FH "  c$k () {\n";
#connect_by_name : port---p.ps (PC)
    if($i <= 50) {
	print FH "    p_c$i.connect_by_name(b$k\_$zero.a$k\_$zero.p_b$i\[".($val2-1)."\:".($val2-4)."\]);  // port---p.ps (PC)\n";
    }
#connect_by_name : port---sig.ps (PC)
    elsif($i > 50 && $i <= 100) {
	print FH "    b$k\_$zero.p_x$i.connect_by_name(b$k\_$zero.a$k\_$zero.s_x$i\[".($val2+$val3-3)."\-\:".($val2)."\],pa_$i);  // port---sig.ps (PC)\n";
    }
#connect_by_name : ifc.p---sig.ps (CP)
    elsif($i > 100 && $i <= 150) {
	print FH "    b$k\_$zero.ifc$j\_$zero.p_n$i.connect_by_name(s_n$i\[".($val3+$val1-1)."\:".($val1)."\],p_$i);  // ifc.p---sig.ps (CP)\n";
	print FH "    b$k\_$zero.a$k\_$zero.p_m$i.connect_by_name(s_o$i\[".($val2-1)."\-\:".(1)."\]);  // port---sig (CP)\n";
    }
#connect_by_name : ifc.p---sg.sig.ps (CP)
    elsif($i > 150 && $i <= 200) {
	print FH "    sg$j\_$one.s_d$i\[".($val1+2*$val2-1)."\:".(2*$val2-1)."\] = {sg$j\_$one.s_b$i,sg$j\_$one.s_c$i\[".($val3-1)."\:".($val3-1)."\]};  // assign : sg.sig---concat\n";
	print FH "    b$k\_$zero.a$k\_$zero.ifc$m\_$zero.p_x$i.connect_by_name(b$k\_$zero.sg$j\_$zero.s_a$i\[".($val2-1)."\-\:".($val2)."\],p_$i);  // ifc.p---sg.sig.ps (CP)\n";
    }
#connect_by_name : port---sg.sg.sig.ps (CP)
    elsif($i > 200 && $i <= 250) {
	print FH "    sg$m\_$zero.sg$j\_$zero.s_d$i\[".($val1+$val2)."\-\:".($val2+1)."\] = {sg$m\_$zero.sg$j\_$zero.s_a$i,sg$m\_$zero.sg$j\_$zero.s_c$i\[".($val3-1)."\]};  // assign : sg.sg.sig---concat\n"; 
	print FH "    sg$m\_$zero.sg$j\_$one.s_d$i\[".($val1+2*$val2-1)."\:".($val1+$val2-1)."\] = {sg$m\_$zero.sg$j\_$one.s_a$i,sg$m\_$zero.sg$j\_$one.s_c$i\[".($val3-1)."\:".($val3-1)."\]};  // assign : sg.sg.sig---concat\n";
	print FH "    a$k\_$one.p_n$i.connect_by_name(sg$m\_$zero.sg$j\_$one.s_b$i\[".($val1-2)."\],p_b$i);  // port---sg.sg.sig.ps (CP)\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#unit d
    print FH "csl_unit d$k {\n";
    if($i <= 50) {
	print FH "  c$k c$k\_$zero(.p_c$i(p_d$i\[".($val1-1)."\-\:".(4)."\]));\n";
	print FH "  csl_port p_d$i(input,$val1);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  c$k c$k\_$zero;\n";
	print FH "  csl_signal s_y$i(".($val2+$val1).");\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  c$k c$k\_$zero;\n";
	print FH "  ifc$j ifc$j\_$one;\n";
	print FH "  b$k b$k\_$one(.ifc$j\_$zero(ifc$j\_$one));\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  c$k c$k\_$zero(.ifc$j\_$two(ifc$j\_$tre));\n";
	print FH "  ifc$j ifc$j\_$tre;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  c$k c$k\_$zero(.ifc$m\_$zero(ifc$m\_$one));\n";
	print FH "  ifc$m ifc$m\_$one;\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  c$k c$k\_$zero;\n";
	print FH "  a$k a$k\_$one;\n";
	print FH "  b$k b$k\_$one;\n";
    }
    print FH "  d$k () {\n";
#connect_by_name : port---p.ps (CP)
    if($i <= 50) {
	print FH "    c$k\_$zero.b$k\_$zero.a$k\_$zero.p_a.connect_by_name(p_d$i\[".($val1-1)."\-\:".(2)."\]);  // port---p.ps (CP)\n";
    }
#connect_by_name : port---sig.ps (CP)
    elsif($i > 50 && $i <= 100) {
	print FH "    c$k\_$zero.b$k\_$zero.p_x$i.connect_by_name(s_y$i\[".($val2+$val1-1)."\:".($val1)."\]);  //  port---sig.ps (CP)\n";
    }
#connect_by_name : port---ifc.p.ps (CP)
    elsif($i > 100 && $i <= 150) {
print FH "    b$k\_$one.a$k\_$zero.p_m$i.connect_by_name(ifc$j\_$one.p_m$i\[".($val1-1)."\-\:".(1)."\]);  // port---ifc.p.ps (CP)\n";	
    }
#connect_by_name : ifc.p---sig.ps (PC)
    elsif($i > 150 && $i <= 200) {
	print FH "    ifc$j\_$tre.p_o$i.connect_by_name(c$k\_$zero.sg$j\_$one.s_a$i\[".($val2-1)."\:".(0)."\]);  // ifc.p---sig.ps (PC)\n";
    }
#connect_by_name : ifc.p---sg.sg.sig.ps (PC)
    elsif($i > 200 && $i <= 250) {
	print FH "    ifc$m\_$one.ifc$j\_$one.p_m$i.connect_by_name(c$k\_$zero.sg$m\_$zero.sg$j\_$zero.s_b$i\[".($val1-1)."\-\:".($val1)."\]);  // ifc.p---sg.sg.sig.ps (PC)\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "    a$k\_$one.sg$j\_$zero.s_b$i.connect_by_name(b$k\_$one.p_b$i\[".($val1+$val3-1)."\:".($val3)."\]);\n";
	print FH "    c$k\_$zero.p_c$i\[".($val2+$val3-1)."\:".($val3)."\].connect_by_name(a$k\_$one.sg$j\_$zero.s_d$i\[".($val1+2*$val2-1)."\-\:".($val2)."\]);\n";
    }
    print FH "  }\n";
    print FH "};\n\n";





















}
