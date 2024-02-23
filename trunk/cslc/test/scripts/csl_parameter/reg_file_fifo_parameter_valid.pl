#!/usr/bin/perl

#Author Petronela
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

for(my $i = 1;$i <= 30; $i++){
    &main($i);
}

sub main {
    my ($i,$var,$it1) = @_;
    my $test_name = "reg_file_fifo_parameter_".$i."_legal.csl";
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
    my $val4 = int(rand(50)) + 1;
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
    &mkDir("$path/reg_file_fifo_parameter_valid/");
    open(FH,">$path/reg_file_fifo_parameter_valid/$test_name");
    if($i == 1){ print "calea catre testele generate este $path/reg_file_fifo_parameter_valid\n"; }
    print FH "//Generated by Petronela\n";
    if($i <= 15){
        print FH "//testing parameter in register file \n\n";
    }
    else{
        print FH "//testing parameter in fifo \n\n";
    }
    if($i <= 15){
        print FH "csl_register_file rgfa {\n";
        print FH "  csl_parameter rgfa_x($val4);\n";
        print FH "  csl_parameter rgfa_y($val5);\n";
        print FH "  csl_parameter rgfa_z($val3);\n";
        print FH "  rgfa(){\n";
        print FH "    set_depth(rgfa_y);\n";
        print FH "    set_width(rgfa_x);\n";
        print FH "  }\n";
        print FH "};\n\n";
        print FH "csl_register_file rgfb{\n";
        print FH "  csl_parameter rgfb_x($val1,$val2);\n";
        print FH "  csl_parameter rgfb_y($val4,$val4);\n";
        print FH "  csl_parameter rgfb_z($val2,$val2);\n";
        print FH "  csl_parameter rgfb_t($val3,$val5);\n";
        print FH "  rgfb(){\n";
        print FH "    set_depth(rgfb_x);\n";
        print FH "    set_width(rgfb_y);\n";
        print FH "  }\n";
        print FH "};\n\n";
        if($i > 5){
            print FH "csl_register_file rgfc{\n";
            print FH "  csl_parameter rgfc_x($val6 \'b$val7);\n";
            print FH "  csl_parameter rgfc_y($val8 \'b$val9);\n";
            print FH "  csl_parameter rgfc_z($val11 \'b$val12);\n";
            print FH "  csl_parameter rgfc_t($val13 \'b$val14);\n";
            print FH "  csl_parameter rgfc_v($val15 \'b$val16);\n";
            print FH "  csl_parameter rgfc_r($val17 \'b$val18);\n";
            print FH "  csl_parameter rgfc_s($val19 \'b$val20);\n";
            print FH "  rgfc(){\n";
            print FH "    set_depth(rgfc_s);\n";
            print FH "    set_width(rgfc_z);\n";
            print FH "  }\n";
            print FH "};\n\n";
        }
        if($i > 10){
            print FH "csl_register_file rgfd{\n";
            print FH "  csl_parameter rgfd_x($val22 \'o$val21);\n";
            print FH "  csl_parameter rgfd_y($val23 \'o$val24);\n";
            print FH "  csl_parameter rgfd_z($val25 \'o$val26);\n";
            print FH "  csl_parameter rgfd_t($val32 \'h$val31);\n";
            print FH "  csl_parameter rgfd_s($val33 \'h$val34);\n";
            print FH "  rgfd(){\n";
            print FH "    set_depth(rgfd_y);\n";
            print FH "    set_width(rgfd_t);\n";
            print FH "  }\n";
            print FH "};\n\n";
        }
    }
    if($i > 15){
        print FH "csl_fifo fa {\n";
        print FH "  csl_parameter fa_x($val4);\n";
        print FH "  csl_parameter fa_y($val5);\n";
        print FH "  csl_parameter fa_z($val3);\n";
        print FH "  csl_parameter fa_t($val3,$val5);\n";
        print FH "  fa(){\n";
        print FH "    set_depth(fa_y);\n";
        print FH "    set_width(fa_x);\n";
        print FH "  }\n";
        print FH "};\n\n";
        print FH "csl_fifo fb{\n";
        print FH "  csl_parameter fb_x($val1,$val2);\n";
        print FH "  csl_parameter fb_y($val4,$val5);\n";
        print FH "  csl_parameter fb_z($val2,$val4);\n";
        print FH "  csl_parameter fb_t($val3,$val5);\n";
        print FH "  csl_parameter fb_s($val3);\n";
        print FH "  fb(){\n";
        print FH "    set_depth(fb_x);\n";
        print FH "    set_width(fb_y);\n";
        print FH "  }\n";
        print FH "};\n\n";
        if($i > 20){
            print FH "csl_fifo fc{\n";
            print FH "  csl_parameter fc_x($val6 \'b$val7);\n";
            print FH "  csl_parameter fc_y($val8 \'b$val9);\n";
            print FH "  csl_parameter fc_z($val11 \'b$val12);\n";
            print FH "  csl_parameter fc_t($val13 \'b$val14);\n";
            print FH "  csl_parameter fc_v($val15 \'b$val16);\n";
            print FH "  csl_parameter fc_r($val17 \'b$val18);\n";
            print FH "  fc(){\n";
            print FH "    set_depth(fc_v);\n";
            print FH "    set_width(fc_z);\n";
            print FH "  }\n";
            print FH "};\n\n";
        }
        if($i > 25){
            print FH "csl_fifo fd{\n";
            print FH "  csl_parameter fc_s($val19 \'b$val20);\n";
            print FH "  csl_parameter fd_x($val22 \'o$val21);\n";
            print FH "  csl_parameter fd_y($val23 \'o$val24);\n";
            print FH "  csl_parameter fd_z($val25 \'o$val26);\n";
            print FH "  csl_parameter fd_t($val32 \'h$val31);\n";
            print FH "  csl_parameter fd_v($val33 \'h$val34);\n";
            print FH "  fd(){\n";
            print FH "    set_depth(fd_y);\n";
            print FH "    set_width(fd_t);\n";
            print FH "  }\n";
            print FH "};\n\n";
        }
    
    }
    print FH "csl_unit top {\n";
    print FH "  csl_parameter top_x($val2);\n";
    print FH "  csl_parameter top_y($val3);\n";
    print FH "  csl_parameter top_z($val3);\n";
    print FH "  csl_parameter top_d($val33 \'d$val2);\n";
    print FH "  csl_port p_top(input,top_y);\n";
    print FH "  csl_signal s_top(input,$val3);\n";
    print FH "  csl_port pt_top(input,top_z);\n";
    print FH "  csl_port d_top(output,top_d);\n";
    if($i <= 15){
        print FH "  rgfa #(.rgfa_z($val5),.rgfa_x($val1),.rgfa_y($val2)) rgfa1;\n";
        print FH "  rgfb #(,$val2,$val3,) rgfb1;\n";    
        if($i > 5){
            print FH "  rgfc rgfc1;\n";
        }
        if($i > 10){
            print FH "  rgfd #(.rgfd($val1),.rgfd($val2),.rgfd($val3),.rgfd($val4),.rgfd($val5)) rgfd1;\n";
        }
    }
    if($i > 15){
        print FH "  fa #(.rgfa_z(top_x),.fa_y(top_z)) fa1;\n";
        print FH "  fb #(,$val2,,top_y,) fb1;\n";
        if($i > 20){
            print FH "  fc #(,,val3,,$val4,) fc1;\n";
        }
        if($i > 25){
            print FH "  fd fd0;\n";
        }
    }
    print FH "  top(){\n";
    if($i > 5 && $i <= 15){
        print FH "    rgfc1.override_parameter(rgfc_z,$val5);\n"; 
    }
    if($i > 25){
        print FH "    fd0.override_parameter(fd_y,$val2);\n";
        print FH "    fd0.override_parameter(fd_t,$val4);\n";
    }
    print FH "  }\n";
    print FH "};\n";
    close(FH);

}