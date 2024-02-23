#!/usr/bin/perl 
use strict;
require "Test_Scripts.pm";

#Author: Monica
#connect_by_name() method with hid and part select
#Test_Matrix: /test_matrices/ar_conn_by_name_matr.ods, 4 test cases
    
   
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $test_valid_dir="ar_conn_name_hid_ps_valid2";
    my $test_invalid_dir="ar_conn_name_hid_ps_invalid2";
    print "Generated tests path : test/csl_test_gen/$test_valid_dir/\n";

use Test_Scripts;
    my $author="Monica";
    my $test_matr="ar_conn_by_name_matr.ods";
 

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

foreach(my $i = 1; $i <= 30; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
      
    my $test_name = "ar_conn_name_hid_ps".$i."_legal.csl";
   
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
    my $l = int(&rand(3,1));
    my $l1=$l+1;
    my $j;
 &each_test($author,$test_matr); 

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";


# sg.sig.ps-->ifc.port
# sg.sig.ps-->ifc.port.ps
# sg.sg.sig.ps-->ifc.ifc.port.ps
# sg.sg.sig.ps-->ifc.ifc.port

    if($i>0 && $i<=10){

	&mkIfc1("ifc1_$i");
        &mkSg1("sg1_$i");

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1(input,br1);\n";
    print FH "   csl_port p2(output,br2);\n";
foreach (my $j=1; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg2_$i {\n";
    print FH "   csl_signal s1(br1);\n";
    print FH "   csl_signal s2(br2);\n";
foreach (my $j=1; $j<=$i; $j++){
    print FH " sg1_$i sg1_i$j;\n";
}
    print FH "   sg2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
 foreach (my $j=1; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH " u1_$i u1_i$i;\n";
    
 foreach (my $j=1; $j<=$i; $j++){
     print FH " sg2_$i sg2_i$j;\n";
#     print FH "csl_port pt2_$j(output,$val1);\n";
#     print FH "csl_signal st1_$j($l);\n";

} 
    
        my $up1=$val1-1;
	my $up2=$val2-1;
    print FH "   u2_$i(){\n";
 foreach (my $j=1; $j<=$i; $j++){
    
    print FH " sg2_i$j.s1 [$up1:$zero].connect_by_name(u1_i$i.ifc2_i$j.p1);                  // sg.sig.ps ---ifc.port\n";
    print FH " sg2_i$j.s2 [$up2:$zero].connect_by_name(u1_i$i.ifc2_i$j.p2[$up2:$zero] );     // sg.sig.ps ---ifc.port.ps\n";
   
}
 foreach (my $j=1; $j<=$i; $j++){
   foreach(my $k=1; $k<=$i; $k++){
    print FH " sg2_i$j.sg1_i$k.s2 [$up2:$zero].connect_by_name(u1_$i.ifc2_i$j.ifc1_i$k.p2 [$up2:$zero]); // sg.sg.sig.ps ---ifc.ifc.port.ps\n";
    print FH " sg2_i$j.sg1_i$k.s1 [$up1:$zero].connect_by_name(u1_$i.ifc2_i$j.ifc1_i$k.p1);              // sg.sg.sig.ps ---ifc.ifc.port\n";
}
    }
    
    print FH "   }\n";
    print FH "   };\n\n";
}


#sg.sig.ps --> port.ps

 if($i>10 && $i<=20){

     &mkSg1("sg1_$i");
	
 print FH " csl_unit u1_$i {\n";
 foreach (my $j=10; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
 foreach (my $j=10; $j<=$i; $j++){
    print FH " u1_$i u1_i$j;\n";
}
    print FH "   u2_$i(){\n";
    print FH "   }\n";
    print FH "   };\n\n";

     my $up1=$val1-1;
     my $up2=$val2-1;

 print FH " csl_unit top_$i {\n";
 foreach (my $j=10; $j<=$i; $j++){
   foreach(my $k=10; $k<=$i; $k++){
     print FH " csl_port p1_$j$k(input,br1);\n";
     print FH " csl_port p2_$j$k(output,br2);\n";
 }
}
    print FH " u2_$i u2_i$i;\n";
    print FH "   top_$i(){\n";
foreach (my $j=10; $j<=$i; $j++){
   foreach(my $k=10; $k<=$i; $k++){
    print FH " u2_i$i.u1_i$j.sg1_i$k.s1 [$up1:$zero].connect_by_name(p1_$j$k [$up1:$zero]);   // sg.sig.ps --- port.ps\n";
    print FH " u2_i$i.u1_i$j.sg1_i$k.s2 [$up2:$zero].connect_by_name(p2_$j$k [$up2:$zero]);   // sg.sig.ps --- port.ps\n";
}
}
    print FH "   }\n";
    print FH "   };\n\n";

   }

#sg.sig.ps --> concat_expr

if($i>20 && $i<=30){

     &mkSg1("sg1_$i");

     my $c1=$val1-3;
     my $c2=2;
     my $c3=1;
     my $c4=$val2-2;
     my $c5=1;	

     my $up1=$val1-1;
     my $up2=$val2-1;

 print FH " csl_unit u1_$i {\n";
 foreach (my $j=20; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

     print FH " csl_unit u2_$i {\n";
 foreach (my $j=20; $j<=$i; $j++){
     print FH " csl_port p1_$j(input,$c1);\n";
     print FH " csl_port p2_$j(input,$c2);\n";
     print FH " csl_port p3_$j(input,$c3);\n";
     }
 foreach (my $j=20; $j<=$i; $j++){
     print FH " csl_port p4_$j(output,$c4);\n";
     print FH " csl_port p5_$j(output,$c5);\n";
    
     }
    print FH " u1_$i u1_i$i;\n";
    
    print FH " u2_$i(){ \n";
    foreach (my $j=20; $j<=$i; $j++){
    print FH " u1_i$i.sg1_i$j.s1 [$up1:$zero].connect_by_name({p1_$j,p2_$j,p3_$j});\n";
    print FH " u1_i$i.sg1_i$j.s2 [$up2:$zero].connect_by_name({p4_$j,p5_$j,1'b1});\n";
      }
    print FH "   }\n";
    print FH "   };\n\n";
     }

	  }
