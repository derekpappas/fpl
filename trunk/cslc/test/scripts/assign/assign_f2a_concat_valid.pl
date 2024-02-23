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

foreach(my $i = 1; $i <=60; $i++) {
    &main($i);
 
}

sub main {
    my $i = $_[0];
    my $test_name = "assign_concat_test".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($i==1){
        print ("Generated path: $path/assign_f2a_concat_valid/ \n");}
    my $val = int(rand(30));
    if($val == 0) { $val = 1; }
    my $val1= int(rand(50));
    if($val1== 0) { $val1= 1; }
    my $val2 = int(rand(10));
    if($val2==0) {$val2=1;}
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_f2a_concat_valid");
        open(FH,">$path/assign_f2a_concat_valid/$test_name");
    }
#*************************************************************
#  port/signal={concat_expr};

 if ($i>0 && $i<=60){
    print FH "// Generated by Monica\n";
    print FH "// Test cases from test matrix: assign_test_matrix.odg \n";
    print FH "// Concatenation expression\n\n";
    print FH "// VALID TEST $i;\n\n";
   
 if ($i <= 5){
     print FH " csl_bitrange br1($val);\n";
     print FH " csl_bitrange br2($val1);\n\n";
     
     print FH " csl_unit  u1 {\n";
    
         print FH " csl_port in_$i(input,br1);\n";
         print FH " csl_port out_$i(output,br2);\n";
     
     print FH " u1(){}\n";
     print FH "};\n";
     
     print FH " csl_unit  u2 {\n";
     
         print FH " csl_port in_$i(input,br1);\n";
         print FH " csl_port out_$i(output,br2);\n";
     
    
	 print FH " csl_signal s1_$i(br1);\n";
	 print FH " csl_signal s2_$i(br2);\n";
     print FH " csl_signal sig1_$i(br1);\n";
	 print FH " csl_signal sig2_$i(br2);\n";
 

     print FH " u1 u1_$i(.in_$i(sig1_$i),.out_$i(sig2_$i));\n";

     print FH " u2(){\n";
     
	 print FH " s1_$i={in_$i};\n";
	 print FH " out_$i={s2_$i};\n";
	 print FH " in_$i={s1_$i};\n";
	 print FH " s2_$i={out_$i};\n";
     
     print FH "}\n";
     print FH "};\n";
     
 }
    if ($i>5 && $i<=10){
	print FH " csl_bitrange br1($val1);\n";
	print FH " csl_bitrange br2($val2);\n\n";
	
	print FH " csl_unit  u1 {\n";
	
	    print FH " csl_port in1_$i(input,br1);\n";
	    print FH " csl_port out1_$i(output,br1);\n";
	    print FH " csl_port in2_$i(input,br2);\n";
	    print FH " csl_port out2_$i(output,br2);\n";
	
	print FH " u1(){}\n";
	print FH "};\n";
	
	print FH " csl_unit  u2 {\n";
	my $v1= $val1 + $val2;
	
	    print FH " csl_port in1_$i(input,$v1);\n";
	    print FH " csl_port out_$i(output,$v1);\n";
	    print FH " csl_port out1_$i(output,br1);\n";
	    print FH " csl_port in2_$i(input,br2);\n";
	    print FH " csl_port out2_$i(output,br2);\n";
	
	
	    print FH " csl_signal s1_$i($v1);\n";
	    print FH " csl_signal s2_$i($v1);\n";
	    print FH " csl_signal s3_$i($val2);\n";
        print FH " csl_signal sig1_$i(br1);\n";
	    print FH " csl_signal sig2_$i(br1);\n";
        print FH " csl_signal sig3_$i(br2);\n";
	    print FH " csl_signal sig4_$i(br2);\n";   
	
	print FH " u1 u1_$i(.in1_$i(sig1_$i),.out1_$i(sig2_$i),.in2_$i(sig3_$i),.out2_$i(sig4_$i));\n";
   
	print FH " u2(){\n";
   
	    print FH " {s1_$i}={in1_$i};\n";
	    print FH " out_$i={s2_$i};\n";
	    print FH " {in1_$i, in2_$i}={s1_$i,s3_$i};\n";
	    print FH " {s2_$i}={out1_$i,out2_$i};\n";
	
	print FH "}\n";
	print FH "};\n";
	
    }

    if ($i>10 && $i<=15){
	print FH " csl_bitrange br0($val);\n";
	print FH " csl_bitrange br1($val1);\n";
	print FH " csl_bitrange br2($val2);\n\n";

	print FH " csl_unit  u1 {\n";
	my $v2=2*$val;
	my $v3=3*$val1;
	my $v4=3*$val2;
	
	    print FH " csl_port in1_$i(input,$v2);\n";
	    print FH " csl_port in2_$i(input,$v3);\n";
	    print FH " csl_port in3_$i(input,$v4);\n";
	
	print FH " u1(){}\n";
	print FH "};\n";

	print FH " csl_unit  u2 {\n";
   
	    print FH " csl_port out1_$i(output,br0);\n";
	    print FH " csl_port out2_$i(output,br1);\n";
	    print FH " csl_port out3_$i(output,br2);\n";
	
	print FH " u2(){}\n";
	print FH "};\n";

	print FH " csl_unit  top {\n";
	
	    print FH " csl_port in1_$i(input,$v2);\n";
	    print FH " csl_port in2_$i(input,$v3);\n";
	    print FH " csl_port in3_$i(input,$v4);\n";
	    print FH " csl_port out1_$i(output,br0);\n";
	    print FH " csl_port out2_$i(output,br1);\n";
	    print FH " csl_port out3_$i(output,br2);\n";
	
	    print FH " csl_signal s1_$i(br0);\n";
	    print FH " csl_signal s2_$i(br1);\n";
	    print FH " csl_signal s3_$i(br1);\n";
	    print FH " csl_signal s4_$i(br2), s5_$i(br2);\n";
        print FH " csl_signal sig1_$i(br0);\n";
        print FH " csl_signal sig2_$i(br1);\n";
        print FH " csl_signal sig3_$i(br2);\n";
        print FH " csl_signal sig4_$i(br0);\n";
	
	
	print FH " u1 u1_i$i(.in1_$i({sig1_$i,sig4_$i}),.in2_$i({3{sig2_$i}}),.in3_$i({3{sig3_$i}}));\n";
	print FH " u2 u2_i$i(.out1_$i(sig1_$i),.out2_$i(sig2_$i),.out3_$i(sig3_$i));\n";

	print FH " top(){\n";
	
	    print FH " in1_$i={out1_$i,s1_$i};\n";
	    print FH " in2_$i={out2_$i & s2_$i, s2_$i ^ s3_$i, s3_$i};\n";
	    print FH " in3_$i={{s4_$i,s5_$i},out3_$i};\n";
	 
	print FH "}\n";
	print FH "};\n";
    }

 if ($i>15 && $i<=20){
     print FH " csl_bitrange br1($val);\n";
     print FH " csl_bitrange br2($val2);\n\n";
     
     print FH " csl_unit  u1 {\n";
     my $v0=2*$val;  
     my $v1=4*$val2;
     
	 print FH " csl_port p1_$i(input,$v1);\n";
	 print FH " csl_port p2_$i(output, $val);\n";
     
     print FH "u1(){}\n";
     print FH " };\n";
     
     print FH "csl_unit u2 {\n";
    
	 print FH " csl_port p21_$i(output, $v1);\n";
	 print FH " csl_port p22_$i(input, $val);\n";
     
     print FH " u2(){}\n";
     print FH " };\n";
     my $o=0;
     my $val2_=$val2-1;
     my $ui=2*$val2-1;

     print FH "csl_unit top {\n";
     print FH " csl_signal s1($val2);\n";
     print FH " csl_signal s10($val2);\n";
     print FH " csl_signal s2($v0);\n";
     print FH " csl_signal s20;\n";
     print FH " csl_signal sig1_$i($v1);\n";
     print FH " csl_signal sig2_$i($val);\n";
     print FH " csl_signal sig3_$i($v1);\n";
     print FH " csl_signal sig4_$i($val);\n";

	 print FH " csl_port p1_$i(input,$v1);\n";
	 print FH " csl_port p2_$i(output, $val);\n";
     
     
	 print FH " csl_port p21_$i(output, $v1);\n";
	 print FH " csl_port p22_$i(input, $val);\n";
     
     print FH " u1 u1_i(.p1_$i(sig1_$i),.p2_$i(sig2_$i));\n";
     print FH " u2 u2_i(.p21_$i(sig3_$i),.p22_$i(sig4_$i));\n";
     print FH "top(){\n";
     
	 print FH " p1_$i={{3{s1}},s10};\n"; 
	 print FH " {s2,s20}={{2{p2_$i}},1'b0};\n";
	 print FH " {s1,s10}={p21_$i [$o:$val2_],p21_$i [$val2:$ui]};\n";
	 print FH " p22_$i ={p2_$i};\n";  
     
     print FH "}\n";
     print FH " };\n";
 
}
#*******************************************************
# ifc.port={concat_expr};
# sg.sig={concat_expr}

 if ($i>20 && $i<=25){
     my $v1=3 *$val1;
     my $v2=3 *$val2; 
     print FH " csl_bitrange br1($val1);\n";
     print FH " csl_bitrange br2($val2);\n\n";

     print FH " csl_interface ifc1 {\n";
     print FH " csl_port p11(input,$val1);\n";
     print FH " csl_port p12(input,$val1);\n";
     print FH " csl_port p13(input,$val1);\n";
     print FH "ifc1(){}\n";
     print FH "};\n";

     print FH " csl_interface ifc2 {\n";
     print FH " csl_port p21(output,$val2);\n";
     print FH " csl_port p22(output,$val2);\n";
     print FH " csl_port p23(output,$val2);\n";
     print FH "ifc2(){}\n";
     print FH "};\n";
    
     print FH " csl_unit u1 {\n";
    
     print FH " ifc1 ifc1_$i;\n";
     print FH " ifc2 ifc2_$i;\n";
      
     print FH " u1(){}\n";
     print FH "};\n";

     print FH " csl_unit u2 {\n";
     
     print FH " csl_port p21_$i(input,$v1);\n";
     print FH " csl_port p22_$i(output,$v2);\n"; 
     print FH " csl_signal s11_$i($val1);\n";
     print FH " csl_signal s12_$i($val1);\n";
     print FH " csl_signal s13_$i($val1);\n";
     print FH " csl_signal s21_$i($val2);\n";
     print FH " csl_signal s22_$i($val2);\n";
     print FH " csl_signal s23_$i($val2);\n";
     print FH " csl_signal sp23_$i($val2);\n";
     print FH " ifc1 ifc1_$i;\n";
     print FH " ifc2 ifc2_$i;\n";
 
     print FH " u1 u1_i(.ifc1_$i.p11(s11_$i),.ifc1_$i.p12(s12_$i),.ifc1_$i.p13(s13_$i),.ifc2_$i.p21(s21_$i),.ifc2_$i.p22(s22_$i),.ifc2_$i.p23(s23_$i));\n";
     print FH " u2(){\n";
    
     print FH " p21_$i={ifc1_$i.p11,ifc1_$i.p12,ifc1_$i.p13};\n";
     print FH " p22_$i={{2{ifc2_$i.p21}},ifc2_$i.p22 + ifc2_$i.p22};\n";
     print FH " ifc2_$i.p23=sp23_$i;\n";
 
    print FH "}\n";
    print FH "};\n";
 }
 if ($i>25 && $i<=30){
     my $v1=2 *$val1 + 2;
     my $v2=4 *$val2; 
     print FH " csl_bitrange br1($val1);\n";
     print FH " csl_bitrange br2($val2);\n\n";

     print FH " csl_interface ifc1 {\n";
     print FH " csl_port p11(input,$v1);\n";
     print FH " csl_port p12(input,$val1);\n";
     print FH " csl_port p13(input,$val1);\n";
     print FH "ifc1(){}\n";
     print FH "};\n";

     print FH " csl_interface ifc2 {\n";
     print FH " csl_port p21(output,$v2);\n";
     print FH " csl_port p22(output,$val2);\n";
     print FH " csl_port p23(output,$val2);\n";
     print FH "ifc2(){}\n";
     print FH "};\n";

     print FH " csl_unit u1 {\n";
    
     print FH " ifc1 ifc1_$i;\n";
     print FH " ifc2 ifc2_$i;\n";
        
     print FH " u1(){}\n";
     print FH "};\n"; 

     print FH " csl_unit u2 {\n";
    
     print FH " ifc1 ifc1_$i;\n";
     print FH " ifc2 ifc2_$i;\n";
        
     
     print FH "ifc2 ifc2_i$i;\n";
     print FH " csl_port p21_$i(input,$v1);\n";
     print FH " csl_port p22_$i(output,$v2);\n"; 
     print FH " csl_port p23_$i(input, $val1);\n";
     print FH " csl_port p24_$i(input,$val1);\n";
     print FH " csl_signal s11_$i($v1);\n";
     print FH " csl_signal s12_$i($val1);\n";
     print FH " csl_signal s13_$i($val1);\n";
     print FH " csl_signal s21_$i($v2);\n";
     print FH " csl_signal s22_$i($val2);\n";
     print FH " csl_signal s23_$i($val2);\n";
 
     print FH " u1 u1_i(.ifc1_$i.p11(s11_$i),.ifc1_$i.p12(s12_$i),.ifc1_$i.p13(s13_$i),.ifc2_$i.p21(s21_$i),.ifc2_$i.p22(s22_$i),.ifc2_$i.p23(s23_$i));\n";
     print FH " u2(){\n";
     
         print FH " p21_$i={{2{ifc1_$i.p12}},2'b11};\n";
         print FH " ifc2_$i.p21={{2{ifc2_i$i.p22}},{2{ifc2_i$i.p22 & ifc2_i$i.p23}}};\n";
         print FH " {ifc1_$i.p12, ifc1_$i.p13}={p23_$i,p24_$i};\n";
     
    print FH "}\n";
    print FH "};\n"; 

  print FH " csl_unit top {\n";
   
     print FH " csl_signal sig21_$i($v2);\n";
    
     print FH " csl_signal s11_$i($v1);\n";
     print FH " csl_signal s12_$i($val1);\n";
     print FH " csl_signal s13_$i($val1);\n";
     print FH " csl_signal s21_$i($v2);\n";
     print FH " csl_signal s22_$i($val2);\n";
     print FH " csl_signal s23_$i($val2);\n";
     print FH " csl_signal s21_i$i($v2);\n";
     print FH " csl_signal s22_i$i($val2);\n";
     print FH " csl_signal s23_i$i($val2);\n";
    
     print FH " u2 u2_$i(.ifc1_$i.p11(s11_$i),.ifc1_$i.p12(s12_$i),.ifc1_$i.p13(s13_$i),.ifc2_$i.p21(s21_$i),.ifc2_$i.p22(s22_$i),.ifc2_$i.p23(s23_$i),.ifc2_i$i.p21(s21_i$i),.ifc2_i$i.p22(s22_i$i),.ifc2_i$i.p23(s23_i$i),.p22_$i(sig21_$i));\n";
     print FH " top(){\n";
     
        
    print FH "}\n";
    print FH "};\n";
 }

 if ($i>30 && $i<=35){
     my $v1=2 *$val1;
     my $v2=4 *$val2; 
     print FH " csl_bitrange br1($val1);\n";
     print FH " csl_bitrange br2($val2);\n\n";

     print FH " csl_interface ifc1 {\n";
     print FH " csl_port p11(input,$v1);\n";
     print FH " csl_port p12(input,$val1);\n";
     print FH " csl_port p13(input,$val1);\n";
     print FH " csl_port p14(output,$val2);\n";
     print FH " csl_port p15(output,$val2);\n";
     print FH "ifc1(){}\n";
     print FH "};\n";

     print FH " csl_signal_group sg1 {\n";
     print FH " csl_signal s11($v2);\n";
     print FH " csl_signal s12($val2);\n";
     print FH " csl_signal s13($val2);\n";
     print FH " csl_signal s14($v1);\n";
     print FH " csl_signal s15($v1);\n";
     print FH "sg1(){}\n";
     print FH "};\n";

     print FH " csl_unit u1 {\n";
     
     print FH " ifc1 ifc1_$i;\n";
        
     print FH " u1(){}\n";
     print FH "};\n"; 

      print FH " csl_unit u2 {\n";
    
	 print FH " sg1 sg1_$i;\n";
	 print FH " ifc1 ifc1_i$i;\n";
     print FH " ifc1 ifc1_$i;\n";
      
     print FH " u1 u1_i$i(.ifc1_$i(ifc1_$i));\n";
     print FH " u2(){\n";
     my $o=0;
     my $ui=2 *$val2 -1; 
 
     print FH " {ifc1_i$i.p14,ifc1_i$i.p15}=sg1_$i.s11[$ui:$o]; \n";
     print FH " sg1_$i.s14={ifc1_i$i.p12, ifc1_i$i.p13 ^ ifc1_i$i.p12};\n";
     print FH " {sg1_$i.s12, sg1_$i.s13}= sg1_$i.s11[$ui:$o];\n";
     print FH " ifc1_i$i.p11 =sg1_$i.s15;\n";
 
     print FH "}\n";
     print FH "};\n"; 
 }
#***********************************************************************
# concat in F2A 

 if ($i>35 && $i<=40){
     my $v1=3 *$val1;
     my $v2=3 *$val2; 
   
     print FH " csl_interface ifc1 {\n";
     print FH " csl_port p11(input,$val1);\n";
     print FH " csl_port p12(input,$val1);\n";
     print FH " csl_port p13(input,$val1);\n";
     print FH "ifc1(){}\n";
     print FH "};\n";

     print FH " csl_interface ifc2 {\n";
     print FH " csl_port p21(output,$val2);\n";
     print FH " csl_port p22(output,$val2);\n";
     print FH " csl_port p23(output,$val2);\n";
     print FH "ifc2(){}\n";
     print FH "};\n";
 
     print FH " csl_signal_group sg{\n";
     print FH " csl_signal  p11($val1);\n";
     print FH " csl_signal  p12($val1);\n";
     print FH " csl_signal  p13($val1);\n";
     print FH "sg(){}\n";
     print FH "};\n";    

     print FH " csl_unit u1 {\n";
     print FH " csl_port p1(input,$v1);\n";
#     print FH " csl_signal s1($v2);\n";
     print FH " ifc2 ifc2_i;\n";
     print FH " u1(){}\n";   
     print FH " };\n";
     
     print FH " csl_unit u2 {\n";
     print FH " csl_port p2(output,$v2);\n";
#     print FH " csl_signal s1($v1);\n";
     print FH " ifc1 ifc1_i;\n";
     print FH " u2(){}\n";   
     print FH " };\n";
     
     print FH " csl_unit top{\n";
     print FH " ifc2 ifc2_i2;\n";
     print FH " ifc2 ifc2_i;\n";
     print FH " ifc1 ifc1_i;\n";
     print FH " sg sg_i;\n";
     
     print FH " csl_signal s1_$i($val1);\n";
     print FH " csl_signal s2_$i($val2);\n";
     print FH " csl_signal s13($val1);\n";
   
        
       print FH " u1 u1_$i(.p1({s1_$i,ifc1_i.p11,ifc1_i.p12}),.ifc2_i(ifc2_i2));\n";
   
       print FH " u2 u2_$i(.p2({s2_$i & ifc2_i.p21,{ifc2_i.p22,ifc2_i.p23}}),.ifc1_i(sg_i)) ;\n";
 
     print FH " top(){\n";
     print FH " ifc1_i.p13=s13;\n";
     print FH "}\n";
     print FH " };\n";
 }
 if ($i>40 && $i<=50){ 
     my $v1=3 *$val1;
     my $v2=3 *$val2; 
     my $v3=4 * $val+2;
     my $b3 = sprintf("%b",$v3);
     print FH " csl_interface ifc1{\n";
     
         print FH "   csl_port p1_$i(input,$v1);\n";
         print FH "   csl_port p2_$i(input,$v2);\n";
     
     print FH " ifc1(){}\n";
     print FH "};\n";
     print FH " csl_signal_group sg1{\n";
      
         print FH "   csl_signal s1_$i($v1);\n";
         print FH "   csl_signal s2_$i($v3);\n";
         print FH "   csl_signal s3_$i($v2);\n";
     
     print FH " sg1(){}\n";
     print FH "};\n";
     
     print FH "csl_unit u1{\n";
      
         print FH " csl_port p1_$i(output,$val1);\n";
         print FH " csl_port p2_$i(input,$val1);\n";
         print FH " csl_port p3_$i(input,$val1);\n";
         print FH " csl_port p4_$i(output,$val2);\n";
         print FH " csl_port p5_$i(output,$v3);\n";
     
  
     print FH " csl_signal s1_$i($val1);\n";
     print FH " csl_signal s2_$i($val1);\n";
     print FH " csl_signal s3_$i($val2);\n";
     print FH " csl_signal s4_$i($val);\n";
     print FH " csl_signal s5_$i(2);\n";

     print FH " ifc1 ifc1_i;\n";
     print FH " sg1 sg1_i;\n";
     print FH " u1(){\n";
  
     print FH " p5_$i={{4{s4_$i}},2'b11 & s5_$i};\n";
     print FH " {p1_$i,p4_$i}={s1_$i,s3_$i};\n";
     print FH " ifc1_i.p1_$i={3{s2_$i}};\n";
     print FH " ifc1_i.p2_$i=sg1_i.s3_$i;\n";
     print FH " sg1_i.s2_$i = ".($v3)."'b".($b3).";\n";
     print FH " sg1_i.s1_$i={{2{p2_$i ^ p3_$i}}, p3_$i};\n";
  
     print FH " }\n";
     print FH " };\n";
 }
 if ($i>50 && $i<=60){
     my $v1=3*$val1 +4;
     my $v2=3*$val2 + 2*$val1; 
     my $v3=4*$val+2;
     print FH " csl_bitrange br1($val1);\n";
     print FH " csl_bitrange br2($val2);\n";
     print FH " csl_bitrange br3($val);\n\n";

     print FH " csl_unit u1{\n";
     print FH "   csl_port p1(input,$v1);\n";
     print FH "   csl_port p2(input,$v2);\n";
     print FH "   csl_port p3(input,5);\n";
     print FH "   csl_port p4(output,$v2);\n";
     print FH "   csl_port p5(output,$v3);\n";
     print FH "  u1(){}\n";
     print FH " };\n";

      print FH " csl_unit u2{\n";
     print FH "   csl_port p1(input,br1);\n";
#     print FH "   csl_port p2(input,br2);\n";
#     print FH "   csl_port p3(output,5);\n";
     print FH "   csl_port p4(output,$val1);\n";
     print FH "   csl_port p5(output,$val2);\n";
     print FH "   csl_signal s1(br1),s2(br1);\n";
     print FH "   csl_signal s3(br2);\n";
     print FH "   csl_signal s4(br3);\n";
     print FH "   csl_signal s5(2),s6;\n";
     foreach (my $j=51; $j<=$i; $j++){
         print FH " u1 u1_i$j(.p1({s1,p1,s2,4'b1000}),\n";
         print FH "           .p2({{3{s3}},{2{s1 + s2}}}),\n";
         print FH "           .p3({s5 & 2'b10,3'b010}),\n";
         print FH "           .p4({{3{p5}},{2{p4}}}),\n";
         print FH "           .p5({{4{s4}},s6 | 1'b1, 1'b0}));\n";
     }
     print FH "  u2(){\n";
     print FH "}\n";
     print FH " };\n";
 }
}
    close (FH);
}