#!/usr/bin/perl

#oanab
#f2a with part select [-:] form

use strict;

print "Generated tests path : test/csl_test_gen/f2a_part_sel_valid4/\n";

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
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "f2a_part_sel".$i."_legal.csl";
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
        &mkDir("$path/f2a_part_sel_valid4");
        open(FH,">$path/f2a_part_sel_valid4/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/f2a_part_sel_invalid1"); 
        open(FH,">$path/f2a_part_sel_invalid1/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#bitranges
    print FH "csl_bitrange br1($val1);\n";
    print FH "csl_bitrange br2($val2);\n";
    print FH "csl_bitrange br3($val3);\n";
    print FH "csl_bitrange br4(".($val2+$val3).");\n";
    print FH "csl_bitrange br5(".($val2+$val1).");\n";
    print FH "csl_bitrange br6(".($val1+$val3).");\n\n";

#fields 
    print FH "csl_field f1($val1);\n";
    print FH "csl_field f6(".($val1+$val3).");\n\n";

    
#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_x$i($dir{$l},br2);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_port p_a$i($dir{$l},f1);\n";
	print FH "  csl_port p_b$i($dir{$l},$val3);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_x$i($dir{$l},br3);\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_m$i(output,".(2*($val2+$val3)).");\n";
	print FH "  csl_port p_n$i(input,".(2*$val3+2*$val1).");\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_port p_a$i($dir{$l},br2);\n";
    }
    print FH "  a$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    if($i <= 50) {
	print FH "  csl_signal s_a$i($val2);\n";
	print FH "  csl_signal s_b$i(br4);\n";
	print FH "  csl_port p_y$i($dir{$l},br3);\n";
#f2a : port---op expr
	print FH "  a$k a$k\_$one(.p_x$i(s_a$i\[".($val2-1)."\-\:".($val2)."\] | s_b$i\[".($val2+$val3-1)."\-\:".($val2)."\]));   // f2a : port---op expr\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s_x$i($val2);\n";
	print FH "  csl_signal s_y$i(f1);\n";
	print FH "  csl_signal s_z$i(br4);\n";
	print FH "  csl_port p_m$i(input,$val1);\n";
#f2a : port---concat expr
	print FH "  a$k a$k\_$one(.p_a$i({s_x$i\[1\:0\],s_y$i\[".($val1-1)."\-\:".($val1-2)."\]}),.p_b$i({s_x$i\[2\],s_z$i\[".($val2+$val3-1)."\:".($val2+1)."\]}));   // f2a : port---concat expr\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_m$i(output,br4);\n";
	print FH "  csl_port p_n$i($dir{$l});\n";
#f2a : port---p.ps
	print FH "  a$k a$k\_$one(.p_x$i(p_m$i\[".($val2+$val3-1)."\-\:".($val3)."\]));   // f2a : port---p.ps\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_z$i(inout,".(2*$val2+$val1+2*$val3).");\n";
	print FH "  csl_signal s_n$i(".(2*$val3+2*$val1).");\n";
	print FH "  csl_signal s_x$i($val3);\n";
	print FH "  csl_signal s_y$i(br5);\n";
	print FH "  csl_port p_c$i($dir{$l},".(3*$val2).");\n";
#f2a : port---p.ps
	print FH "  a$k a$k\_$one(.p_m$i(p_z$i\[".(2*$val2+1+2*$val3)."\-\:".(2*$val2+2*$val3)."\]),.p_n$i(s_n$i));   // f2a : port---p.ps\n";
#f2a : port---repl expr
	print FH "  a$k a$k\_$two(.p_m$i({2{s_x$i\[".($val3-1)."\-\:".($val3)."\],s_y$i\[".($val1+$val2-1)."\-\:".($val2)."\]}}),.p_n$i(s_n$i));   // f2a : port---repl expr\n";
    }
    print FH "  b$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_a$i($dir{$l},f6);\n";
	print FH "  csl_port p_b$i($dir{$l},br3);\n";
#f2a : port---op expr
	print FH "  b$k b$k\_$one(.p_y$i(p_a$i\[".($val1+$val3-1)."\-\:".($val3)."\] & p_b$i\[".($val3-1)."\:".($val3-1)."\]));   // f2a : port---op expr\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_port p_n$i(input,".($val1+$val2).");\n";
#f2a : port---p.ps
	print FH "  b$k b$k\_$one(.p_m$i(p_n$i\[".($val1+$val2-1)."\-\:".($val1)."\]));   // f2a : port---p.ps\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_port p_z$i(inout,$val3);\n";
	print FH "  csl_signal s_m$i(br4);\n";
#f2a : port---p.ps
	print FH "  b$k b$k\_$one(.p_n$i(p_z$i\[".($val3-1)."\-\:".(1)."\]),.p_m$i(s_m$i));   // f2a : port---p.ps\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_d$i(input,br4);\n";
	print FH "  csl_port p_z$i(inout,".(2*$val2+$val1+2*$val3).");\n";
#f2a : port---repl expr
	print FH "  b$k b$k\_$one(.p_c$i({3{p_d$i\[".($val2+$val3-1)."\-\:".($val2)."\]}}),.p_z$i(p_z$i));   // f2a : port---repl expr\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  b$k b$k\_$one;\n";
	print FH "  csl_port p_b$i($dir{$l},br4);\n";
#f2a : port---p.ps
	print FH "  a$k a$k\_$one(.p_a$i(p_b$i\[".($val2+$val3-1)."\-\:".($val2)."\]));   // f2a : port---p.ps\n";
    }
    print FH "  c$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";











}
