#!/usr/bin/perl

#oanab

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

print "Generated tests path : inter_not_gen_rtl_invalid4/\n";

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
    my $test_name = "inter_not_gen_rtl".$i."_illegal.csl";
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
        &mkDir("$path/inter_not_gen_rtl_valid2");
        open(FH,">$path/inter_not_gen_rtl_valid2/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/inter_not_gen_rtl_invalid4"); 
        open(FH,">$path/inter_not_gen_rtl_invalid4/$test_name");
    }
    print FH "//Generated by oanab\n";
    print FH "//Test cases from: do_not_gen_rtl_test_matr.odg \n\n";

#register reg
    if($i > 50 && $i <= 100) {
	print FH "csl_register reg$k {\n";
	print FH "  reg$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_type(register);\n";
	if($i > 50 && $i <= 100) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#fifo f
    if($i > 150 && $i <= 200) {
	print FH "csl_fifo f$k {\n";
	print FH "  f$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	if($i > 150 && $i <= 200) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#register file rf
    if($i > 100 && $i <= 150) {
	print FH "csl_register_file rf$k {\n";
	print FH "  rf$k () {\n";
	print FH "    set_width($val3);\n";
	print FH "    set_depth(".($val2+$val3).");\n";
	if($i > 100 && $i <= 150) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
}

#memory mem
    if($i > 200 && $i <= 250) {
	print FH "csl_memory mem$k {\n";
	print FH "  mem$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#interface ifc
    if($i <= 150 || $i > 175) {
	print FH "csl_interface ifc$k {\n";
	print FH "  csl_port p_x$i($dir{$l},$val2);\n";
	if($l < 3) {
	    print FH "  csl_port p_y$i($dir{$l+1},$val3);\n";
	}
	else {
	    print FH "  csl_port p_y$i($dir{$l-1},$val3);\n";
	}
	if($l == 1) {
	    print FH "  csl_port p_z$i($dir{$l+2},$val1);\n";
	}
	else {
	    print FH "  csl_port p_z$i($dir{$l-1},$val1);\n";
	}
	print FH "  ifc$k () {\n";
	if($i <= 25 || $i > 50 && $i <= 75) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#interface iifc
    if($i > 100 && $i <= 175 || $i > 200 && $i <= 250) {
	print FH "csl_interface iifc$k {\n";
	print FH "  csl_port p_a$i($dir{$l},$val3);\n";
	if($l < 3) {
	    print FH "  csl_port p_b$i($dir{$l+1},$val1);\n";
	}
	else {
	    print FH "  csl_port p_b$i($dir{$l-1},$val1);\n";
	}
	if($l == 1) {
	    print FH "  csl_port p_c$i($dir{$l+2},$val2);\n";
	}
	else {
	    print FH "  csl_port p_c$i($dir{$l-1},$val2);\n";
	}
	print FH "  iifc$k () {\n";
	print FH "    do_not_gen_rtl();\n";
        print FH "  }\n";
	print FH "};\n\n";
    }
    
    
#signal group sg
    if($i <= 150 || $i > 175) {
	print FH "csl_signal_group sg$k {\n";
	print FH "  csl_signal s_x$i($val2);\n";
	print FH "  csl_signal s_y$i($val3);\n";
	print FH "  csl_signal s_z$i($val1);\n";
	print FH "  sg$k () {\n";
	if($i <= 25 || $i > 50 && $i <= 75) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#signal group ssg
    if($i > 100 && $i <= 175 || $i > 200 && $i <= 250) {
	print FH "csl_signal_group ssg$k {\n";
	print FH "  csl_signal s_a$i($val1);\n";
	print FH "  csl_signal s_b$i($val2);\n";
	print FH "  csl_signal s_c$i($val3);\n";
	print FH "  ssg$k () {\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }


#unit a
    print FH "csl_unit a$k {\n";
    print FH "  csl_signal s$i($val2);\n";
    if($i > 25 && $i <= 50 || $i > 75 && $i <= 100 || $i > 175 && $i <= 200) {
	print FH "  ifc$k ifc$k\_$one;\n";
    }
    elsif($i > 50 && $i <= 75) {
	print FH "  reg$k reg$k\_$zero;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  rf$k rf$k\_$zero;\n";
	print FH "  iifc$k iifc$k\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  iifc$k iifc$k\_$two;\n";
	print FH "  ssg$k ssg$k\_$two;\n";
    }
    print FH "  a$k () {\n";
    if($i > 25 && $i <= 50 || $i > 75 && $i <= 100 || $i > 175 && $i <= 200) {
	print FH "    ifc$k\_$one.do_not_gen_rtl();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
    if($i > 25 && $i <= 50 || $i > 175 && $i <= 200) {
	print FH "  sg$k sg$k\_$one;\n";
    }
    elsif($i > 50 && $i <= 75) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  sg$k sg$k\_$zero;\n";
    }
    elsif($i > 75 && $i <= 100) {
	print FH "  reg$k reg$k\_$one;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$one;\n";
	print FH "  ssg$k ssg$k\_$zero;\n";
    }
    elsif($i > 150 && $i <= 175) {
	print FH "  iifc$k iifc$k\_$one;\n";
	print FH "  ssg$k ssg$k\_$one;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  mem$k mem$k\_$zero;\n";
    }
    print FH "  b$k () {\n";
    if($i <= 25) {
	print FH "    do_not_gen_rtl();\n";
    }
    if($i > 25 && $i <= 50) {
	print FH "    do_not_gen_rtl();\n";
	print FH "    sg$k\_$one.do_not_gen_rtl();\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "    ifc$k\_$one.do_not_gen_rtl();\n";
    }
    elsif($i > 175 && $i <= 200) {
	print FH "    sg$k\_$one.do_not_gen_rtl();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    print FH "  b$k b$k\_$zero;\n";
    if($i <= 25) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  sg$k sg$k\_$zero;\n";
    }
    elsif($i > 75 && $i <= 150) {
	print FH "  sg$k sg$k\_$one;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  f$k f$k\_$zero;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "  ifc$k ifc$k\_$two;\n";
	print FH "  sg$k sg$k\_$two;\n";
    }
    print FH "  c$k () {\n";
    if($i > 75 && $i <= 150) {
	print FH "    sg$k\_$one.do_not_gen_rtl();\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    ifc$k\_$two.do_not_gen_rtl();\n";
	print FH "    sg$k\_$two.do_not_gen_rtl();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";








}
