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

foreach(my $i = 1; $i <= 130; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
    my $test_name = "connect_sg_ifc_ifc1_ps_test".$i."_legal.csl";
    &createCslFile($test_name, $i);
}
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_ar_gen";
   if($i==1){
        print (" Generated path: $path/ar_connect_sg_ifc_ifc1_ps_valid/\n");}
    my $val1 = int(rand(500));
    if($val1 == 0) { $val1 = 1; }
    my $val2= int(rand(200));
    if($val2== 0) { $val2= 1; }
    my $val3 = int(rand(100));
    if($val3==0) {$val3=1;}
    
    my $n=10;
    my $m=25;
    my $o=0;    

    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_connect_sg_ifc_ifc1_ps_valid");
        open(FH,">$path/ar_connect_sg_ifc_ifc1_ps_valid/$test_name");
    }
       if($i>0 && $i<=130){
 #*************************************************     
           if( $i>0 && $i<=100){
    print FH "//Generated by Monica\n";
    print FH "//Connect SG.signal--IFC.ifc1.port[ part_select]\n\n";
    print FH "// TEST $i;\n";

    print FH " csl_bitrange br1($val1);\n";
    print FH " csl_bitrange br2($val2);\n";
    print FH " csl_bitrange br3($val3);\n\n";

     if($i<=20){
       foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_signal_group sg_$i$j {\n";
        print FH "   csl_signal s_$j(br1);\n";
           foreach( my $k=1; $k<=$m; $k++){
              print FH "   csl_signal s_$j$k($k);\n";
          }
        print FH "sg_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
  
    }
       foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_interface ifc_$i$j {\n";
        print FH "   csl_port p_$j(output,br1);\n";
           foreach( my $k=1; $k<=$m; $k++){
              print FH "   csl_port p_$j$k(input,$k);\n";
          }
        if( $j<=$j-1){
            print FH "  ifc_$i$j  ifc_i$i$j;\n";
         }      
        print FH "ifc_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }
      foreach( my $j=1; $j<=$n; $j++){
      if($j>2){
        print FH "csl_unit u_$i$j {\n";
       
        print FH "   ifc_$i$j ifc_i$i$j;\n";
        print FH "   sg_$i$j  sg_i$i$j;\n";
        print FH "u_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }
    }
     print FH " csl_unit u_top_$i {\n";    
     foreach( my $j=1; $j<=$n; $j++){
           if($j>2){
           print FH " u_$i$j  u_i$i$j;\n";
      }
       }
     print FH " u_top_$i() {\n";
   foreach( my $j=1; $j<=$n; $j++){
           if($j>2){
               my $l=$j-1;
                foreach( my $val=1; $val<$m; $val++){
                     my  $upper_r=$val-1;
               foreach( my $j=3; $j<=$n; $j++){
               print FH "   u_i$i$j.sg_i$i$j.s_$j$val.connect(u_i$i$j.ifc_i$i$j.ifc_i$i$j.p_$j$val [$o:$upper_r]);\n";
           }
           }
           }
       }
     print FH "  }\n";
     print FH "};\n";
 
   }
     #********************************************************
 if($i > 20  && $i<=40 ){
      foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_signal_group sg_$i$j {\n";
        print FH "   csl_signal s_$j(br2);\n";
        foreach( my $k=1; $k<=$n; $k++){
              print FH "   csl_signal s_$j$k($k);\n";
          }
        print FH "sg_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
      foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_interface ifc_$i$j {\n";
        print FH "   csl_port p_$j(input,br2);\n";
        foreach( my $k=1; $k<=$n; $k++){
              print FH "   csl_port p_$j$k(input,$k);\n";
          }
         if( $j==$j-1 ){
            print FH "  ifc_$i$j  ifc_i$i$j;\n";
         }      
        print FH "ifc_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
     foreach( my $j=1; $j<=$n; $j++){
       if($j==$n){
        print FH "csl_unit u_$i$j {\n";
         foreach( my $j=1; $j<=$n; $j++){
        print FH "   ifc_$i$j ifc_i$i$j;\n";
        print FH "   sg_$i$j  sg_i$i$j;\n";
    }
        print FH "u_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    
   }   
} 
       print FH " csl_unit u_top_$i {\n";
    foreach( my $j=1; $j<=$n; $j++){
           if($j==$n){
           print FH " u_$i$j  u_i$i$j;\n";
       }
      }
     print FH " u_top_$i() {\n";
     foreach( my $j=1; $j<=$n; $j++){
           if($j==$n){
               my $l=$j-1;
                foreach( my $val=1; $val<10; $val++){
                     my  $upper_r=$val-1;
               foreach( my $j=1; $j<=$n; $j++){
               print FH "   u_i$i$n.sg_i$i$j.s_$j$val.connect(u_i$i$n.ifc_i$i$j.ifc_i$i$j.p_$j$val [$o:$upper_r]);\n";
           }
           }
           }
       }
  
 print FH "  }\n";
 print FH "};\n";
   }
    #*****************************************************************
 if($i > 40  && $i<=60 ){
      foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_signal_group sg_$i$j {\n";
        print FH "   csl_signal s_$j(br3);\n";
        foreach( my $k=1; $k<=$j; $k++){
              print FH "   csl_signal s_$j$k($k);\n";
          }
        print FH "sg_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }  
     foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_interface ifc_$i$j {\n";
        print FH "   csl_port p_$j(input,br3);\n";
        foreach( my $k=1; $k<=$j; $k++){
              print FH "   csl_port p_$j$k(output,$k);\n";
          }
         if( $j<=$j-1 ){
            print FH "  ifc_$i$j  ifc_i$i$j;\n";
            
         }      
        print FH "ifc_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
   foreach( my $j=1; $j<=$n; $j++){
      if($j>=1 && $j<=$n){
       print FH "csl_unit u_$i$j {\n";
       print FH "   ifc_$i$j ifc_i$i$j;\n";
       print FH "   sg_$i$j  sg_i$i$j;\n";
   
        print FH "u_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
  }
   print FH " csl_unit u_top_$i {\n";
       foreach( my $j=1; $j<=$n; $j++){
           if($j>=1 && $j<=$n){
           print FH " u_$i$j  u_i$i$j;\n";
       }
      } 
    print FH " u_top_$i() {\n";
          
    foreach (my $k=1; $k<=6; $k++){
        if($k == 6){
            my $l=$k-1;
                foreach( my $val=1; $val<6; $val++){
                     my  $upper_r=$val-1;
                                          
                         print FH " u_i$i$k.sg_i$i$k.s_$k$val.connect(u_i$i$k.ifc_i$i$k.ifc_i$i$l.p_$l$l [$o:$upper_r] );\n"; 
                            
             }
          }
      }
       
     print FH "  }\n";
     print FH "};\n";
   }

  #***********************************************************
      if($i > 60  && $i<= 80 ){
      foreach( my $j=1; $j<=8; $j++){
        print FH "csl_signal_group sg_$i$j {\n";
        print FH "   csl_signal s_$j(br2);\n";
        foreach( my $k=1; $k<=$j; $k++){
              print FH "   csl_signal s_$j$k($k);\n";
          }
        print FH "sg_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
    foreach( my $j=1; $j<=8; $j++){
        print FH "csl_interface ifc_$i$j {\n";
        print FH "   csl_port p_$j(output,br2);\n";
        foreach( my $k=1; $k<=$j; $k++){
              print FH "   csl_port p_$j$k(input,$k);\n\n";
                 }
        
           foreach( my $k=1; $k<$j; $k++){
            print FH "  ifc_$i$k  ifc_i$i$k;\n";
       
         }      
        print FH "ifc_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
   foreach( my $j=1; $j<=8; $j++){
      if($j>=2 && $j<=8){
       print FH "csl_unit u_$i$j {\n";
       print FH "   ifc_$i$j ifc_i$i$j;\n";
       print FH "   sg_$i$j  sg_i$i$j;\n";
   
        print FH "u_$i$j() {\n";
       print FH "  }\n";
        print FH "};\n";
    }    
  }
   print FH " csl_unit u_top_$i {\n";
       foreach( my $j=1; $j<=8; $j++){
           if($j>=2 && $j<=8){
           print FH " u_$i$j  u_i$i$j;\n";
       }
      }  
     print FH " u_top_$i() {\n";
  foreach( my $j=1; $j<=8; $j++){
           if($j>=2 && $j<=8){ 
    foreach (my $k=1; $k<$j; $k++){
        if($k == $j-1){
            foreach (my $l=1; $l<$k; $l++){
               
                if($l==$k-1){
                     my $val=$l-1;
                    print FH " u_i$i$j.sg_i$i$j.s_$j$l.connect(u_i$i$k.ifc_i$i$k.ifc_i$i$l.p_$l$l);\n";
                     if($j>2){
                         print FH " u_i$i$j.sg_i$i$j.s_$j$l.connect(u_i$i$k.ifc_i$i$k.ifc_i$i$l.p_$l$l [$o:$val]);\n"; }
                        }
                   }
             }
          }
      }
 } 
     print FH "  }\n";
     print FH "};\n";
  }

#**********************************************************
     if($i > 80  && $i<= 100 ){
      foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_signal_group sg_$i$j {\n";
        print FH "   csl_signal s_$j(br1);\n";
        foreach( my $k=1; $k<=$m-$n; $k++){
              print FH "   csl_signal s_$j$k($k);\n";
          }
        print FH "sg_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
      foreach( my $j=1; $j<=$n; $j++){
        print FH "csl_interface ifc_$i$j {\n";
        print FH "   csl_port p_$j(output,br1);\n";
        foreach( my $k=1; $k<=$m-$n; $k++){
              print FH "   csl_port p_$j$k(output,$k);\n";
          }
        foreach( my $k=1; $k<$j; $k++){
            print FH "  ifc_$i$k  ifc_i$i$k;\n";
         }      
        print FH "ifc_$i$j() {\n";
        print FH "  }\n";
        print FH "};\n";
    }    
     foreach( my $j=1; $j<=$n; $j++){
       if($j>=4){
        print FH "csl_unit u_$i$j {\n";
        print FH "   ifc_$i$j ifc_i$i$j;\n";
        print FH "   sg_$i$j  sg_i$i$j;\n";
            
        print FH "u_$i$j() {\n";
        foreach (my $k=1; $k<$j; $k++){
        if($k == $j-1){
                
               print FH " sg_i$i$j.s_$j$k.connect(ifc_i$i$j.ifc_i$i$k.p_$k$k);\n";
               
           }
     }
        print FH "  }\n";
        print FH "};\n";
    }    
   }
 print FH " csl_unit u_top_$i {\n";
       foreach( my $j=1; $j<=$n; $j++){
           if($j>=4){
           print FH " u_$i$j  u_i$i$j;\n";
       }
       }
     print FH " u_top_$i() {\n";
  foreach( my $j=1; $j<=$n; $j++){
           if($j>4){
    foreach (my $k=1; $k<$j; $k++){
        if($k == $j-1){
            foreach (my $l=1; $l<$k; $l++){
                if($l==$k-1){
                    print FH " u_i$i$j.sg_i$i$j.s_$j$k.connect(u_i$i$k.ifc_i$i$k.ifc_i$i$l.p_$l$k);\n";
                 }
            }
         }
     }
   }
 }
     print FH "  }\n";
     print FH "};\n";
      
 }

}
#***************************************************************
     if($i>100 && $i<=110){
    print FH "//Generated by Monica\n";
    print FH "//Connect SG.signal[part_select]--IFC.ifc1.port[ part_select]\n\n";
    print FH "// TEST $i;\n";

    print FH " csl_bitrange br1($val1);\n";
    print FH " csl_bitrange br2($val2);\n";
    print FH " csl_bitrange br3($val3);\n\n";
        
         
      foreach( my $j=100; $j<=$i; $j++){
          my $k=2*$j;
         print FH " csl_signal_group sg1_$j {\n";
         print FH "   csl_signal  s11_$j($k);\n";
     
         print FH " sg1_$j(){}\n";
         print FH " };\n";
         print FH " csl_interface ifc1_$j {\n";
         print FH "   csl_port p11_$j(input,$k);\n";
         print FH "   ifc1_$j (){}\n";
         print FH " };\n";
    }
      print FH " csl_interface ifc2{\n";
      print FH "   csl_port p12 (output,br2);\n";
   foreach( my $j=100; $j<=$i; $j++){
       my $k=$j+1;
       if( $k>100){
           print FH "   ifc1_$j ifc1_i$k;\n";
          }
   }
      print FH " ifc2(){}\n";
      print FH "};\n";
    
         print FH " csl_unit u1{\n";
         print FH "   ifc2 ifc_i2;\n";
         print FH "  u1(){}\n";
         print FH " };\n";
        
         print FH " csl_unit u2{\n";
         print FH "    u1 u1_i;\n";
      foreach( my $j=100; $j<=$i; $j++){
          my $ui=$j-1;
         print FH " sg1_$j sg1_i$j;\n"; 
      }
         print FH " u2(){\n";
    foreach( my $j=100; $j<=$i; $j++){
      my $ui=$j-1;                             #upper_index
      my $li=$ui+1;                           #lower_index
      my $k=$j+1;
      my $k1=2*$j-1;
      
       if( $k>100){
         print FH " sg1_i$j.s11_$j [$o: $ui].connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$o: $ui]);\n";  
         print FH " sg1_i$j.s11_$j [$li: $k1].connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$li: $k1]);\n";    
     }
   }
  
       print FH "}\n";
         print FH " };\n"; 
     }
#***************************************************************
     if ($i>110 && $i<=120){
    print FH "//Generated by Monica\n";
    print FH "//Connect SG.sg1.signal--IFC.ifc1.port[ part_select]\n\n";
    print FH "// TEST $i;\n";

    print FH " csl_bitrange br1($val1);\n";
    print FH " csl_bitrange br2($val2);\n";
    print FH " csl_bitrange br3($val3);\n\n";

  foreach( my $j=110; $j<=$i; $j++){
       my $k=2*$j; 
         print FH " csl_signal_group sg1_$j {\n";
         print FH "   csl_signal  s11_$j($j);\n";
     
         print FH " sg1_$j(){}\n";
         print FH " };\n";
         print FH " csl_interface ifc1_$j {\n";
         print FH "   csl_port p11_$j(input,$k);\n";
         print FH "   ifc1_$j (){}\n";
         print FH " };\n";
    }
      print FH " csl_interface ifc2{\n";
      print FH "   csl_port p12 (output,br2);\n";
   foreach( my $j=110; $j<=$i; $j++){
       my $k=$j+1;
       if( $k>100){
           print FH "   ifc1_$j ifc1_i$k;\n";
          }
   }
      print FH " ifc2(){}\n";
      print FH "};\n";
      print FH " csl_unit u1{\n";
         print FH "   ifc2 ifc_i2;\n";
         print FH "  u1(){}\n";
         print FH " };\n";
        
    print FH " csl_signal_group sg2{\n";
    print FH "  csl_signal s21(br1);\n";
    print FH "  csl_signal s22(br3);\n";
    foreach( my $j=110; $j<=$i; $j++){
         
         print FH " sg1_$j sg1_i$j;\n"; 
      }
    print FH " sg2(){}\n";
    print FH " };\n";

         print FH " csl_unit u2{\n";
         print FH "    u1 u1_i;\n";
         print FH "    sg2 sg2_i;\n"; 
         print FH " u2(){\n";
    foreach( my $j=110; $j<=$i; $j++){
      my $ui=$j-1;                             #upper_index
      my $li=$ui+1;                           #lower_index
      my $k=$j+1;
      my $k1=2*$j-1;
      
       if( $k>110){
         print FH " sg2_i.sg1_i$j.s11_$j.connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$o: $ui]);\n";  
      #   print FH " sg2_i.sg1_i$j.s11_$j.connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$li: $k1]);\n";    
     }
   }   
    print FH " }\n";
    print FH " };\n";
}
#***************************************************************
     if ($i>120 && $i<=130){
    print FH "//Generated by Monica\n";
    print FH "//Connect SG.sg1.signal[part_select]--IFC.ifc1.port[part_select]\n\n";
    print FH "// TEST $i;\n";

    print FH " csl_bitrange br1($val1);\n";
    print FH " csl_bitrange br2($val2);\n";
    print FH " csl_bitrange br3($val3);\n\n";

 foreach( my $j=120; $j<=$i; $j++){
          my $k=2*$j;
         print FH " csl_signal_group sg1_$j {\n";
         print FH "   csl_signal  s11_$j($k);\n";
     
         print FH " sg1_$j(){}\n";
         print FH " };\n";

         print FH " csl_interface ifc1_$j {\n";
         print FH "   csl_port p11_$j(input,$k);\n";
         print FH "   ifc1_$j (){}\n";
         print FH " };\n";
    }
      print FH " csl_interface ifc2{\n";
      print FH "   csl_port p12 (output,br2);\n";
   foreach( my $j=120; $j<=$i; $j++){
       my $k=$j+1;
       if( $k>100){
           print FH "   ifc1_$j ifc1_i$k;\n";
          }
   }
      print FH " ifc2(){}\n";
      print FH "};\n";
    
         print FH " csl_unit u1{\n";
         print FH "   ifc2 ifc_i2;\n";
         print FH "  u1(){}\n";
         print FH " };\n";

    print FH " csl_signal_group sg2{\n";
    print FH "  csl_signal s21(br1);\n";
    print FH "  csl_signal s22(br3);\n";
    foreach( my $j=120; $j<=$i; $j++){
         
         print FH " sg1_$j sg1_i$j;\n"; 
      }
    print FH " sg2(){}\n";
    print FH " };\n";

         print FH " csl_unit u2{\n";
         print FH "    u1 u1_i;\n";
         print FH "    sg2 sg2_i;\n"; 
         print FH " u2(){\n";
    foreach( my $j=120; $j<=$i; $j++){
      my $ui=$j-1;                             #upper_index
      my $li=$ui+1;                           #lower_index
      my $k=$j+1;
      my $k1=2*$j-1;
      
       if( $k>120){
         print FH " sg2_i.sg1_i$j.s11_$j [$o:$ui].connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$o: $ui]);\n";  
         print FH " sg2_i.sg1_i$j.s11_$j [$li:$k1].connect(u1_i.ifci_2.ifc1_i$k.p11_$j [$li: $k1]);\n";    
     }
   }   
    print FH " }\n";
    print FH " };\n";
}
}
close (FH);
}
