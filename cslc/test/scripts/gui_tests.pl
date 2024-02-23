#!/usr/bin/perl 
use strict;
require "Gui_Test_Scripts.pm";

#Author: Monica
#xtrem tests for GUI
    
   
    my $path = "$ENV{WORK}/test/csl_test_gen";
    my $test_valid_dir="gui_valid";
    my $test_invalid_dir="gui_invalid";
    
    print "Generated tests path : test/csl_test_gen/$test_valid_dir/\n";

use Test_Scripts;
    my $author="Monica";
    my $test_matr="gui_test_cases.ods";

#***************For xml file*************
my $csl   ="<CSL> \n";
my $_csl  ="</CSL> \n";
my $unit  ="    <Unit> \n";
my $_unit ="    </Unit> \n";
my $name  ="        <Name>";
my $_name ="</Name> \n";
my $unit_type ="        <UnitType> \n";
my $_unit_type ="        </UnitType>\n";
my $ifc   ="    <Interface>\n";    
my $_ifc  ="    </Interface>\n";
my $port  ="        <Port>\n";
my $_port ="        </Port>\n";
my $dir   ="            <Direction>";
my $_dir  ="</Direction>\n";
my $br    ="            <BitRange>";
my $_br   ="</BitRange> \n";  
my $wire_type    ="            <WireType>";
my $_wire_type   ="</WireType> \n";  
my $logic_type   ="            <LogicType>";
my $_logic_type   ="</LogicType> \n"; 
my $conn  ="    <Connection> \n";
my $_conn ="    </Connection> \n"; 
my $act_name ="        <ActualName>";
my $_act_name="</ActualName>\n";
my $ifc_name ="        <InterfaceName>";
my $_ifc_name="</InterfaceName>\n";
my $ifc_type ="        <InterfaceType>";
my $_ifc_type="</InterfaceType>\n";
my $ifc_conn ="        <InterfaceConnection>\n";
my $_ifc_conn="        </InterfaceConnection>\n";
my $drv_unit    ="            <DriverUnit>";
my $_drv_unit   ="</DriverUnit>\n";
my $drv_ifc_inst="            <DriverInterfaceInstance>";
my $_drv_ifc_inst="</DriverInterfaceInstance>\n ";
my $rec_unit     ="           <ReceiverUnit>";
my $_rec_unit    ="<ReceiverUnit>\n";
my $rec_ifc_inst ="           <ReceiverInterfaceInstance>";
my $_rec_ifc_inst="<ReceiverInterfaceInstance>\n";

#***************************************
#**********XML content******************

my $zero = 0;
sub mkXmlUnit1 {
    my($unitName,$unitInst)=@_;
    print FH "$unit";
    print FH "$name".$unitInst."$_name";
    print FH "$unit_type";
    print FH "    $name".$unitName."$_name";
    print FH "$_unit_type";
    print FH "$_unit";
}

sub mkXmlIfc1 {
    my($ifcName,$portW)=@_;
    print FH "$ifc";
    print FH "$name".$ifcName."$_name";
    print FH "$port";
    print FH "    $name x1 $_name";
    print FH "$dir INPUT $_dir";
    print FH "$br".($portW-1).":".$zero."$_br";
    print FH "$wire_type WIRE $_wire_type"; 
    print FH "$_port";
    print FH "$_ifc";
}

#******************************************
#************For ifc.csl file****************
sub mkIfc1 {
    my($ifcName,$width) = @_;
     print FH " csl_interface $ifcName {\n";
     print FH "    csl_port x1(input,$width);\n";
     print FH "   $ifcName (){}\n";
     print FH "   };\n\n";
}
#*********************************************
foreach(my $i = 1; $i <= 2; $i++) {
    &main($i);
}
 
sub main {
    my $i = $_[0];
    
    my $project_name = "gui_test_legal".$i."_project";  
    my $test_name_csl_xml = "gui_test_".$i."_legal.csl.xml";
    my $test_name_ifc_csl = "gui_test_".$i."_legal.ifc.lib.csl";
   
	&createXmlFile($project_name,$test_name_csl_xml, $i);
        &createIfcFile($project_name,$test_name_ifc_csl, $i);
    
   }

sub rand {
    my ($rand_val,$add_val)=@_;
    my $res=rand($rand_val)+ $add_val;
    return $res;
}

#*********************IFC_CSL File ******************************

sub createIfcFile {
    my($project_name,$test_name_ifc_csl, $i) = @_;
   
   &mkName($path,$test_valid_dir,$project_name,$test_name_ifc_csl);
   &each_test($author,$test_matr); 

if ($i==1)
{
#generates 100 simple interfaces
print FH " //100 simple interfaces generated \n";

    foreach(my $cnt=1; $cnt<=100; $cnt++){

	&mkIfc1("ifc1_$cnt","$cnt");
 
    }
}

if($i==2)
{
#generates 100 hid interfaces
print FH " //50 simple interfaces generated and 50 hid ifc \n";

    foreach(my $cnt1=1; $cnt1<=50; $cnt1++){

	&mkIfc1("ifc1_$cnt1","$cnt1");
 
    }
 foreach(my $cnt2=1; $cnt2<=50; $cnt2++){ 

    print FH " csl_interface ifc2_$cnt2 {\n";
    print FH "   csl_port x1(output);\n";
    print FH "   csl_port x2(output);\n";
    print FH "   ifc1_$cnt2 ifc1_i$cnt2;\n";
          
    print FH "   ifc2_$cnt2(){}\n";
    print FH "   };\n\n";
    }
}

#************XML File*******************************

sub createXmlFile {
 my($project_name,$test_name_csl_xml, $i) = @_;
   
   &mkName($path,$test_valid_dir,$project_name,$test_name_csl_xml);
   &each_test($author,$test_matr); 
  
if ($i==1)
{
#generates 100 parent to child connections
print FH " //100 parent to child connections \n\n";
print FH "<CSL>\n";
print FH "$unit";
print FH "$name top_unit $_name";
print FH "$unit_type";
print FH "    $name top_unit $_name";
print FH "$_unit_type";

   foreach(my $cnt=1; $cnt<=100; $cnt++){
       
	&mkXmlUnit1("unit1_$cnt","u1_$cnt");
 
    }
print FH "$_unit";

    foreach(my $cnt=1; $cnt<=100; $cnt++){
        
	&mkXmlIfc1("ifc1_$cnt","$cnt");
 
    }


}

if($i==2)
{
#generates 100 hid interfaces
print FH " //50 simple interfaces generated and 50 hid ifc \n\n";
print FH "<CSL>\n";

    foreach(my $cnt1=1; $cnt1<=50; $cnt1++){

	&mkXmlIfc1("ifc1_$cnt1","$cnt1");
 
    }
 foreach(my $cnt2=1; $cnt2<=50; $cnt2++){ 

    print FH " csl_interface ifc2_$cnt2 {\n";
    print FH "   csl_port x1(output);\n";
    print FH "   csl_port x2(output);\n";
    print FH "   ifc1_$cnt2 ifc1_i$cnt2;\n";
          
    print FH "   ifc2_$cnt2(){}\n";
    print FH "   };\n\n";
    }
}  
  print FH "</CSL>\n"; 
}
}

