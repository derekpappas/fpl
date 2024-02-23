#!/usr/bin/perl

#oanab
#assign with part select

use strict;

print "Generated tests path : test/csl_test_gen/assign_part_sel_invalid6/\n";

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
    my $test_name = "assign_part_sel".$i."_illegal.csl";
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
        &mkDir("$path/assign_part_sel_valid");
        open(FH,">$path/assign_part_sel_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/assign_part_sel_invalid6"); 
        open(FH,">$path/assign_part_sel_invalid6/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges and fields
    print FH "csl_bitrange br1($val1);\n";
    print FH "csl_bitrange br2($val2);\n";
    print FH "csl_bitrange br3($val3);\n";
    print FH "csl_bitrange br4(".($val2+$val3).");\n";
    print FH "csl_bitrange f5(".($val1+$val2+$val3).");\n\n";

#ifc k
    if($i > 100 && $i <= 150) {
	print FH "csl_interface ifc$k {\n";
	print FH "  csl_port p_a$i(input,br3);\n";
	print FH "  csl_port p_b$i(output,br2);\n";
	print FH "  csl_port p_c$i(input,br1);\n";
	print FH "  csl_port p_d$i(output,br4);\n";
	print FH "  ifc$k () {}\n";
	print FH "};\n\n";
    }
    

#ifc m
    if($i > 100 && $i <= 150) {
	print FH "csl_interface ifc$m {\n";
	print FH "  csl_port p_x$i(input,br3);\n";
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  ifc$k ifc$k\_$one;\n";
	print FH "  ifc$k ifc$k\_$two;\n";
	print FH "  ifc$m () {}\n";
	print FH "};\n\n";
    }

#sg k
    if($i <= 200) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal s_a$i(br2);\n";
	print FH "  csl_signal s_b$i(br3);\n";
	print FH "  csl_signal s_c$i($val2);\n";
	print FH "  csl_signal s_d$i(br4);\n";
	print FH "  sg$k () {}\n";
	print FH "};\n\n";
    }
    

#sg m
    if($i <= 150) {
	print FH "csl_signal_group sg$m {\n";
	print FH "  csl_signal s_x$i(br2);\n";
	print FH "  csl_signal s_y$i(br3);\n";
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  sg$k sg$k\_$one;\n";
	print FH "  sg$m () {}\n";
	print FH "};\n\n";
    }

    
#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 100) {
	print FH "  csl_signal s_x$i(".(2*$val2).");\n";
	print FH "  csl_port p_a$i(input,br4);\n";
	print FH "  csl_port p_b$i(input,br1);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  sg$m sg$m\_$zero;\n";
	print FH "  csl_signal s_x$i(br3);\n";
	print FH "  csl_signal s_y$i(f5);\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_signal s_x$i(br3);\n";
	print FH "  csl_port p_a$i(input,br4);\n";
	print FH "  csl_port p_b$i(input,br1);\n";
    }
    print FH "  a$k () {\n";
#Invalid assign between repl expr and sig
    if($i <= 50) {
	print FH "    {2{p_a$i\[".($val2+$val3)."\:".($val3+2)."\],p_b$i\[2\]}} = s_x$i;  // Invalid assign between repl expr and sig\n";
    }
#Invalid assign between repl expr and sig
    elsif($i > 50 && $i <= 100) {
	print FH "    {3{p_a$i\[".($val2+$val3)."\:".($val2+2)."\],p_b$i\[1\]}} = s_x$i\[".(2*$val2)."\-\:".($val2)."\];  // Invalid assign between repl expr and sig\n";
    }
#Invalid assign between repl expr and sg.sg
    elsif($i > 100 && $i <= 150) {
	print FH "    {3{s_x$i\[4\],s_y$i\[".($val1+$val2)."\:".($val1)."\]}} = sg$m\_$zero.sg$k\_$zero;  // Invalid assign between repl expr and sg.sg\n";
    }
#Invalid assign between concat expr and sig
    elsif($i > 150 && $i <= 200) {
	print FH "    {p_a$i\[".($val2+$val3)."\-\:".($val3-1)."\],p_b$i\[2\]} = s_x$i;  // Invalid assign between concat expr and sig\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
    if($i <= 50) {
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  csl_signal s_x$i(br3);\n";
	print FH "  csl_signal s_y$i(".($val1+$val2).");\n";
    }
    elsif($i > 50 && $i <= 150) {
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  csl_port p_a$i(input,br4);\n";
	print FH "  csl_port p_b$i(input,".($val1+1).");\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  sg$k sg$k\_$one;\n";
	print FH "  csl_signal s_a$i(br4);\n";
	print FH "  csl_signal s_b$i(".($val1+$val3).");\n";
    }
    print FH "  b$k () {\n";
#Invalid assign between repl expr and sg.sig
    if($i <= 50) {
	print FH "    {2{s_x$i\[3\],s_y$i\[".($val1+$val2)."\-\:".($val1)."\]}} = sg$k\_$zero.s_c$i;  // Invalid assign between repl expr and sg.sig\n";
    }
#Invalid assign between repl expr and sg.sig.ps
    elsif($i > 50 && $i <= 100) {
	print FH "    {2{p_a$i\[".($val2+$val3)."\],p_b$i\[1\]}} = sg$k\_$zero.s_d$i\[".($val2+$val3)."\:".($val2+3)."\];  // Invalid assign between repl expr and sg.sig.ps\n";
    }
#Invalid assign between repl expr and sg
    elsif($i > 100 && $i <= 150) {
	print FH "    {2{p_a$i\[".($val2+$val3)."\:".($val2)."\],p_b$i\[".($val1)."\]}} = sg$k\_$zero;  // Invalid assign between repl expr and sg\n";
    }
#Invalid assign between concat expr and sg.sig
    elsif($i > 150 && $i <= 200) {
	print FH "    {s_a$i\[".(1)."\:".(0)."\],s_b$i\[".($val1+$val3)."\:".($val1+1)."\]} = sg$k\_$one.s_b$i;  // Invalid assign between concat expr and sg.sig\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    print FH "  b$k b$k\_$zero;\n";
    if($i <= 50) {
	print FH "  sg$m sg$m\_$zero;\n";
	print FH "  csl_signal s_a$i(br4);\n";
	print FH "  csl_signal s_b$i(".($val3+2*$val2).");\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  sg$m sg$m\_$one;\n";
	print FH "  csl_signal s_x$i(".(2*$val2+3*$val1).");\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  ifc$m ifc$m\_$one;\n";
	print FH "  csl_signal s_a$i(br2);\n";
	print FH "  csl_signal s_b$i(".($val3+2*$val2+3).");\n";
	print FH "  csl_signal s_c$i(".(2*$val1+3*$val3).");\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_signal s_m$i(".(2*$val1+3*$val3).");\n";
	print FH "  csl_signal s_x$i(".($val3+2*$val2).");\n";
	print FH "  csl_signal s_y$i(br2);\n";
    }
    print FH "  c$k () {\n";
#Invalid assign between repl expr and sg.sg.sig
    if($i <= 50) {
	print FH "    {2{s_a$i\[".($val2+$val3)."\:".($val3)."\],s_b$i\[".($val3+2*$val2)."\:".($val3+$val2)."\]}} = sg$m\_$zero.sg$k\_$zero.s_b$i;  // Invalid assign between repl expr and sg.sg.sig\n";
    }
#Invalid assign between repl expr and sg.sg.sig.ps
    elsif($i > 50 && $i <= 100) {
	print FH "    {3{s_x$i\[1\]}} = sg$m\_$one.sg$k\_$zero.s_a$i\[2\];  // Invalid assign between repl expr and sg.sg.sig.ps\n";
    }
#Invalid assign between repl expr and ifc, repl expr and ifc.ifc
    elsif($i > 100 && $i <= 150) {
	print FH "    {3{s_a$i\[3\],s_c$i\[".(2*$val1+2*$val3)."\:".(2*$val2)."\]}} = ifc$k\_$zero;  // Invalid assign between repl expr and ifc\n";
	print FH "    {2{s_c$i\[".(2*$val1+3*$val3)."\-\:".(3*$val1)."\],s_b$i\[".($val3+2*$val2)."\:".($val2)."\]}} = ifc$m\_$one.ifc$k\_$one; // Invalid assign between repl expr and ifc.ifc\n";
    }
#Invalid assign between concat expr and sig.ps
    elsif($i > 150 && $i <= 200) {
	print FH "    {s_x$i\[".($val3+2*$val2)."\:".(2*$val2+3)."\],s_y$i\[3\]} = s_m$i\[".($val1+2*$val3)."\:".($val1+$val3+1)."\];  // Invalid assign between concat expr and sig.ps\n";
    }
    print FH "  }\n";
    print FH "};\n\n";











}
