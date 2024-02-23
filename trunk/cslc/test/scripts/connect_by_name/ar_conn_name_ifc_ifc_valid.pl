#!/usr/bin/perl 
use strict;
require "Test_Scripts.pm";

#Author: Monica
#connect_by_name() method with hid and part select
#Test_Matrix: /test_matrices/ar_conn_by_name_matr.ods, 4 test cases
    
   
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $test_valid_dir="ar_conn_name_ifc_ifc_valid";
    my $test_invalid_dir="ar_conn_name_ifc_ifc_invalid";
    print "Generated tests path : test/csl_test_gen/$test_valid_dir/\n";

use Test_Scripts;
    my $author="Monica";
    my $test_matr="ar_conn_by_name_matr.ods";

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


foreach(my $i = 1; $i <= 20; $i++) {
    &main($i);
}
 
sub main {
    my $i = $_[0];
      
    my $test_name = "ar_conn_name_ifc_ifc".$i."_legal.csl";
   
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

 &each_test($author,$test_matr); 

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";


# ifc-->ifc.ifc
# ifc.ifc-->ifc.ifc


    if($i>0 && $i<=10){

	&mkIfc1("ifc1_$i","br1");
       
    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port x1(input,br2);\n";
    foreach (my $j=1; $j<=$i; $j++){
        print FH " ifc1_$i ifc1_i$j;\n";
          }
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
    print FH " csl_port p_$i(input,br2);\n";
    print FH "ifc2_$i ifc2_i$i;\n";
    foreach (my $j=1; $j<=$i; $j++){
        print FH "ifc1_$i ifc1_i$j;\n";
       
          } 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH "ifc2_$i ifc2_i$i;\n";
    print FH "ifc2_$i ifc2i_$i;\n";
   
    print FH "u1_$i u1_i$i;\n";
       
    print FH "   u2_$i(){\n";
    foreach (my $j=1; $j<=$i; $j++){
        print FH " u1_i$i.ifc1_i$j.connect_by_name(ifc2_i$i.ifc1_i$j);            // ifc-->ifc.ifc\n";  
        print FH " u1_i$i.ifc2_i$i.ifc1_i$j.connect_by_name(ifc2i_$i.ifc1_i$j);   // ifc.ifc-->ifc.ifc\n"; 
        
    }
        print FH " u1_i$i.ifc2_i$i.connect_by_name(ifc2i_$i);                     // ifc-->ifc\n";  
        print FH " u1_i$i.p_$i.connect_by_name(ifc2_i$i.x1);                      // port-->ifc.port\n";  
    print FH " }\n";
    print FH "   };\n\n";
    }

# sg-->ifc.ifc
# sg.sg-->ifc.ifc

 if($i>10 && $i<=20){
    &mkSg1("sg1_$i","br3");
    &mkIfc1("ifc1_$i","br3");

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port x1(output,br2);\n";
    print FH "   csl_port x2(output,br1);\n";
    foreach (my $j=10; $j<=$i; $j++){
        print FH " ifc1_$i ifc1_i$j;\n";
          }
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg2_$i {\n";
    print FH "   csl_signal x1(br2);\n";
    print FH "   csl_signal x2(br1);\n";
    foreach (my $j=10; $j<=$i; $j++){
    print FH " sg1_$i sg1_i$j;\n";
     }
    print FH "   sg2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
    print FH " ifc2_$i ifc22_i$i;\n";
    print FH " ifc2_$i ifc22i_$i;\n";
    print FH "sg2_$i sg2_i$i;\n";
    foreach (my $j=10; $j<=$i; $j++){
        print FH "sg1_$i sg1_i$j;\n";
       
          } 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH " csl_port p1(input,br2);\n";
    print FH " csl_port p2(input,br1);\n";
    print FH "ifc2_$i ifc2_i$i;\n";
    print FH "ifc2_$i ifc2i_$i;\n";
   
    print FH "u1_$i u1_i$i;\n";
       
    print FH "   u2_$i(){\n";
    foreach (my $j=10; $j<=$i; $j++){
        print FH " u1_i$i.sg1_i$j.connect_by_name(ifc2_i$i.ifc1_i$j);           // sg-->ifc.ifc\n";  
        print FH " u1_i$i.sg2_i$i.sg1_i$j.connect_by_name(ifc2i_$i.ifc1_i$j);   // sg.sg-->ifc.ifc\n";  
              
    }
       print FH " u1_i$i.ifc22_i$i.connect_by_name(ifc2_i$i);                     // ifc-->ifc\n";  
       print FH " u1_i$i.ifc22i_$i.connect_by_name(ifc2i_$i);                     // ifc-->ifc\n";
       print FH " u1_$i.sg2_i$i.x1.connect_by_name(p1);                           //sg.sig--port   \n";
       print FH " u1_$i.sg2_i$i.x2.connect_by_name(p2);                           //sg.sig--port  \n"; 
    print FH " }\n";
    print FH "   };\n\n";
    }
}
