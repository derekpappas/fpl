#!/usr/bin/perl
use strict;

# variable for printing debug information
my $pdebug=0;
# variable containing file name
my $file;

my $numArgs=$#ARGV +1;

if ($numArgs=0) {
    if ($pdebug) {print "$numArgs\n";}
    die "Too few arguments. Use --help for more information\n";
}

foreach my $argnum (0 .. $#ARGV) {
    if ($ARGV[$argnum]=~ m/(--debug)/) {
        $pdebug=1;
    }
    if ($ARGV[$argnum]=~ m/(--help)/) {
        print "MBASM assambler\n";
        print "[perl] mbasm.pl asm_file [--debug] [--help]\n\n";
        print "--debug -> prints debug information\n";
        exit;
    }
    if ($ARGV[$argnum]=~ m/(.+)(.)(asm)/) {
        $file=$1.$2.$3;
        if ($pdebug) {print "$file\n";}
    }
}
if ($pdebug) {print "Start program\n";}
#my $file="marchc.asm";
if ($pdebug) {print "$file\n";}
open(SF,$file) or die "[ERROR] could not open file\n";
my @lines=<SF>;
chomp(@lines);
close(SF);

my $lc = 0;
my %labelMap = ();
my %etMap = ();
my @codeLines = ();


# remove the empty lines and the lines with comments
# leaving only the code in the array

# registers
my $r0 = "r0"; 
my $r1 = "r1"; 
my $r2 = "r2"; 
my $r3 = "r3"; 
my $r4 = "r4"; 
my $r5 = "r5"; 
my $r6 = "r6"; 
my $r7 = "r7"; 
my $r8 = "r8"; 
my $r9 = "r9"; 
my $r10 = "r10"; 
my $r11 = "r11"; 
my $r12 = "r12"; 
my $r13 = "r13"; 
my $r14 = "r14"; 
my $r15 = "r15";

#special registers
my $status = "status"; 
my $caddrl = "caddrl"; 
my $caddrh = "caddrh"; 
my $haddrl = "haddrl"; 
my $haddrh = "haddrh"; 
my $sr5 = "r5"; 
my $sr6 = "r6"; 
my $sr7 = "r7"; 
my $sr8 = "r8"; 
my $sr9 = "r9"; 
my $sr10 = "r10"; 
my $sr11 = "r11"; 
my $sr12 = "r12"; 
my $sr13 = "r13"; 
my $sr14 = "r14"; 
my $sr15 = "r15";

#opcodes
my $add   = "add";
my $sub   = "sub"; 
my $or    = "or";
my $and   = "and";
my $cmp   = "cmp";
my $br    = "br";
my $sh    = "sh";
my $not   = "not";
my $mov   = "mov";
my $swp   = "swp";
my $incr  = "incr";
my $decr  = "decr";
my $movr  = "movr";
my $movc  = "movc";
my $mv  = "mv";
my $mram= "mram";


# define opcode map
my %opcodeMap=();
$opcodeMap{$add} =  "0000";
$opcodeMap{$sub} =  "0001";
$opcodeMap{$or} = "0010";
$opcodeMap{$and} = "0011";
$opcodeMap{$cmp} = "0100";
$opcodeMap{$sh} = "0101";
$opcodeMap{$not} = "0110";
$opcodeMap{$swp} = "0111";
$opcodeMap{$mov} = "1000";
$opcodeMap{$movr} = "1001";
$opcodeMap{$movc} = "1010";
$opcodeMap{$mv} = "1011";
$opcodeMap{$mram} = "1100";
$opcodeMap{$br} = "1101";
$opcodeMap{$incr} = "1110";
$opcodeMap{$decr} = "1111";


# define register map

my %registerMap=();
$registerMap{$r0} = "0000";
$registerMap{$r1} = "0001";
$registerMap{$r2} = "0010";
$registerMap{$r3} = "0011";
$registerMap{$r4} = "0100";
$registerMap{$r5} = "0101";
$registerMap{$r6} = "0110";
$registerMap{$r7} = "0111";
$registerMap{$r8} = "1000";
$registerMap{$r9} = "1001";
$registerMap{$r10} = "1010";
$registerMap{$r11} = "1011";
$registerMap{$r12} = "1100";
$registerMap{$r13} = "1101";
$registerMap{$r14} = "1110";
$registerMap{$r15} = "1111";


# define special register map

my %sregisterMap=();
$sregisterMap{$status} = "0000";
$sregisterMap{$caddrl} = "0001";
$sregisterMap{$caddrh} = "0010";
$sregisterMap{$haddrl} = "0011";
$sregisterMap{$haddrh} = "0100";
$sregisterMap{$sr5} = "0101";
$sregisterMap{$sr6} = "0110";
$sregisterMap{$sr7} = "0111";
$sregisterMap{$sr8} = "1000";
$sregisterMap{$sr9} = "1001";
$sregisterMap{$sr10} = "1010";
$sregisterMap{$sr11} = "1011";
$sregisterMap{$sr12} = "1100";
$sregisterMap{$sr13} = "1101";
$sregisterMap{$sr14} = "1110";
$sregisterMap{$sr15} = "1111";

#printf ("b =%.6b\n", $r1);


#searching for etiquets

foreach my $line (@lines) {
    if($line =~ /(\b.+\b)\s+(equ)\s+(\d+|r\d+)/) {
	my $et = $1;
	my $lt = $3; 
	if($pdebug) {print "$et $lt\n"; }
	if(defined $etMap{$et}) {
	    die "et defined twice : $1\n";
	}
	else {
	    $etMap{$et} = $lt;
	}
    }	
}

foreach my $line (@lines) {
    if ($line !~ /^\s*$/ ) { # empty line case
        if ($line !~ /^\#.*$/) { # comment at the beginning of the line case
            if ($line !~ /^\s*\#.*$/) { # comment in middle of line case
		if($line !~ /(.+)\s+(equ)\s+(\d+|r\d+)/) {
		    push(@codeLines, $line);
		    # print "1 line = $line\n";
		}
		else {
		    # print "1 NOMATCH line = $line\n";
		}
	    }
	    else {
		# print " 2 NOMATCH line = $line\n";
	    }
	}
	else {
	    # print "3 NOMATCH line = $line\n";
	}
    }
}

#display the etiquets and their value

foreach my $et (keys %etMap) {
    if ($pdebug) {print "etMap{$et} = $etMap{$et}\n";}
}

#replacing etiquets with the coressponding value

foreach my $et (keys %etMap) {
    foreach my $line (@codeLines) {
	$line =~ s/$et/$etMap{$et}/g;
    }
}

# get the labels and line numbers that the labels are on

foreach my $line (@codeLines) {
    if ($line =~ m/([^:]+):/) {
        my $label = $1;
        if ($pdebug) {print "*$lc colon = $label\n";}   
        if (defined $labelMap {$label}) {  
            die "label defined twice : $1\n";
        }
        else {
            $labelMap {$label} = $lc;
        }
    }   
    $lc = $lc +1;
}

foreach my $key (keys %labelMap) {
    if ($pdebug) {print "labelMap{$key} = $labelMap{$key}\n";}
}

foreach my $line (@codeLines) {
    if ($pdebug) {print "code line = $line\n";}
}

# strip out the labels with colons

my @strippedCodeLines = ();
foreach my $line (@codeLines) {
    if ($line =~ m/^([^\#]+)\#/){
        $line = $1;
    }

    if ($line =~ m/:(.+)$/) {
        push(@strippedCodeLines, $1);
    }   
    else {
        push(@strippedCodeLines, $line);
    }
}

foreach my $line (@strippedCodeLines) {
    if ($pdebug) {print "stripped code line = $line\n";}
}

# replace the labels in the asm cmds with the label line number

foreach my $label (keys %labelMap) {
    foreach my $line (@strippedCodeLines) {
        $line =~ s/$label/$labelMap{$label}/;
    }
}

foreach my $line (@strippedCodeLines) {
    if ($pdebug) {print "label replaced line = $line\n";}
}

foreach my $line (@strippedCodeLines) {
    if ($pdebug) {print "register replaced line = $line\n";}
}
 
#------------------------------
# Assambling instructions
#------------------------------

# assambling add instruction
foreach my $line (@strippedCodeLines) {
    
    if ($line =~ m/(add)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
        
        if ($pdebug) {print "$1 $2 $3 $4\n";}
        printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}$registerMap{$4}\n");
    }
    
# assambling sub instruction
    else {
        if ($line =~ m/(sub)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
            
            if ($pdebug) {print "$1 $2 $3 $4\n";}
            printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}$registerMap{$4}\n");
        }
        
# assambling or instruction
        else {
            if ($line =~ m/(or)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
                
                if ($pdebug) {print "$1 $2 $3 $4\n";}
                printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}$registerMap{$4}\n");
            }
            
# assambling and instruction
            else {		
                if ($line =~ m/(and)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
                    
                    if ($pdebug) {print "$1 $2 $3 $4\n";}
                    printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}$registerMap{$4}\n");
                }
                
# assambling cmp instruction
                else {
                    if ($line =~ m/(cmp)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
                        
                        if ($pdebug) {print "$1 $2 $3 $4\n";}
                        printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}$registerMap{$4}\n");
                    }
                    
# assambling br instruction
                    else {
                        if ($line =~ m/(br)\s+(\d)\s+(\d+)/) {
                            
                            if ($pdebug) {print "$1 $2 $3\n";}
                            printf ("$opcodeMap{$1}$2%.11b\n",$3);
                        }
                        
# assambling sh instruction
                        else {
                            if ($line =~ m/(sh)\s+(r\d+)\s+(\d+)\s+(r\d+)/) {
                                
                                if ($pdebug) {print "$1 $2 $3 $4\n";}
                                printf ("$opcodeMap{$1}$registerMap{$2}%.4b$registerMap{$4}\n",$3);
                            }
                            
# assambling not instruction
                            else {
                                if ($line =~ m/(not)\s+(r\d+)\s+(r\d+)/) {
                                    
                                    if ($pdebug) {print "$1 $2 $3\n";}
                                    printf ("$opcodeMap{$1}$registerMap{$2}0000$registerMap{$3}\n");
                                }
                                
# assambling mov instruction
                                else {
                                    if ($line =~ m/(mov)\s+(r\d+)\s+(r\d+)/) {
                                        
                                        if ($pdebug) {print "$1 $2 $3\n";}
                                        printf ("$opcodeMap{$1}$registerMap{$2}0000registerMap{$3}\n");
                                    }
                                    
                                        
# assambling swp instruction
                                    else {
                                        if ($line =~ m/(swp)\s+(r\d+)\s+(r\d+)/) {
                                            
                                            if ($pdebug) {print "$1 $2 $3\n";}
                                            printf ("$opcodeMap{$1}$registerMap{$2}0000$registerMap{$3}\n");
                                        } 

                                        
# assambling incr instruction
                                        else {
                                            if ($line =~ m/(incr)/) {
                                                
                                                if ($pdebug) {print "$1\n";}
                                                printf ("$opcodeMap{$1}000000000000\n");
                                            }
                                            
# assambling decr instruction
                                            else {
                                                if ($line =~ m/(decr)/) {
                                                    
                                                    if ($pdebug) {print "$1\n";}
                                                    printf ("$opcodeMap{$1}000000000000\n");
                                                }
                                                
# assambling movr instruction
                                                else {
                                                    if ($line =~ m/(movr)\s+(r\d+)\s+(\d+)/) {
                                                        
                                                        if ($pdebug) {print "$1 $2 $3\n";}
                                                        printf ("$opcodeMap{$1}$registerMap{$2}%.8b\n",$3);
                                                    }
                                                    
# assambling movc instruction
                                                    else {
                                                        if ($line =~ m/(movc)\s+(r\d+)\s+(\d+)/) {
                                                            
                                                            if ($pdebug) {print "$1 $2 $3\n";}
                                                            printf ("$opcodeMap{$1}$registerMap{$2}%.8b\n",$3);
                                                        }
                                                        
# assambling mvrs instruction
                                                        else {    
                                                            if ($line =~ m/(mv)(rs)\s+(.+)\s+(r\d+)/) {
                                                                
                                                                if ($pdebug) {print "$1$2 $3 $4\n";}
                                                                printf ("$opcodeMap{$1}0000$sregisterMap{$3}$registerMap{$4}\n");
                                                            }
# assambling mvsr instruction
                                                            else {
                                                                if ($line =~ m/(mv)(sr)\s+(r\d+)\s+(\b.+\b)/) {
                                                                    
                                                                    if ($pdebug) {print "$1$2 $3 $4\n";}
                                                                    printf ("$opcodeMap{$1}1000$registerMap{$3}$sregisterMap{$4}\n");
                                                                }
# assambling mramrs instruction
                                                                else {
                                                                    if ($line =~ m/(mram)(rs)\s+(r\d+)/) {
                                                                        
                                                                        if ($pdebug) {print "$1$2 $3\n";}
                                                                        printf ("$opcodeMap{$1}00000000$registerMap{$3}\n");
                                                                    }
# assambling mramsr instruction
                                                                else {
                                                                    if ($line =~ m/(mram)(sr)\s+(r\d+)/) {
                                                                        
                                                                        if ($pdebug) {print "$1$2 $3\n";}
                                                                        printf ("$opcodeMap{$1}10000000$registerMap{$3}\n");
                                                                    }
                                                                }
                                                            }
                                                        }   
                                                    }   
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

}
