#!/usr/bin/perl

#oanab

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

print "Generated tests path : test/csl_test_gen/inter_not_gen_rtl_valid1/\n";

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

foreach(my $i = 1; $i <= 450; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my %dir = (1,"input",
	       2,"output",
	       3,"inout");
    my $dir = $_[4];
    my $test_name = "inter_not_gen_rtl".$i."_legal.csl";
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
        &mkDir("$path/inter_not_gen_rtl_valid1");
        open(FH,">$path/inter_not_gen_rtl_valid1/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/inter_not_gen_rtl_invalid1"); 
        open(FH,">$path/inter_not_gen_rtl_invalid1/$test_name");
    }
    print FH "//Generated by oanab\n\n";


#register reg
    if($i > 25 && $i <= 50 || $i > 150 && $i <= 300) {
	print FH "csl_register reg$k {\n";
	print FH "  reg$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_type(register);\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#register rreg 
    if($i > 175 && $i <= 200 || $i > 325 && $i <= 350) {
	print FH "csl_register rreg$k {\n";
	print FH "  rreg$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_type(register);\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#register file rf
    if($i > 50 && $i <= 75 || $i > 200 && $i <= 225 || $i > 300 && $i <= 450) {
	print FH "csl_register_file rf$k {\n";
	print FH "  rf$k () {\n";
	print FH "    set_width($val3);\n";
	print FH "    set_depth(".($val2+$val3).");\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#register file rrf
    if($i > 350 && $i <= 375) {
	print FH "csl_register_file rrf$k {\n";
	print FH "  rrf$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

    my $valr = $val2 + $val3;
    my $binvr = sprintf("%b",$valr);
    my $valrr = $val2 + $val1;
    my $binvrr = sprintf("%b",$valrr);

#fifo f
    if($i > 75 && $i <= 100 || $i > 225 && $i <= 250 || $i > 375 && $i <= 400) {
	print FH "csl_fifo f$k {\n";
	print FH "  f$k () {\n";
	print FH "    set_width($val1);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }
    
    
#memory mem
    if($i > 100 && $i <= 125 || $i > 250 && $i <= 275 || $i > 400 && $i <= 425) {
	print FH "csl_memory mem$k {\n";
	print FH "  mem$k () {\n";
	print FH "    set_width($val2);\n";
	print FH "    set_depth(".($val2+$val1).");\n";
	print FH "    do_not_gen_rtl();\n";
	print FH "  }\n";
	print FH "};\n\n";
    }
    
    
    
#unit a
    print FH "csl_unit a$k {\n";
    if($i > 100 && $i <= 125 || $i > 250 && $i <= 275) {
	print FH "  mem$k mem$k\_$zero;\n";
    }
    elsif($i > 175 && $i <= 200 || $i > 325 && $i <= 350) {
	print FH "  csl_signal reg_in($val2);\n";
	print FH "  csl_signal reg_out($val2);\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal enable;\n";
	print FH "  csl_signal reset_;\n";
	print FH "  rreg$k rreg$k\_$one(.reg_in(reg_in),.reg_out(reg_out),.clock(clock),.enable(enable),.reset_(reset_));\n";
    }
    elsif($i > 225 && $i <= 250) {
	print FH "  csl_signal reg_in($val2);\n";
	print FH "  csl_signal reg_out($val2);\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal enable;\n";
	print FH "  csl_signal reset_;\n";
	print FH "  reg$k reg$k\_$one(.reg_in(reg_in),.reg_out(reg_out),.clock(clock),.enable(enable),.reset_(reset_));\n";
    }
    elsif($i > 350 && $i <= 375) {
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
	print FH "  rf$k rf$k\_$one(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
	print FH "  csl_signal data_out1_($val1);\n";
	print FH "  csl_signal data_out0_($val1);\n";
	print FH "  csl_signal data_in_($val1);\n";
	print FH "  csl_signal rd_addr1_(".(length($binvrr)).");\n";
	print FH "  csl_signal rd_addr0_(".(length($binvrr)).");\n";
	print FH "  csl_signal wr_addr_(".(length($binvrr)).");\n";
	print FH "  rrf$k rrf$k\_$one(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1_),.data_out0(data_out0_),.data_in(data_in_),.rd_addr1(rd_addr1_),.rd_addr0(rd_addr0_),.wr_addr(wr_addr_),.clock(clock),.clear(clear),.reset(reset));\n";
    }
    elsif($i > 400 && $i <= 425) {
	print FH "  rf$k rf$k\_$zero(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
    }
    print FH "  a$k () {\n";
#75 tests call the met in unit a
    if($i <= 75) {
	print FH "    do_not_gen_rtl();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";
    

#unit b
    print FH "csl_unit b$k {\n";
    print FH "  a$k a$k\_$zero;\n";
    if($i > 50 && $i <= 75 || $i > 325 && $i <= 350) {
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
	print FH "  rf$k rf$k\_$zero(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
    }
    elsif($i > 150 && $i <= 200 || $i > 250 && $i <= 275) {
	print FH "  csl_signal reg_in($val2);\n";
	print FH "  csl_signal reg_out($val2);\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal enable;\n";
	print FH "  csl_signal reset_;\n";
	print FH "  reg$k reg$k\_$one(.reg_in(reg_in),.reg_out(reg_out),.clock(clock),.enable(enable),.reset_(reset_));\n";
    }
    elsif($i > 200 && $i <= 225) {
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
	print FH "  rf$k rf$k\_$zero(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
	print FH "  csl_signal reg_in($val2);\n";
	print FH "  csl_signal reg_out($val2);\n";
	print FH "  csl_signal enable;\n";
	print FH "  reg$k reg$k\_$zero(.reg_in(reg_in),.reg_out(reg_out),.clock(clock),.enable(enable),.reset_(reset));\n"
	}
    elsif($i > 275 && $i <= 300) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val2);\n";
	print FH "  csl_port clk(input);\n";
    }
    elsif($i > 375 && $i <= 400) {
	print FH "  f$k f$k\_$one(.valid(valid),.clock(clock),.reset_(reset_),.wr_data(wr_data),.rd_data(rd_data),.empty(empty),.full(full),.pop(pop),.push(push));\n";
	print FH "  csl_signal wr_data($val1);\n";
	print FH "  csl_signal rd_data($val1);\n";
	print FH "  csl_signal empty;\n";
	print FH "  csl_signal full;\n";
	print FH "  csl_signal pop;\n";
	print FH "  csl_signal push;\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal reset_;\n";
    }
    elsif($i > 400 && $i <= 425) {
	print FH "  mem$k mem$k\_$zero;\n";
    }
     print FH "  b$k () {\n";
#125 tests call the met in unit b
    if($i <= 25 || $i > 75 && $i <= 125) {
	print FH "    do_not_gen_rtl();\n";
    }
    elsif($i > 275 && $i <= 300) {
	print FH "    clk.set_attr(clock);\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


#unit c
    print FH "csl_unit c$k {\n";
    if($i > 275 && $i <= 300) {
	print FH "  b$k b$k\_$zero(.clk(clock),.p_x$i(reg_in),.p_y$i(reg_out));\n";
    }
    else {
	print FH "  b$k b$k\_$zero;\n";
    }
    if($i > 25 && $i <= 50 || $i > 275 && $i <= 300) {
	print FH "  csl_signal reg_in($val2);\n";
	print FH "  csl_signal reg_out($val2);\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal enable;\n";
	print FH "  csl_signal reset_;\n";
	print FH "  reg$k reg$k\_$zero(.reg_in(reg_in),.reg_out(reg_out),.clock(clock),.enable(enable),.reset_(reset_));\n";
    }
    elsif($i > 75 && $i <= 100 || $i > 225 && $i <= 250) {
	print FH "  csl_signal wr_data($val1);\n";
	print FH "  csl_signal rd_data($val1);\n";
	print FH "  csl_signal empty;\n";
	print FH "  csl_signal full;\n";
	print FH "  csl_signal pop;\n";
	print FH "  csl_signal push;\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal reset_;\n";
	print FH "  f$k f$k\_$zero(.valid(valid),.clock(clock),.reset_(reset_),.wr_data(wr_data),.rd_data(rd_data),.empty(empty),.full(full),.pop(pop),.push(push));\n";
    }
    elsif($i > 125 && $i <= 150) {
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val1);\n";
	print FH "  csl_port clk(input);\n";
	print FH "  csl_signal s_x$i($val2);\n";
	print FH "  csl_signal s_y$i($val1);\n";
	print FH "  csl_signal clock;\n";
    }
    elsif($i > 300 && $i <= 325 || $i > 375 && $i <= 400) {
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
	print FH "  rf$k rf$k\_$one(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
    }
    elsif($i > 425 && $i <= 450) {
	print FH "  csl_signal rd_en1;\n";
	print FH "  csl_signal rd_en0;\n";
	print FH "  csl_signal wr_en;\n";
	print FH "  csl_signal data_out1($val3);\n";
	print FH "  csl_signal data_out0($val3);\n";
	print FH "  csl_signal data_in($val3);\n";
	print FH "  csl_signal rd_addr1(".(length($binvr)).");\n";
	print FH "  csl_signal rd_addr0(".(length($binvr)).");\n";
	print FH "  csl_signal wr_addr(".(length($binvr)).");\n";
	print FH "  csl_signal clock;\n";
	print FH "  csl_signal valid;\n";
	print FH "  csl_signal clear;\n";
	print FH "  csl_signal reset;\n";
	print FH "  rf$k rf$k\_$one(.valid(valid),.rd_en1(rd_en1),.rd_en0(rd_en0),.wr_en(wr_en),.data_out1(data_out1),.data_out0(data_out0),.data_in(data_in),.rd_addr1(rd_addr1),.rd_addr0(rd_addr0),.wr_addr(wr_addr),.clock(clock),.clear(clear),.reset(reset));\n";
	print FH "  csl_signal s_x$i($val2);\n";
	print FH "  csl_signal s_y$i($val1);\n";
	print FH "  csl_port p_x$i(input,$val2);\n";
	print FH "  csl_port p_y$i(output,$val1);\n";
	print FH "  csl_port clk(input);\n";
    }
    print FH "  c$k () {\n";
    if($i > 125 && $i <= 150 || $i > 425 && $i <= 450) {
	print FH "    clk.set_attr(clock);\n";
	print FH "    s_x$i = p_x$i;\n";
	print FH "    p_y$i = s_y$i;\n";
	print FH "    clock = clk;\n";
    }
    if($i > 150 && $i <= 175 || $i > 300 && $i <= 325) {
	print FH "    do_not_gen_rtl();\n";
    }
    print FH "  }\n";
    print FH "};\n\n";
    
#stim vector
    if($i > 125 && $i <= 150 || $i > 275 && $i <= 300 || $i > 425 && $i <= 450) {
	print FH "csl_vector stim_vect$k {\n";
	print FH "  stim_vect$k () {\n";
	if($i > 125 && $i <= 150 || $i > 425 && $i <= 450) {
	    print FH "    set_unit_name(c$k);\n";
	}
	elsif($i > 275 && $i <= 300) {
	    print FH "    set_unit_name(b$k);\n";
	}
	print FH "    set_direction(input);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#exp vector
    if($i > 125 && $i <= 150 || $i > 275 && $i <= 300 || $i > 425 && $i <= 450) {
	print FH "csl_vector exp_vect$k {\n";
	print FH "  exp_vect$k () {\n";
	if($i > 125 && $i <= 150 || $i > 425 && $i <= 450) {
	    print FH "    set_unit_name(c$k);\n";
	}
	elsif($i > 275 && $i <= 300) {
	    print FH "    set_unit_name(b$k);\n";
	}
	print FH "    set_direction(output);\n";
	print FH "  }\n";
	print FH "};\n\n";
    }

#testbench tb
    if($i > 125 && $i <= 150 || $i > 275 && $i <= 300 || $i > 425 && $i <= 450) {
	print FH "csl_testbench tb$k {\n";
	print FH "  csl_signal clk(reg);\n";
	if($i > 125 && $i <= 150|| $i > 425 && $i <= 450 ) {
	    print FH "  c$k c$k\_$zero;\n";
	}
	elsif($i > 275 && $i <= 300) {
	    print FH "  b$k b$k\_$one;\n";
	}
	print FH "  tb$k () {\n";
	print FH "    clk.set_attr(clock);\n";
	print FH "    add_logic(clock,clk,10,ps);\n";
	if($i > 125 && $i <= 150 || $i > 275 && $i <= 300 || $i > 425 && $i <= 450) {
	    print FH "    do_not_gen_rtl();\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

}
