#!/usr/bin/perl

#Author Petronela
#modified by oanab
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

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

for(my $i = 1;$i <= 20; $i++){
    &main($i);
}

sub main {
    my ($i,$var,$it1) = @_;
    my $test_name = "reg_parameter_".$i."_legal.csl";
    &createCslFile($test_name, $i);
}

sub binar {
    my $val11 = int(rand(7)) + 2;
    my $val12 = 1;
    for(my $v = 1; $v < $val11; $v++){
        $val12 = $val12 * 10;
    }
    my $val13 = int(rand($val11)) - 1;
    my $val14 = 1;
    for(my $s = 1; $s < $val13; $s++){
        $val14 = $val14 * 10;
    }
    $val12 = $val12 + $val14;
    my @array=($val11,$val12);
    return @array;
}
sub createCslFile {
    my($test_name, $i,$var) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $val1 = int(rand(20)) + 2;
    my $val2 = $val1 + int(rand(20)) + 1;
    my $val3 = 1;
    my $val4 = $val1 + 2;
    my $val5 = int(rand(80)) + 2;
    my $val27 = int(rand(100)) + 1;
    my $val10 = int(rand(200)) + 1;
    my ($val6,$val7) = &binar; 
    my ($val8,$val9) = &binar;
    my ($val11,$val12) = &binar; 
    my ($val13,$val14) = &binar;
    my ($val15,$val16) = &binar;
    my ($val17,$val18) = &binar;
    my ($val19,$val20) = &binar;
    my $val22 = int(rand(3)) + 2;
    my $val21 = sprintf("%.".$val22."o",$val5);
    $val22 = $val22 * 3;
    my $val23 = int(rand(3)) + 2;
    my $val24 = sprintf("%.".$val23."o",$val10);
    $val23 = $val23 * 3;
    my $val25 = int(rand(2)) + 2;
    my $val26 = sprintf("%.".$val25."o",$val27);
    $val25 = $val25 * 3;
    my $val32 = int(rand(3)) + 2;
    my $val31 = sprintf("%.".$val32."x",$val5);
    $val32 = $val32 * 4;
    my $val33 = int(rand(3)) + 2;
    my $val34 = sprintf("%.".$val33."x",$val10);
    $val33 = $val33 * 4;
    &mkDir("$path/reg_parameter_valid/");
    open(FH,">$path/reg_parameter_valid/$test_name");
    if($i == 1){ print "calea catre testele generate este $path/reg_parameter_valid\n"; }

    print FH "//Generated by Petronela\n";
    print FH "//testing parameter in register \n\n";
    
    print FH "csl_register rga {\n";
    print FH "  csl_parameter rga_x($val4);\n";
    print FH "  csl_parameter rga_y($val5);\n";
    print FH "  csl_parameter rga_z($val3);\n";
    print FH "  csl_parameter rga_t($val2);\n";
    print FH "  rga(){\n";
    print FH "    set_type(counter);\n";
    print FH "    set_width($val13);\n";
    print FH "    add_logic(count_direction,up);\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_register rgb{\n";
    print FH "  csl_parameter rgb_x($val1);\n";
    print FH "  csl_parameter rgb_y($val4);\n";
    print FH "  csl_parameter rgb_z($val2);\n";
    print FH "  csl_parameter rgb_t($val3);\n";
    print FH "  rgb(){\n";
    print FH "    set_type(register);\n";
    print FH "    set_width($val3);\n";
    print FH "    add_logic(set,rgb_x);\n";
    print FH "    add_logic(reset,rgb_t);\n";
    print FH "  }\n";
    print FH "};\n\n";
    
    if($i > 5) {
         print FH "csl_register rgc{\n";
         print FH "  csl_parameter rgc_x($val1);\n";
         print FH "  csl_parameter rgc_y($val4);\n";
         print FH "  csl_parameter rgc_z($val2);\n";
         print FH "  csl_parameter rgc_t($val3);\n";
         print FH "  rgc(){\n";
         print FH "    set_type(register);\n";
         print FH "    set_width(rgc_x);\n";
         print FH "  }\n";
         print FH "};\n\n";
         print FH "csl_register rgd{\n";
         print FH "  csl_parameter rgd_x($val1,$val2);\n";
         print FH "  csl_parameter rgd_y($val4,$val4);\n";
         print FH "  csl_parameter rgd_z($val2,".($val2).");\n";
         print FH "  csl_parameter rgd_t($val3,$val4);\n";
         print FH "  csl_parameter rgd_v($val5,$val5);\n";
         print FH "  rgd(){\n";
         print FH "    set_type(counter);\n";
         print FH "    set_width(rgd_y);\n";
	 print FH "    add_logic(count_direction,up);\n";
         print FH "  }\n";
         print FH "};\n\n";
    }
    if($i > 10){
        print FH "csl_register rge{\n";
        print FH "  csl_parameter rge_x($val6 \'b$val7);\n";
        print FH "  csl_parameter rge_y($val8 \'b$val9);\n";
        print FH "  csl_parameter rge_z($val11 \'b$val12);\n";
        print FH "  csl_parameter rge_t($val13 \'b$val14);\n";
        print FH "  csl_parameter rge_v($val15 \'b$val16);\n";
        print FH "  csl_parameter rge_r($val17 \'b$val18);\n";
        print FH "  csl_parameter rge_s($val19 \'b$val20);\n";
        print FH "  rge(){\n";
        print FH "    set_type(counter);\n";
        print FH "    set_width(rge_z);\n";
	print FH "    add_logic(count_direction,up);\n";
        print FH "  }\n";
        print FH "};\n\n";
    }
    if($i > 15){
        print FH "csl_register rgf{\n";
	print FH "  csl_parameter rgf_x($val27);\n";
        print FH "  csl_parameter rgf_y($val23 \'o$val24);\n";
	print FH "  csl_parameter rgf_z($val10);\n";
        print FH "  csl_parameter rgf_t(1\'b1);\n";
        print FH "  csl_parameter rgf_v($val33 \'h$val34);\n";
        print FH "  rgf(){\n";
        print FH "    set_type(counter);\n";
	print FH "    add_logic(count_direction,up);\n";
        print FH "    set_width(rgf_v);\n";
        print FH "    add_logic(count_amount,rgf_t);\n";
	if($val27 > $val10) {
	    print FH "    add_logic(start_value,rgf_z);\n";
	    print FH "    add_logic(end_value,rgf_x);\n";
	}
	elsif($val27 < $val10) {
	    print FH "    add_logic(start_value,rgf_x);\n";
	    print FH "    add_logic(end_value,rgf_z);\n";
	}
        print FH "  }\n";
        print FH "};\n\n";
    }
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top($val3);\n";
    print FH "  csl_signal rst,clk,en,rega(".length($val14)."),set(1);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  rga #(,$val2,,) rga0(.reset_(rst),.clock(clk),.reg_out(rega),.enable(p_top));\n";
    print FH "  rga #(.rga_y($val3),.rga_x($val1)) rga1(.reset_(s_top),.clock(pt_top),.reg_out(rega),.enable(en));\n";    
    print FH "  rgb rgb0(.reset_(rst),.clock(clk),.reg_out(s_top),.enable(en),.reg_in(s_top),.set(set));\n";
    if($i > 5) {
        print FH "  csl_parameter top_s($val3);\n";
        print FH "  csl_parameter top_t($val3);\n";
        print FH "  csl_parameter top_v($val3);\n";
        print FH "  csl_parameter top_r($val3);\n";
        print FH "  csl_port p_tops(input,top_s);\n";
        print FH "  csl_port p_topv(input,top_v);\n";
        print FH "  csl_port p_topt(input,top_r);\n";
        print FH "  csl_port p_topr(output,top_t);\n";
	print FH "  csl_parameter top_rg($val4,$val4);\n";
	print FH "  csl_signal regd(top_rg);\n";
        print FH "  rgc #(.rgc_z($val6),.rgc_t($val5),.rgc_x($val3),.rgc_y($val4)) rgc0(.reset_(p_tops),.reg_out(p_topr),.enable(p_topv),.clock(p_topt),.reg_in(p_tops));\n";
        print FH "  rgd rgd0(.reset_(rst),.clock(clk),.reg_out(regd),.enable(en));\n";    
    }
    if($i > 10){
	print FH "  csl_signal rege($val2);\n";
        print FH "  rge rge0(.reset_(rst),.clock(clk),.reg_out(rege),.enable(en));\n";
    }
    if($i > 15){
	print FH "  csl_signal regf($val33 \'h$val34);\n";
        print FH "  rgf #($val3,,$val2,,) rgf0(.reset_(rst),.clock(clk),.reg_out(regf),.enable(en));\n";
        print FH "  rgf #(.rgf_y($val5),.rgf_x($val27)) rgf1(.reset_(rst),.clock(clk),.reg_out(regf),.enable(en));\n";    
    }
    print FH "  top(){\n";
    if($i > 10){
        print FH "    rge0.override_parameter(rge_z,$val2);\n";
        print FH "    rge0.override_parameter(rge_y,$val4);\n";
    }
    print FH "  }\n";
    print FH "};\n";
    close(FH);
}