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

foreach(my $i = 1; $i <=70; $i++) {
    &main($i);
 
}

sub main {
    my $i = $_[0];
    my $test_name = "connect_op_expr_ifc_test".$i."_illegal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen/";
 if($i==1){
        print ("Generated path: $path/ar_connect_op_expr_ifc_invalid/ \n");}
    my $val = int(rand(500));
    if($val == 0) { $val = 1; }
    my $val1= int(rand(200));
    if($val1== 0) { $val1= 1; }
    my $val2 = int(rand(100));
    if($val2==0) {$val2=1;}
    if($test_name=~/(_illegal)/){
        &mkDir("$path/ar_connect_op_expr_ifc_invalid");
        open(FH,">$path/ar_connect_op_expr_ifc_invalid/$test_name");
    }


#op_expr.connect(ifc.port);   
    if($i>0 && $i<=10){

    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--ifc.port\n\n";
    print FH "// INVALID TEST $i;\n";
    
    print FH " csl_interface ifc1 {\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val1);\n";
    print FH "   csl_port p13(output,$val2);\n";
    print FH "   csl_port p14(output);\n";
    print FH " ifc1(){}\n";
    print FH " };\n";

    print FH " csl_unit u1{\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val);\n";
    print FH "   csl_port p13(output,$val1);\n";
    print FH "   csl_port p14(output,$val1);\n";
    print FH "   ifc1 ifc1_i1;\n";
    print FH " u1(){}\n";
    print FH " };\n";

    print FH " csl_unit u2{\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val);\n";
    print FH "   csl_port p23(output,$val1);\n";
    print FH "   csl_port p24(output,$val1);\n";
    print FH "   u1 u1_i1;\n";
    print FH "   u1 u1_i2;\n";
    print FH "   ifc1 ifc1_i2;\n";
    print FH " u2(){\n";
    print FH " (p21 - p22).connect(u1_i1.ifc1_i1.p11);      //invalid connection: operation_expr--unit.ifc.port\n";
    print FH " (~p23).connect(u1_i2.ifc1_i1.p12);           //invalid connection: operation_expr--unit.ifc.port\n";    
    print FH " (1'b0 ^1'b1).connect(u1_i2.ifc1_i1.p14);     //invalid connection: operation_expr--unit.ifc.port\n";
    print FH " }\n";
    print FH " };\n";

    print FH " csl_unit top{\n";
    print FH " csl_signal s1($val),s2($val);\n";
    print FH " csl_signal s3($val2),s4($val2);\n";
    print FH " csl_signal s5,s6,s7;\n";
   
  foreach(my $j=1; $j<=$i; $j++){
        print FH " u2 u2_i$j;\n";
    }
    print FH " top(){\n";
  foreach( my $j=1; $j<=$i; $j++){
    print FH " (s1 & s2).connect(u2_i$j.ifc1_i2.p11);           //invalid connection: operation_expr--unit.ifc.port\n"; 
    print FH " (s1 ^ s2).connect(u2_i$j.ifc1_i2.p12);           //invalid connection: operation_expr--unit.ifc.port\n";
    print FH " (s3 + s4).connect(u2_i$j.ifc1_i2.p13);           //invalid connection: operation_expr--unit.ifc.port\n";
    print FH " ((s5 & s6) | s7).connect(u2_i$j.ifc1_i2.p14);    //invalid connection: operation_expr--unit.ifc.port\n";
    print FH " ((s5 & s6) | 1'b0).connect(u2_i$j.u1_i1.ifc1_i1.p14);   //invalid connection: operation_expr--unit.unit.ifc.port\n";  
}
    print FH " }\n";
    print FH " };\n";
}
#***************************************************
#op_expr.connect(ifc.port[ps]);

 if($i>10 && $i<=20){
  print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--ifc.port[part_select]\n\n";
    print FH "// INVALID TEST $i;\n";
    
    print FH " csl_interface ifc1 {\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val1);\n";
    print FH "   csl_port p13(output,$val2);\n";
    print FH "   csl_port p14(output);\n";
    print FH " ifc1(){}\n";
    print FH " };\n";

    print FH " csl_unit u1{\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val);\n";
    print FH "   csl_port p13(output,$val1);\n";
    print FH "   csl_port p14(output,$val1);\n";
    print FH "   ifc1 ifc1_i1;\n";
    print FH " u1(){}\n";
    print FH " };\n";

    my $ui1=$val-1;
    my $ui2=$val1-1;
    my $ui3=$val2-1;
    my $o=0;
    print FH " csl_unit u2{\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val);\n";
    print FH "   csl_port p23(output,$val1);\n";
    print FH "   csl_port p24(output,$val1);\n";
    print FH "   u1 u1_i1;\n";
    print FH "   u1 u1_i2;\n";
    print FH "   ifc1 ifc1_i2;\n";
    print FH " u2(){\n";
    print FH " (p21 - p22).connect(u1_i1.ifc1_i1.p11[$o:$ui1]);      //invalid connection: operation_expr--unit.ifc.port[ps]\n";
    print FH " (~p23).connect(u1_i2.ifc1_i1.p12[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.port[ps]\n";    
    print FH " (1'b0 ^1'b1).connect(u1_i2.ifc1_i1.p14[$o:$ui2]);     //invalid connection: operation_expr--unit.ifc.port[ps]\n";
    print FH " }\n";
    print FH " };\n";

    print FH " csl_unit top{\n";
    print FH " csl_signal s1($val),s2($val);\n";
    print FH " csl_signal s3($val2),s4($val2);\n";
    print FH " csl_signal s5,s6,s7;\n";
   
  foreach(my $j=11; $j<=$i; $j++){
        print FH " u2 u2_i$j;\n";
    }
    print FH " top(){\n";
  foreach( my $j=11; $j<=$i; $j++){
    print FH " (s1 & s2).connect(u2_i$j.ifc1_i2.p11[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.port[ps]\n"; 
    print FH " (s1 ^ s2).connect(u2_i$j.ifc1_i2.p12[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.port[ps]\n";
    print FH " (s3 + s4).connect(u2_i$j.ifc1_i2.p13[$o:$ui2]);           //invalid connection: operation_expr--unit.ifc.port[ps]\n";
    print FH " ((s5 & s6) | s7).connect(u2_i$j.ifc1_i2.p14[$o:$ui2]);    //invalid connection: operation_expr--unit.ifc.port[ps]\n";
    print FH " ((s5 & s6) | 1'b0).connect(u2_i$j.u1_i1.ifc1_i1.p14[$o:$ui2]);   //invalid connection: operation_expr--unit.unit.ifc.port[ps]\n";  
}
    print FH " }\n";
    print FH " };\n";
}

#***************************************************
#op_expr.connect(ifc.ifc1.port);

 if($i>20 && $i<=30){
    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--ifc.ifc1.port\n\n";
    print FH "// INVALID TEST $i;\n";
    
    print FH " csl_interface ifc1 {\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val1);\n";
    print FH "   csl_port p13(output,$val2);\n";
    print FH "   csl_port p14(output);\n";
    print FH " ifc1(){}\n";
    print FH " };\n";

    print FH " csl_interface ifc2 {\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val1);\n";
    print FH "   csl_port p23(output,$val2);\n";
    print FH "   csl_port p24(output);\n";
 foreach(my $j=21; $j<=$i; $j++){
     print FH "   ifc1 ifc1_i$j;\n";
 }
    print FH " ifc2(){}\n";
    print FH " };\n";

   print FH " csl_unit u1{\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val);\n";
    print FH "   csl_port p13(output,$val1);\n";
    print FH "   csl_port p14(output,$val1);\n";
    print FH "   ifc2 ifc2_i1;\n";
    print FH " u1(){}\n";
    print FH " };\n";

    print FH " csl_unit u2{\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val);\n";
    print FH "   csl_port p23(output,$val1);\n";
    print FH "   csl_port p24(output,$val1);\n";
    print FH "   u1 u1_i1;\n";
    print FH "   u1 u1_i2;\n";
    print FH "   ifc2 ifc2_i2;\n";
    print FH " u2(){\n";
 foreach(my $j=21; $j<=$i; $j++){
    print FH " (p21 - p22).connect(u1_i1.ifc2_i1.ifc1_i$j.p11);      //invalid connection: operation_expr--unit.ifc.ifc1.port\n";
    print FH " (~p23).connect(u1_i2.ifc2_i1.ifc1_i$j.p12);           //invalid connection: operation_expr--unit.ifc.ifc1.port\n";    
    print FH " (1'b0 ^1'b1).connect(u1_i2.ifc2_i1.ifc1_i$j.p14);     //invalid connection: operation_expr--unit.ifc.ifc1.port\n";
}
    print FH " }\n";
    print FH " };\n";

    print FH " csl_unit top{\n";
    print FH " csl_signal s1($val),s2($val);\n";
    print FH " csl_signal s3($val2),s4($val2);\n";
    print FH " csl_signal s5,s6,s7;\n";
   
  foreach(my $j=21; $j<=$i; $j++){
        print FH " u2 u2_i$j;\n";
    }
    print FH " top(){\n";
  foreach( my $j=21; $j<=$i; $j++){
    print FH " (s1 & s2).connect(u2_i$j.ifc2_i2.ifc1_i$j.p11);           //invalid connection: operation_expr--unit.ifc.ifc1.port\n"; 
    print FH " (s1 ^ s2).connect(u2_i$j.ifc2_i2.ifc1_i$j.p12);           //invalid connection: operation_expr--unit.ifc.ifc1.port\n";
    print FH " (s3 + s4).connect(u2_i$j.ifc2_i2.ifc1_i$j.p13);           //invalid connection: operation_expr--unit.ifc.ifc1.port\n";
    print FH " ((s5 & s6) | s7).connect(u2_i$j.ifc2_i2.ifc1_i$j.p14);    //invalid connection: operation_expr--unit.ifc.ifc1.port\n";
    print FH " ((s5 & s6) | 1'b0).connect(u2_i$j.u1_i1.ifc2_i1.ifc1_i$j.p14);   //invalid connection: operation_expr--unit.unit.ifc.ifc1.port\n";  
}
    print FH " }\n";
    print FH " };\n";
}
  
#***************************************************
#op_expr.connect(ifc.ifc1.port[ps]);

 if($i>30 && $i<=40){
    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--ifc.ifc1.port[part-select]\n\n";
    print FH "// INVALID TEST $i;\n";

    print FH " csl_interface ifc1 {\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val1);\n";
    print FH "   csl_port p13(output,$val2);\n";
    print FH "   csl_port p14(output);\n";
    print FH " ifc1(){}\n";
    print FH " };\n";

    print FH " csl_interface ifc2 {\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val1);\n";
    print FH "   csl_port p23(output,$val2);\n";
    print FH "   csl_port p24(output);\n";
 foreach(my $j=31; $j<=$i; $j++){
     print FH "   ifc1 ifc1_i$j;\n";
 }
    print FH " ifc2(){}\n";
    print FH " };\n";

   print FH " csl_unit u1{\n";
    print FH "   csl_port p11(input,$val);\n";
    print FH "   csl_port p12(input,$val);\n";
    print FH "   csl_port p13(output,$val1);\n";
    print FH "   csl_port p14(output,$val1);\n";
    print FH "   ifc2 ifc2_i1;\n";
    print FH " u1(){}\n";
    print FH " };\n";

    print FH " csl_unit u2{\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val);\n";
    print FH "   csl_port p23(output,$val1);\n";
    print FH "   csl_port p24(output,$val1);\n";
    print FH "   u1 u1_i1;\n";
    print FH "   u1 u1_i2;\n";
    print FH "   ifc2 ifc2_i2;\n";
    print FH " u2(){\n";
    my $ui1=$val-1;
    my $ui2=$val1-1;
    my $ui3=$val2-1;
    my $o=0;
 foreach(my $j=31; $j<=$i; $j++){
    print FH " (p21 - p22).connect(u1_i1.ifc2_i1.ifc1_i$j.p11[$o:$ui1]);      //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";
    print FH " (~p23).connect(u1_i2.ifc2_i1.ifc1_i$j.p12[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";    
    print FH " (1'b0 ^1'b1).connect(u1_i2.ifc2_i1.ifc1_i$j.p14[$o:$ui2]);     //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";
}
    print FH " }\n";
    print FH " };\n";

  print FH " csl_unit top{\n";
    print FH " csl_signal s1($val),s2($val);\n";
    print FH " csl_signal s3($val2),s4($val2);\n";
    print FH " csl_signal s5,s6,s7;\n";
   
  foreach(my $j=31; $j<=$i; $j++){
        print FH " u2 u2_i$j;\n";
    }
    print FH " top(){\n";
  foreach( my $j=31; $j<=$i; $j++){
    print FH " (s1 & s2).connect(u2_i$j.ifc2_i2.ifc1_i$j.p11[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n"; 
    print FH " (s1 ^ s2).connect(u2_i$j.ifc2_i2.ifc1_i$j.p12[$o:$ui1]);           //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";
    print FH " (s3 + s4).connect(u2_i$j.ifc2_i2.ifc1_i$j.p13[$o:$ui2]);           //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";
    print FH " ((s5 & s6) | s7).connect(u2_i$j.ifc2_i2.ifc1_i$j.p14[$o:$ui2]);    //invalid connection: operation_expr--unit.ifc.ifc1.port[ps]\n";
    print FH " ((s5 & s6) | 1'b0).connect(u2_i$j.u1_i1.ifc2_i1.ifc1_i$j.p14[$o:$ui2]);   //invalid connection: operation_expr--unit.unit.ifc.ifc1.port[ps]\n";  
}
    print FH " }\n";
    print FH " };\n";
}
#*****************************************************
# op_expr.connect(concat_expr);
 if($i>40 && $i<=50){
    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--concat_expr\n\n";
    print FH "// INVALID TEST $i;\n";
  my $v0=3*$val + 2*$val1;
  my $v1=2*$val + $val1;
    print FH " csl_unit u1{\n";
    print FH "   csl_port p21(input,$v1);\n";
    print FH "   csl_port p22(input,$v1);\n";
    print FH "   csl_port p23(output,$v0);\n";
    print FH "   csl_port p24(output,$v0);\n";
    print FH "   csl_signal s1($val),s2($val);\n";
    print FH "   csl_signal s3($val1),s4($val1);\n";
   
    print FH " u1(){\n";
   
    print FH " (p21 - p22).connect({s1,s2,s3});             //invalid connection: operation_expr--concat_expr\n";
    print FH " (p23 | p24).connect({s1,s2,{s1,s3},s4});     //invalid connection: operation_expr--concat_expr\n";    
    print FH " (p23 + p24).connect({s2,s1,{s3,s4,s2}});     //invalid connection: operation_expr--concat_expr\n";

    print FH " }\n";
    print FH " };\n";

  print FH " csl_unit top{\n";
    my $v2=$val + $val2;
    my $v3=2*($val + $val2);
    print FH " csl_port p1(input,$val),p2(input,$val);\n";
    print FH " csl_port p3(output,$val2),p4(output,$val2);\n";
    print FH " csl_port p5(input),p6(input),p7(output);\n";
    print FH " csl_signal s1($v2),s2($v2);\n";
    print FH " csl_signal s3($v3),s4($v3);\n";
    print FH " csl_signal s5,s6,s7;\n";
    print FH " u1 u1_i;  \n";
 
    print FH " top(){\n";
  
    print FH " (s1 & s2).connect({p1, p3});                  //invalid connection: operation_expr--concat_expr\n"; 
    print FH " (s1 ^ s2).connect({p2,p4});                  //invalid connection: operation_expr--concat_expr\n";
    print FH " (s3 + s4).connect({p1,p2,p3,p4});            //invalid connection: operation_expr--concat_expr\n";
  

    print FH " }\n";
    print FH " };\n";
}

#*****************************************************
# op_expr.connect(op_expr);
 if($i>50 && $i<=60){
    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--op_expr\n\n";
    print FH "// INVALID TEST $i;\n";

  print FH " csl_unit u1{\n";
    print FH "   csl_port p21(input,$val);\n";
    print FH "   csl_port p22(input,$val);\n";
    print FH "   csl_port p23(output,$val1);\n";
    print FH "   csl_port p24(output,$val1);\n";
    print FH "   csl_signal s1($val),s2($val);\n";
    print FH "   csl_signal s3($val1),s4($val1);\n";
   
    print FH " u1(){\n";
   
    print FH " (p21 - p22).connect(s1^s2);       //invalid connection: operation_expr--operation_expr\n";
    print FH " (~p23).connect(~s4);              //invalid connection: operation_expr-operation_expr\n";    
    print FH " (p23 + p24).connect(s3 - s4);     //invalid connection: operation_expr--operation_expr\n";

    print FH " }\n";
    print FH " };\n";

  print FH " csl_unit top{\n";
    print FH " csl_port p1(input,$val),p2(input,$val);\n";
    print FH " csl_port p3(output,$val2),p4(output,$val2);\n";
    print FH " csl_port p5(input),p6(input),p7(output);\n";
    print FH " csl_signal s1($val),s2($val);\n";
    print FH " csl_signal s3($val2),s4($val2);\n";
    print FH " csl_signal s5,s6,s7;\n";
    print FH " u1 u1_i;  \n";
 
    print FH " top(){\n";
  
    print FH " (s1 & s2).connect(p1 & p2);                  //invalid connection: operation_expr--op_expr\n"; 
    print FH " (s1 ^ s2).connect(p1 ^ p2);                  //invalid connection: operation_expr--op_expr\n";
    print FH " (s3 + s4).connect(p3 + p4);                  //invalid connection: operation_expr--op_expr\n";
    print FH " ((s5 & s6) | s7).connect((p5 & p6) | p7);    //invalid connection: operation_expr--op_expr\n";
    print FH " ((s5 & s6) | 1'b0).connect((p5 & p6) | 1'b0);   //invalid connection: operation_expr--op_expr\n";  

    print FH " }\n";
    print FH " };\n";
}

#*****************************************************
# op_expr.connect(replic_expr);
 if($i>60 && $i<=70){
    print FH "//Generated by Monica\n";
    print FH "//Connect op_expr--replic_expr\n\n";
    print FH "// INVALID TEST $i;\n";
    my $v0=3*($val + $val1);
    my $v1=2*$val + $val1;
    print FH " csl_unit u1{\n";
    print FH "   csl_port p21(input,$v1);\n";
    print FH "   csl_port p22(input,$v1);\n";
    print FH "   csl_port p23(output,$v0);\n";
    print FH "   csl_port p24(output,$v0);\n";
    print FH "   csl_signal s1($val),s2($val);\n";
    print FH "   csl_signal s3($val1),s4($val1);\n";
   
    print FH " u1(){\n";
   
    print FH " (p21 - p22).connect({{2{s1}},s4});     //invalid connection: operation_expr--replic_expr\n";
    print FH " (p23 | p24).connect({3{s1,s3}});      //invalid connection: operation_expr--replic_expr\n";    
    print FH " (p23 + p24).connect({3{s2,s4}});      //invalid connection: operation_expr--replic_expr\n";

    print FH " }\n";
    print FH " };\n";

  print FH " csl_unit top{\n";
    my $v2=3*($val + $val2);
    my $v3=2*($val + $val2);
    print FH " csl_port p1(input,$val),p2(input,$val);\n";
    print FH " csl_port p3(output,$val2),p4(output,$val2);\n";
    print FH " csl_port p5(input),p6(input),p7(output);\n";
    print FH " csl_signal s1($v2),s2($v2);\n";
    print FH " csl_signal s3($v3),s4($v3);\n";
    print FH " csl_signal s5,s6,s7;\n";
    print FH " u1 u1_i;  \n";
 
    print FH " top(){\n";
  
    print FH " (s1 & s2).connect({3{p1, p3}});           //invalid connection: operation_expr--replic_expr\n"; 
    print FH " (s1 ^ s2).connect({3{p2,p4}});            //invalid connection: operation_expr--replic_expr\n";
    print FH " (s3 + s4).connect({2{p1,p4}});            //invalid connection: operation_expr--replic_expr\n";
  

    print FH " }\n";
    print FH " };\n";
}

    close (FH);
}
