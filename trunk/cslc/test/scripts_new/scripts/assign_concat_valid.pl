#!/usr/bin/perl

#Author Anamaria
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

my $j;

foreach (my $k = 1; $k <= 15; $k++) {
    $j=$j+1;
    my @a1 = ("p_x_$k", "p_y_$k", "p_a_$k", "p_b_$k", "s_k1_$k", "s_x_$k", "s_y_$k", "s_a_$k", "s_b_$k", "s_k2_$k", "p_in_$k", "s_u1_$k", "s_u2_$k");
    my @a2 = ("p_z_$k", "p_t_4k", "p_a_$k", "p_k2_$k", "s_x_$k", "s_y_$k", "s_k1_$k", "s_a_$k", "s_b_$k", "s_k2_$k", "p_out_$k", "s_u3_$k", "s_u1_$k");
    my @a3 = ("p_t_$k", "p_k1_$k", "p_b_$k", "s_x_4k", "s_y_$k", "s_k1_$k", "s_a_$k", "s_b_$k", "s_k2_$k", "p_out_$k", "s_u2_$k", "s_u3_$k");
    my $ctests;
    if($k <= 5) {   
        foreach my $u (@a1) {
            $ctests = $u; 
            &main($k, $ctests, $u);
        }
    }
    elsif($k > 5 && $k <= 10) {
         foreach my $u(@a2) {
            $ctests = $u; 
            &main($k, $ctests, $u);
        } 
     }
    elsif($k > 10 && $k <= 15) {
         foreach my $u(@a3) {
            $ctests = $u; 
            &main($k, $ctests, $u);
        } 
     }
}
sub main {  
 
    my ($k, $ctests, $u) = @_; 
    my $test_name = "assign_concat".$k."_".$u."_legal.csl";
    &createCslFile($test_name, $k, $ctests);
}
   
sub createCslFile {
 
    my($test_name, $k, $ctests) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
#  if ($j==1 ) {
#     print ("Generated path:  $path/assign_concat_valid/ \n"); }
   
    my $val1 = int(rand(300));
    my $val2 = int(rand(50));
    my $val3 = int(rand(350));
    
    if($val1 == 0) { $val1 = 1; }
    if($val2 == 0) { $val2 = 1; }
    if($val3 == 0) { $val3 = 1; }
    my $val4 = $val3 + $val2 + $val1;
    my $val5 = $val1 + $val2;
    my $val6 = $val2 + $val3;
    my $val7 = $val1 + $val3;
    my $val8 = 2*$val1;
    my $val9 = 2*$val1 + $val2;
    my $val10 = 2*$val3 + $val1;
    my $val11 = 2*$val1 + $val3;
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_concat_valid");
        open(FH,">$path/assign_concat_valid/$test_name");
    }
   
    print FH "// Generated by  AnamariaH \n\n";
    print FH "// Assign port_concat_signals in the same unit \n\n";
  

    print FH "csl_unit unit_a{ \n";

    print FH "csl_signal s_x_$k($val1); \n";
    print FH "csl_signal s_y_$k($val2); \n";
    print FH "csl_signal s_k1_$k($val3); \n";
   
    if($k <= 5) {
    print FH "csl_port p_x_$k(input, $val4);\n";
    print FH "csl_port p_y_$k(input, $val7);\n";
    print FH "csl_signal s1_$k($val2);\n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "csl_port p_z_$k(output, $val5); \n";
    print FH "csl_port p_t_$k(output, $val6); \n"; 
    print FH "csl_signal s_y1_$k($val2);\n"; 
    }
    elsif($k > 10 && $k <= 15) {
    print FH "csl_port p_t_$k(output, $val5); \n"; 
    print FH "csl_port p_k1_$k(output, $val6);\n";
    print FH "csl_signal s_y1_$k($val2);\n"; 
    }

    print FH "  unit_a() { \n"; 
    if($k <= 5) { 
    print FH "    p_x_$k = {s_k1_$k, s_x_$k, s_y_$k} ; \n";
    print FH "    p_y_$k = {s1_$k} ; \n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "   p_z_$k = {s_x_$k, s_y_$k} ;  \n";
    print FH "   p_t_$k = {s_k1_$k, s_y1_$k} ;  \n";
    }
    elsif($k > 10 && $k <= 15) {
    print FH "    p_t_$k = {s_x_$k, s_y_$k} ; \n";
    print FH "    p_k1_$k = {s_y1_$k, s_k1_$k} ; \n";
 
    }
    
    print FH " } \n";
    print FH "}; \n";

    print FH "csl_unit unit_b{ \n";

    print FH "csl_signal s_a_$k($val2);\n";
    print FH "csl_signal s_b_$k($val1); \n";
    print FH "csl_signal s_k2_$k($val1); \n";
   
    if($k <= 5) {
    print FH "csl_port p_a_$k(input, $val5);\n";
    print FH "csl_port p_b_$k(output, $val5);\n";
    print FH "csl_signal s_a1_$k($val2);\n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "csl_port p_k2_$k(input, $val5); \n";
    print FH "csl_port p_a_$k(input, $val8); \n"; 
    print FH "csl_signal s_b1_$k($val1);\n"; 
    }
    elsif($k > 10 && $k <= 15) {
    print FH "csl_port p_b_$k(output, $val9); \n"; 
    }
    print FH "   unit_a a0; \n";
    print FH "   unit_b() { \n"; 
    if($k <= 5) {    
    print FH "    p_a_$k = {s_a_$k, s_b_$k} ; \n";
    print FH "    p_b_$k = {s_k2_$k, s_a1_$k} ; \n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "   p_k2_$k = {s_a_$k, s_b_$k} ; \n";
    print FH "   p_a_$k = {s_k2_$k, s_b1_$k} ; \n";
    }
    elsif($k > 10 && $k <=15) {
    print FH "    p_b_$k = {s_a_$k, s_b_$k, s_k2_$k} ; \n";
    }
    print FH " } \n";
    print FH "}; \n";
 
    print FH "csl_unit unit_c{ \n";
  
     
    if($k <= 5) {
    print FH "csl_port p_in_$k(input, $val7);\n";
    print FH "csl_signal s_u1_$k($val3); \n";
    print FH "csl_signal s_u2_$k($val1); \n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "csl_port p_out_$k(output, $val10); \n";
    print FH "csl_signal s_u3_$k($val7); \n";
    print FH "csl_signal s_u1_$k($val3); \n";
    }
    elsif($k > 10 && $k <= 15) {
    print FH "csl_port p_out_$k(output, $val11); \n"; 
    print FH "csl_signal s_u2_$k($val1); \n";
    print FH "csl_signal s_u3_$k($val7); \n";
    }
   
    print FH "  unit_b b0; \n";
    print FH "  unit_c() { \n";  
    if($k <= 5) {    
    print FH "    p_in_$k = {s_u1_$k, s_u2_$k} ; \n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "   p_out_$k = {s_u3_$k, s_u1_$k} ; \n";
    }
    elsif($k > 10 && $k <=15) {
   print FH "    p_out_$k = {s_u2_$k, s_u3_$k} ; \n";
    }   
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
  
    close(FH);

}
