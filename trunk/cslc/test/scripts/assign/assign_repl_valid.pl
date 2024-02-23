#!/usr/bin/perl

#Author Monica
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

sub mkDir {
    my($dirName) = @_;
    unless(-e "$dirName")  { `mkdir $dirName`; }
}

foreach(my $i = 1; $i <=50; $i++) {
    &main($i);
 
}

sub main {
    my $i = $_[0];
    my $test_name = "assign_repl".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($i==1){
        print ("Generated path: $path/assign_repl_valid/\n");}
    my $val = int(rand(300));
    if($val == 0) { $val = 1; }
    my $val1= int(rand(200));
    if($val1== 0) { $val1= 1; }
    my $val2 = int(rand(10));
    if($val2==0) {$val2=1;}
    if($test_name=~/(_legal)/){
        &mkDir("$path/assign_repl_valid");
        open(FH,">$path/assign_repl_valid/$test_name");
    }
#*************************************************************
# port/signal ={replic_expr}
    if($i>0 && $i<=50){
     print FH "//Generated by Monica\n";
    print FH "//Test cases from: assign_test_matrix.odg, part_select_matrix.odg\n"; 

    if( $i >0 && $i<=10){
   
    print FH "// Replicate used in assign and f2a\n\n";
    print FH "// VALID TEST $i;\n\n";
            
        print FH " csl_unit u_a {\n";
       
#        print FH "  csl_port en1_in(input), en2_in(input);\n";
       
      foreach( my $j=1; $j<=$i; $j++){
        my $v1= 2 * $val1;
        my $v2= 3 * $val2;
        print FH "  csl_port out_data$j (output, $v1), out_addr$j (output, $v2);\n";
  
        print FH "  csl_signal s1_out$j ($val2), s2_out$j ($val1);\n";
    }
        print FH "  u_a() {\n";
 foreach( my $j=1; $j<=$i; $j++){
        print FH " out_data$j={2{s2_out$j}};\n";
        print FH " out_addr$j={3{s1_out$j}};\n";
    }
        print FH "  }\n";
        print FH "};\n";
        my $v1= 2 * $val1;
        my $v2= 3 * $val2;
        
        print FH " csl_unit u_b{\n";
        print FH " csl_port rd_en(input,4);\n";
       
      foreach( my $j=1; $j<=$i; $j++){
        my $v3= 2* ($val1 + $val1);
        my $v4= 2* $val1 + 3* $val2;
        print FH " csl_port in_data$j (input, $v1), wr_addr$j (input, $v2);\n";
        print FH " csl_signal wr_sig$j($v2);\n";
    }
 foreach( my $j=1; $j<=$i; $j++){
     my $v3= 2* ($val1 + $val1);
     my $v4= 2* $val1 + 3* $val2;
     print FH " csl_port p1_data$j(output,$v3);\n";
#        print FH " csl_port p2_data$j(output, $v4);\n";
    }

    print FH " csl_port data_out0(output,$v1);\n";
    print FH "  u_b() {\n";
     foreach( my $j=1; $j<=$i; $j++){
     print FH "    rd_en[2]=rd_en[0];\n";
     print FH "    rd_en[1]=rd_en[3];\n";
     print FH "    wr_sig$j= wr_addr$j;\n";
     print FH "    p1_data$j={2{data_out0}};\n";
 } 
     
     print FH "  }\n";
     print FH "};\n";       
    
    print FH " csl_unit top_$i {\n";
    my $v3= 2* ($val1 + $val1);
    print FH " csl_signal s1($val1), s2($val2), data($v3);\n";
  foreach( my $j=1; $j<=$i; $j++){
    print FH " u_a ua_i$j(.out_data$j({2{s1}}),.out_addr$j({3{s2}}));\n";
    print FH " u_b ub_$j(";
    foreach( my $j=1; $j<=$i; $j++){
	print FH ".in_data$j({2{s1}}),";
    }
    print FH ".wr_addr$j({3{s2}}),.p1_data$j(data),.data_out0(data\[".(2*$val1-1)."\:".(0)."\]));\n";
}
    print FH "   top_$i(){}\n";
    print FH " };\n"; 
    }

#*************************************************************
# ifc.port={replic_expr}
# sg.sig={replic_expr}

    if($i>10 && $i<=20){
	print FH "// Replicate used in assign \n\n";
	print FH "// VALID TEST $i;\n\n";
	print FH " csl_interface ifc_$i {\n";
	foreach(my $j=11; $j<=$i; $j++){
	    print FH "  csl_port p_in$j(input,$j);\n"; 
	    print FH "  csl_port p_out$j(output,$j);\n";
	}
	print FH "   ifc_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_signal_group sg_$i {\n";
	foreach(my $j=11; $j<=$i; $j++){
	    print FH "  csl_signal  sg1_$j($j);\n";
	    print FH "  csl_signal  sg2_$j($j);\n"; 
	}
	print FH "   sg_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_unit u1_$i {\n";
	
	print FH "   csl_port  p1(input), p2(input);\n";
	foreach(my $j=11; $j<=$i; $j++){
	    my $v1= 2*$j;
	    my $v2= 5*$j;
	    my $v3= 3*($j +2);
	    
	    print FH "   csl_signal s1_$j($v1),s2_$j($v2),s3_$j($v3);\n";
	}
	print FH "  ifc_$i ifc_i1;\n";
	print FH "  ifc_$i ifc_i2;\n";
	print FH "  u1_$i(){\n";
	foreach(my $j=11; $j<=$i; $j++){
	    print FH " s1_$j ={2{ifc_i1.p_in$j}};\n";
	    print FH " s3_$j ={3{ifc_i2.p_in$j,{p1,p2}}};\n";
	    print FH " s2_$j ={5{ifc_i2.p_in$j & ifc_i1.p_in$j}};\n";
	    print FH " ifc_i2.p_out$j=s1_$j/2;\n";
	    print FH " ifc_i1.p_out$j=s2_$j/5;\n";
	}
	print FH "  }\n";
	print FH "};\n";
	
	print FH " csl_unit u2_$i {\n";
	foreach(my $j=11; $j<=$i; $j++){
	    my $v1= 2*$j;
	    my $v2= 5*$j;
	    my $v3= 6*$j;
	    
	    print FH " csl_port p1_$j(input,$v1), p2_$j(input,$v2), p3_$j(output,$v3);\n";
	}
#	print FH " csl_port p4(output),p5(output);\n"; 
	print FH " sg_$i sg_i1;\n";
	print FH " sg_$i sg_i2;\n";
	print FH " ifc_$i ifc_i3;\n";
	print FH " u2_$i(){\n";
	foreach(my $j=11; $j<=$i; $j++){
	    print FH " {sg_i1.sg1_$j,sg_i1.sg2_$j} ={2{ifc_i3.p_in$j}};\n";
	    print FH " p1_$j ={2{sg_i2.sg1_$j ^ sg_i1.sg1_$j}};\n";
	    print FH " p2_$j ={{3{sg_i1.sg1_$j}},{2{sg_i2.sg2_$j}}};\n";
	    print FH " p3_$j ={3{{2{sg_i1.sg2_$j}}}};\n";
	}
	print FH "  }\n";
	print FH "};\n";
	
	print FH " csl_unit u_top_$i {\n";
	print FH "  csl_signal s_top;\n";
	print FH "  ifc_$i ifc_top;\n";
	print FH "  sg_$i sg_i3;\n";
	print FH "  sg_$i sg_i4;\n";
	print FH "  u1_$i u1_i(.p1(s_top),.p2(s_top),.ifc_i1(ifc_top),.ifc_i2(ifc_top));\n";
	foreach(my $j=11; $j<=$i; $j++){
	    my $v1= 2*$j;
	    my $v2= 5*$j;
	    my $v3= 6*$j;
	    print FH "  csl_signal s1_$j($v1),s2_$j($v2),s3_$j($v3);\n";
	}
	print FH "  u2_$i u2_i(";
	foreach(my $j=11; $j<=$i; $j++){
	    print FH ".p1_$j(s1_$j),.p2_$j(s2_$j),.p3_$j(s3_$j),";
	}
	print FH ".ifc_i3(ifc_i3));\n";
	foreach(my $j=11; $j<=$i; $j++){
	    my $v1= 2*$j;
	    my $v2= 5*$j;
	    print FH "  csl_signal s_$j($v1);\n";
	    print FH "  csl_port p_$j(input,$v2);\n";
	}
	print FH " ifc_$i ifc_i3;\n";
	print FH " u_top_$i (){\n";
	foreach(my $j=11; $j<=$i; $j++){
	    my $v1= 2*$j;
	    my $v2= 5*$j;
	    my $v3= 3*($j +2);
	}
	foreach(my $j=11; $j<=$i; $j++){
	    print FH "    s_$j={2{ifc_i3.p_in$j}};\n";
	    print FH "    p_$j={5{ifc_i3.p_out$j}};\n";
	    print FH "    {sg_i3.sg1_$j, sg_i4.sg1_$j}={2{ifc_i3.p_in$j}};\n";
	    print FH "    {sg_i3.sg2_$j, sg_i4.sg2_$j}={sg_i3.sg1_$j, sg_i4.sg1_$j};\n";
	}
	print FH "  }\n";
	print FH "};\n";
    }

#************************************************
# ifc.ifc1.port={replic_expr}
# sg.sg1.sig={replic_expr}

    if($i>20 && $i<=30){

	print FH "// Replicate with HIDs used in assign \n\n";
	print FH "// VALID TEST $i;\n\n";
	print FH " csl_interface ifc1_$i {\n";
	foreach(my $j=21; $j<=$i; $j++){
	    my $v11=3*$j;
	    print FH "  csl_port p_in$j(input,$v11);\n"; 
	    print FH "  csl_port p_out$j(output,$v11);\n";
	}
	print FH "   ifc1_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_signal_group sg1_$i {\n";
	foreach(my $j=21; $j<=$i; $j++){
	    
	    print FH "  csl_signal  sig1_$j($j);\n";
	    print FH "  csl_signal  sig2_$j($j);\n"; 
	}
	print FH "   sg1_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_interface ifc2_$i {\n";
	foreach(my $j=21; $j<=$i; $j++){
    
	    print FH "  csl_port p_in$j(input,$j);\n"; 
	    print FH "  csl_port p_out$j(output,$j);\n";
	}
	print FH "  ifc1_$i ifc1_i1;\n";
	
	print FH "   ifc2_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_signal_group sg2_$i {\n";
	foreach(my $j=21; $j<=$i; $j++){
	    my $v11=3*$j;
	    print FH "  csl_signal  sig1_$j($v11);\n";
	    print FH "  csl_signal  sig2_$j($v11);\n"; 
	}
	print FH "  sg1_$i sg1_i1;\n";

	print FH "   sg2_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_unit u1_$i {\n";
	print FH "  ifc2_$i ifc2_i1;\n";
	print FH " u1_$i(){\n";
	print FH " }\n";
	print FH "};\n";
	
	
	print FH " csl_unit u_top_$i {\n";
	print FH "  ifc2_$i ifc2_i1;\n";
	print FH "  sg2_$i sg2_i1;\n";
	print FH " u1_$i u1_i1(.ifc2_i1(ifc2_i1));\n";
	print FH " u1_$i u1_i2(.ifc2_i1(ifc2_i1));\n";
	print FH " u_top_$i(){\n";
	foreach(my $j=21; $j<=$i; $j++){
	    print FH " ifc2_i1.ifc1_i1.p_in$j={3{sg2_i1.sg1_i1.sig1_$j}};\n";
	    print FH " sg2_i1.sig1_$j={3{ifc2_i1.p_in$j}};\n";
	    print FH " ifc2_i1.ifc1_i1.p_out$j={3{sg2_i1.sg1_i1.sig1_$j + sg2_i1.sg1_i1.sig2_$j}};\n"; 
	    print FH " sg2_i1.sig2_$j={3{ifc2_i1.p_in$j}};\n";
	}
	print FH " }\n";
	print FH "};\n";
    }
#************************************************
# port/signal[part_select]={replic_expr}
# unit.ifc/sg.port/sig[part_select]={replic_expr}

 if($i>30 && $i<=40){
    
     print FH "// Replicate with part_select used in assign \n\n";
     print FH "// VALID TEST $i;\n\n";
     my $o=0;
     print FH " csl_interface ifc1_$i {\n";
     foreach(my $j=31; $j<=$i; $j++){
	 my $v12=4*$j;
	 my $v11=2*$j;
	 print FH "  csl_port p_in$j(input,$v11);\n"; 
	 print FH "  csl_port p_out$j(output,$v12);\n";
     }
     print FH "   ifc1_$i(){}\n";
     print FH "};\n";
     
     print FH " csl_signal_group sg1_$i {\n";
     foreach(my $j=31; $j<=$i; $j++){
	 
	 print FH "  csl_signal  sig1_$j($j);\n";
	 print FH "  csl_signal  sig2_$j($j);\n"; 
     }
     print FH "   sg1_$i(){}\n";
     print FH "};\n";

     print FH " csl_interface ifc2_$i {\n";
     foreach(my $j=31; $j<=$i; $j++){
	 my $v12 =4*$j;
	 print FH "  csl_port p_in$j(input,$v12);\n"; 
	 print FH "  csl_port p_out$j(output,$v12);\n";
     }
     print FH "  ifc1_$i ifc1_i1;\n";
     
     print FH "   ifc2_$i(){}\n";
     print FH "};\n";
     
     print FH " csl_signal_group sg2_$i {\n";
     foreach(my $j=31; $j<=$i; $j++){
	 my $v11=2*$j;
	 print FH "  csl_signal  sig1_$j($v11);\n";
	 print FH "  csl_signal  sig2_$j($v11);\n"; 
     }
     print FH "  sg1_$i sg1_i1;\n";
     
     print FH "   sg2_$i(){}\n";
     print FH "};\n";
     
     print FH " csl_unit u1_$i {\n";
     print FH "  ifc2_$i ifc2_i1;\n";
     print FH " u1_$i(){\n";
     print FH " }\n";
     print FH "};";
     
     
     print FH " csl_unit u_top_$i {\n";
     print FH "  ifc2_$i ifc2_i1;\n";
     print FH "  sg2_$i sg2_i1;\n";
     print FH "  u1_$i u1_i1(.ifc2_i1(ifc2_i1));\n";
     print FH "  u1_$i u1_i2(.ifc2_i1(ifc2_i1));\n";
     print FH "  u_top_$i(){\n";
     foreach(my $j=31; $j<=$i; $j++){
	 my $v12=4*$j;
	 my $v11=2*$j;
	 my $j1=$j-1;
	 my $v11_=$v11-1;
	 my $v12_=$v12-1;
	 print FH " ifc2_i1.p_out$j={2{sg2_i1.sig1_$j [$j1:$o],sg2_i1.sig1_$j [$v11_:$j]}};\n";
	 print FH " sg2_i1.sig1_$j={2{ifc2_i1.p_in$j [$j1:$o] & ifc2_i1.ifc1_i1.p_in$j [$j1:$o] }};\n";
	 
	 print FH " ifc2_i1.ifc1_i1.p_out$j [$v12_:$o]={{2{sg2_i1.sg1_i1.sig1_$j [$j1:$o]}},{2{sg2_i1.sg1_i1.sig2_$j [$j1:$o]}}};\n";
	 
	 print FH " ifc2_i1.ifc1_i1.p_out$j [$v12_:$o]={4{sg2_i1.sg1_i1.sig1_$j [$j1:$o] + sg2_i1.sg1_i1.sig2_$j [$j1:$o]}};\n"; 
	 print FH " {sg2_i1.sig2_$j ,sg2_i1.sig1_$j} ={2{{2{ifc2_i1.p_in$j [$v11_:$j]}}}};\n";
     }
     print FH " }\n";
     print FH "};";
 }
    
#**********************************************************
# f2a cases
    if($i>40 && $i<=50){

	print FH "// Replicate used in f2a \n\n";
	print FH "// VALID TEST $i;\n\n";
	
	print FH " csl_interface ifc1_$i {\n";
	foreach(my $j=41; $j<=$i; $j++){
	    my $v11=3*$j;
	    print FH "  csl_port p_in$j(input,$v11);\n"; 
	    print FH "  csl_port p_out$j(output,$v11);\n";
	}
	print FH "   ifc1_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_signal_group sg1_$i {\n";
	foreach(my $j=41; $j<=$i; $j++){
	    
	    print FH "  csl_signal  sig1_$j($j);\n";
	    print FH "  csl_signal  sig2_$j($j);\n"; 
	}
	print FH "   sg1_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_interface ifc2_$i {\n";
	foreach(my $j=41; $j<=$i; $j++){
	    
	    print FH "  csl_port p_in$j(input,$j);\n"; 
	    print FH "  csl_port p_out$j(output,$j);\n";
	}
	print FH "  ifc1_$i ifc1_i1;\n";
	
	print FH "   ifc2_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_signal_group sg2_$i {\n";
	foreach(my $j=41; $j<=$i; $j++){
	    my $v11=3*$j;
	    print FH "  csl_signal  sig1_$j($v11);\n";
	    print FH "  csl_signal  sig2_$j($v11);\n"; 
	}
	print FH "  sg1_$i sg1_i1;\n";
	
	print FH "   sg2_$i(){}\n";
	print FH "};\n";
	
	print FH " csl_unit u1_$i {\n";
	my $v_1=2*$val;
	my $v_2=4*($val1 + $val2);
	print FH "  csl_port p11(input,$v_1);\n";
	print FH "  csl_port p12(output,$v_2);\n";
	print FH "  ifc2_$i ifc2_i1;\n";
#	print FH "  sg2_$i sg2_i1;\n";
	print FH " u1_$i(){\n";
	print FH " }\n";
	print FH "};\n";
	
	
	print FH " csl_unit u2_$i {\n";
	my $v_1=2*$val;
	my $v_2=4*($val1 + $val2);
	print FH "  csl_port p21(input,$v_1);\n";
	print FH "  csl_port p22(output,$v_2);\n";
	print FH "  ifc2_$i ifc2_i1;\n";
	print FH "  sg2_$i sg2_i1;\n";
	print FH "  u1_$i u1_i1(.ifc2_i1(ifc2_i1),.p11(p21),.p12(p22));\n";    
	print FH "  u1_$i u1_i2(.ifc2_i1(ifc2_i1),.p11(p21),.p12(p22));\n";      

	print FH "  u2_$i(){\n";
	foreach(my $j=41; $j<=$i; $j++){
	    print FH "    {sg2_i1.sig1_$j,sg2_i1.sig2_$j} = {3{sg2_i1.sg1_i1.sig1_$j,sg2_i1.sg1_i1.sig2_$j}};\n";
	}
	print FH " }\n";
	print FH "};\n";
	
	print FH " csl_unit top {\n";
	print FH "  ifc2_$i ifc2_i1;\n";
	print FH "  csl_signal s1($val),s2($val) ;\n";
	print FH "  csl_signal s3($val1),s4($val2);\n";
	print FH "  csl_signal s5($val1),s6($val2);\n";
	print FH "  u1_$i u1_i3 (.p11({2{s1}}),.p12({4{s3,s4}}),.ifc2_i1(ifc2_i1));\n";
	print FH "  u2_$i u2_i1 (.p21({2{s2}}),.p22({2{{2{s5,s6}}}}),.ifc2_i1(ifc2_i1));\n";
	print FH "  top(){}\n";
	print FH " };\n";
    }
 }
    close(FH);
}