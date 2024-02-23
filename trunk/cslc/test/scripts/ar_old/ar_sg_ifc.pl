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

foreach(my $i = 1; $i <= 500; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my $test_name = "connect_sg_s_ifc_p_test".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen";
   if($i==1){
        print (" Generated path: $path/ar_connect_sg_ifc_valid/\n");}
    my $val = int(rand(500));
    if($val == 0) { $val = 1; }
    my $val1= int(rand(200));
    if($val1== 0) { $val1= 1; }
    my $val2 = int(rand(100));
    if($val2==0) {$val2=1;}

    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_connect_sg_ifc_valid");
        open(FH,">$path/ar_connect_sg_ifc_valid/$test_name");
    }
   
    print FH "//Generated by Monica\n";
    print FH "//Connect SG.signal--IFC.port\n\n";
    print FH "// TEST $i;\n";
    print FH "csl_bitrange br($val);\n\n";
    if($i >=0 && $i<=250){                             #[0-250]=>two levels,one instace,one connection: top(sg_a0) -> u_a0(ifc_a0)
        print FH "csl_interface ifc_a {\n";
     if($i>0 && $i <= 50) {
        print FH "  csl_port p1_$i(input,$val);\n"; 
    }
    elsif($i > 50 && $i <= 100) {
        print FH "  csl_port p1_$i(output,$val1);\n"; 
        print FH "  csl_port p2_$i(input,$val2);\n"
    }
    elsif($i > 100 && $i <= 150) {
        print FH "  csl_port p1_br$i(input,br);\n"; 
    }
    elsif($i >150 && $i <=200){
        print FH "  csl_port p1_$i(output,$val2);\n";
    }
    elsif($i > 200 && $i <= 250) {
        print FH "  csl_port p1_$i(input,$val);\n"; 
        print FH "  csl_port p1_br$i(output,br);\n";
    }

    print FH "  ifc_a() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

 print FH "csl_signal_group sg_a{\n";
   
    if($i <= 50) {
        print FH "  csl_signal s1_$i($val);\n"; 
    }
    elsif($i > 50 && $i <= 100) {      
        print FH "  csl_signal s1_$i($val1);\n";
        print FH "  csl_signal s2_$i($val2);\n"
    }
    elsif($i>100 && $i<=150){
        print FH"   csl_signal s1_br$i(br);\n";
    }
    elsif($i > 150 && $i <= 200) {      
        print FH "  csl_signal s1_$i($val2);\n";
    }
    elsif($i > 200 && $i <= 250) {      
        print FH "  csl_signal s1_$i($val);\n";     
        print FH "  csl_signal s1_br$i(br);\n";
    }

    print FH "  sg_a() {\n";                
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";


    print FH "csl_unit u_a {\n";  
    print FH "  ifc_a ifc_a0;\n";
    print FH "  sg_a  sg_a0;\n";
    print FH " u_a(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";
   
   
    print FH "csl_unit u_top1 {\n"; 
    print FH " ifc_a ifc_a11;\n";
    print FH " ifc_a ifc_a12;\n"; 
    print FH "  sg_a sg_a1;\n";
    print FH "  u_a u_a0;\n";
    print FH "  u_a u_a1;\n";
    print FH "  u_top1() {\n";
    if($i <= 50) {
        print FH "    u_a0.ifc_a0.p1_$i.connect(sg_a0.s1_$i);\n";
    }
    
    if($i > 50 && $i <= 100) {
        print FH "    u_a1.ifc_a0.p1_$i.connect(sg_a0.s1_$i);\n";
        print FH "    u_a1.ifc_a0.p2_$i.connect(sg_a0.s2_$i);\n";
    }
    elsif($i > 100 && $i <= 150) {
        print FH "    u_a1.ifc_a0.p1_br$i.connect(sg_a0.s1_br$i);\n";
    }
    elsif($i >150 && $i <=200){
        print FH "   u_a0.ifc_a0.p1_$i.connect(sg_a0.s1_$i);\n";
    }
    elsif($i > 200 && $i <= 250) {
        print FH "   u_a0.ifc_a0.p1_$i.connect(sg_a0.s1_$i);\n";
        print FH "   u_a0.ifc_a0.p1_br$i.connect(sg_a0.s1_br$i);\n";
    }
   
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";

       print FH " csl_unit top {\n";                         #third level
       print FH "  u_top1 top1_i;\n";
       
       print FH "    top() {\n";  
   if($i <= 50) {
       print FH " top1_i.u_a0.sg_a0.s1_$i.connect(top1_i.u_a1.ifc_a0.p1_$i);\n";
   }
    elsif($i > 50 && $i <= 100) {
       print FH "  top1_i.u_a0.sg_a0.s1_$i.connect(top1_i.u_a1.ifc_a0.p1_$i);\n";
       print FH "  top1_i.u_a1.sg_a0.s2_$i.connect(top1_i.u_a0.ifc_a0.p2_$i);\n";
   }
    elsif($i > 100 && $i <= 150) {
        print FH "    top1_i.u_a1.sg_a0.s1_br$i.connect(top1_i.u_a0.ifc_a0.p1_br$i);\n";
    }
    elsif($i >150 && $i <=200){
        print FH "   top1_i.u_a0.sg_a0.s1_$i.connect( top1_i.u_a0.ifc_a0.p1_$i);\n";
    }
   elsif($i > 200 && $i <= 250) {
        print FH "   top1_i.u_a0.sg_a0.s1_$i.connect( top1_i.u_a1.ifc_a0.p1_$i);\n";
        print FH "   top1_i.u_a0.sg_a0.s1_br$i.connect(  top1_i.u_a1.ifc_a0.p1_br$i);\n";
    }
       print FH "  }\n";        
       print FH "};\n";        
       print FH "\n";
}
    
    if($i >250  && $i <=500){                        #[250-500]=> three levels,four connections: 
                                                        # top(sg_top1,sg_top2)->top1(sg_b0,ifc_b11,ifc_b12)->u_b0(ifc_b0,ifc_b1),u_b1(ifc_b0,ifc_b1)
       print FH "csl_bitrange br1($val1);\n";
       print FH "csl_interface ifc_b {\n";   
    
    if($i > 250 && $i <= 300) {
       print FH "csl_port p_b1_$i(output,$val);\n";
       print FH "csl_port p_b2_$i(output,$val1);\n";
     }
     elsif( $i > 300 && $i <= 350) {
       print FH "csl_port p_b1_$i(input,$val);\n";
       print FH "csl_port p_b2_$i(input,$val1);\n";
     }
    elsif( $i > 350 && $i <= 400) {
       print FH "csl_port p_b_br1_$i(output,br);\n";
       print FH "csl_port p_b_br2_$i(output,br1);\n";
   }
    elsif( $i > 400 && $i <= 450) {
       print FH "csl_port p_b_br1_$i(input,br);\n";
       print FH "csl_port p_b_$i(output,$val2);\n";
   }
    elsif( $i > 450 && $i <= 500) {
       print FH "csl_port p_b_$i(output,$val2);\n";
       print FH "csl_port p_b_br_$i(input,br1);\n";
   }
       print FH " ifc_b() {\n";
       print FH "  }\n";        
       print FH "};\n";        
       print FH "\n";
    print FH "csl_unit u_b {\n";     #first  level
    print FH "  ifc_b ifc_b0;\n";
    print FH "  ifc_b ifc_b1;\n";
    print FH " u_b(){\n";
    print FH "  }\n";
    print FH "};\n";
    print FH "\n";

 
  print FH "csl_signal_group sg_b{\n";

   if($i > 250 && $i <= 300) {
       print FH "csl_signal s_b1_$i($val);\n";
       print FH "csl_signal s_b2_$i($val1);\n";
     }
     elsif( $i > 300 && $i <= 350) {
       print FH "csl_signal s_b1_$i($val);\n";
       print FH "csl_signal s_b2_$i($val1);\n";
     }
    elsif( $i > 350 && $i <= 400) {
       print FH "csl_signal s_b_br1_$i(br);\n";
       print FH "csl_signal s_b_br2_$i(br1);\n";
   }
    elsif( $i > 400 && $i <= 450) {
       print FH "csl_signal s_b_br1_$i(br);\n";
       print FH "csl_signal s_b_$i($val2);\n";
   }
    elsif( $i > 450 && $i <= 500) {
       print FH "csl_signal s_b_$i($val2);\n";
       print FH "csl_signal s_b_br_$i(br1);\n";
   }
       print FH " sg_b() {\n";
       print FH "  }\n";
       print FH "};\n";
   
       print FH " csl_unit top1 {\n";               #second level
       print FH " ifc_b ifc_b11;\n";
       print FH " ifc_b ifc_b12;\n";
       print FH " u_b u_b0;\n";
       print FH " u_b u_b1;\n";
       print FH " sg_b sg_b0;\n";
       print FH "   top1() {\n";

     if($i > 250 && $i <= 300) {
       print FH "u_b0.ifc_b0.p_b1_$i.connect(sg_b0.s_b1_$i);\n";
       print FH "u_b0.ifc_b0.p_b2_$i.connect(sg_b0.s_b2_$i);\n";
       
     }
     elsif( $i > 300 && $i <= 350) {
       print FH "u_b1.ifc_b1.p_b1_$i.connect(sg_b0.s_b1_$i);\n";
       print FH "u_b1.ifc_b1.p_b2_$i.connect(sg_b0.s_b2_$i);\n";
     }
    elsif( $i > 350 && $i <= 400) {
        print FH "u_b0.ifc_b1.p_b_br1_$i.connect(sg_b0.s_b_br1_$i);\n";
       print FH "u_b0.ifc_b1.p_b_br2_$i.connect(sg_b0.s_b_br2_$i);\n";
     }
    elsif( $i > 400 && $i <= 450) {
       print FH "u_b1.ifc_b0.p_b_br1_$i.connect(sg_b0.s_b_br1_$i);\n";
       print FH "u_b1.ifc_b0.p_b_$i.connect(sg_b0.s_b_$i);\n";
     }
    elsif( $i > 450 && $i <= 500) {
       print FH "u_b0.ifc_b0.p_b_$i.connect(sg_b0.s_b_$i);\n";
       print FH "u_b1.ifc_b1.p_b_br_$i.connect(sg_b0.s_b_br_$i);\n";
   }  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
    
       print FH " csl_unit top {\n";                         #third level
       print FH "  sg_b sg_top1;\n";
       print FH "  sg_b sg_top2;\n";
       print FH "  top1 top1_i;\n";
       print FH "    top() {\n";
    if($i > 250 && $i <= 300) {
       print FH "top1_i.ifc_b11.p_b1_$i.connect(sg_top1.s_b1_$i);\n";
       print FH "top1_i.ifc_b12.p_b1_$i.connect(sg_top2.s_b1_$i);\n";
       
     }
     elsif( $i > 300 && $i <= 350) {
         print FH "top1_i.ifc_b11.p_b2_$i.connect(sg_top1.s_b2_$i);\n";
         print FH "top1_i.ifc_b12.p_b2_$i.connect(sg_top2.s_b2_$i);\n";
     }
    elsif( $i > 350 && $i <= 400) {
        print FH "top1_i.ifc_b12.p_b_br1_$i.connect(sg_top1.s_b_br1_$i);\n";
        print FH "top1_i.ifc_b12.p_b_br2_$i.connect(sg_top1.s_b_br2_$i);\n";
     }
    elsif( $i > 400 && $i <= 450) {
       print FH "top1_i.ifc_b11.p_b_br1_$i.connect(sg_top2.s_b_br1_$i);\n";
       print FH "top1_i.ifc_b11.p_b_$i.connect(sg_top2.s_b_$i);\n";
     }
    elsif( $i > 450 && $i <= 500) {
       print FH "top1_i.ifc_b11.p_b_$i.connect(sg_top2.s_b_$i);\n";
       print FH "top1_i.ifc_b12.p_b_br_$i.connect(sg_top1.s_b_br_$i);\n";
   }  
    print FH "  }\n";        
    print FH "};\n";        
    print FH "\n";
   
   }
   
    close(FH);
 }  

`./ar_sg_ifc_ifc1.pl`;
`./ar_sg_ifc_ps.pl`;
`./ar_sg_ifc_ifc1_ps.pl`;
`./ar_unit_port_invalid.pl`;
`./ar_unit_sig_invalid.pl`;
`./ar_unit_port_ps_invalid.pl`;
`./ar_sg_sig_concat_valid.pl`;
`./ar_sg_sig_replic_valid.pl`;
`./ar_sg_op_expr.pl`;
`./ar_op_expr_ifc_invalid.pl`;
`./ar_concat_expr_ifc_invalid.pl`;
`./ar_replic_expr_ifc_invalid.pl`;
`./ar_sg_sg_invalid.pl`;
`./ar_port_unit_invalid.pl`;
`./ar_port_rf_invalid.pl`;
`./ar_port_fifo_invalid.pl`;