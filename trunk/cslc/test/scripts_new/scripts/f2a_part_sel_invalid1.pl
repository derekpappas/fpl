#!/usr/bin/perl

#oanab
#f2a with part select

use strict;

print "Generated tests path : test/csl_test_gen/f2a_part_sel_invalid1/\n";

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
    my $test_name = "f2a_part_sel".$i."_illegal.csl";
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
        &mkDir("$path/f2a_part_sel_valid");
        open(FH,">$path/f2a_part_sel_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/f2a_part_sel_invalid1"); 
        open(FH,">$path/f2a_part_sel_invalid1/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges and fields
    print FH "csl_bitrange br1($val1);\n";
    print FH "csl_bitrange f2($val2);\n";
    print FH "csl_bitrange f3($val3);\n";
    print FH "csl_bitrange br4(".($val2+$val3).");\n";
    print FH "csl_bitrange br5(".($val2+3*$val3).");\n\n";


#ifck
    if($i <= 50 || $i > 150 && $i <= 200) {
	print FH "csl_interface ifc$k {\n";
	print FH "  csl_port p_a$i(input,f3);\n";
	print FH "  csl_port p_b$i(output,br2);\n";
	print FH "  csl_port p_c$i(output,br4);\n";
	print FH "  csl_port p_d$i(input,br1);\n";
	print FH "  ifc$k () {}\n";
	print FH "};\n\n";
    }

#sgk
    if($i <= 100 || $i > 200 && $i <= 300) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal s_a$i(f2);\n";
	print FH "  csl_signal s_b$i(br2);\n";
	print FH "  csl_signal s_c$i($val2);\n";
	print FH "  csl_signal s_d$i(br4);\n";
	print FH "  sg$k () {}\n";
	print FH "};\n\n";
    }

#sgm
    if($i > 50 && $i <= 100) {
	print FH "csl_signal_group sg$m {\n";
	print FH "  csl_signal s_x$i(f2);\n";
	print FH "  csl_signal s_y$i(f3);\n";
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  sg$k sg$k\_$one;\n";
	print FH "  sg$m () {}\n";
	print FH "};\n\n";
    }

#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_signal s_a$i(br4);\n";
	print FH "  sg$k sg$k\_$one;\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  sg$m sg$m\_$zero;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_y$i($dir{$l},".($val3+2*$val1).");\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_a$i($dir{$l},".(2*$val3).");\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_signal s_x$i($val1);\n";
	print FH "  csl_signal s_y$i(br3);\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  csl_signal s_x$i(br4);\n";
    }
    print FH "  a$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
#f2a : Invalid formal : s.ps---port, Invalid formal : sg.s.ps---port
    if($i <= 50) {
	print FH "  csl_port p_a$i(input,".($val2+1).");\n";
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  a$k a$k\_$one(.s_a$i\[".($val2+$val3)."\:".$val3."\](p_a$i));   // Invalid formal : s.ps---port\n";
	print FH "  a$k a$k\_$two(.sg$k\_$one.s_d$i\[".($val2+$val3)."\-\:".$val3."\](p_x$i));   // Invalid formal : sg.s.ps---port\n";
    }
#f2a : Invalid formal : sg.sg.s.ps---sg
    elsif($i > 50 && $i <= 100) {
	print FH "  sg$k sg$k\_$zero;\n";
	print FH "  csl_port p_x$i($dir{$l},".($val1+$val2).");\n";
	print FH "  a$k a$k\_$one(.sg$m\_$zero.sg$k\_$zero.s_a$i\[3\](sg$k\_$zero));   // Invalid formal : sg.sg.s.ps---sg\n";
    }
#f2a : Invalid formal : p.ps---port
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_z$i(output,".($val2-1).");\n";
	print FH "  csl_port p_a$i(input,br4);\n";
	print FH "  a$k a$k\_$one(.p_a$i\[3\](p_z$i));  // Invalid formal : p.ps---port\n";
    }
#f2a : Invalid formal : op expr---sig
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_signal s_m$i(f2);\n";
	print FH "  csl_signal s_n$i(f3);\n";
	print FH "  a$k a$k\_$one(.(~p_a$i\[".(2*$val3)."\-\:".$val3."\])(s_n$i));  // Invalid formal : op expr---sig\n";
    }
#f2a : Invalid formal : concat expr---port, Invalid formal : concat expr---sg 
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_port p_a$i(input,f3);\n";
	print FH "  sg$k sg$k\_$one;\n";
	print FH "  a$k a$k\_$one(.{s_x$i\[2\],s_y$i\[3\]}(p_a$i));  // Invalid formal : concat expr---port\n";
	print FH "  a$k a$k\_$two(.{s_x$i\[2\],s_y$i\[".$val3."\-\:".(3)."\]}(sg$k\_$one));  //Invalid formal :  concat expr---sg\n";
    }
#f2a : Invalid formal : repl expr---sig
    elsif($i > 250 && $i <= 300) {
	print FH "  csl_signal s_y$i(".(3*$val2).");\n";
	print FH "  a$k a$k\_$two(.{3{s_x$i\[".($val2+$val3)."\:".$val3."\]}}(s_y$i));  // Invalid formal : repl expr---sig\n";
    }
    print FH "  b$k () {\n";
#Invalid assign (different widths) : p.ps---port
    if($i > 100 && $i <= 150) {
	print FH "    p_a$i\[".($val2+$val3)."\-\:".$val2."\] = p_z$i;  // Invalid assign (different widths) : p.ps---port\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    print FH "  b$k b$k\_$zero;\n";
#f2a : Invalid formal and connection : s.ps---ifc, Invalid formal : sg.s.ps---port
    if($i <= 50) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  csl_port p_x$i(input,br3);\n";
	print FH "  a$k a$k\_$two(.s_a$i\[".($val2+$val3)."\:".$val3."\](ifc$k\_$zero));   // Invalid formal and connection : s.ps---ifc\n";
	print FH "  b$k b$k\_$one(.sg$k\_$zero.s_d$i\[".($val2+$val3)."\:".$val2."\](p_x$i));   // Invalid formal : sg.s.ps---port\n";
    }
#f2a : Invalid formal : p.ps---port
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_port p_y$i(input,br1);\n";
	print FH "  b$k b$k\_$one(.p_x$i\[".($val1+$val2)."\-\:".$val1."\](p_y$i));   // Invalid formal : p.ps---port\n";
    }
#f2a : Invalid formal : p.ps---sig
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_signal s_x$i(f3);\n";
	print FH "  csl_port p_m$i($dir{$l},br4);\n";
	print FH "  b$k b$k\_$one(.a$k\_$zero.p_y$i\[".($val3+2*$val1)."\:".(2*$val1)."\](s_x$i),.p_m$i\[4\](s_x$i));  // Invalid formal : p.ps---sig\n";
    }
#f2a : Invalid formal and connection : op expr---ifc
    elsif($i > 150 && $i <= 200) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  b$k b$k\_$two(.(s_m$i\[".$val2."\:".($val2-1)."\] & s_n$i\[".$val3."\:".($val3-3)."\])(ifc$k\_$zero));   // Invalid formal and connection : op expr---ifc\n";
    }
#f2a : Invalid formal and connection : concat expr---sig (with nums)
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_signal s_z$i(f2);\n";
	print FH "  b$k b$k\_$one(.{1`b1,2`b10}(s_z$i));  // Invalid formal and connection : concat expr---sig\n";
    }
#f2a : Invalid formal : repl expr---port
    elsif($i > 250 && $i <= 300) {
	print FH "  csl_port p_x$i(input,".(2*$val2+2*$val3).");\n";
	print FH "  a$k a$k\_$one(.{2{sg$k\_$zero.s_a$i\[".($val2-1)."\-\:".(2)."\],s_b$i}})(p_x$i));  // Invalid formal : repl expr---port\n";
    }
    print FH "  c$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";











}
