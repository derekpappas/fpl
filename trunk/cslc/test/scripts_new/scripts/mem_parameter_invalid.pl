#!/usr/bin/perl

#Author Monica
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
    my $test_name = "mem_parameter_".$i."_illegal.csl";
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
    my $val1 = int(rand(20)) + 1;
    my $val2 = $val1 + int(rand(20)) + 1;
    my $val3 = 1;
    my $val4 =$val2 + int(rand(50)) + 1;
    my $val5 = int(rand(80)) + 1;
    my $val27 = int(rand(100)) +1;
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
    my $val35 = int(rand(3)) + 2;
    my $val36 = sprintf("%.".$val35."d",$val5);
    $val35 = $val35 * 4;
    my $val37 = int(rand(3)) + 2;
    my $val38 = sprintf("%.".$val37."d",$val10);
    $val37 = $val37 * 4;

    &mkDir("$path/mem_parameter_invalid/");
    open(FH,">$path/mem_parameter_invalid/$test_name");
    if($i == 1){ print "Genertated path: $path/mem_parameter_invalid\n"; }
    if ($i<=20){
    print FH "//Generated by Monica\n";
    print FH "//illegal test with parameter in memory \n\n";
    if($i <= 5){
    print FH "csl_memory mema {\n";
    print FH "  csl_parameter mema_x($val4);\n";
    print FH "  csl_parameter mema_y($val5);\n";
    print FH "  csl_parameter mema_z($val3);\n";
    print FH "  csl_parameter mema_t($val2);\n";
    print FH "  mema(){\n";
    print FH "    set_depth(mema_x1);     //error: parameter mema_x1 doesn't exist in scope\n"; 
    print FH "    set_width(mema_y);\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_memory memb{\n";
    print FH "  csl_parameter memb_x($val1);\n";
    print FH "  csl_parameter memb_y($val4);\n";
    print FH "  csl_parameter memb_z($val2,$val4); \n";
    print FH "  csl_parameter memb_t($val3);\n";
    print FH "  csl_parameter memb_s($val5,$val1);\n";
    print FH "  csl_parameter memb_r($val2,$val4);\n";    
    print FH "  memb(){\n";
    print FH "    set_depth(memb_t);\n";
    print FH "    set_width(memb_z);\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top(input,$val3);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  mema #($val2, , , ) mema0;\n";
    print FH "  memb #(.memb_z($val3),.memb_s($val1),.memb_t($val2)) memb0;\n";  
    print FH "  top(){\n";
    print FH "  }\n";
    print FH "};\n";
}
    if($i > 5 && $i<=10){
    print FH "csl_memory mema {\n";
    print FH "  csl_parameter mema_x($val4);\n";
    print FH "  csl_parameter mema_y($val5);\n";
    print FH "  csl_parameter mema_z($val3);\n";
    print FH "  csl_parameter mema_t($val2);\n";
    print FH "  mema(){\n";
    print FH "    set_depth(mema_x); \n"; 
    print FH "    set_width(mema_y);\n";
    print FH "  }\n";
    print FH "};\n\n";
    print FH "csl_memory memb{\n";
    print FH "  csl_parameter memb_x($val1);\n";
    print FH "  csl_parameter memb_y($val4);\n";
    print FH "  csl_parameter memb_z($val2,$val4); \n";
    print FH "  csl_parameter memb_t($val3);\n";
    print FH "  csl_parameter memb_s($val5,$val1);\n";
    print FH "  csl_parameter memb_r($val2,$val4);\n";    
    print FH "  memb(){\n";
    print FH "    set_depth(memb_t);\n";
    print FH "    set_width(memb_z);\n";
    print FH "  }\n";
    print FH "};\n\n";
        print FH "csl_memory memc{\n";
        print FH "  csl_parameter memc_x($val8 \'b$val9);\n";
        print FH "  csl_parameter memc_y($val4);\n";
        print FH "  csl_parameter memc_z($val2,$val3);          //error: number $val2 is bigger than 1 bit  \n";
        print FH "  csl_parameter memc_t($val15 \'b$val16);\n";
        print FH "  csl_parameter memc_s($val6 \'b$val7);\n";
        print FH "  csl_parameter memc_r($val11 \'b$val12);\n";   
        print FH "  csl_parameter memc_w($val17 \'b$val18);\n";
        print FH "  csl_parameter memc_k($val13 \'b$val14);\n";
        print FH "  memc(){\n";
        print FH "    set_depth(memc_s);\n";
        print FH "    set_width(memc_y);\n";
        print FH "  }\n";
        print FH "};\n\n";
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top(input,$val3);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  mema #($val2 , , , , ,) mema0;           //error: too many parameters in actual list\n";
    print FH "  memb #(.memb_z($val3),.memb_s($val1),.memb_t($val2)) memb0;\n";    
        print  FH "  memc #(.memc_x($val2),.memc_t(memc_k),.memc_r(val3),.memc_k($val4),.memc_w($val6 \'b$val7)) memc0;\n";
        print  FH "  memc #(,$val2,,,$val4,,,) memc1;\n";    
     print FH "  top(){\n";
    print FH "  }\n";
    print FH "};\n";
    }
    if( $i > 10 && $i<=15){
        print FH "csl_memory memd{\n";
        print FH "  csl_parameter memd_x($val22 \'o$val21);\n";
        print FH "  csl_parameter memd_y($val23 \'o$val24);\n";
        print FH "  csl_parameter memd_z($val25 \'o$val26);\n";
        print FH "  csl_parameter memd_t($val32 \'h$val31);\n";
        print FH "  csl_parameter memd_s($val33 \'h$val34);\n";
        print FH "  csl_parameter memd_r($val35 \'d$val36);\n";
        print FH "  csl_parameter memd_w($val37 \'b$val38);          //error: wrong format\n";
        print FH "  memd(){\n";
        print FH "    set_depth(memd_w);\n";
        print FH "    set_width(memd_t);\n";
        print FH "  }\n";
        print FH "};\n\n";
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top(input,$val3);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  memd memd0;\n";
    print FH "  memd #(,,,$val2,$val22 \'o$val21,$val6 \'b$val7,,) memd1;\n";
    print FH "  top(){\n";
        print FH "    memd0.override_parameter(memd_w,$val1);\n";
        print FH "    memd0.override_parameter(memd_t,$val37 \'d$val38);\n";

    print FH "  }\n";
    print FH "};\n";

    }
    if($i > 15) {
        print FH "csl_memory meme{\n";
        print FH "  csl_parameter meme_x();           //error: parameter need a value \n";
        print FH "  csl_parameter meme_y($val2);\n";
        print FH "  csl_parameter meme_z($val3);\n";
        print FH "  csl_parameter meme_t($val4);\n";    
        print FH "  csl_parameter meme_s($val35 \'d$val36);\n";
        print FH "  csl_parameter meme_r($val11 \'b$val12);\n";
        print FH "  meme(){\n";
        print FH "    set_depth(meme_x);\n";
        print FH "    set_width(meme_t);\n";
        print FH "    initialize_random_values(meme_z);\n";
        print FH "    initialize_random(meme_y);\n";
        print FH "    set_num_rd_ifc(meme_r);\n";
        print FH "    set_num_wr_ifc(meme_s);\n";
        print FH "  }\n";
        print FH "};\n\n";
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top(input,$val3);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  meme meme0;\n";
    print FH "  top(){\n";
    print FH "  }\n";
    print FH "};\n";
    }
}
    close(FH);

}
