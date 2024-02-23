#!/usr/bin/perl
#v0.1
#author: andreib
#script to batch execute touch command on a given input string and a given number of times
#resulting files will be named input_string + counter(number_of_times) + .v(extension)

$input_string = $ARGV[0];
$iterations = $ARGV[1];

unless ( @ARGV == 2 )
{
  die("Run script with two arguments: input_string number_of_iterations\n");
}
#print $input_string;
#print $iterations;

#for($i=1;$i<=$iterations;++$i)
$i=1; 
 do {
#  exec "touch $input_string . $i . {.v}";
   system "touch $input_string$i.v";
  $i=$i+1;
} while ($i<=$iterations);

