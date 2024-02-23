#!/usr/bin/perl 
use strict;
require "Test_Scripts.pm";

#Author: Monica
#connect_by_pattern() 
#Test_Matrix: /test_matrices/ar_conn_by_pattern_matr.ods, 35 test cases
    
   
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $test_valid_dir="ar_conn_patern_p_s_ifcp_sgs_valid";
    my $test_invalid_dir="ar_conn_patern_p_s_ifcp_sgs_invalid";
    print "Generated tests path : test/csl_test_gen/$test_valid_dir/\n";

use Test_Scripts;
    my $author="Monica";
    my $test_matr="ar_conn_by_pattern_matr.ods";

sub mkIfc1 {
    my($ifcName,$width) = @_;
     print FH " csl_interface $ifcName {\n";
     print FH "    csl_port x1(input,$width);\n";
     print FH "   $ifcName (){}\n";
     print FH "   };\n\n";
}
sub mkSg1 {
    my($sgName,$width) = @_;
     print FH " csl_signal_group $sgName {\n";
     print FH "    csl_signal x1($width);\n";
     print FH "   $sgName (){}\n";
     print FH "   };\n\n";
}


foreach(my $i = 1; $i <= 60; $i++) {
    &main($i);
}
 
sub main {
    my $i = $_[0];
      
    my $test_name = "ar_conn_pattern_p_s_ifcp_sgs".$i."_legal.csl";
   
	&createCslFile($test_name, $i);
    
   }

sub rand {
    my ($rand_val,$add_val)=@_;
    my $res=rand($rand_val)+ $add_val;
    return $res;
}

     
sub createCslFile {
    my($test_name, $i) = @_;
   
   &mkName($path,$test_valid_dir,$test_name);
 

    my $k = int(&rand(20,int(&rand(20,0))));
    my $zero = 0;
    my $val1 = int(&rand(100,4));
    my $val2 = int(&rand(100,3));
    my $val3 = int(&rand(100,8));
    my $j;
    my $up1 =$val1-1;
    my $up2 =$val2-1;
    my $up3 =$val3-1;
    my $up4 =$val3-3;
    
 &each_test($author,$test_matr); 

 if($i>0 && $i<=10) {

	&mkIfc1("ifc1_$i","$val1");
   
    print FH " csl_unit u1_$i {\n";
    print FH "   csl_port p_u1(input,$val2);\n";
    print FH "   ifc1_$i ifc1_i$i;\n";
   
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "   csl_port p_u2(input,$val3);\n";
    foreach (my $j=1; $j<=$i; $j++){  
    print FH "   u1_$i u1_i$j;\n";
      } 
    print FH "   u2_$i(){\n";
    print FH " }\n";
    print FH "   };\n\n";

    print FH " csl_unit u3_$i { \n";
    print FH "   csl_port p_u3(input,$val2);\n";
    print FH "   csl_signal s_u3( $val3 );\n";
    print FH "   ifc1_$i ifct_i$i;\n";
    print FH "   u2_$i u2_i$i;\n";
     
    print FH "   u3_$i(){\n";

	print FH " p_u3.connect_by_pattern(p_u1);           //port--port\n";
        print FH " ifct_i$i.connect_by_pattern(ifc1_i$i);   //ifc--ifc\n";
        print FH " s_u3.connect_by_pattern(p_u2);           //sig--port\n";

    print FH " }\n";
    print FH "   };\n\n";
}
 if($i>10 && $i<=20) {

	&mkIfc1("ifc1_$i","$val2");
        &mkIfc1("ifc2_$i","$val3");
 	&mkSg1("sg1_$i","$val2");
        &mkSg1("sg2_$i","$val3");

    print FH " csl_unit u1_$i {\n";
    print FH "   csl_signal s_u1($val2);\n";
  
    print FH "   ifc1_$i ifc1_i$i;\n";
    print FH "   sg1_$i  sg1_i$i;\n";
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "   csl_port p_u2(input,$val2);\n";
    print FH "   csl_port p_u22(output,$val3);\n";
    print FH "   csl_port p_u11(input,$val3);\n";
    print FH "   ifc1_$i ifc2_i$i;\n";
    print FH "   ifc2_$i ifc22_i$i;\n";
    print FH "   sg1_$i  sg2_i$i;\n";
    foreach (my $j=1; $j<=$i; $j++){  
    print FH "   u1_$i u1_i$j;\n";
      } 
    print FH "   u2_$i(){\n";
        print FH " p_u2.connect_by_pattern(s_u1);          //port--sig\n";
        print FH " ifc2_i$i.connect_by_pattern(sg1_i$i);   //ifc--sg\n";
        print FH " sg2_i$i.connect_by_pattern(ifc1_i$i);   //sg--ifc\n";
    print FH " }\n";
    print FH "   };\n\n";

    print FH " csl_unit u3_$i {\n";
    print FH "   csl_port p_u3(input,$val3);\n";
    print FH "   csl_signal s_u3($val2);\n";
    print FH "   ifc2_$i ifc3_i$i;\n";
    print FH "   sg2_$i  sg3_i$i;\n";
    print FH "   ifc1_$i ifc13_i$i;\n";
    print FH "   sg1_$i  sg13_i$i;\n";
    foreach (my $j=1; $j<=$i; $j++){  
    print FH "   u2_$i u2_i$j;\n";
      } 
    print FH "   u3_$i(){\n";
        print FH " p_u3.connect_by_pattern(ifc22_i$i.x1);         //port--ifc.port\n";
        print FH " s_u3.connect_by_pattern(p_u2);                 //sig--port\n";
        print FH " sg3_i$i.x1.connect_by_pattern(p_u22);          //sg.sig--port\n";
        print FH " ifc3_i$i.x1.connect_by_pattern(p_u11);         //ifc.port--port\n";
        print FH " ifc13_i$i.x1.connect_by_pattern(sg2_i$i.x1);   //ifc.port--sg.sig\n";
        print FH " sg13_i$i.x1.connect_by_pattern(ifc2_i$i.x1);   //sg.sig--ifc.port\n";
    print FH " }\n";
    print FH "   };\n\n";

    }
if($i>20 && $i<=30) {
  	&mkIfc1("ifc1_$i","$val1");
        &mkIfc1("ifc2_$i","$val3");

    print FH " csl_unit u1_$i {\n";
    print FH "   csl_signal s_u1($val3);\n";
  
    print FH "   ifc1_$i  ifc1_i$i;\n";
    print FH "   ifc2_$i  ifc21_i$i;\n";
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "   csl_port p_u2(input,$val3);\n";
    print FH "   csl_signal s_u2($val1);\n";
    print FH "   ifc1_$i ifc2_i$i;\n";
    foreach (my $j=1; $j<=$i; $j++){  
    print FH "   u1_$i u1_i$j;\n";
      } 
    print FH "   u2_$i(){\n";
        print FH " p_u2[$up4:$zero].connect_by_pattern(ifc21_i$i.x1[$up4:$zero]);      //port.ps--ifc.port.ps\n";
        print FH " ifc2_i$i.x1[$up3:$zero].connect_by_pattern(s_u1[$up3:$zero]);       //ifc.port.ps--sig.ps\n";
        print FH " s_u2[$up1:$zero].connect_by_pattern(ifc1_i$i.x1);                   //sig.ps--ifc.port\n";
    print FH " }\n";
    print FH "   };\n\n";


    print FH " csl_unit u3_$i {\n";
    print FH "   csl_port p1_u3(input,$val3);\n";
    print FH "   csl_port p2_u3(output,$val1);\n";
    print FH "   ifc1_$i ifc13_i$i;\n";
    foreach (my $j=1; $j<=$i; $j++){  
    print FH "   u2_$i u2_i$j;\n";
      } 
    print FH "   u3_$i(){\n";
        print FH " p1_u3[$up4:$zero].connect_by_pattern(p_u2[$up4:$zero]);                   //port.ps--port.ps\n";
        print FH " p2_u3.connect_by_pattern(s_u2[$up1:$zero]);                               //port--sig.ps\n";
        print FH " ifc13_i$i.x1[$up1:$zero].connect_by_pattern(ifc2_i$i.x1[$up1:$zero]);     //ifc.port.ps--ifc.port.ps\n";
       
    print FH " }\n";
    print FH "   };\n\n";


    }
if($i>30 && $i<=50) {
  	&mkIfc1("ifc1_$i","$val1");
        &mkSg1("sg1_$i","$val1");

	print FH " csl_interface ifc2_$i {\n";
        print FH "  csl_port pi2_$i(input,$val2);\n";
        print FH "  ifc1_$i ifc1_i$i;\n";
        print FH "   ifc2_$i(){}\n";
        print FH "   };\n\n";

	print FH " csl_signal_group sg2_$i {\n";
        print FH "  csl_signal si2_$i($val2);\n";
        print FH "  sg1_$i sg1_i$i;\n";
        print FH "  sg2_$i(){}\n";
        print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";

    print FH "   ifc2_$i  ifc21_i$i;\n";
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "   csl_port p_u2(output,$val1);\n";
    print FH "   csl_signal s_u2($val1);\n";
    print FH "   sg2_$i sg2_i$i;\n";
    foreach (my $j=10; $j<=$i; $j++){  
    print FH "   u1_$i u1_i$j;\n";
      } 
    print FH "   u2_$i(){\n";
    print FH " }\n";
    print FH "   };\n\n";

    print FH " csl_unit u3_$i {\n";
    print FH "   csl_port p_u3(input,$val1);\n";
    print FH "   csl_signal s_u3($val1);\n";
    print FH "   ifc2_$i ifc23_i$i;\n";
    print FH "   sg2_$i sg23_i$i;\n";
    foreach (my $j=10; $j<=$i; $j++){  
    print FH "   u2_$i u2_i$j;\n";
      } 
    print FH "   u3_$i(){\n";
if($i>30 && $i<=40) {
	print FH "   p_u3.connect_by_pattern(sg2_i$i.sg1_i$i.x1);     //port --sg.sg.sig\n";
        print FH "   s_u3.connect_by_pattern(ifc21_i$i.ifc1_i$i.x1);  //sig--ifc.ifc.port\n";
        print FH "   ifc23_i$i.pi2_$i.connect_by_pattern(sg2_i$i.si2_$i); //ifc.port--sg.sig\n";
        print FH "   sg23_i$i.si2_$i.connect_by_pattern(ifc21_i$i.pi2_$i);//sg.sig--ifc.port\n";
        print FH "   ifc23_i$i.ifc1_i$i.x1.connect_by_pattern(s_u2);      //ifc.ifc.port--sig\n";
        print FH "   sg23_i$i.sg1_i$i.x1.connect_by_pattern(p_u2);      //sg.sg.sig--port\n";
    }
if($i>40 && $i<=50) {
        print FH "   p_u3.connect_by_pattern(sg2_i$i.sg1_i$i.x1[$up1:$zero]);                       //port --sg.sg.sig.ps\n";
        print FH "   s_u3[$up1:$zero].connect_by_pattern(ifc21_i$i.ifc1_i$i.x1);                    //sig.ps--ifc.ifc.port\n";
        print FH "   ifc23_i$i.pi2_$i [$up2:$zero].connect_by_pattern(sg2_i$i.si2_$i [$up2:$zero]); //ifc.port.ps--sg.sig.ps\n";
        print FH "   sg23_i$i.si2_$i [$up2:$zero].connect_by_pattern(ifc21_i$i.pi2_$i);             //sg.sig.ps--ifc.port\n";
        print FH "   ifc23_i$i.ifc1_i$i.x1 [$up1:$zero].connect_by_pattern(s_u2);                    //ifc.ifc.port.ps--sig\n";
        print FH "   sg23_i$i.sg1_i$i.x1[$up1:$zero].connect_by_pattern(p_u2[$up1:$zero]);           //sg.sg.sig.ps--port.ps\n";  
}
    print FH " }\n";
    print FH "   };\n\n";
    }
 if($i>50 && $i<=60) {
        &mkIfc1("ifc1_$i","$val3");
        &mkSg1("sg1_$i","$val3");

	print FH " csl_interface ifc2_$i {\n";
 #       print FH "  csl_port pi2_$i(input,$val2);\n"; 
        print FH "  ifc1_$i ifc1_i$i;\n";
        print FH "   ifc2_$i(){}\n";
        print FH "   };\n\n";

	print FH " csl_signal_group sg2_$i {\n";
 #       print FH "  csl_signal si2_$i($val2);\n"; 
        print FH "  sg1_$i sg1_i$i;\n";
        print FH "  sg2_$i(){}\n";
        print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
    print FH "   ifc2_$i  ifc21_i$i;\n";
#    print FH "   sg1_$i sg11_i$i;\n";
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "   sg2_$i sg22_i$i;\n";
    print FH "   ifc1_$i ifc12_i$i;\n";
    print FH "   ifc1_$i ifc12_ii$i;\n";
    foreach (my $j=30; $j<=$i; $j++){  
    print FH "   u1_$i u1_i$j;\n";
      } 
    print FH "   u2_$i(){\n";
    print FH " }\n";
    print FH "   };\n\n";

    print FH " csl_unit u3_$i {\n";
    print FH "   ifc2_$i ifc23_i$i;\n";
    print FH "   sg2_$i sg23_i$i;\n";
    print FH "   ifc1_$i ifc13_i$i;\n";
    print FH "   sg1_$i sg13_i$i;\n";
    foreach (my $j=30; $j<=$i; $j++){  
    print FH "   u2_$i u2_i$j;\n";
      } 
    print FH "   u3_$i(){\n";
    print FH "   ifc23_i$i.ifc1_i$i.connect_by_pattern(sg22_i$i.sg1_i$i);   //ifc.ifc --sg.sg\n";
    print FH "   ifc13_i$i.connect_by_pattern(ifc12_i$i);                   //ifc --ifc\n";
    print FH "   sg23_i$i.sg1_i$i.connect_by_pattern(ifc21_i$i.ifc1_i$i);   //sg.sg--ifc.ifc\n";
    print FH "   sg13_i$i.connect_by_pattern(ifc12_ii$i);                   //sg --ifc\n";

    print FH " }\n";
    print FH "   };\n\n";

    print FH " csl_unit u4_$i {\n";
    print FH "   ifc2_$i ifc24_i$i;\n";
#    print FH "   ifc2_$i ifc24_ii$i;\n";
    print FH "   sg2_$i sg24_i$i;\n";
    print FH "   ifc1_$i ifc14_i$i;\n";
    foreach (my $j=30; $j<=$i; $j++){  
    print FH "   u3_$i u3_i$j;\n";
      } 
    print FH "   u4_$i(){\n";
    print FH "   ifc24_i$i.ifc1_i$i.connect_by_pattern(sg13_i$i);     //ifc.ifc --sg\n";
    print FH "   ifc14_i$i.connect_by_pattern(ifc23_i$i.ifc1_i$i);    //ifc --ifc.ifc\n";
    print FH "   sg24_i$i.sg1_i$i.connect_by_pattern(ifc13_i$i);      //sg.sg--ifc\n";
#    print FH "   ifc24_ii$i.connect_by_pattern(sg23_i$i);             //ifc --ifc.ifc\n";
    print FH " }\n";
    print FH "   };\n\n";
    }
}
