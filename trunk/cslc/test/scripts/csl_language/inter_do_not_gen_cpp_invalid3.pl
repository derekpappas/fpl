#!/usr/bin/perl

#oanab
#generating tests with the method called in unit,reg,rf,fifo,mem,tb,unit instance,reg instance,rf instance,fifo instance,mem instance,mem map,vector

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

print "Generated tests path : inter_not_gen_cpp_invalid3/\n";

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

foreach(my $i = 1; $i <= 500; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "inter_not_gen_cpp".$i."_illegal.csl";
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
        &mkDir("$path/inter_not_gen_cpp_valid");
        open(FH,">$path/inter_not_gen_cpp_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/inter_not_gen_cpp_invalid3"); 
        open(FH,">$path/inter_not_gen_cpp_invalid3/$test_name");
    }
    print FH "//Generated by oanab\n";
     print FH "//Test cases from: do_not_gen_cpp_test_matr.odg \n\n";

#register reg
    if($i <= 50 || $i > 175 && $i <= 225) {
	print FH "csl_register reg$k {\n";
	print FH "  reg$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_type(register);\n";
	if($i <= 50 || $i > 175 && $i <= 225) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#register rreg
    if($i > 300 && $i <= 350 || $i > 400 && $i <= 450) {
	print FH "csl_register rreg$k {\n";
	print FH "  rreg$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_type(register);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#register file rf
    if($i <= 50 || $i > 225 && $i <= 250) {
	print FH "csl_register_file rf$k {\n";
	print FH "  rf$k () {\n";
	print FH "    set_width($val3);\n";
	print FH "    set_depth(".($val2+$val3).");\n";
	if($i <= 50 || $i > 225 && $i <= 250) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#register file rrf
    if($i > 300 && $i <= 350 || $i > 400 && $i <= 450) {
	print FH "csl_register_file rrf$k {\n";
	print FH "  rrf$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	print FH "  }\n";
	print FH "};\n\n";
    }


#fifo f
    if($i > 50 && $i <= 100 || $i > 225 && $i <= 250) {
	print FH "csl_fifo f$k {\n";
	print FH "  f$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	if($i > 50 && $i <= 100 || $i > 225 && $i <= 250) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#fifo ff
    if($i > 350 && $i <= 400 || $i > 450 && $i <= 500) {
	print FH "csl_fifo ff$k {\n";
	print FH "  ff$k () {\n";
	print FH "    set_width($val3);\n";
	print FH "    set_depth(".($val3+$val1).");\n";
	print FH "  }\n";
	print FH "};\n\n";
    }
    
    
#memory mem
    if($i > 50 && $i <= 100 || $i > 250 && $i <= 300) {
	print FH "csl_memory mem$k {\n";
	print FH "  mem$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	if($i > 50 && $i <= 100 || $i > 250 && $i <= 300) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }
  
#memory mmem
    if($i > 350 && $i <= 400 || $i > 450 && $i <= 500) {
	print FH "csl_memory mmem$k {\n";
	print FH "  mmem$k () {\n";
	print FH "    set_width($val3);\n";
	print FH "    set_depth(".($val2+$val3).");\n";
	print FH "  }\n";
	print FH "};\n\n";
    }  

#unit a
    print FH "csl_unit a$k {\n";
    print FH "  csl_port p_a($dir{$l},$val1);\n";
    if($i <= 50 || $i > 175 && $i <= 225) {
	print FH "  reg$k reg$k\_$zero;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  rreg$k rreg$k\_$zero;\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "  mmem$k mmem$k\_$zero;\n";
    }
    elsif($i > 450 && $i <= 500) {
	print FH "  ff$k ff$k\_$one;\n";
    }
    print FH "  a$k () {\n";
    if($i <= 50) {
	print FH "    do_not_gen_cpp();\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "    rreg$k\_$zero.do_not_gen_cpp();\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "    mmem$k\_$zero.do_not_gen_cpp();\n";
    }
    elsif($i > 450 && $i <= 500) {
	print FH "    ff$k\_$one.do_not_gen_cpp();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
    if($i > 50 && $i <= 100) {
	print FH "  f$k f$k\_$zero;\n";
    }
    elsif($i > 100 && $i <= 250) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val3);\n";
	print FH "  csl_port clk(input);\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val3);\n";
	print FH "  csl_port clk(input);\n";
	print FH "  mem$k mem$k\_$one;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val3);\n";
	print FH "  csl_port clk(input);\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val3);\n";
	print FH "  csl_port clk(input);\n";
	print FH "  ff$k ff$k\_$zero;\n";
    }
    elsif($i > 400 && $i <= 450) {
	print FH "  rreg$k rreg$k\_$one;\n";
	print FH "  rrf$k rrf$k\_$one;\n";
    }
    print FH "  b$k () {\n";
    if($i > 100 && $i <= 350) {
	print FH "    clk.set_attr(clock);\n";
    }
    elsif($i > 350 && $i <= 400) {
	print FH "    clk.set_attr(clock);\n";
	print FH "    ff$k\_$zero.do_not_gen_cpp();\n";
    }
    elsif($i > 400 && $i <= 450) {
	print FH "    rreg$k\_$one.do_not_gen_cpp();\n";
	print FH "    rrf$k\_$one.do_not_gen_cpp();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    print FH "  b$k b$k\_$zero;\n";
    if($i <= 50) {
	print FH "  rf$k rf$k\_$zero;\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  mem$k mem$k\_$zero;\n";
    }
    elsif($i > 225 && $i <= 250) {
	print FH "  rf$k rf$k\_$one;\n";
	print FH "  f$k f$k\_$one;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  rrf$k rrf$k\_$zero;\n";
    }
    elsif($i > 450 && $i <= 500) {
	print FH "  mmem$k mmem$k\_$one;\n";
    }
    print FH "  c$k () {\n";
    if($i > 175 && $i <= 225) {
	print FH "    do_not_gen_cpp();\n";
    }
    elsif($i > 250 && $i <= 300 || $i > 400 && $i <= 450) {
	print FH "    b$k\_$zero.do_not_gen_cpp();\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "    rrf$k\_$zero.do_not_gen_cpp();\n";
    }
    elsif($i > 450 && $i <= 500) {
	print FH "    mmem$k\_$one.do_not_gen_cpp();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";
  
  

#mem map pag
    if($i <= 150 || $i > 400 && $i <= 500) {
	print FH "csl_memory_map_page mpg$k {\n";
	print FH "  mpg$k () {\n";
	print FH "    set_unit_name(a$k);\n";
	print FH "    add_address_range(0,$val2);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#mem map
    if($i <= 150 || $i > 400 && $i <= 500) {
	print FH "csl_memory_map mmap$k {\n";
	print FH "  mmap$k () {\n";
	print FH "    set_type(hierarchical);\n";
	print FH "    do_not_gen_cpp();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }


#stim vector
    if($i > 100 && $i <= 400) {
	print FH "csl_vector stim_vect$k {\n";
	print FH "  stim_vect$k () {\n";
	print FH "    set_unit_name(b$k);\n";
	if($i > 150 && $i <= 400) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "    set_direction(input);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#exp vector
    if($i > 100 && $i <= 400) {
	print FH "csl_vector exp_vect$k {\n";
	print FH "  exp_vect$k () {\n";
	print FH "    set_unit_name(b$k);\n";
	if($i > 150 && $i <= 300) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "    set_direction(output);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#testbench tb
    if($i > 100 && $i <= 400) {
	print FH "csl_testbench tb$k {\n";
	print FH "  csl_signal clk(reg);\n";
	print FH "  b$k b$k\_$one;\n";
	print FH "  tb$k () {\n";
	print FH "    clk.set_attr(clock);\n";
	print FH "    add_logic(clock,clk,10,ps);\n";
	if($i > 100 && $i <= 150) {
	    print FH "    do_not_gen_cpp();\n";
	    print FH "    do_not_gen_cpp();\n";
	}
	elsif($i > 150 && $i <= 175) {
	    print FH "    do_not_gen_cpp();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }


}
