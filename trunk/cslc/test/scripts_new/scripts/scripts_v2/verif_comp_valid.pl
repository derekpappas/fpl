#!/usr/bin/perl

#oanab
#verif comp methods

use strict;

print "Generated tests path : test/csl_test_gen/verif_comp_valid/\n";

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
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "verif_comp".$i."_legal.csl";
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
    my $val1 = int(rand(20))+1;
    my $val2 = int(rand(100))+2;
    my $val3 = int(rand(100))+3;
    my $l = int(rand(3))+1;
    if($test_name=~/(_legal)/){
        &mkDir("$path/verif_comp_valid");
        open(FH,">$path/verif_comp_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/verif_comp_invalid"); 
        open(FH,">$path/verif_comp_invalid/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#sgk
    if($i > 50 && $i <= 100 || $i > 150 && $i <= 200) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal s_a$i;\n";
	print FH "  csl_signal s_b$i($val2);\n";
	print FH "  sg$k () {}\n";
	print FH "};\n\n";
    }
#sgk
    elsif($i > 250 && $i <= 300) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal s_x$i($val1);\n";
	print FH "  csl_signal s_y$i($val2);\n";
	print FH "  csl_signal s_z$i(1);\n";
	print FH "  sg$k () {}\n";
	print FH "};\n\n";
    }

#unit a
    print FH "csl_unit a$k {\n";
    print FH "  csl_port p$i($dir{$l},$val1);\n";
    if($i > 50 && $i <= 100) {
	print FH "  sg$k sg$k\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_port p_in(input,$val1);\n";
	print FH "  csl_port p_out(output,$val1);\n";
	print FH "  csl_port clk(input);\n";
    }
    print FH "  a$k () {\n";
    if($i > 200 && $i <= 250) {
	print FH "    clk.set_attr(clock);\n";
    }
    print FH "  }\n";
    print FH "};\n\n";
    

#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
    if($i > 100 && $i <= 200) {
	print FH "  csl_port p_in(input,$val1);\n";
	print FH "  csl_port p_out(output,$val1);\n";
	print FH "  csl_port clk(input);\n";
    }
    print FH "  b$k () {\n";
    if($i > 100 && $i <= 200) {
	print FH "    clk.set_attr(clock);\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    print FH "  b$k b$k\_$zero;\n";
    if($i <= 100 || $i > 250 && $i <= 300) {
	print FH "  csl_port p_in(input,$val2);\n";
	print FH "  csl_port p_out(output,$val2);\n";
	print FH "  csl_port clk(input);\n";
    }
    print FH "  c$k () {\n";
    if($i <= 100 || $i > 250 && $i <= 300) {
	print FH "    clk.set_attr(clock);\n";
    }
    print FH "  }\n";
    print FH "};\n\n";

#signals used by the set_vc.. commands
    if($i <= 50) {
	print FH "csl_signal clk(reg);\n";
	print FH "csl_signal s$i;\n\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "csl_signal rst;\n";
	print FH "csl_signal s_x$i;\n";
	print FH "csl_signal s_y$i;\n\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "csl_signal s$i;\n\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "csl_signal s_a$i;\n";
    }
    
    
#stim vector
    print FH "csl_vector stim_vect$k {\n";
    print FH "  stim_vect$k () {\n";
#sig
    if($i <= 50) {
	print FH "    set_unit_name(c$k);\n";
	print FH "    set_vc_clock(clk);  // sig as argument\n";
	print FH "    set_vc_stall(s$i); // sig as argument\n";
    }
#sg.sig
    elsif($i > 50 && $i <= 100) {
	print FH "    set_unit_name(c$k);\n";
	print FH "    set_vc_clock(sg$k.s_a$i);  // sg.sig as argument\n";
	print FH "    set_vc_compare_trigger(sg$k.s_a$i);  // sg.sig as argument\n";
    }
#sig
    elsif($i > 100 && $i <= 150) {
	print FH "    set_unit_name(b$k);\n";
	print FH "    set_vc_reset(rst);  // sig as argument\n";
    }
#sg.sig
    elsif($i > 150 && $i <= 200) {
	print FH "    set_unit_name(b$k);\n";
	print FH "    set_vc_stall(sg$k.s_a$i);  // sg.sig as argument\n";
    }
#sig
    elsif($i > 200 && $i <= 250) {
	print FH "    set_unit_name(a$k);\n";
	print FH "    set_vc_compare_trigger(s$i);  // sig as argument\n";
    }
#sig
    elsif($i > 250 && $i <= 300) {
	print FH "    set_unit_name(c$k);\n";
	print FH "    set_vc_start_generation_trigger(s_a$i);  // sig as argument\n";
    }
    print FH "    set_direction(input);\n";
    print FH "  }\n";
    print FH "};\n\n";
    

#exp vector
    print FH "csl_vector exp_vect$k {\n";
    print FH "  exp_vect$k () {\n";
    if($i <= 100) {
	print FH "    set_unit_name(c$k);\n";
    }
#sig expr
    elsif($i > 100 && $i <= 150) {
	print FH "    set_unit_name(b$k);\n";
	print FH "    set_vc_compare_trigger(s_x$i | s_y$i);  // sig expr as argument\n";
    }
#sg.sig
    elsif($i > 150 && $i <= 200) {
	print FH "    set_unit_name(b$k);\n";
	print FH "    set_vc_reset(sg$k.s_a$i);  // sg.sgi as argument\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    set_unit_name(a$k);\n";
    }
#sg.sig
    elsif($i > 250 && $i <= 300) {
	print FH "    set_unit_name(c$k);\n";
	print FH "    set_vc_end_generation_trigger(sg$k.s_z$i);  // sg.sig as argument\n";
    }
    print FH "    set_direction(output);\n";
    print FH "  }\n";
    print FH "};\n\n";
    

#testbench tb
    print FH "csl_testbench tb$k {\n";
    print FH "  csl_signal clk(reg);\n";
    if($i <= 100 ) {
	print FH "  c$k c$k\_$zero(.clk(clk));\n";
    }
    elsif($i > 100 && $i <= 200) {
	print FH "  b$k b$k\_$one(.clk(clk));\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  b$k b$k\_$one(.clk(clk));\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  a$k a$k\_$zero(.clk(clk));\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  c$k c$k\_$zero(.clk(clk));\n";
    }
    print FH "  tb$k () {\n";
    print FH "    clk.set_attr(clock);\n";
    print FH "    add_logic(clock,clk,10,ps);\n";
    print FH "  }\n";
    print FH "};\n\n";
    

}
