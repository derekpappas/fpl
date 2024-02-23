#!/usr/bin/perl

#oanab
#verinum used with f2a
use strict;

print "Generated tests path : test/csl_test_gen/f2a_verinum_valid/\n";

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
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "f2a_verinum".$i."_legal.csl";
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
    my $val1 = int(rand(100)) + 1;
    my $val2 = int(rand(100)) + 1;
    my $val3 = int(rand(100)) + 6;
    my $l = int(rand(3))+1;
    my $hex1 = sprintf("%x",$val1);
    my $hex2 = sprintf("%x",$val2);
    my $hex3 = sprintf("%x",$val3);
    my $bin1 = sprintf("%b",$val1);
    my $bin2 = sprintf("%b",$val2);
    my $bin3 = sprintf("%b",$val3);
    my $oct1 = sprintf("%o",$val1);
    my $oct2 = sprintf("%o",$val2);
    my $oct3 = sprintf("%o",$val3);
    if($test_name=~/(_legal)/){
        &mkDir("$path/f2a_verinum_valid");
        open(FH,">$path/f2a_verinum_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/f2a_verinum_invalid"); 
        open(FH,">$path/f2a_verinum_invalid/$test_name");
    }
    print FH "//Generated by oanab\n";
    print FH "//Test cases from: Interconnect_F2A_matrix.ods \n"; 

#bitranges
    print FH "csl_bitrange br1($val1);  // dec bitrange\n"; # dec bitrange
    print FH "csl_bitrange br2(".(length($bin2))."'h$hex2);  // hex bitrange\n"; # hex bitrange
    print FH "csl_bitrange br3(".(length($bin3))."'b$bin3);  // binary bitrange\n"; # binary bitrange
    print FH "csl_bitrange br4(".($val2+$val3).");  // dec bitrange\n\n"; # dec bitrange

#fields
    print FH "csl_field f2(".(length($bin2))."'o$oct2);  // octal bitrange\n"; # octal bitrange
    print FH "csl_field f5(".($val1+$val2+$val3).");  // dec bitrange\n\n"; # dec bitrange

#interface ifc 
    if($i > 100 && $i <= 150) {
	print FH "csl_interface ifc$k {\n";
	for (my $j = 1; $j <= 3; $j++) {
	    print FH "  csl_port p_$j($dir{$j},br$j);\n";
	}
	print FH "  ifc$k () {}\n";
	print FH "};\n\n";
    }


#unit a
    print FH "csl_unit a$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_a$i($dir{$l},br4);\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_port p_a$i(input,".(length($bin3))."'b$bin3,1'h1);\n";
	print FH "  csl_port p_b$i(input,br1);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$zero;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_port p_x$i($dir{$l},".(3*$val2+2*$val1).");  // dec width\n"; # dec width
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_port p_a$i($dir{$l},br4);\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  csl_parameter par_a$i(".(length($bin2))."'h$hex2);\n";
	print FH "  csl_parameter par_b$i(".($val1+$val2+$val3).",16);\n";
	print FH "  csl_port p_a$i(input,par_a$i);\n";
	print FH "  csl_port p_b$i(output,par_b$i);\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  csl_port p_x$i($dir{$l});\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "  csl_signal s_x$i(br3);\n";
	print FH "  csl_signal s_y$i(".($val3).");\n";
    }
    print FH "  a$k () {\n";
    if($i > 300 && $i <= 350) {
	print FH "    p_x$i.set_bitrange(br2);\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "    s_x$i.set_offset(2'b10);  // bin offset\n"; # bin offset
	print FH "    s_y$i = s_x$i;\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_x$i($dir{$l},".(length($bin2))."'b$bin2);  // bin width\n"; # bin width
	print FH "  csl_signal s_a$i(br2);\n";
#f2a : port---concat expr with octal const
	print FH "  a$k a$k\_$one(.p_a$i({s_a$i,".$val3."'o$oct3}));  // f2a : port---concat expr with octal const\n"; 
    }
    elsif($i > 50 && $i <= 100) {
	my $valmin = sprintf("%x",$val1+$val3-1);
	my $val = sprintf("%x",$val1+$val3);
	my $bin = sprintf("%b",$val1+$val3);
	my $binm = sprintf("%b",$val1+$val3-1);
	print FH "  csl_port p_a$i(input,".(length($bin))."'h$val);  // hex width\n"; # hex width
#f2a : port---port.ps
	print FH "  a$k a$k\_$zero(.p_a$i(p_a$i\[".(length($binm))."'h$valmin\:".(length($bin1))."'h$hex1\]),.p_b$i(p_a$i\[".(length($binm))."'h$valmin\-\:".(length($bin1))."'h$hex1\]));  // f2a : port---port.ps\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  csl_parameter par$i(".(length($bin3))."'o$oct3);  // octal width\n"; # octal width
	print FH "  csl_port p_$i($dir{$l},par$i);\n";
	print FH "  ifc$k ifc$k\_$one;\n";
#f2a : ifc---ifc
	print FH "  a$k a$k\_$zero(.ifc$k\_$zero(ifc$k\_$one));  // f2a : ifc---ifc\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  csl_signal s_a$i(f2);\n";
	print FH "  csl_signal s_b$i(".(length($bin1))."'h$hex1);  // hex width\n"; # hex width
#f2a : port---repl in concat
	print FH "  a$k a$k\_$zero(.p_x$i({{2'b11{s_a$i}},{2{s_b$i}}}));  // f2a : port---repl in concat\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  csl_signal s_a$i(".(length($bin3))."'b$bin3);  // bin width\n"; # bin width
	print FH "  csl_port p_a$i(input,br1);\n";
#f2a : port---concat expr
	print FH "  a$k a$k\_$zero(.p_a$i({s_a$i,".($val2)."'h$hex2}));  // f2a : port---concat expr\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  csl_signal s_a$i(br3);\n";
	print FH "  csl_parameter par(".($val1+$val2+$val3).");\n";
	print FH "  csl_signal s_b$i(par);\n";
	my $val = sprintf("%o",$val1+$val2+$val3);
	my $bin = sprintf("%b",$val1+$val2+$val3);
#f2a : ppar---sig, ppar---spar
	print FH "  a$k #(".(length($bin3))."'b$bin3,".(length($bin))."'o$val) a$k\_$zero(.p_a$i(s_a$i),.p_b$i(s_b$i));  // f2a : ppar---sig, ppar---spar\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  csl_port p_y$i($dir{$l},".(length($bin2))."'o$oct2);  // octal width\n"; # octal width
#f2a : port---op expr
	print FH "  a$k a$k\_$zero(.p_x$i(p_y$i | ".($val2)."'h$hex2));  // f2a : port---op expr\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  csl_port p_x$i(input,f5);\n";
    }
    print FH "  b$k () {\n";
   
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    if($i <= 50) {
	print FH "  csl_port p_y$i($dir{$l},f2);\n"; 
#f2a : port---port
	print FH "  b$k b$k\_$zero(.p_x$i(p_y$i));  // f2a : port---port\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  b$k b$k\_$zero(.p_a$i(s_a$i));  // f2a : port---sig\n";
	print FH "  csl_signal s_a$i(".($val1+$val3).");\n";
	my $valmin = sprintf("%b",$val1+$val2-1);
	print FH "  csl_signal s_b$i(f5);\n";
#f2a : port---sig.ps
	print FH "  a$k a$k\_$two(.p_b$i(s_b$i\[".(length($valmin))."'b$valmin\:".(length($bin2))."'b$bin2\]),.p_a$i(s_a$i\[".($val1+$val3-1)."\-\:".(length($bin3))."'h".($hex3)."\]));  // f2a : port---sig.ps\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$two;\n";
	print FH "  csl_signal s_a$i(br3);\n";
	print FH "  csl_signal s_b$i(".(length($bin3))."'b$bin3);  // bin width\n"; # bin width
#f2a : port---op expr
	print FH "  b$k b$k\_$one(.p_$i(s_a$i & s_b$i),.ifc$k\_$one(ifc$k\_$two));  // f2a : port---op expr\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_port p_b$i(input,$val1);\n";
    }
    elsif($i > 200 && $i <= 250) {
#f2a : port---const (hex)
	print FH "  b$k b$k\_$zero(.p_a$i(".($val1)."'h$hex1));  // f2a : port---const (hex)\n";
#f2a : port---const (octal)
	print FH "  b$k b$k\_$one(.p_a$i(".($val1)."'o$oct1));  // f2a : port---const (octal)\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  b$k b$k\_$zero;\n";
	print FH "  csl_port p_x$i($dir{$l});\n";
	print FH "  csl_signal s_a$i(br3);\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  csl_port p_x$i($dir{$l});\n";
	print FH "  b$k b$k\_$zero(.p_y$i(s_y$i));  // f2a : port---sig\n";
	print FH "  csl_signal s_y$i(f2);\n";
    }
    elsif($i > 350 && $i <= 400) {
	my $val = sprintf("%o",$val1+$val2+$val3);
	my $hex = sprintf("%x",$val1+$val2+$val3-1);
	my $bin = sprintf("%b",$val1+$val2+$val3);
	print FH "  csl_signal s_a$i(".(length($bin))."'o$val);\n";
	print FH "  csl_signal s_b$i(br1);\n";
	print FH "  b$k b$k\_$one(.p_x$i({s_a$i\[".(length($bin))."'h$hex\-\:".(length($bin))."'h$hex\],s_b$i\[1'b1\]}));\n";
    }
    print FH "  c$k () {\n";
    if($i > 150 && $i <= 200) {
#connect_by_name : port---sig
	print FH "    p_b$i.connect_by_name(b$k\_$zero.s_b$i);  // port---sig (PC)\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "    p_x$i.set_width(".(length($bin3))."'o$oct3);  // octal width\n"; # octal width
	print FH "    s_a$i = p_x$i;  // assign : sig---port\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "    p_x$i.set_range(1'b1,".(length($bin2))."'o$oct2);  // octal range\n"; # octal range
	print FH "    s_y$i = p_x$i;  // assign : sig---port\n";
    }
    print FH "  }\n";
    print FH "};\n\n";





}