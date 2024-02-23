#!/usr/bin/perl

#Author Anamaria
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

print "Generated tests path : test/csl_test_gen/assign_sps_valid/\n";

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}


foreach (my $k = 1; $k <= 15; $k++) {
    my @a1 = ("p_a1_$k", "p_a3_$k", "p_b1_$k", "p_b2_$k", "p_c1_$k", "p_c2_$k", "p_c3_$k", "p_c4_$k");
    my @a2 = ("p_a1_$k", "p_a2_4k", "p_b1_$k", "p_b2_$k", "p_c1_$k", "p_c4_$k", "s_a1_$k", "s_a3_$k", "s_b_$k", "s_c1_$k", "s_c2_$k");
    my @a3 = ("p_a1_$k", "p_a2_$k", "p_b1_$k", "p_c1_4k", "p_c2_$k", "p_c3_$k", "s_a1_$k", "s_a3_$k", "s_b_$k", "s_c1_$k", "s_c2_$k");
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
    my $test_name = "assign_sps".$k."_".$u."_legal.csl";
    &createCslFile($test_name, $k, $ctests);
}
   
sub createCslFile {
    my($test_name, $k, $ctests) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $val1 = int(rand(300));
    my $val2 = int(rand(200));
    my $val3 = 100;
   
    if($val1 == 0) { $val1 = 1; }
    if($val2 == 0) { $val2 = 1; }
   
    &mkDir("$path/assign_sps_valid");
    open(FH,">$path/assign_sps_valid/$test_name");

    print FH "// Generated by  AnamariaH \n";
    print FH "// Test cases from: assign_test_matrix.odg\n";
    print FH "// Assign port_port/signal_port/port_signal\n\n";

  

    print FH "csl_unit unit_a{ \n";
    print FH "csl_port p_a1_$k(input, $val3);\n";
    print FH "csl_port p_a2_$k(output, $val1); \n";
    print FH "csl_port p_a3_$k(output, $val3); \n";
    print FH "csl_signal s_a3_$k($val3); \n";
    if($k > 5 && $k <= 15) {
	print FH "csl_signal s_a1_$k($val1); \n";
    }
    
   
   
    print FH "  unit_a() { \n"; 
    if($k <= 5) {   
    print FH "    s_a3_$k = p_a1_$k ; \n";
    print FH "// Assign signal_port\n\n";

    }
    elsif($k > 5 && $k <= 10) {
    print FH "   s_a1_$k = p_a2_$k;  \n";
    print FH "   s_a3_$k = p_a1_$k;  \n";
    print FH "   s_a3_$k = p_a3_$k;  \n";
    print FH "// Assign signal_port\n\n";

    }
    elsif($k > 10 && $k <= 15) {
    print FH "    p_a2_$k = s_a1_$k ; \n";
    print FH "    p_a1_$k = s_a3_$k ; \n";
    print FH "// Assign port_signal\n\n";

    }
    
    print FH " } \n";
    print FH "}; \n";

    print FH "csl_unit unit_b{ \n";
    print FH "csl_port p_b1_$k(input, $val1);\n";
    print FH "csl_port p_b2_$k(output, $val1); \n";
    print FH "csl_signal s_b_$k($val1); \n";
    print FH "csl_signal s3_$k($val3); \n";
   
    if($k <= 5) {
	print FH "   unit_a a0(.p_a1_$k(s3_$k),.p_a2_$k(p_b2_$k),.p_a3_$k(s3_$k)); \n";
    }
    elsif($k > 5 && $k <= 10) {
	print FH "   unit_a a0(.p_a1_$k(s3_$k),.p_a2_$k(p_b2_$k),.p_a3_$k(s3_$k)); \n";
    }
    elsif($k > 10 && $k <= 15) {
	print FH "   unit_a a0(.p_a1_$k(s3_$k),.p_a2_$k(p_b2_$k),.p_a3_$k(s3_$k)); \n";
    }
    print FH "   unit_b() { \n"; 
    if($k <= 5) {    
    print FH "    s_b_$k = p_b1_$k ; \n";
    print FH "// Assign signal_port\n\n";

    }
    elsif($k > 5 && $k <= 10) {
    print FH "   s_b_$k = p_b1_$k ; \n";
    print FH "   s_b_$k = p_b2_$k ; \n";
    print FH "// Assign signal_port\n\n";
    }
    elsif($k > 10 && $k <= 15) {
    print FH "    p_b1_$k = s_b_$k ; \n";
    print FH "// Assign port_signal\n\n";

    }
    print FH " } \n";
    print FH "}; \n";
 
    print FH "csl_unit unit_c{ \n";
    print FH "csl_port p_c1_$k(input, $val1);\n";
    if($k > 5 && $k <= 15) {
	print FH "csl_port p_c2_$k(input, $val2);\n";
	print FH "csl_signal s_c1_$k($val1); \n";
	print FH "csl_signal s_c2_$k($val2); \n";
    }
    print FH "csl_port p_c3_$k(output, $val1);\n";
    
    if($k <= 5) {
	print FH "  unit_b b0(.p_b1_$k(p_c1_$k),.p_b2_$k(p_c3_$k)); \n";
    }
    elsif($k > 5 && $k <= 10) {
	print FH "  unit_b b0(.p_b1_$k(p_c1_$k),.p_b2_$k(p_c3_$k)); \n";
    }
    elsif($k > 10 && $k <= 15) {
	print FH "csl_port p_c4_$k(input, $val2); \n";
	print FH "  unit_b b0(.p_b1_$k(p_c1_$k),.p_b2_$k(p_c3_$k)); \n";
    }
    print FH "  unit_c() { \n";  
    
    if($k > 5 && $k <= 10) {
    print FH "   s_c1_$k = p_c1_$k ; \n";
    print FH "   s_c2_$k = p_c2_$k ; \n";
    print FH "// Assign signal_port\n\n";
    }
    elsif($k > 10 && $k <= 15) {
    print FH "    p_c1_$k = s_c1_$k ; \n";
    print FH "    p_c2_$k = s_c2_$k ; \n";
    print FH "    p_c4_$k = s_c2_$k ; \n";
    print FH "// Assign port_signal\n\n";

    }   
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}

