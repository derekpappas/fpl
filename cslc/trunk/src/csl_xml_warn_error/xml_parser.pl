#! /usr/bin/perl
use Switch;
#deletes table header and removes any unwanted spaces
if($#ARGV<1){
    print "USAGE: xml_parser XML_input_file XML_output_file\n";
    exit;
}     
$input_file=$ARGV[0];
$output_file=$ARGV[1];
system("cp -fv $ARGV[0] $ARGV[1]");
open (FILE,"<$output_file") or die "Can't open $file\n";
@lines=<FILE>;
close FILE;
open (FILE,">$output_file") or die "Can't open $file\n";
print FILE $lines[0];
print FILE $lines[2];
for ($count=3;$count<=$#lines;$count++){
    if($count>84){#jump first 84 lines(table header)
	print FILE $lines[$count];	
    }
    if($lines[$count]=~/<\/CellBody>/){
		if($lines[$count+1]=~/<CellBody>/){
			$count+=3;#jump a space
		}
	}
}
close FILE;

#Open the file and read data
#Die with grace if it fails
open (FILE, "<$output_file") or die "Can't open $file: $!\n";
@lines = <FILE>;
close FILE;

$m =1;	#first line
$n =60;	#last index in first line
$a =3;	#index for <ROW>
$b =5;	#index for <Cat>
$c =10;	#index for <Ph>
$e =15;	#index for <Type>
$ff=20; #<Name>
$f=25;	#<Desc>
$f1=30; #<Arguments>
$f2=35; #<Level>
$g =40;	#<V95>
$h =45;	#<V01>
$i =50;	#<SystVlog>
$j =55;	#<csl>
$k =59; #index for </ROW> then \n
$ch ="CellBody";
$chn="Name";
$ch1 ="Category";
$ch2 ="Phase";
$ch3 ="we";
$ch4 ="Type";
$ch5 ="Description";
$ch51="Arguments";
$ch52="Level";
$ch6 ="V1995";
$ch7 ="V2001";
$ch8 ="System_verilog";
$ch9 ="csl";
$ch10 ="\<\?xml version=\"1.0\" encoding=\"UTF-8\"\?\>";
$ch11 ="\<XML\>";
#$ch12 ="\<TABLE\>";
$ch13 ="\<ROW\>";
#$ch14 ="\<CELL ROWSPAN=\"1\" COLSPAN=\"1\"\>";
#$ch15 ="\<\/CELL\>";
$ch16 ="\<\/ROW\>";
#$ch17 ="\<TABLE\>";
$ch18 ="\<\/XML\>";
#Open same file for writing, reusing STDOUT
open (FILE, ">$output_file") or die "Can't open $file: $!\n";

print FILE "$ch10\n";
print FILE "$ch11\n";
for ( @lines ) {
#  s/$ch10/$ch10/g;
#  s/$ch11/$ch11/g;
#  s/$ch12/$ch12/g;
    switch ($m) {
    case ($a) {
#        print FILE,"$ch16\n";
#        print FILE,"\n";
         if($a!=$#lines){
		print FILE "$ch13\n";
	    }
    }
    case [$b,($b+2)] {	#if is line 10 or 12, line 57 or 59, line 104 or 106... modify the <CellBody> with <Cathegory>
	s/$ch/$ch1/g;
	print FILE;
    }
    case [$ff,($ff+2)] {	#if is line 10 or 12, line 57 or 59, line 104 or 106... modify the <CellBody> with <Cathegory>
	s/$ch/$chn/g;
	print FILE;
    }
    case [$f1,($f1+2)] {	#if is line 10 or 12, line 57 or 57, line 104 or 106... modify the <CellBody> with <Cathegory>
	s/$ch/$ch51/g;
	print FILE;
    }
    case [$f2,($f2+2)] {	#if is line 10 or 12, line 57 or 57, line 104 or 106... modify the <CellBody> with <Cathegory>
	s/$ch/$ch52/g;
	print FILE;
    }
    case [$c,($c+2)] {	#if is line 15 or 17, line 62 or 64, line 109 or 111... modify the <CellBody> with <Phase>
	s/$ch/$ch2/g;
	print FILE;
    }
    case [$d,($d+2)] {	#if is line 20 or 22, line 67 or 69... modify the <CellBody> with <Phase>
	s/$ch/$ch3/g;
	print FILE;
    }
    case [$e,($e+2)] {
	s/$ch/$ch4/g;
	print FILE;
    }
    case [$f,($f+2)] {
	s/$ch/$ch5/g;
	print FILE;
    }
    case [$g,($g+2)] {
	s/$ch/$ch6/g;
	print FILE;
    }
    case [$h,($h+2)] {
	s/$ch/$ch7/g;
	print FILE;
    }
    case [$i,($i+2)] {
	s/$ch/$ch8/g;
	print FILE;
    }
    case [$j,($j+2)] {
	s/$ch/$ch9/g;
	print FILE;
    }
    case ($k) {
#        print "$ch16\n";
        s/$ch16/$ch16/g;
        print FILE;
        print FILE "\n";
    }
#   else {print "Another line\n";}
  }
#  s/$ch13/$ch13/g;
#  s/$ch14/$ch14/g;
#  s/$ch15/$ch15/g;
#  s/$ch16/$ch16/g;
#  print "$m\n";
  $m++;	#increment the index for lines
  if ($m == $n){	#if is the end of the first iteration, increment the indexs
#print "line __53__ or __100__ or ..\n";
    $ff+=57; $a+=57; $b+=57; $c+=57; $d+=57; $e+=57; $f+=57; $f1+=57; $f2+=57; $g+=57; $h+=57; $i+=57; $j+=57; $k+=57; $n+=57;	
  }
}

#    s/$c1.*.$c2/chomp($lines)/eg;
#       s/$c1.*.$c2//g;

#       s/$ch18/$ch18/;

    print FILE "$ch18\n";


#Finish up
close FILE;
#print("$n\n");
