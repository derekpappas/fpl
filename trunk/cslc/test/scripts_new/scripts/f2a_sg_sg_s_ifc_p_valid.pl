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

print "Generated tests path : f2a_sg_sg_s_ifc_p_valid/\n";

foreach (my $k = 1; $k <= 20; $k++) {
 my @a1 = ("s1_sg1_$k", "s2_sg1_$k", "s3_sg1_$k", "p1_ifc1_$k", "p2_ifc1_$k", "p3_ifc1_$k", "p1_ifc2_$k", "p2_ifc2_$k", "s1_sg2_$k","p1_ifc3_$k", "p2_ifc3_$k", "s1_sg3_$k", "s2_sg3_$k");
 my @a2 = ("s1_sg1_$k", "s2_sg1_$k", "p1_ifc1_$k", "p2_ifc1_$k", "p1_ifc2_$k", "p3_ifc2_$k", "p2_ifc3_$k", "s3_sg1_$k", "s1_sg2_$k");
 my @a3 = ("p2_ifc1_$k", "p1_ifc1_$k","s1_sg1_$k", "s2_sg1_$k", "s3_sg1_$k", "s1_sg2_$k", "p1_ifc2_$k", "p3_ifc2_$k", "p1_ifc3_$k", "s1_sg3_$k", "s2_sg3_$k");
 my @a4 = ("p2_ifc1_$k", "p3_ifc1_$k", "s1_sg1_$k", "s2_sg1_$k", "s3_sg1_$k", "s1_sg2_$k", "p2_ifc2_$k", "p4_ifc2_$k", "p3_ifc2_$k", "s1_sg3_$k", "s2_sg3_$k", "p1_ifc3_$k");
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
    elsif($k > 15 && $k <= 20) {
         foreach my $u(@a4) {
            $ctests = $u; 
            &main($k, $ctests, $u);
        } 
     }
}
sub main {     
    my ($k, $ctests, $u) = @_; 
    my $test_name = "f2a_ifc_p_sg_sg_s_ifc_p".$k."_".$u."_legal.csl";
    &createCslFile($test_name, $k, $ctests);
}
   
sub createCslFile {
    my($test_name, $k, $ctests) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $val1 = int(rand(300));
    my $val2 = int(rand(50));
    my $val3 = int(rand(350));
    
    if($val1 == 0) { $val1 = 1; }
    if($val2 == 0) { $val2 = 1; }
    if($val3 == 0) { $val3 = 1; }
  
    &mkDir("$path/f2a_sg_sg_s_ifc_p_valid");
    open(FH,">$path/f2a_sg_sg_s_ifc_p_valid/$test_name");

      
    print FH "// Generated by  AnamariaH \n\n";
    print FH "// F2a ifc_p_sg_sg_signal/sg_signal_ifc_ifc_p . \n\n";

  
    print FH "csl_signal_group sg1{ \n";
    print FH "csl_signal s1_sg1_$k($val1); \n";
    print FH "csl_signal s2_sg1_$k($val2); \n";
    print FH "csl_signal s3_sg1_$k($val3); \n";
    print FH " sg1() {} \n";
    print FH "};\n";

    print FH "csl_signal_group sg2{ \n";
    print FH "  sg1 sgn1; \n";
    print FH "csl_signal s1_sg2_$k($val2); \n";
    print FH "  sg2() {} \n";
    print FH "};\n";
    
    print FH "csl_signal_group sg3{ \n";
    print FH "  sg2 sgn2; \n";
    print FH "csl_signal s1_sg3_$k($val3); \n";
    print FH "csl_signal s2_sg3_$k($val2); \n";
    print FH "  sg3() {} \n";
    print FH "};\n";


    print FH "csl_interface ifc1{ \n";
    print FH "csl_port p1_ifc1_$k(input,$val3); \n";
    print FH "csl_port p2_ifc1_$k(input,$val2); \n";
    print FH "csl_port p3_ifc1_$k(output,$val1); \n";
    print FH "  ifc1() {} \n";
    print FH "};\n";

    print FH "csl_interface ifc2{ \n";
    print FH "   ifc1 inter11; \n";
    print FH "csl_port p1_ifc2_$k(output,$val2);\n";
    print FH "csl_port p2_ifc2_$k(output,$val1);\n";
    print FH "csl_port p3_ifc2_$k(input,$val3);\n";
    print FH "csl_port p4_ifc2_$k(input,$val2);\n";
    print FH "  ifc2() {} \n";
    print FH "};\n";

    print FH "csl_interface ifc3{ \n";
    print FH "csl_port p1_ifc3_$k(input,$val1); \n";
    print FH "csl_port p2_ifc3_$k(input,$val3); \n";
    print FH "  ifc3() {} \n";
    print FH "};\n";

    print FH "csl_unit unit_a{ \n";
    print FH "  sg1 sgn10; \n";
    print FH "  ifc1 inter1; \n";
    print FH "  unit_a() { \n"; 
    print FH " } \n";
    print FH "}; \n";

    print FH "csl_unit unit_b{ \n";
    print FH " sg2 sgn20; \n";
    print FH " sg1 sgn11; \n";
    print FH " ifc2 inter2; \n";
    print FH " ifc3 inter3; \n";
    print FH " unit_a a0; \n";
    print FH " unit_a a1; \n";   
    print FH " // F2a ifc_p_sg_sg_s. \n";
    print FH "   unit_b() { \n"; 
    print FH " } \n";
    print FH "}; \n";

    print FH "csl_unit unit_c{ \n";
    print FH " sg3 sgn30; \n";
    print FH " sg1 sgn11; \n";
    print FH " sg2 sgn20; \n";
    print FH " ifc3 inter3; \n";
    if($k <= 10) {
    print FH " unit_b b0(.inter3.p2_ifc3_$k(sgn20.sgn1.s3_sg1_$k),.inter3.p2_ifc3_$k(sgn20.sgn1.s3_sg1_$k)); \n";
    print FH " unit_b b1(.inter3.p2_ifc3_$k(sgn20.sgn1.s3_sg1_$k)); \n";   
    print FH " // F2a sg_sg_s_ifc_p. \n";
    }
    elsif($k > 5 && $k <= 10){
    print FH " unit_b b0(.inter2.inter11.p1_ifc1_$k(sgn30.s1_sg3_$k)); \n";
    print FH " unit_b b1(.inter2.inter11.p2_ifc1_$k(sgn30.s2_sg3_$k)); \n";   
    print FH " // F2a ifc_ifc_p_sg_s. \n";
    }
    elsif($k > 10 && $k <= 15){
    print FH " unit_b b0(.inter3.p1_ifc3_$k(sgn20.sgn1.s1_sg1_$k),.inter3.p2_ifc3_$k(sgn11.s3_sg1_$k)); \n";
     print FH " // F2a sg_sg_s_ifc_p or sg_s_ifc_p or sg_s_sg_sg_s. \n";
    }
    elsif($k > 15 && $k <= 20){
    print FH " unit_a a2(.inter1.p2_ifc1_$k(sgn30.sgn2.s1_sg2_$k));\n";
    print FH " unit_b b0(.inter2.p3_ifc2_$k(sgn30.sgn2.sgn1.s3_sg1_$k),.inter2.p4_ifc2_$k(sgn30.sgn2.s1_sg2_$k));\n";
    print FH " // F2a ifc_p_sg_sg_s or ifc_p_sg_sg_sg_s. \n";
    }
    print FH "   unit_c() { \n"; 
    print FH " } \n";
    print FH "}; \n";



    print FH "csl_unit unit_top{ \n";
    print FH "  sg2 sgn21; \n";
    if($k <= 5) {
    print FH "  unit_b b0(.inter2.p1_ifc2_$k(sgn21.sgn1.s2_sg1_$k),.inter2.p2_ifc2_$k(sgn21.sgn1.s1_sg1_$k)); \n"; 
    print FH "  unit_b b1(.inter2.p3_ifc2_$k(sgn21.sgn1.s3_sg1_$k)); \n";
    print FH "  unit_a a2(.inter1.p3_ifc1_$k(sgn21.sgn1.s1_sg1_$k)); \n";   
    print FH "  unit_c c0(.inter3.p1_ifc3_$k(sgn21.sgn1.s1_sg1_$k));\n";
    print FH " // F2a ifc_p_sg_sg_s. \n";
    }
    elsif($k > 5 && $k <= 10) {
    print FH "  unit_b b0(.inter2.p3_ifc2_$k(sgn21.sgn1.s3_sg1_$k)); \n";
    print FH "  unit_c c0(.inter3.p2_ifc3_$k(sgn21.sgn1.s3_sg1_$k)); \n";
    print FH "// F2a ifc_p_sg_sg_s. \n";
    }
    elsif($k > 10 && $k <= 15) {
    print FH "  unit_b b0(.inter2.p1_ifc2_$k(sgn21.sgn1.s2_sg1_$k)) ; \n";
    print FH "  unit_c c0(.inter3.p1_ifc3_$k(sgn21.sgn1.s1_sg1_$k)); \n";
    print FH "  unit_a a2(.inter1.p1_ifc1_$k(sgn21.sgn1.s3_sg1_$k)); \n";
    print FH " // F2a ifc_p_sg_sg_s . \n";
    }   
    elsif($k > 15 && $k <= 20) {
    print FH "   unit_b b0(.inter2.p4_ifc2_$k(sgn21.sgn1.s2_sg1_$k),.inter2.p2_ifc2_$k(sgn21.sgn1.s1_sg1_$k)) ; \n";
    print FH"    unit_c c0(.inter3.p1_ifc3_$k(sgn21.sgn1.s1_sg1_$k)); \n";
    print FH "// F2a sg_s_sg_sg_s or ifc_p_sg_sg_s. \n";
    }
    print FH "  unit_top() { \n";  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
    close(FH);

}
