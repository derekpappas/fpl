# synp_converter - test out the atomic functions

#require "perllib.pl";
do "perllib.pl";

my $inputfilename  = "";
my $outputfilename = "";
my $foundinputfilename = false;

# use argv
if ($outputfilename =~ m/([^\.]+)\.synp/) {
$inputfilename  = $ARGV[0];

# check file extension for .synp

if (m/(([^\.]+\.synp)/){
    print "found input file name: $1\n";            
    $foundinputfilename = true;
    $inputfilename = "$1";
}

if (! $foundinputfilename) {
   print "ERROR Did not find the input file synp file";
   exit;
}

if ($outputfilename =~ m/([^\.]+)\.synp/) {
    $outputfilename = "$1.vf";
    print "output file name: $outputfilename\n";            
}
else {
   print "ERROR Unable to extract the root of the input file synp file";
   exit;
}

my @linelist    = load_file($inputfilename);

@linelist = rsort(@linelist);        # Sort and reverse the line list
@linelist = atomic_chomp(@linelist); # Chomp each line in linelist

listall(@linelist);
printsplitline(@linelist);
my $top_module = parse_and_find_top_module(@linelist);
parse(@linelist, $top_module, $outputfilename);

sub openfile {
	my $filename = @_;
   FILE F
   unless( open F, ">$filename" ){
      die "Error";
   }
	return F;
}


sub listall {
	my @list2print = @_;

	foreach(@list2print) {
		print "$_\n";
	}
}

sub printsplitline {
	my @filelist = @_;
	my @linelist;

	foreach(@filelist) {
		@linelist = split(/\s+/);";
		print "*************linelist**********\n@linelist\n";
   }
}

sub parse_and_find_top_module {
	my @filelist = @_;
	my @linelist;
   my $top_module = "";
   my $found_top_module = false;

	foreach(@filelist) {
		@linelist = split(/\s+/);";
		print "*************linelist**********\n@linelist\n";
      
      if (m/set_option\s+-top_module\s+\"([^\"]+)\"/) {
          print "found top_module: $1\n";            
          $found_top_module = true;
          $top_module = $1;
                    
  $top_module_path = abs_path($top_module);

if ($top_module_path =~ m/(([^\\]+\\)+)[^\.]+.v/) {
             print "found top_module: $1\n";            
             my $cwd = cwd();
             $top_module_path = "$cwd/$1";
         }
      }
   }

   if ($found_top_module) return $top_module_path;
   else {
      print "ERROR Did not find the top module in the file";
      exit;
   }
}

sub parse {
	my (@filelist, $top_module_path, $outputfilename) = @_;
	my @linelist;
   my $top_module = "";
   my $found_top_module = false;

#   F = openfile($outputfilename);

   my FILE F;
   unless( open F, ">$filename" ){
      die "Error: can't open $filename";
   }

	foreach(@filelist) {
      if (m/add_file\s+-verilog\s+\"([^\"]+)\"/){
          print "found add_file: $1\n";            
          print F "$top_module_path$1\n";
      }
      elsif (m/set_option\s+-include_path\s+\"([^\"]+)\"/){
          print "found include_path: $1\n";            
          print F "-I $top_module_path$1\n";
      }
   }
}



sub getcwd {

	return $cwd;
}
