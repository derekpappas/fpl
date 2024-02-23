#!/usr/bin/perl 
use strict;
require "Test_Scripts.pm";

#Author: Monica
#invalid tests for f2a statement 
#Test_Matrix: /test_matrices/Interconnect_F2A_matrix.ods
    
   
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $test_valid_dir="f2a_valid1";
    my $test_invalid_dir="f2a_invalid1";
    print "Generated tests path : test/csl_test_gen/$test_invalid_dir/\n";

use Test_Scripts;
    my $author="Monica";
    my $test_matr="Interconnect_F2A_matrix.ods";
 

sub mkIfc1 {
    my($ifcName) = @_;
     print FH " csl_interface $ifcName {\n";
     print FH "    csl_port p1(input,br1);\n";
     print FH "    csl_port p2(output,br2);\n";
     print FH "   $ifcName (){}\n";
     print FH "   };\n\n";
}
sub mkSg1 {
    my($sgName) = @_;
     print FH " csl_signal_group $sgName {\n";
     print FH "    csl_signal s1(br1);\n";
     print FH "    csl_signal s2(br2);\n";
     print FH "   $sgName (){}\n";
     print FH "   };\n\n";
}

foreach(my $i = 1; $i <= 50; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
      
    my $test_name = "f2a".$i."_illegal.csl";
   
	&createCslFile($test_name, $i);
    
   }

sub rand {
    my ($rand_val,$add_val)=@_;
    my $res=rand($rand_val)+ $add_val;
    return $res;
}
sub createCslFile {
    my($test_name, $i) = @_;
   
   &mkName($path,$test_invalid_dir,$test_name);
 

    my $k = int(&rand(20,int(&rand(20,0))));
    my $zero = 0;
    my $val1 = int(&rand(100,4));
    my $val2 = int(&rand(100,3));
    my $val3 = int(&rand(100,8));
    my $l = int(&rand(3,1));
    my $l1=$l+1;
    my $j;
     my $up1=$val1-1;
     my $up2=$val2-1;
 &each_test($author,$test_matr); 

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";


    if($i>0 && $i<=10){

	&mkIfc1("ifc1_$i");
        &mkSg1("sg1_$i");

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1(input,br1);\n";
    print FH "   csl_port p2(output,br2);\n";
    print FH " ifc1_$i ifc1_i$i;\n";
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg2_$i {\n";
    print FH "   csl_signal s1(br1);\n";
    print FH "   csl_signal s2(br2);\n";
    print FH " sg1_$i sg1_i$i;\n";

    print FH "   sg2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
 foreach (my $j=1; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
  
    
 foreach (my $j=1; $j<=$i; $j++){
     print FH " sg2_$i sg2_i$j;\n";
} 
     print FH " u1_$i u1_i$i( \n";
   foreach (my $j=1; $j<=$i; $j++){
       if($j<$i){
      print FH " .ifc2_i$j.p1(sg2_i$j.s1),.ifc2_i$j.p2(sg2_i$j.s2 & $val2),\n";
      print FH " .ifc2_i$j.ifc1_i$i.p2(1'b1 | sg2_i$j.sg1_i$i.s2 ),.ifc2_i$j.ifc1_i$i.p1(sg2_i$j.sg1_i$i.s1), // f2a illegal: port(input)=> op_expr,verinum\n";  
     }
  else {
      print FH " .ifc2_i$j.p1(sg2_i$j.s1),.ifc2_i$j.p2(sg2_i$j.s2 & $val2),\n";
      print FH " .ifc2_i$j.ifc1_i$i.p2(1'b1 | sg2_i$j.sg1_i$i.s2 ),.ifc2_i$j.ifc1_i$i.p1(sg2_i$j.sg1_i$i.s1)); // f2a illegal: port(input)=> op_expr,verinum\n";  
}

}
      
     print FH "   u2_$i(){\n";
    
    print FH "   }\n";
    print FH "   };\n\n";
}



 if($i>10 && $i<=20){

     &mkSg1("sg1_$i");
	
 print FH " csl_unit u1_$i {\n";
 foreach (my $j=11; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
 foreach (my $j=11; $j<=$i; $j++){
     print FH " csl_port p1_$j(input,br1);\n";
     print FH " csl_port p2_$j(output,br2);\n";
}

 foreach (my $j=11; $j<=$i; $j++){
    print FH " u1_$i u1_i$j(\n";
 foreach (my $k=11; $k<=$j; $k++){
if($k<$j){
    print FH "              .sg1_i$j.s1 [$up1:$zero](p1_$k [$up1:$zero]),.sg1_i$j.s2(p2_$k [$up2:$zero]),   //f2a illegal: sig.ps => p.ps, sig=>p.ps\n";       
}
    else{
   print FH "              .sg1_i$j.s1 [$up1:$zero](p1_$k [$up1:$zero]),.sg1_i$j.s2(p2_$k [$up2:$zero]));   //f2a illegal: sig.ps => p.ps, sig=>p.ps\n";       
}
}
}
    print FH "   u2_$i(){\n";

    print FH "   }\n";
    print FH "   };\n\n";

    
 print FH " csl_unit top_$i {\n";
 foreach (my $j=11; $j<=$i; $j++){
     print FH " sg1_$i sg11_$j;\n";
     print FH " sg1_$i sg12_$j;\n";
}
    print FH " u2_$i u2_i$i( \n";
 foreach (my $j=11; $j<=$i; $j++){
if($j<$i){
    print FH "              .p1_$j(sg11_$j),.p2_$j.s2(sg12_$j),   //f2a illegal: p => sg\n";       
}
    else{
    print FH "              .p1_$j(sg11_$j),.p2_$j.s2(sg12_$j));   //f2a illegal: p => sg\n";             
}
}

    print FH "   top_$i(){\n";

    print FH "   }\n";
    print FH "   };\n\n";

   }

if($i>20 && $i<=30){

     &mkSg1("sg1_$i");

     my $c1=$val1+$val2;
     my $up1=$c1-1;
    

 print FH " csl_unit u1_$i {\n";
 foreach (my $j=21; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

     print FH " csl_unit u2_$i {\n";
 foreach (my $j=21; $j<=$i; $j++){
     print FH " csl_port p1_$j(input,$c1);\n";
    
     }

     print FH " u1_$i u1_i$i(";
foreach (my $j=21; $j<=$i; $j++){
    if($j<$i){
      print FH" .{sg1_i$j.s1,sg1_i$j.s2}(p1 [$up1:$zero]),  //f2a illegal: concat_expr => port.ps\n";
     }
    else{
      print FH" .{sg1_i$j.s1,sg1_i$j.s2}(p1 [$up1:$zero]));\n";
}
  }
    print FH " u2_$i(){ \n";
   
    print FH "   }\n";
    print FH "   };\n\n";
     }

if($i>30 && $i<=40){

     &mkSg1("sg1_$i");

     
     my $c2=2*$val1;
     my $c3=2*$val2;
    
     my $up1=$c2-1;
     my $up2=$c3-1;

 print FH " csl_unit u1_$i {\n";
 foreach (my $j=31; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

     print FH " csl_unit u2_$i {\n";
 foreach (my $j=31; $j<=$i; $j++){
     print FH " csl_port p2_$j(input,$c2);\n";
     print FH " csl_port p3_$j(input,$c3);\n";
     }

     print FH " u1_$i u1_i$i(";
foreach (my $j=31; $j<=$i; $j++){
    if($j<$i){
      print FH" .{2{sg1_i$j.s1}}(p2_$j [$up1:$zero]),.{2{sg1_i$j.s2}}(p3_$j [$up2:$zero]),  //f2a illegal: replic_expr => port.ps\n";
     }
    else{
      print FH" .{2{sg1_i$j.s1}}(p2_$j [$up1:$zero]),.{2{sg1_i$j.s2}}(p3_$j [$up2:$zero]));\n";
}
  }
    print FH " u2_$i(){ \n";
   
    print FH "   }\n";
    print FH "   };\n\n";
     }

if($i>40 && $i<=50){

     &mkSg1("sg1_$i");

     my $c1=$val1+3;
     my $c2=$val2+2;
    

     my $up1=$c1-1;
     my $up2=$c2-1;

 print FH " csl_unit u1_$i {\n";
 foreach (my $j=41; $j<=$i; $j++){
    print FH " csl_signal s1_$j($c1);\n";
    print FH " csl_signal s2_$j($c2);\n";
  } 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

     print FH " csl_unit u2_$i {\n";
 foreach (my $j=41; $j<=$i; $j++){
     print FH " csl_port p1_$j(input,$c1);\n";
     print FH " csl_port p2_$j(input,$c2);\n";
     }

     print FH " u1_$i u1_i$i(";
foreach (my $j=41; $j<=$i; $j++){
    if($j<$i){
      print FH" .s1_$j(p1_$j),.s2_$j(p2_$j [$up2:$zero]),   //f2a: sig => port, sig=>port.ps\n";
     }
    else{
     print FH" .s1_$j(p1_$j),.s2_$j(p2_$j [$up2:$zero]));\n";  
}
  }
    print FH " u2_$i(){ \n";
   
    print FH "   }\n";
    print FH "   };\n\n";
     }


	  }















