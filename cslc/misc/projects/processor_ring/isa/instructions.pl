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
    if ($ARGV[$argnum]=~ m/(.+)(.)(asm)/) {   # nu trebuia ca . sa fie altfel ca sa fie recunoscut ca .?
        $file=$1.$2.$3;
        if ($pdebug) {print "$file\n";}
    }
}
if ($pdebug) {print "Start program\n";}
#my $file="isa_RISC.asm";
if ($pdebug) {print "$file\n";}
open(SF,$file) or die "[ERROR] could not open file\n";
my @lines=<SF>;
chomp(@lines);
close(SF);
my $lc=0;
my %etMap = ();
my %labelMap = ();
my @codeLines = ();
my $zero=0000000000000000;
my $ones=1111111111111111;

#sub HextoBin {
#    my(%h)=('0'=>'0000','1'=>'0001','2'=>'0010','3'=>'0011','4'=>'0100','5'=>'0101','6'=>'0110','7'=>'0111','8'=>'1000','9'=>'1001','A'=>'1010','B'=>'1011','C'=>'1100','D'=>'1101','E'=>'1110','F'=>'1111');
#   $_=$_[0];
#  s/([0-9A-F])/($h{$1})/g;
#    printf ("%.4b$2");
#}


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
my $r16 = "r16"; 
my $r17 = "r17"; 
my $r18 = "r18"; 
my $r19 = "r19"; 
my $r20 = "r20"; 
my $r21 = "r21"; 
my $r22 = "r22"; 
my $r23 = "r23"; 
my $r24 = "r24"; 
my $r25 = "r25"; 
my $r26 = "r26"; 
my $r27 = "r27"; 
my $r28 = "r28"; 
my $r29 = "r29";
my $r30 = "r30";  
my $r31 = "r31"; 


#opcodes
my $read32req = "read32req";
my $write32 = "write32";
my $read32resp = "read32resp";
my $write64 = "write64";
my $read64resp = "read64resp";
my $read32dmareq = "read32dmareq";
my $write32dma = "write32dma";
my $read64dmareq = "read64dmareq";
my $write64dma = "write64dma";
my $add   = "add";
my $sub   = "sub"; 
my $equal = "equal";
my $branch = "branch";
my $movhi = "movhi";
my $movi = "movi";
my $ori = "ori";
my $ldw = "ldw";
my $stw = "stw";
my $brgt= "brgt";
my $brlt= "brlt";
my $brp = "brp";
my $brn = "brn";


#hexa codes

my $A = "A";
my $B = "B";
my $C = "C";
my $D = "D";
my $E = "E";
my $F = "F";

# define opcode map
my %opcodeMap=();
$opcodeMap{$read32req} = "000000";
$opcodeMap{$write32} = "000001";
$opcodeMap{$read32resp} = "000010";
$opcodeMap{$write64} = "000011";
$opcodeMap{$read64resp} = "000100";
$opcodeMap{$read32dmareq} = "000101";
$opcodeMap{$write32dma} = "000110";
$opcodeMap{$read64dmareq} = "000111";
$opcodeMap{$write64dma} = "001000";
$opcodeMap{$add} =  "001001";
$opcodeMap{$sub} = "001010";
$opcodeMap{$equal} = "001011";
$opcodeMap{$branch} = "001100";
$opcodeMap{$movhi} = "001101";
$opcodeMap{$movi} = "001110";
$opcodeMap{$ori} = "001111";
$opcodeMap{$ldw} = "010000";
$opcodeMap{$stw} = "010001";
$opcodeMap{$brgt}= "010010";
$opcodeMap{$brlt}= "010011";
$opcodeMap{$brp} = "010100";
$opcodeMap{$brn} = "010101";

# define register map

my %registerMap=();
$registerMap{$r0} = "00000";
$registerMap{$r1} = "00001";
$registerMap{$r2} = "00010";
$registerMap{$r3} = "00011";
$registerMap{$r4} = "00100";
$registerMap{$r5} = "00101";
$registerMap{$r6} = "00110";
$registerMap{$r7} = "00111";
$registerMap{$r8} = "01000";
$registerMap{$r9} = "01001";
$registerMap{$r10} = "01010";
$registerMap{$r11} = "01011";
$registerMap{$r12} = "01100";
$registerMap{$r13} = "01101";
$registerMap{$r14} = "01110";
$registerMap{$r15} = "01111";
$registerMap{$r16} = "10000";
$registerMap{$r17} = "10001";
$registerMap{$r18} = "10010";
$registerMap{$r19} = "10011";
$registerMap{$r20} = "10100";
$registerMap{$r21} = "10101";
$registerMap{$r22} = "10110";
$registerMap{$r23} = "10111";
$registerMap{$r24} = "11000";
$registerMap{$r25} = "11001";
$registerMap{$r26} = "11010";
$registerMap{$r27} = "11011";
$registerMap{$r28} = "11100";
$registerMap{$r29} = "11101";
$registerMap{$r30} = "11110";
$registerMap{$r31} = "11111";

#define hexa map

my %hexaMap=();
$hexaMap{$A} = "10";
$hexaMap{$B} = "11";
$hexaMap{$C} = "12";
$hexaMap{$D} = "13";
$hexaMap{$E} = "14";
$hexaMap{$F} = "15";


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
    if ($line !~ /^\s*$/ ) {             # empty line case
        if ($line !~ /^\#.*$/) {         # comment at the beginning of the line case
            if ($line !~ /^\s*\#.*$/) {  # comment in middle of line case
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

my $zero = "000000";

#------------------------------
# Assambling instructions
#------------------------------

#assambling read32req instruction

foreach my $line (@strippedCodeLines) {
    if($line =~ m/(read32req)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])/) {
	if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
	printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}0000$5$zero$opcodeMap{$1}\n");
    }
   
#assambling write32 instruction

    else {
	if($line =~ m/(write32)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])\s+(\d+)/) {
	    if ($pdebug) {print "$1 $2 $3 $4 $5 $6\n"; }
	    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b$5$zero$opcodeMap{$1}\n",$6);
	}
	else {
	    if($line =~ m/(write32)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])/) {
		if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
		printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}0000$5$zero$opcodeMap{$1}\n");
	    }
		
#assambling read32resp instruction

	    else {
		if($line =~ m/(read32resp)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])\s+(\d+)/) {
		    if ($pdebug) {print "$1 $2 $3 $4 $5 $6\n"; }
		    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b$5$zero$opcodeMap{$1}\n",$6);
		}
		
		else {
		    if($line =~ m/(read32resp)\s+(pr\d+)\s+(data)(r\d+)\s+(pr\d+)\s+(r\d+)\s+([01])/) {
			if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
			printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}000045$zero$opcodeMap{$1}\n");
		}
		 
					
		
#assambling write64 instruction
		    
		    else {
			if($line =~ m/(write64)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])\s+(\d+)/) {
			    if ($pdebug) {print "$1 $2 $3 $4 $5 $6\n"; }
			    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b$5$zero$opcodeMap{$1}\n",$6);
			}
			
#assambling read64resp instruction
			
			else {
			    if($line =~ m/(read64resp)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+([01])\s+(\d+)/) {
				if ($pdebug) {print "$1 $2 $3 $4 $5 $6\n"; }
				printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b$5$zero$opcodeMap{$1}\n",$6);
			    }
			    
#assambling read32dmareq instruction
			    
			    else {
				if($line =~ m/(read32dmareq)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
				    if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
				    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b0$zero$opcodeMap{$1}\n",$5);
				}
				
#assambling write32dma instruction
				
				else {
				    if($line =~ m/(write32dma)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
					if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
					printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b0$zero$opcodeMap{$1}\n",$5);
				    }
				    
#assambling read64dmareq instruction
				    
				    else {
					if($line =~ m/(read64dmareq)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
					    if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
					    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b0$zero$opcodeMap{$1}\n",$5);
					}
					
#assambling write64dma instruction
					
					else {
					    if($line =~ m/(write64dma)\s+(r\d+)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
						if ($pdebug) {print "$1 $2 $3 $4 $5\n"; }
						printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}%.4b0$zero$opcodeMap{$1}\n",$5);
					    }
					    
					    
# assambling add instruction
					    
					    else {
						if ($line =~ m/(add)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
						    if ($pdebug) {print "$1 $2 $3 $4\n";}
						    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}00000000000$opcodeMap{$1}\n");
						}
						
# assambling sub instruction
						
						else {
						    if ($line =~ m/(sub)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
							if ($pdebug) {print "$1 $2 $3 $4\n";}
							printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}00000000000$opcodeMap{$1}\n");
						    }
						    
# assambling equal instruction
						    
						    else {
							if ($line =~ m/(equal)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
							    if ($pdebug) {print "$1 $2 $3 $4\n";}
							    printf ("$registerMap{$2}$registerMap{$3}$registerMap{$4}00000000000$opcodeMap{$1}\n");
							}
							
# assambling branch instruction
							
							else {
							    if ($line =~ m/(branch)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
								if ($pdebug) {print "$1 $2 $3 $4\n";}
								printf ("$registerMap{$2}$registerMap{$3}%.16b$opcodeMap{$1}\n",$4);
							    }
							   
#assambling movhi instruction
							    
							    else {
								if($line =~m/(movhi)\s+(r\d+)\s+(\d+)/) {
								    if($pdebug) {print "$1 $2 $3\n";}
								    if($3>65535) {print "immediate value has more than 16 bits\n";}
								    else {
									printf ("$registerMap{$2}00000%.16b$opcodeMap{$1}\n",$3);
								    }
								}

#assambling movi instruction
							    
								else {
								    if($line =~ m/(movi)\s+(r\d+)\s+0x([0-9A-F])([0-9A-F])/) {
									if($pdebug) {print "$1 $2 0x$3$4\n";}
								printf ("$registerMap{$2}00000%.8b%.8b$opcodeMap{$1}\n",$hexaMap{$3}|$3,$hexaMap{$4}|$4);
								
                                # 	printf ("$registerMap{$2}$zero%.4b%.4b$opcodeMap{$1}\n",$hexaMap{$3}|$3,$hexaMap{$4}|$4);

								    }
																							    
#assambling ori instruction
								    
								    else {
									if($line =~m/(ori)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
									    if ($pdebug) {print "$1 $2 $3 $4\n";}
									    if($4>65535) {print "immediate value has more than 16 bits\n";}
									    else {
										printf ("$registerMap{$3}$registerMap{$2}%.16b$opcodeMap{$1}\n",$4);
									    }
									}
									
#assambling ldw instruction
									
									else {
									    if($line =~m/(ldw)\s+(r\d+)\s+(\d+)(\()(r\d+)(\))/) {
										if ($pdebug) {print "$1 $2 $3 $4$5$6\n";}
										printf ("$registerMap{$5}$registerMap{$2}%.16b$opcodeMap{$1}\n",$3);
									    }
									    
#assambling stw instruction
									    
									    else {
										if($line =~m/(stw)\s+(r\d+)\s+(\d+)(\()(r\d+)(\))/) {
										    if ($pdebug) {print "$1 $2 $3$4$5$6\n";}
										    printf ("$registerMap{$2}$registerMap{$5}%.16b$opcodeMap{$1}\n",$3);
										}
# assambling brgt instruction
							
							else {
							    if ($line =~ m/(brgt)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
								if ($pdebug) {print "$1 $2 $3 $4\n";}
								printf ("$registerMap{$2}$registerMap{$3}%.16b$opcodeMap{$1}\n",$4);
							    }
                            
# assambling brlt instruction
							
							else {
							    if ($line =~ m/(brlt)\s+(r\d+)\s+(r\d+)\s+(\d+)/) {
								if ($pdebug) {print "$1 $2 $3 $4\n";}
								printf ("$registerMap{$2}$registerMap{$3}%.16b$opcodeMap{$1}\n",$4);
                            }

 #assambling brp instruction
							    
								else {
								    if($line =~ m/(brp)\s+(r\d+)\s+0x([0-9A-F])([0-9A-F])/) {
									if($pdebug) {print "$1 $2 0x$3$4\n";}
									printf ("$registerMap{$2}00000%.8b%.8b$opcodeMap{$1}\n",$hexaMap{$3}|$3,$hexaMap{$4}|$4);
								}
                                
 #assambling brn instruction
							    
								else {
								    if($line =~ m/(brn)\s+(r\d+)\s+0x([0-9A-F])([0-9A-F])/) {
									if($pdebug) {print "$1 $2 0x$3$4\n";}
									printf ("$registerMap{$2}00000%.8b%.8b$opcodeMap{$1}\n",$hexaMap{$3}|$3,$hexaMap{$4}|$4);
								}
                                
                                }}
                                 }}
                                    
                               
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
}

