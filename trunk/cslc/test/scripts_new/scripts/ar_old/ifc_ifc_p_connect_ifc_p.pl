#!/usr/bin/perl

#Author costelc
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
# for
my $n=9;
my $i ;
my $j;
my $i11;
my $j11;
my $count=0;
foreach ($i11=1;$i11<=3;$i11++)
{
    foreach ($j11=$i11+1;$j11<=3;$j11++)
{
        foreach ($i=1;$i<=$n;$i++)
        {
            foreach ($j=1;$j<=$n;$j++)    
            { 
                        $count=$count+1;
                        &main($count,$i, $j,$i11, $j11 );
                    }
            }
        }
}

sub main {     
  #  my $count = $_[0];  
    my $test_name = "ifc_ifc_p_connect_ifc_p_".$count."_legal.csl";
    &createCslFile($test_name, $count);
}


sub createCslFile {
    my $ifc ;
    my $i2;
    my $n=9;
    my $x=0 ;
    my $y=0;
    my($test_name, $count) = @_;
    my $path = "$ENV{WORK}/test/csl_test_gen";
    if($count==1){
        print (" Generated path: $path/ifc_ifc_p_connect_ifc_p/\n");}
    my $val = int(rand(500));
    if($val == 0) { $val = 1; }
    if($test_name=~/(_legal)/){
        &mkDir("$path/ifc_ifc_p_connect_ifc_p_valid");
        open(FH,">$path/ifc_ifc_p_connect_ifc_p_valid/$test_name");
    }
    elsif($test_name=~/(_illegal)/) {
        &mkDir("$path/ifc_ifc_p_connect_ifc_p_invalid"); 
        open(FH,">$path/ifc_ifc_p_connect_ifc_p_invalid/$test_name");
    }

    print FH "//costelc \n";
    print FH "//ifc_ifc_port-ifc_port \n\n";
    print FH "csl_bitrange br($val);\n";

    print FH "csl_interface ifc {\n";
    print FH "csl_port p_ifc_$x(input,br);\n";
    $y=$x+1;
    print FH "csl_port p_ifc_$y(output,br);\n";
    print FH " ifc() {} \n";
    print FH "};\n";
    
    print FH "csl_unit u1{\n";
    foreach ($i2=1; $i2<=$n; $i2++)
{
    print FH "ifc ifc$i2;\n";
} 
   print FH "u1() {} \n";
    print FH "};\n";
    
    print FH "csl_unit u2{\n";
    foreach ($i2=1; $i2<=$n; $i2++)
{
    print FH "ifc ifc$i2;\n";
}   
    print FH "u1 u1;\n";
    print FH "u2() {} \n";
    print FH "};\n";
    
    print FH "csl_unit u3{\n";
    foreach ($i2=1; $i2<=$n; $i2++)
{
    print FH "ifc ifc$i2;\n";
}      
    print FH "u2 u2; \n";
    print FH "u3() {} \n";
    print FH "};\n";
    
    print FH "csl_unit top{\n";
    print FH " u3 u3;\n";
    print FH "top() {\n";        
         print FH "u$i11.ifc$i.connect(u$j11.ifc$j);\n";    

    print FH "}\n";
    print FH "}; \n";

        
    close(FH);
}





 
