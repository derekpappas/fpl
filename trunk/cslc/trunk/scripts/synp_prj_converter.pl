#!/usr/bin/perl

#require "perl_library.pm";

do "perl_library.pl";

use Cwd;

$inputfilename  = "";
$outputfilename = "";
$foundinputfilename = false;

print $outputfilename;

# use argv
print "count = $#ARGV \n";
print "argv0 = $ARGV[0]\n";
print "argv1 = $ARGV[1]\n";

if ($#ARGV != 2) {
    print "usage: synp_prj_converter filename.prj \n";
    #exit;
}

$inputfilename = $ARGV[0];
# check file extension for .prj
print "found input file name: $inputfilename\n";            

if ($ARGV[0] =~ m/([^\.]+)\.prj/) {
    print "found input file name: $1\n";            
    $foundinputfilename = true;
    $outputfilename = "$1";
}
else  {
    print "ERROR Did not find the input file prj file";
    exit;
}

if ($outputfilename = $ARGV[0] =~ m/([^\.]+)\.prj/) {
    $outputfilename = "$1.vf";
    print "output file name: $outputfilename\n";            
}
else {
    print "ERROR Unable to extract the root of the input file prj file";
    exit;
}

my @linelist    = load_file($inputfilename);

@linelist = rsort(@linelist);        # Sort and reverse the line list
@linelist = atomic_chomp(@linelist); # Chomp each line in linelist

listall(@linelist);
#printsplitline(@linelist);
my $top_module_path = parse_and_find_top_module(@linelist);

print "top_module_path top = $top_module_path\n";

parse($top_module_path, $outputfilename, @linelist);

sub openfile {
    my $filename = @_;
    FILE File;
    unless( open File, ">$filename" ) {    
        die( "Error" );
    }
    return File;
}


sub listall {
    my @list2print = @_;

    foreach(@list2print) {
        #print "$_\n";
    }
}

sub printsplitline {
    my @filelist = @_;
    my @linelist;
    
    foreach(@filelist) {
        @linelist = split(/\s+/);
        #print "*************linelist**********\n@linelist\n";
    }
}

sub parse_and_find_top_module {
    my @filelist = @_;
    my @linelist;
    my $top_module = "";
    my $found_top_module = false;
    my $top_module_path = "";
    
    foreach(@filelist) {
        @linelist = split(/\s+/);
        #print "*************linelist**********\n@linelist\n";
        
        if (m/set_option -top_module \"([^\"]+)\"/) {
            print "found top_module: $1\n";            
            $found_top_module = true;
            $top_module = $1;
#            $top_module_path = abs_path($top_module);
            
            my $cwd = getcwd();
            if ($top_module_path =~ m/(([^\/]+\/)+)[^\.]+.v/) {
                print "found top_module1: $1\n";            
                $top_module_path = "$cwd/$1";
                print "top_module_path1 = $top_module_path\n";
                last;
            }
            else {
                $top_module_path = "$cwd";
                print "top_module_path2 = $top_module_path\n";
                last;
            }
        }
    }
    if ($found_top_module) {
        return $top_module_path;
    }   
    else {
        print "ERROR Did not find the top module in the file";
        exit;
    }
}

sub parse {
    my($top_module_path, $outputfilename, @filelist) = @_;

    @linelist;
    $top_module = "";
    $found_top_module = false;
    print "top_module_path4 = $top_module_path\n";
    print "outputfilename = $outputfilename\n";
    open( fh, ">$outputfilename") or die "outfile:  $outputfilename not opened";    
    foreach(@filelist) {
        @linelist = split(/\s+/);
        #print "*************linelist**********\n", @linelist, "\n";
        
        if (m/add_file\s+-verilog\s+\"([^\"]+)\"/){
            print "found add_file: $1\n";            
            print fh "$top_module_path/$1\n";
        }
        elsif (m/set_option\s+-include_path\s+\"([^\"]+)\"/){
            print "found include_path: $1\n";            
            print fh "-I $top_module_path/$1\n";
        }
    }    
}
