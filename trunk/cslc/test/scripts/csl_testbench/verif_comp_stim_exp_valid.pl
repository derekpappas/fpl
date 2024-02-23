#!/usr/bin/perl
#modified by oanab

use Switch;               # the switch/case command
use strict;
use File::Find;           # traversing the directory tree
use File::Basename;       # retrieving the basename of a directory
use File::Path;           # mkpath command

my $set_h   = "set_h";
my $set_v   = "set_v";
my $set_r   = "set_r";
my $set_s   = "set_s";
my $set_sg  = "set_sg";
my $set_eg  = "set_eg";
my $set_c   = "set_c";
my $set_m   = "set_m";
my $set_cy  = "set_cy";
my $set_f   = "set_f";
my $set_a   = "set_a";
my %mapcommd;
$mapcommd{$set_h }  = "set_vc_header_comment";
$mapcommd{$set_v }  = "set_version";
$mapcommd{$set_r }  = "set_radix";
$mapcommd{$set_s }  = "set_vc_stall";
$mapcommd{$set_sg}  = "set_vc_start_generation_trigger";
$mapcommd{$set_eg}  = "set_vc_end_generation_trigger";
$mapcommd{$set_c }  = "set_vc_capture_edge_type";
$mapcommd{$set_m }  = "set_vc_max_number_of_mismatches";
$mapcommd{$set_cy}  = "set_vc_max_cycles";
$mapcommd{$set_f }  = "set_vc_output_filename";
$mapcommd{$set_a }  = "add_logic";

for(my $i=1;$i<=20;$i++){
    &comds($i);
}

sub check {
    my $val;
    my $commd = $_[0];
    my $i   = $_[1];
    switch($commd){
        case ($set_h)   {my @alphanumeric = ('a'..'z','A'..'Z');$val = join '', map $alphanumeric[rand @alphanumeric], 0..$i;return $val;}
        case ($set_v)   {$val = $i;return $val;}
        case ($set_r)   {my @radix = ("bin","hex");$val = $radix[$i-1];return $val;}
        case ($set_s)   {$val = "trigg";return $val;}
        case ($set_sg)  {$val = "trigg";return $val;}
        case ($set_eg)  {$val = "trigg";return $val;}
        case ($set_c)   {my @capt=("rise","fall");$val = $capt[$i-1] ;return $val;}
        case ($set_m)   {$val = $i;return $val;}
        case ($set_cy)  {$val = $i;return $val;}
        case ($set_f)   {my @alphanumeric = ('a'..'z','A'..'Z');$val = join '', map $alphanumeric[rand @alphanumeric], 0..$i;return $val;}
        case ($set_a)   {$val = "inject_stalls";return $val;}
    }
       
     
}
sub comds {
    my $i=$_[0];
    my $val;
    my $test_name;
    foreach my $commd(keys %mapcommd)
    {
            $val = &check($commd,$i);
            $test_name;
            my $test_type = "_legal";
            if($val ne ""){
                $test_name="verifcomp_stim_exp_$commd"."_"."$val$test_type".".csl";
                &cslFile($test_name,$mapcommd{$commd},$val);
            }
        
    }
    
}

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

sub cslFile {
    my ($test_name,$cmd,$val)=@_;
    my $path="$ENV{WORK}/test/csl_test_gen/";
    &mkDir("$path/verif_comp_stim_exp_valid");
    open(FH,">$path/verif_comp_stim_exp_valid/$test_name");
    &header($test_name);
    &description($cmd);
    &legend();
    print FH "csl_unit dut{\n";
    print FH "  csl_port stim_in(input),exp_out(output);\n";
    print FH "  csl_port clk(input);\n";
    print FH "  csl_port ps(input),pe(output),pclk(input);\n";
    print FH "    dut(){\n";
    print FH "    clk.set_attr(clock);\n";
    print FH "    stim_in = ps;\n";
    print FH "    pe = exp_out;\n";
    print FH "    clk = pclk;\n";
    print FH "    }\n";
    print FH "};\n";
    print FH "csl_signal trigg;\n";
    print FH "csl_vector stim_vec{\n";
    print FH "    stim_vec(){\n";
    print FH "       set_unit_name(dut);\n";
    print FH "       set_direction(input);\n";
    if($cmd eq $mapcommd{$set_h } || $cmd eq $mapcommd{$set_f}){
        print FH "       $cmd(\"$val\");\n";}
    else {print FH "       $cmd($val);\n"}
    print FH "    }\n";
    print FH "};\n";
    print FH "csl_vector exp_vec{\n";
    print FH "    exp_vec(){\n";
    print FH "       set_unit_name(dut);\n";
    print FH "       set_direction(output);\n";
    if($cmd eq $mapcommd{$set_h } || $cmd eq $mapcommd{$set_f}){
        print FH "       $cmd(\"$val\");\n";}
    else {print FH "       $cmd($val);\n"}
    print FH "    }\n";
    print FH "};\n";
    printf FH "csl_testbench tb{ \n";
    printf FH "    csl_signal clk(reg); \n";
    printf FH "    dut dut_1(.clk(clk)); \n";
    printf FH "    tb(){ \n";
    printf FH "        clk.set_attr(clock); \n";
    printf FH "        add_logic(clock,clk,200,ps); \n";
    printf FH "    } \n";
    printf FH "}; \n";
}
 

sub header
{
    my $test_name =$_[0];
    my $test_date = `date "+%d/%m/%G, %T"`;
    print FH "//Test generated by Petronela\n";
    print FH "//Test name: $test_name\n";
    print FH "//Date: $test_date\n";
    
}

sub description {
    my $cmd = $_[0];
    print FH "//Description:\n";
    print FH "//testing the command $cmd for stim and exp vector\n\n ";

}

sub legend {
    print FH "//Legend:\n";
    foreach my $commd(keys %mapcommd){
        print FH "//$commd = $mapcommd{$commd}\n";
    }
    print FH "\n\n";
} 
