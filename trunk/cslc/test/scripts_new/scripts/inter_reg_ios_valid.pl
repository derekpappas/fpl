#!/usr/bin/perl

#oanab
#method called for a ifc,unit

use strict;

if(! defined $ENV{WORK}){
    die "[ERROR] The environment variable WORK is not set. Set it to point to TOT/se";
}

my $totDir     = $ENV{WORK};
&testDirExists($totDir);

sub testDirExists {
    my($execName) = @_;
    unless(-e "$execName") { die "[ERROR] The directory $execName does not exist!\n"; }
    
}

print "Generated tests path : test/csl_test_gen/inter_reg_ios_valid/\n";

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

foreach(my $i = 1; $i <= 350; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    #my @dir = ("input","output","inout");
    #my $l = int(rand($#dir+1));
    my @sp = ("  csl_port clk(input);","  csl_signal clk(reg);");
    my $test_name = "inter_reg_ios".$i."_legal.csl";
   	&createCslFile($test_name, $i, @sp);
}

sub createCslFile {
    my ($test_name, $i, @sp) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $k = int(rand(20)) + int(rand(20));
    my $zero = 0;
    my $one = 1;
    my $two = 2;
    my $tre = 3;
    my $val1 = int(rand(100))+1;
    my $val2 = int(rand(100))+2;
    my $val3 = int(rand(100))+3;
    my $m = $k + 5;
    if($test_name=~/(_legal)/){
        &mkDir("$path/inter_reg_ios_valid");
        open(FH,">$path/inter_reg_ios_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/inter_reg_ios_invalid1"); 
        open(FH,">$path/inter_reg_ios_invalid1/$test_name");
    }
    print FH "//Generated by oanab\n\n";

#interface ifck
    print FH "csl_interface ifc$k {\n";
    print FH "  csl_port p_x$i(input,$val2);\n";
    print FH "  csl_port p_y$i(output,$val3);\n";
    print FH "  csl_port p_z$i(output,$val1);\n";
    print FH "  ifc$k () {\n";
    print FH "  }\n";
    print FH "};\n\n";
    
#interface ifcm
    if($i > 50) {
	print FH "csl_interface ifc$m {\n";
	if($i > 50 && $i <= 100) {
	    print FH "  csl_port p_a$i(output,".($val1+3).");\n";
	    print FH "  csl_port p_b$i(output,$val3);\n";
	    print FH "  csl_port p_c$i(input,$val2);\n";
	    print FH "  ifc$k ifc$k\_$zero;\n";
	    print FH "  ifc$k ifc$k\_$one;\n";
	}
	elsif($i > 100 && $i <= 150) {
	    print FH "  csl_port p_a$i(output,".($val1+3).");\n";
	    print FH "  csl_port p_b$i(output,$val3);\n";
	    print FH "  csl_port p_c$i(input,$val2);\n";
	    print FH "  ifc$k ifc$k\_$two;\n";
	}
	elsif($i > 150 && $i <= 200) {
	    print FH "  csl_port p_a$i(output,".($val1+3).");\n";
	    print FH "  csl_port p_b$i(output,$val3);\n";
	    print FH "  csl_port p_c$i(input,$val2);\n";
	    print FH "  ifc$k ifc$k\_$zero;\n";
	    print FH "  ifc$k ifc$k\_$one;\n";
	    print FH "  ifc$k ifc$k\_$two;\n";
	}
	elsif($i > 200 && $i <= 250) {
	    print FH "  csl_port p_a$i(output,".($val1+3).");\n";
	    print FH "  csl_port p_b$i(output,$val3);\n";
	    print FH "  csl_port p_c$i(input,$val2);\n";
	}
	elsif($i > 250 && $i <= 300) {
	    print FH "  csl_port p_a$i(output,".($val1+3).");\n";
	    print FH "  csl_port p_b$i(output,$val3);\n";
	    print FH "  csl_port p_c$i(input,$val2);\n";
	    print FH "  csl_port p_clk(input);\n";
	    print FH "  ifc$k ifc$k\_$zero;\n";
	}
	elsif($i > 300 && $i <= 350) {
	    print FH "  ifc$k ifc$k\_$zero;\n";
	    print FH "  ifc$k ifc$k\_$one;\n";
	}
	print FH "  ifc$m () {\n";
	if($i > 250 && $i <= 300) {
	    print FH "    p_clk.set_attr(clock);\n";
	    print FH "    ifc$k\_$zero.set_clock(p_clk);\n";
	}
	print FH "  }\n";
	print FH "};\n\n";
    }

#unit a
    print FH "csl_unit a$k {\n";
    print FH $sp[int rand($#sp+1)];
    print FH "\n";
    if($i <= 50) {
	print FH "  csl_signal s;\n";
	print FH "  ifc$k ifc$k\_$zero;\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s;\n";
	print FH "  ifc$m ifc$m\_$zero;\n";
	print FH "  csl_port p_clk(input);\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  ifc$k ifc$k\_$zero;\n";
	print FH "  csl_signal rst;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  ifc$m ifc$m\_$zero;\n";
	print FH "  csl_signal rst$k;\n";
	print FH "  csl_signal enable$k;\n";
    }
    elsif($i > 200 && $i <= 300) {
	print FH "  csl_signal s;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  ifc$k ifc$k\_$tre;\n";
	print FH "  csl_signal rst$k;\n";
	print FH "  csl_signal enable$k;\n";
    }
    print FH "  a$k () {\n";
    print FH "    clk.set_attr(clock);\n";
    if($i <= 50) {
	print FH "    ifc$k\_$zero.set_clock(clk);\n";
	print FH "    ifc$k\_$zero.register_ios(input);\n";
	print FH "    s = clk;\n";
    }    
    elsif($i > 50 && $i <= 100) {
	print FH "    p_clk.set_attr(clock);\n";
	print FH "    ifc$m\_$zero.ifc$k\_$one.set_clock(clk);\n";
	print FH "    ifc$m\_$zero.ifc$k\_$zero.set_clock(p_clk);\n";
	print FH "    ifc$m\_$zero.ifc$k\_$one.register_ios(input);\n";
	print FH "    ifc$m\_$zero.ifc$k\_$zero.register_ios(input);\n";
	print FH "    s = clk;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "    ifc$k\_$zero.set_clock(clk);\n";
	print FH "    ifc$k\_$zero.register_ios(input,.reset(rst),1);\n";
	print FH "    rst = clk;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "    ifc$m\_$zero.ifc$k\_$zero.set_clock(clk);\n";
	print FH "    ifc$m\_$zero.ifc$k\_$zero.register_ios(input,.reset(rst$k),3,.en(enable$k));\n";
	print FH "    enable$k = clk;\n";
	print FH "    rst$k = enable$k;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    set_clock(clk);\n";
	print FH "    register_ios(output);\n";
	print FH "    s = clk;\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "    s = clk;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "    ifc$k\_$tre.set_clock(clk);\n";
	print FH "    ifc$k\_$tre.register_ios(output,.reset_(rst$k),2,.en(enable$k));\n";
	print FH "    rst$k = clk;\n";
	print FH "    enable$k = rst$k;\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


# unit b
    print FH "csl_unit b$k {\n";
    print FH $sp[int rand($#sp+1)];
    print FH "\n";
    if($i <= 50) {
	print FH "  csl_signal s;\n";
	print FH "  a$k a$k\_$zero(.ifc$k\_$zero(ifc$k\_$one));\n";
	print FH "  ifc$k ifc$k\_$one;\n";
    }
    elsif($i > 50 && $i <= 100) {
	print FH "  csl_signal s(".($val1+$val3).");\n";
	print FH "  a$k a$k\_$zero(.ifc$m\_$zero(ifc$m\_$one),.p_clk(ifc$k\_$two.p_x$i\[".($val2-1)."\]));\n";
	print FH "  ifc$k ifc$k\_$two;\n";
	print FH "  ifc$m ifc$m\_$one;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "  a$k a$k\_$zero(.ifc$k\_$zero(ifc$m\_$one.ifc$k\_$two));\n";
	print FH "  a$k a$k\_$one(.ifc$k\_$zero.p_x$i(ifc$m\_$one.p_c$i),.ifc$k\_$zero.p_y$i(ifc$m\_$one.p_b$i),.ifc$k\_$zero.p_z$i(ifc$m\_$one.p_a$i\[".($val1+2)."\:".(3)."\]));\n";
	print FH "  ifc$m ifc$m\_$one;\n";
	print FH "  csl_signal rst$k;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "  a$k a$k\_$zero(.ifc$m\_$zero(ifc$m\_$one));\n";
	print FH "  ifc$m ifc$m\_$one;\n";
	print FH "  csl_signal reset;\n";
	print FH "  csl_signal en;\n";
    }
    elsif($i > 200 && $i <= 300) {
	print FH "  a$k a$k\_$zero;\n";
	print FH "  ifc$m ifc$m\_$zero;\n";
	print FH "  csl_signal rst;\n";
	if($i > 250) {
	    print FH "  csl_signal rst$k;\n";
	    print FH "  csl_signal enable$k;\n";
	}
    }
    elsif($i > 300 && $i <= 350) {
	print FH "  csl_signal rst;\n";
	print FH "  a$k a$k\_$zero(.ifc$k\_$tre(ifc$k\_$zero));\n";
	print FH "  ifc$k ifc$k\_$zero;\n";
    }
    print FH "  b$k () {\n";
    print FH "    clk.set_attr(clock);\n";
    if($i <= 50) {
	print FH "    ifc$k\_$one.set_clock(clk);\n";
	print FH "    ifc$k\_$one.register_ios(input);\n";
	print FH "    s = clk;\n";
    }   
    elsif($i > 50 && $i <= 100) {
	print FH "    ifc$k\_$two.set_clock(clk);\n";
	print FH "    s\[".($val1-1)."\] = clk;\n";
	print FH "    {ifc$k\_$two.p_y$i,ifc$k\_$two.p_z$i} = s;\n";
    }
    elsif($i > 100 && $i <= 150) {
	print FH "    ifc$m\_$one.ifc$k\_$two.set_clock(clk);\n";
	print FH "    ifc$m\_$one.ifc$k\_$two.register_ios(input,.reset(rst$k),2);\n";
	print FH "    rst$k = clk;\n";
    }
    elsif($i > 150 && $i <= 200) {
	print FH "    ifc$m\_$one.ifc$k\_$one.set_clock(clk);\n";
	print FH "    ifc$m\_$one.ifc$k\_$one.register_ios(input,.reset(reset),1,.en(en));\n";
	print FH "    en = clk;\n";
	print FH "    reset = en;\n";
    }
    elsif($i > 200 && $i <= 250) {
	print FH "    ifc$m\_$zero.set_clock(clk);\n";
	print FH "    ifc$m\_$zero.register_ios(input);\n";
	print FH "    rst = clk;\n";
    }
    elsif($i > 250 && $i <= 300) {
	print FH "    ifc$m\_$zero.ifc$k\_$zero.register_ios(input,.reset(rst),1);\n";  
	print FH "    ifc$m\_$zero.set_clock(clk);\n";
	print FH "    ifc$m\_$zero.register_ios(output,.reset(rst$k),4,.en(enable$k));\n";
	print FH "    rst = clk;\n";
	print FH "    rst$k = enable$k;\n";
    }
    elsif($i > 300 && $i <= 350) {
	print FH "    set_clock(clk);\n";
	print FH "    register_ios(output);\n";
	print FH "    rst = clk;\n";
    }
    print FH "  }\n";
    print FH "};\n\n";


# unit c
    if($i > 150) {
	print FH "csl_unit c$k {\n";
	print FH $sp[int rand($#sp+1)];
	print FH "\n";
	if($i > 150 && $i <= 200) {
	    print FH "  b$k b$k\_$zero(.ifc$m\_$one(ifc$m\_$two));\n";
	    print FH "  ifc$m ifc$m\_$two;\n";
	    print FH "  csl_signal rst$k;\n";
	    print FH "  csl_signal enable$k;\n";
	}
	elsif($i > 200 && $i <= 300) {
	    print FH "  b$k b$k\_$zero(.ifc$m\_$zero(ifc$m\_$one));\n";
	    print FH "  ifc$m ifc$m\_$one;\n";
	    print FH "  csl_signal s;\n";
	}
	elsif($i > 300 && $i <= 350) {
	    print FH "  b$k b$k\_$zero(.ifc$k\_$zero(ifc$m\_$tre.ifc$k\_$zero));\n";
	    print FH "  b$k b$k\_$one(.ifc$k\_$zero(ifc$m\_$tre.ifc$k\_$one));\n";
	    print FH "  ifc$m ifc$m\_$tre;\n";
	    print FH "  csl_signal rst$k;\n";
	    print FH "  csl_signal enable$k;\n";
	}
	print FH "  c$k () {\n";
	print FH "    clk.set_attr(clock);\n";
	if($i > 150 && $i <= 200) {
	    print FH "    ifc$m\_$two.ifc$k\_$two.set_clock(clk);\n";
	    print FH "    ifc$m\_$two.ifc$k\_$two.register_ios(input,.reset_(rst$k),1,.en(enable$k));\n";
	    print FH "    rst$k = clk;\n";
	    print FH "    enable$k = rst$k;\n";
	}
	elsif($i > 200 && $i <= 250) {
	    print FH "    s = clk;\n";
	}
	elsif($i > 250 && $i <= 300) {
	    print FH "    set_clock(clk);\n";
	    print FH "    register_ios(output);\n";
	    print FH "    s = clk;\n";
	}
	elsif($i > 300 && $i <= 350) {
	    print FH "    ifc$m\_$tre.set_clock(clk);\n";
	    print FH "    ifc$m\_$tre.register_ios(input,.reset_(rst$k),6,.en(enable$k));\n";
	    print FH "    rst$k = clk;\n";
	    print FH "    enable$k = rst$k;\n";
	}
	print FH "  }\n";
	print FH "};\n";
    }








}
