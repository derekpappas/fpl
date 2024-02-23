#!/usr/bin/perl

#Monica
#connect_by_name() method with hid and part select
#Test_Matrix: /test_matrices/ar_conn_by_name_matr.ods, 11 test cases

use strict;

print "Generated tests path : test/csl_test_gen/ar_conn_name_hid_ps_valid/\n";

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

foreach(my $i = 1; $i <= 60; $i++) {
    &main($i);
}

sub main {
    my $i = $_[0];
      
    my $test_name = "ar_conn_name_hid_ps".$i."_legal.csl";
   
	&createCslFile($test_name, $i);
    
   }
sub createCslFile {
    my($test_name, $i) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen/";
    my $k = int(rand(20)) + int(rand(20));
    my $zero = 0;
    my $one = 1;
    my $two = 2;
    my $tre = 3;
    my $val1 = int(rand(100)) + 4;
    my $val2 = int(rand(100)) + 3;
    my $val3 = int(rand(100)) + 8;
    my $l = int(rand(3))+1;
    my $l1=$l+1;
    my $j;

    if($test_name=~/(_legal)/){
        &mkDir("$path/ar_conn_name_hid_ps_valid");
        open(FH,">$path/ar_conn_name_hid_ps_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ar_conn_name_hid_ps_invalid"); 
        open(FH,">$path/ar_conn_name_hid_ps_invalid/$test_name");
    }
    print FH "//Generated by Monica\n\n";
    print FH "//Test_Matrix: /test_matrices/ar_conn_by_name_matr.ods\n\n";

#bitranges
    print FH "csl_bitrange br1($val1);\n\n";

    print FH "csl_bitrange br2($val2);\n\n";
    
    print FH "csl_bitrange br3($val3);\n\n";


# ifc.port.ps-->port
# ifc.port.ps-->sig
# ifc.ifc.port.ps-->port
# ifc.ifc.port.ps-->sig

    if($i>0 && $i<=10){

    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br1);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1_$i(input,br1);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
foreach (my $j=1; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
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
     print FH "csl_port pt1_$j(input,$l);\n";
     print FH "csl_signal st1_$j($l);\n";

} 
foreach(my $k=1; $k<=$i; $k++){

print FH "csl_port ptt2_$k(output,$l);\n";
 print FH "csl_signal stt2_$k($l);\n";
}
    
 
    print FH "   u2_$i(){\n";
 foreach (my $j=1; $j<=$i; $j++){
    
    print FH " u1_i$i.ifc2_i$j.p1_$i [$l:$one].connect_by_name(pt1_$j);  // ifc.port.ps ---port\n";
    print FH " u1_i$i.ifc2_i$j.p2_$i [$l:$one].connect_by_name(st1_$j);  // ifc.port.ps ---sig\n";
}
 foreach (my $j=1; $j<=$i; $j++){
   foreach(my $k=1; $k<=$i; $k++){
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p2_$i [$l:$one].connect_by_name(ptt2_$k);  // ifc.ifc.port.ps ---port\n";
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p1_$i [$l:$one].connect_by_name(stt2_$k);  // ifc.ifc.port.ps ---sig\n";
}
    }
    
    print FH "   }\n";
    print FH "   };\n\n";
}

# ifc.port.ps-->port.ps
# ifc.port.ps-->sig.ps
# ifc.ifc.port.ps-->port.ps
# ifc.ifc.port.ps-->sig.ps

 if($i>10 && $i<=20){

    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";

foreach (my $j=11; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
 foreach (my $j=11; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";
    print FH " u1_$i u1_i$i;\n";

 foreach (my $j=11; $j<=$i; $j++){
     print FH "csl_port pt1_$j(input,$l1);\n";
     print FH "csl_signal st1_$j($l1);\n";

} 
foreach(my $k=11; $k<=$i; $k++){

print FH "csl_port ptt2_$k(output,$l);\n";
 print FH "csl_signal stt2_$k($l);\n";
}
    
    my $up1=$l-1;
    my $up2=$l1-1;
    print FH "   u2_$i(){\n";
 foreach (my $j=11; $j<=$i; $j++){
    
    print FH " u1_i$i.ifc2_i$j.p1_$i [$up2:$zero].connect_by_name(pt1_$j [$up2:$zero]);  // ifc.port.ps ---port.ps\n";
    print FH " u1_i$i.ifc2_i$j.p2_$i [$up2:$zero].connect_by_name(st1_$j [$up2:$zero]);  // ifc.port.ps ---sig.ps\n";
}
 foreach (my $j=11; $j<=$i; $j++){
   foreach(my $k=11; $k<=$i; $k++){
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p2_$i [$up1:$zero].connect_by_name(ptt2_$k [$up1:$zero]);  // ifc.ifc.port.ps ---port.ps\n";
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p1_$i [$up1:$zero].connect_by_name(stt2_$k [$up1:$zero]);  // ifc.ifc.port.ps ---sig.ps\n";
}
    }
    
    print FH "   }\n";
    print FH "   };\n\n";
}

# ifc.port.ps-->ifc.port
# ifc.port.ps-->sg.sig
# ifc.ifc.port.ps-->ifc.port
# ifc.ifc.port.ps-->sg.sig

 if($i>20 && $i<=30){

    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg1_$i {\n";
    print FH "   csl_signal s1_$i(br3);\n";
    print FH "   csl_signal s2_$i(br2);\n";
    print FH "   sg1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
   

foreach (my $j=21; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";

 foreach (my $j=21; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";

    print FH " u1_$i u1_i$i;\n";

 foreach (my $j=21; $j<=$i; $j++){
     print FH " ifc1_$i ifc1_i$j;\n";
 }
foreach (my $j=21; $j<=$i; $j++){
     print FH " sg1_$i sg1_i$j;\n";
 }
    
    my $up1=$val3-1;
    my $up2=$val2-1;

    print FH "   u2_$i(){\n";
 foreach (my $j=21; $j<=$i; $j++){
    
    print FH " u1_i$i.ifc2_i$j.p1_$i [$up1:$zero].connect_by_name(ifc1_i$j.p1_$i);  // ifc.port.ps ---ifc.port\n";
    print FH " u1_i$i.ifc2_i$j.p2_$i [$up2:$zero].connect_by_name(sg1_i$j.s2_$i);  // ifc.port.ps ---sg.sig\n";

   
}
 foreach (my $j=21; $j<=$i; $j++){
   foreach(my $k=21; $k<=$i; $k++){
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p1_$i [$up1:$zero].connect_by_name(sg1_i$j.s1_$i);  // ifc.ifc.port.ps ---sg.sig\n";
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p2_$i [$up2:$zero].connect_by_name(ifc1_i$j.p2_$i);  // ifc.ifc.port.ps ---ifc.port\n";

}
    }
    
    print FH "   }\n";
    print FH "   };\n\n";
}

# ifc.port.ps-->ifc.port.ps
# ifc.port.ps-->sg.sig.ps
# ifc.ifc.port.ps-->ifc.port.ps
# ifc.ifc.port.ps-->sg.sig.ps

 if($i>30 && $i<=40){

    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg1_$i {\n";
    print FH "   csl_signal s1_$i(br3);\n";
    print FH "   csl_signal s2_$i(br2);\n";
    print FH "   sg1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1_$i(input,br3);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
   

foreach (my $j=31; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";

 foreach (my $j=31; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u2_$i {\n";

    print FH " u1_$i u1_i$i;\n";

 foreach (my $j=31; $j<=$i; $j++){
     print FH " ifc1_$i ifc1_i$j;\n";
 }
foreach (my $j=31; $j<=$i; $j++){
     print FH " sg1_$i sg1_i$j;\n";
 }
    
    my $up1=$val3-1;
    my $up2=$val2-1;

    print FH "   u2_$i(){\n";
 foreach (my $j=31; $j<=$i; $j++){
    
    print FH " u1_i$i.ifc2_i$j.p1_$i [$up1:$zero].connect_by_name(ifc1_i$j.p1_$i [$up1:$zero]);  // ifc.port.ps ---ifc.port.ps\n";
    print FH " u1_i$i.ifc2_i$j.p2_$i [$up2:$zero].connect_by_name(sg1_i$j.s2_$i [$up2:$zero]);  // ifc.port.ps ---sg.sig.ps\n";

   
}
 foreach (my $j=31; $j<=$i; $j++){
   foreach(my $k=31; $k<=$i; $k++){
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p1_$i [$up1:$zero].connect_by_name(sg1_i$j.s1_$i [$up1:$zero]);  // ifc.ifc.port.ps ---sg.sig.ps\n";
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p2_$i [$up2:$zero].connect_by_name(ifc1_i$j.p2_$i [$up2:$zero]);  // ifc.ifc.port.ps ---ifc.port.ps\n";

}
    }
    
    print FH "   }\n";
    print FH "   };\n\n";
}

#ifc.port --- ifc.port.ps
#port.ps---ifc.port.ps
#sg.sig---ifc.port.ps
#sig.ps---ifc.port.ps

 if($i>40 && $i<=50){
    my $up1=$val1-1;
    my $up2=$val2-1;
    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br1);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_signal_group sg1_$i {\n";
    print FH "   csl_signal s1_$i(br1);\n";
    print FH "   csl_signal s2_$i(br2);\n";
    print FH "   sg1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";

 foreach (my $j=41; $j<=$i; $j++){
    print FH "ifc1_$i ifc1_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";
   
    print FH " csl_unit u2_$i { \n";

 foreach (my $j=41; $j<=$i; $j++){
    print FH "sg1_$i sg1_i$j;\n";
} 
    print FH "   u2_$i(){}\n";
    print FH "   };\n\n";

     print FH " csl_unit top_$i { \n";
 foreach (my $j=41; $j<=$i; $j++){
    print FH " csl_port pt2_$j(output,br2);\n"; 
    print FH " csl_port pt1_$j(input,br1);\n"; 
}
    print FH " u1_$i u1_i$i;\n";
    print FH " u2_$i u2_i$i;\n";

 foreach (my $j=41; $j<=$i; $j++){
#    print FH "sg1_$i sg1_i$j;\n";
    print FH "ifc1_$i ifc1_i$j;\n";
} 
    print FH "   top_$i(){\n";
 foreach (my $j=41; $j<=$i; $j++){
     print FH " u1_i$i.ifc1_i$j.p1_$i.connect_by_name(ifc1_i$j.p1_$i [$up1:$zero]);       // ifc.port --- ifc.port.ps\n";
     print FH " u2_i$i.sg1_i$j.s2_$i.connect_by_name(ifc1_i$j.p2_$i [$up2:$zero]);        //sg.sig ---ifc.port.ps\n";
     print FH " pt2_$j [$up2:$zero].connect_by_name(u1_i$i.ifc1_i$j.p2_$i [$up2:$zero]);  // port.ps --- ifc.port.ps\n";
     print FH " u2_i$i.sg1_i$j.s1_$i [$up1:$zero].connect_by_name(pt1_$j [$up1:$zero]);   // sg.sig.ps --- ifc.port.ps\n";
}
    print FH "   }\n";
   print FH "   };\n\n";

}
#ifc.port.ps --{concat_expr}
#ifc.port.ps --op_expr
#ifc.port--op_expr

 if($i>50 && $i<=60){

     my $s1=$val1-2;
     my $s2=2;
     my $l1=$val1; 
     my $l2=$val2;
     my $x1=$val2-2;
     my $x2=2;
     my $y1=$val1-1;
     my $y2=$val2-1;
    print FH " csl_interface ifc1_$i {\n";
    print FH "   csl_port p1_$i(input,br1);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
    print FH "   ifc1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_interface ifc2_$i {\n";
    print FH "   csl_port p1_$i(input,br1);\n";
    print FH "   csl_port p2_$i(output,br2);\n";
foreach (my $j=51; $j<=$i; $j++){
    print FH " ifc1_$i ifc1_i$j;\n";
}
    print FH "   ifc2_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit u1_$i {\n";
 foreach (my $j=51; $j<=$i; $j++){
    print FH "ifc2_$i ifc2_i$j;\n";
} 
    print FH "   u1_$i(){}\n";
    print FH "   };\n\n";

    print FH " csl_unit top_$i {\n";
    print FH " u1_$i u1_i$i;\n";
 foreach (my $j=51; $j<=$i; $j++){
     print FH "csl_port pt1_$j(input,$s1);\n";
     print FH "csl_port pt2_$j(input,$s2);\n";
     print FH "csl_signal st1_$j($x1);\n";
     print FH "csl_signal st2_$j($x2);\n";

}
 foreach (my $j=51; $j<=$i; $j++){ 
    foreach(my $k=51; $k<=$i; $k++){
  print FH "csl_port ptt1_$j$k(input,br1);\n";
 print FH "csl_signal stt1_$j$k(br1);\n";
 print FH "csl_port ptt2_$j$k(output,br2);\n";
 print FH "csl_signal stt2_$j$k(br2);\n";
   }
 }   
 
    print FH "   top_$i(){\n";
 foreach (my $j=51; $j<=$i; $j++){
    
    print FH " u1_i$i.ifc2_i$j.p1_$i [$y1:$zero].connect_by_name({pt1_$j,pt2_$j});  // ifc.port.ps ---{concat_expr}\n";
    print FH " u1_i$i.ifc2_i$j.p2_$i [$y2:$zero].connect_by_name({st1_$j,st2_$j});  // ifc.port.ps ---{concat_expr}\n";
}
 foreach (my $j=51; $j<=$i; $j++){
   foreach(my $k=51; $k<=$i; $k++){
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p2_$i [$y2:$zero].connect_by_name(stt2_$j$k & ptt2_$j$k);  // ifc.ifc.port.ps ---op_expr\n";
    print FH " u1_i$i.ifc2_i$j.ifc1_i$k.p1_$i.connect_by_name(stt1_$j$k | ptt1_$j$k);             // ifc.ifc.port ---op_expr\n";
}
    }
    print FH "  }\n";
    print FH "   };\n\n";
 }
}