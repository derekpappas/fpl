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
my $r32 = "r32"; 
my $r33 = "r33"; 
my $r34 = "r34"; 
my $r35 = "r35"; 
my $r36 = "r36"; 
my $r37 = "r37"; 
my $r38 = "r38"; 
my $r39 = "r39"; 
my $r40 = "r40"; 
my $r41 = "r41"; 
my $r42 = "r42"; 
my $r43 = "r43"; 
my $r44 = "r44"; 
my $r45 = "r45"; 
my $r46 = "r46"; 
my $r47 = "r47"; 
my $r48 = "r48"; 
my $r49 = "r49"; 
my $r50 = "r50"; 
my $r51 = "r51"; 
my $r52 = "r52"; 
my $r53 = "r53"; 
my $r54 = "r54"; 
my $r55 = "r55"; 
my $r56 = "r56"; 
my $r57 = "r57"; 
my $r58 = "r58"; 
my $r59 = "r59"; 
my $r60 = "r60"; 
my $r61 = "r61";
my $r62 = "r62";  
my $r63 = "r63"; 


#special registers
my $status = "status"; 
#opcodes
my $add   = "add";
my $addc  = "addc";
my $and   = "and";
my $const_plus = "const+";
my $const_minus ="const-";
my $consth ="consth";
my $or    = "or";
my $rotl  ="rotl";
my $S     ="S";
my $xor = "xor";
my $lw = "lw";
my $lhu = "lhu";
my $lhs = "lhs";
my $lbu = "lbu";
my $lbs = "lbs";
my $sw = "sw";
my $sh = "sh";
my $sb = "sb";
my $sll   = "sll"; 
my $sra   = "sra";
my $srl   = "srl";  
my $sub   = "sub"; 
my $subc   = "subc";
my $subr   = "subr"; 
my $subrc   = "subrc"; 
my $B     = "B";
my $calln ="calln";
my $callr ="callr";
my $jmpn  ="jmpn";
my $jmpr  ="jmpr";
my $halt ="halt";
my $nop  ="nop";
my $reti ="reti";
my $trap  ="trap";

#signed compare cc
my $lt  = "lt";
my $ge  = "ge";
my $le  = "le";
my $gt  = "gt";
my $eq  = "eq";
my $ne  = "ne";

#compare to zero cc
my $z   = "z";
my $nz  = "nz";
my $p   = "p";
my $n   = "n";
my $nn  = "nn";

#Arithmetic cc
my $c   = "c";
my $nc  = "nc";
my $v   = "v";
my $nv  = "nv";
my $b   = "b";
my $nb  = "nb";

#define condition code eq
my %condcodeMap=();
$condcodeMap{$lt} = "01001";
$condcodeMap{$ge} = "01010";
$condcodeMap{$le} = "01011";
$condcodeMap{$gt} = "01100";
$condcodeMap{$eq} = "01101";
$condcodeMap{$ne} = "01110";
$condcodeMap{$z}  = "01111";
$condcodeMap{$nz} = "10001";
$condcodeMap{$p}  = "10010";
$condcodeMap{$n}  = "10011";
$condcodeMap{$nn} = "10100";
$condcodeMap{$c}  = "10111";
$condcodeMap{$nc} = "10110";
$condcodeMap{$v}  = "11010";
$condcodeMap{$nv} = "11011";
$condcodeMap{$b}  = "11100";
$condcodeMap{$nb} = "11101";

# define opcode map
my %opcodeMap=();
$opcodeMap{$add} =  "001000";
$opcodeMap{$addc} =  "011001";
$opcodeMap{$and} =  "010001";
$opcodeMap{$const_plus} = "100001";
$opcodeMap{$const_minus} = "100010";
$opcodeMap{$consth} = "100011";
$opcodeMap{$or} = "010010";
$opcodeMap{$rotl} = "010111";
$opcodeMap{$S}   ="011010";
$opcodeMap{$sll} = "010100";
$opcodeMap{$sra} = "010101";
$opcodeMap{$srl} = "010110";
$opcodeMap{$sub} = "011100";
$opcodeMap{$subc} = "011101";
$opcodeMap{$subr} = "011110";
$opcodeMap{$subrc} ="011111";
$opcodeMap{$xor}   = "010011";
$opcodeMap{$lw} = "100110";
$opcodeMap{$lhu} = "101000";
$opcodeMap{$lhs} = "101010";
$opcodeMap{$lbu} = "101100";
$opcodeMap{$lbs} = "101110";
$opcodeMap{$sw} = "110110";
$opcodeMap{$sh} = "111011";
$opcodeMap{$sb} = "111111";
$opcodeMap{$B}     ="001000";
$opcodeMap{$calln} = "001100";
$opcodeMap{$callr} = "001101";
$opcodeMap{$jmpn} = "001110";
$opcodeMap{$jmpr} = "001111";
$opcodeMap{$halt} = "000100";
$opcodeMap{$reti} = "000101";
$opcodeMap{$trap} = "000110";

# define register map

my %registerMap=();
$registerMap{$r0} = "000000";
$registerMap{$r1} = "000001";
$registerMap{$r2} = "000010";
$registerMap{$r3} = "000011";
$registerMap{$r4} = "000100";
$registerMap{$r5} = "000101";
$registerMap{$r6} = "000110";
$registerMap{$r7} = "000111";
$registerMap{$r8} = "001000";
$registerMap{$r9} = "001001";
$registerMap{$r10} = "001010";
$registerMap{$r11} = "001011";
$registerMap{$r12} = "001100";
$registerMap{$r13} = "001101";
$registerMap{$r14} = "001110";
$registerMap{$r15} = "001111";
$registerMap{$r16} = "010000";
$registerMap{$r17} = "010001";
$registerMap{$r18} = "010010";
$registerMap{$r19} = "010011";
$registerMap{$r20} = "010100";
$registerMap{$r21} = "010101";
$registerMap{$r22} = "010110";
$registerMap{$r23} = "010111";
$registerMap{$r24} = "011000";
$registerMap{$r25} = "011001";
$registerMap{$r26} = "011010";
$registerMap{$r27} = "011011";
$registerMap{$r28} = "011100";
$registerMap{$r29} = "011101";
$registerMap{$r30} = "011110";
$registerMap{$r31} = "011111";
$registerMap{$r32} = "100000";
$registerMap{$r33} = "100001";
$registerMap{$r34} = "100010";
$registerMap{$r35} = "100011";
$registerMap{$r36} = "100100";
$registerMap{$r37} = "100101";
$registerMap{$r38} = "100110";
$registerMap{$r39} = "100111";
$registerMap{$r40} = "101000";
$registerMap{$r41} = "101001";
$registerMap{$r42} = "101010";
$registerMap{$r43} = "101011";
$registerMap{$r44} = "101100";
$registerMap{$r45} = "101101";
$registerMap{$r46} = "101110";
$registerMap{$r47} = "101111";
$registerMap{$r48} = "110000";
$registerMap{$r49} = "110001";
$registerMap{$r50} = "110010";
$registerMap{$r51} = "110011";
$registerMap{$r52} = "110100";
$registerMap{$r53} = "110101";
$registerMap{$r54} = "110110";
$registerMap{$r55} = "110111";
$registerMap{$r56} = "111000";
$registerMap{$r57} = "111001";
$registerMap{$r58} = "111010";
$registerMap{$r59} = "111011";
$registerMap{$r60} = "111100";
$registerMap{$r61} = "111101";
$registerMap{$r62} = "111110";
$registerMap{$r63} = "111111";

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

#identifying call and jmp instructions

foreach my $line(@strippedCodeLines) {
    $line =~ s/(call|jmp)\s+(\d+)/$1n $2/;
}

foreach my $line(@strippedCodeLines) {
    $line =~ s/(call|jmp)\s+(r\d+)/$1r $2/;
}

#------------------------------
# Assambling instructions
#------------------------------

# assambling add instruction
foreach my $line (@strippedCodeLines) {
    if ($line =~ m/(add)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
        if ($pdebug) {print "$1 $2 $3 $4\n";}
        printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
    }
    else {
	if($line =~ m/(add)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
	    if ($pdebug) {print "$1 $2 $3 $4\n";}
	    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
	}
    
# assambling addc instruction
	else {
	    if ($line =~ m/(addc)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
		if ($pdebug) {print "$1 $2 $3 $4 $5\n";}
		printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
	    }
	    else {
		if($line =~ m/(addc)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
		    if ($pdebug) {print "$1 $2 $3 $4\n";}
		    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
		}

# assambling and instruction
		else {
		    if ($line =~ m/(and)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
			if ($pdebug) {print "$1 $2 $3 $4\n";}
			printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n"); 
		    }
		    else {
			if($line =~ m/(and)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
			    if ($pdebug) {print "$1 $2 $3 $4\n";}
			    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
			}

# assambling const+ instruction
			else {
			    if ($line =~ m/(const\+)\s+(\d+)\s+(r\d+)/) {           
				if ($pdebug) {print "$1 $2 $3 \n";}
				printf ("$opcodeMap{$1}$registerMap{$3}0%.16b000\n",$2);
			    }
# assambling const- instruction
			    else {
				if ($line =~ m/(const\-)\s+(\d+)\s+(r\d+)/) {
				    if ($pdebug) {print "$1 $2 $3 \n";}
				    printf ("$opcodeMap{$1}$registerMap{$3}0%.16b000\n",$2);
				}

# assambling consth instruction
				else {
				    if ($line =~ m/(consth)\s+(\d+)\s+(r\d+)/) {
					if ($pdebug) {print "$1 $2 $3 \n";}
					printf ("$opcodeMap{$1}$registerMap{$3}0%.16b000\n",$2);
				    }

# assambling xor instruction
				    else {
					if ($line =~ m/(xor)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
					    if ($pdebug) {print "$1 $2 $3 $4\n";}
					    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
					}
					else {
					    if($line =~ m/(xor)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
						if ($pdebug) {print "$1 $2 $3 $4\n";}
						printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
					    }

# assambling rotl instruction
					    else{
						if ($line =~ m/(rotl)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
						    if ($pdebug) {print "$1 $2 $3 $4\n";}
						    printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}00000000$registerMap{$4}\n");
						}
						else {
						    if($line =~ m/(rotl)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
							if ($pdebug) {print "$1 $2 $3 $4\n";}
							printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
						    }
						    
# assambling Sz instruction
						    else {    
							if ($line =~ m/(S)(z)\s+(r\d+)/) {   
							    
							    if ($pdebug) {print "$1$2 $3\n";}
							    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
							}
# assambling Snz instruction
							else {    
							    if ($line =~ m/(S)(nz)\s+(.+)\s+(r\d+)/) {   
								
								if ($pdebug) {print "$1$2 $3\n";}
								printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
							    }
# assambling Sp instruction
							    else {    
								if ($line =~ m/(S)(p)\s+(r\d+)/) {   
								    
								    if ($pdebug) {print "$1$2 $3\n";}
								    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
								}
# assambling Sn instruction
								else {    
								    if ($line =~ m/(S)(n)\s+(r\d+)/) {   
									
									if ($pdebug) {print "$1$2 $3\n";}
									printf ("$opcodeMap{$1}}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
								    }
# assambling Snn instruction
								    else {    
									if ($line =~ m/(S)(nn)\s+(r\d+)/) {   
									    
									    if ($pdebug) {print "$1$2 $3\n";}
									    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
									}
# assambling Sc instruction
									else {    
									    if ($line =~ m/(S)(c)\s+(r\d+)/) {   
										
										if ($pdebug) {print "$1$2 $3\n";}
										printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
									    }
# assambling Snc instruction
									    else {    
										if ($line =~ m/(S)(nc)\s+(r\d+)/) {   
										    
										    if ($pdebug) {print "$1$2 $3\n";}
										    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
										}
# assambling Sv instruction
										else {    
										    if ($line =~ m/(S)(v)\s+(r\d+)/) {   
											
											if ($pdebug) {print "$1$2 $3\n";}
											printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
										    }
# assambling Snv instruction
										    else {    
											if ($line =~ m/(S)(nv)\s+(r\d+)/) {   
											    
											    if ($pdebug) {print "$1$2 $3\n";}
											    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
											}
# assambling Sb instruction
											else {    
											    if ($line =~ m/(S)(b)\s+(r\d+)/) {   
												
												if ($pdebug) {print "$1$2 $3\n";}
												printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
											    }
# assambling Snb instruction
											    else {    
												if ($line =~ m/(S)(nb)\s+(r\d+)/) {   
												    
												    if ($pdebug) {print "$1$2 $3\n";}
												    printf ("$opcodeMap{$1}$registerMap{$3}1$condcodeMap{$2}00000000000000\n");
												}
# assambling sll instruction
												else{
												    
												    if ($line =~ m/(sll)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
													
													if ($pdebug) {print "$1 $2 $3 $4\n";}
													printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
												    }
												    else {
													if($line =~ m/(sll)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
													    if ($pdebug) {print "$1 $2 $3 $4\n";}
													    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
													}
# assambling sra instruction
													else{
													    
													    if ($line =~ m/(sra)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
														
														if ($pdebug) {print "$1 $2 $3 $4\n";}
														printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
													    }
													    else {
														if($line =~ m/(sra)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
														    if ($pdebug) {print "$1 $2 $3 $4\n";}
														    printf ("$opcodeMap{$1}$registerMap{$2}$registerMap{$3}1%.13b\n",$2);
														}
# assambling srl instruction
														else{
														    
														    if ($line =~ m/(srl)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
															
															if ($pdebug) {print "$1 $2 $3 $4\n";}
															printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
														    }
														    else {
															if($line =~ m/(srl)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
															    if ($pdebug) {print "$1 $2 $3 $4\n";}
															    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
															}
# assambling sub  instruction                                                                                          
															else{
															    
															    if ($line =~ m/(sub)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
																
																if ($pdebug) {print "$1 $2 $3 $4\n";}
																printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
															    }
															    else {
																if($line =~ m/(sub)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
																    if ($pdebug) {print "$1 $2 $3 $4\n";}
																    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
																}
# assambling subc  instruction
																else{
																    
																    if ($line =~ m/(subc)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
																	
																	if ($pdebug) {print "$1 $2 $3 $4\n";}
																	printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
																    }
																    else {
																	if($line =~ m/(subc)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
																	    if ($pdebug) {print "$1 $2 $3 $4\n";}
																	    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
																	}
# assambling subr instruction
																	else{
																	    
																	    if ($line =~ m/(subr)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
																		
																		if ($pdebug) {print "$1 $2 $3 $4\n";}
																		printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
																	    }
																	    else {
																		if($line =~ m/(subr)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
																		    if ($pdebug) {print "$1 $2 $3 $4\n";}
																		    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
																		}
# assambling subrc instruction
																		else{
																		    
																		    if ($line =~ m/(subrc)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
																			
																			if ($pdebug) {print "$1 $2 $3 $4\n";}
																			printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}$registerMap{$2}\n");
																		    }
																		    else {
																			if($line =~ m/(subrc)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
																			    if ($pdebug) {print "$1 $2 $3 $4\n";}
																			    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
																			}
# assambling or instruction
																			else{
																			    
																			    if ($line =~ m/(or)\s+(r\d+)\s+(r\d+)\s+(r\d+)/) {
																				
																				if ($pdebug) {print "$1 $2 $3 $4\n";}
																				printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}00000000$registerMap{$2}\n");
																			    }
																			    else {
																				if($line =~ m/(or)\s+(\d+)\s+(r\d+)\s+(r\d+)/) {
																				    if ($pdebug) {print "$1 $2 $3 $4\n";}
																				    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$3}1%.13b\n",$2);
																				}
# assambling lw instruction
																				else{
																				    
																				    if ($line =~ m/(lw)\s+\*(r\d+)\((\d+)\)\s+(r\d+)/) {
																					
																					if ($pdebug) {print "$1 *$2($3) $4\n";}
																					printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$2}1%.13b\n",$3);
																				    }
# assambling lhu instruction
																				    else{
																					
																					if ($line =~ m/(lhu)\s+\*(r\d+)\((\d+)\)\s+(r\d+)/) {
																					    
																					    if ($pdebug) {print "$1 *$2($3) $4\n";}
																					    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$2}1%.13b\n",$3);
																					}						
																					
# assambling lhs instruction
																					else{
																					    
																					    if ($line =~ m/(lhs)\s+\*(r\d+)\((\d+)\)\s+(r\d+)/) {
																						
																						if ($pdebug) {print "$1 *$2($3) $4\n";}
																						printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$2}1%.13b\n",$3);
																					    }
# assambling lbu instruction
																					    else{
																						
																						if ($line =~ m/(lbu)\s+\*(r\d+)\((\d+)\)\s+(r\d+)/) {
																						    
																						    if ($pdebug) {print "$1 *$2($3) $4\n";}
																						    printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$2}1%.13b\n",$3);
																						}
# assambling lbs instruction
																						else{
																						    
																						    if ($line =~ m/(lw)\s+\*(r\d+)\((\d+)\)\s+(r\d+)/) {
																							
																							if ($pdebug) {print "$1 *$2($3) $4\n";}
																							printf ("$opcodeMap{$1}$registerMap{$4}$registerMap{$2}1%.13b\n",$3);
																						    }
# assambling sw instruction
																						    else{
																							
																							if ($line =~ m/(sw)\s+(r\d+)\s+\*(r\d+)\((\d+)\)/) {
																							    
																							    if ($pdebug) {print "$1 $2 *$3($4)\n";}
																							    printf ("$opcodeMap{$1}$registerMap{$3}$registerMap{$2}1%.13b\n",$4);
																							}
																							
# assambling sh instruction
																							else{
																							    
																							    if ($line =~ m/(sh)\s+(r\d+)\s+\*(r\d+)\((\d+)\)/) {
																								
																								if ($pdebug) {print "$1 $2 *$3($4)\n";}
																								printf ("$opcodeMap{$1}$registerMap{$3}$registerMap{$2}1%.13b\n",$4);
																							    }
# assambling sb instruction
																							    else{
																								
																								if ($line =~ m/(sb)\s+(r\d+)\s+\*(r\d+)\((\d+)\)/) {
																								    
																								    if ($pdebug) {print "$1 $2 *$3($4)\n";}
																								    printf ("$opcodeMap{$1}$registerMap{$3}$registerMap{$2}1%.13b\n",$4);
																								}
																								
# assambling Bz instruction
																								else {    
																								    if ($line =~ m/(B)(z)\s+(\d+)/) {   
																									
																									if ($pdebug) {print "$1$2 $3\n";}
																									printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																								    }
# assambling Bnz instruction
																								    else {    
																									if ($line =~ m/(B)(nz)\s+(\d+)/) {   
																									    
																									    if ($pdebug) {print "$1$2 $3\n";}
																									    printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																									}
# assambling Bp instruction
																									else {    
																									    if ($line =~ m/(B)(p)\s+(\d+)/) {   
																										
																										if ($pdebug) {print "$1$2 $3\n";}
																										printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																									    }
# assambling Bn instruction
																									    else {    
																										if ($line =~ m/(B)(n)\s+(\d+)/) {   
																										    
																										    if ($pdebug) {print "$1$2 $3\n";}
																										    printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																										}
# assambling Bnn instruction
																										else {    
																										    if ($line =~ m/(B)(nn)\s+(\d+)/) {   
																											
																											if ($pdebug) {print "$1$2 $3\n";}
																											printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																										    }
# assambling Bc instruction
																										    else {    
																											if ($line =~ m/(B)(c)\s+(\d+)/) {   
																											    
																											    if ($pdebug) {print "$1$2 $3\n";}
																											    printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																											}
# assambling Bnc instruction
																											else {    
																											    if ($line =~ m/(B)(nc)\s+(\d+)/) {   
																												
																												if ($pdebug) {print "$1$2 $3\n";}
																												printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																											    }
# assambling Bv instruction
																											    else {    
																												if ($line =~ m/(B)(v)\s+(\d+)/) {   
																												    
																												    if ($pdebug) {print "$1$2 $3\n";}
																												    printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																												}
# assambling Bnv instruction
																												else {    
																												    if ($line =~ m/(B)(nv)\s+(\d+)/) {   
																													
																													if ($pdebug) {print "$1$2 $3\n";}
																													printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																												    }
# assambling Bb instruction
																												    else {    
																													if ($line =~ m/(B)(b)\s+(\d+)/) {   
																													    
																													    if ($pdebug) {print "$1$2 $3\n";}
																													    printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																													}
# assambling Bnb instruction
																													else {    
																													    if ($line =~ m/(B)(nb)\s+(\d+)/) {   
																														
																														if ($pdebug) {print "$1$2 $3\n";}
																														printf ("$opcodeMap{$1}0000001$condcodeMap{$2}%.14b\n",$3);
																													    }
# assambling call m instruction
																													    else {    
																														if ($line =~ m/(calln)\s+(\d+)/) {   
																														    
																														    if ($pdebug) {print "call $2\n";}
																														    printf ("$opcodeMap{$1}0000000%.19b\n",$2);
																														}
# assambling call ry instruction
																														else {    
																														    if ($line =~ m/(callr)\s+(r\d+)/) {   
																															
																															if ($pdebug) {print "call $2\n";}
																															printf ("$opcodeMap{$1}$registerMap{$2}00000000000000000000\n"); 
																														    }
																														    
# assambling jmp m instruction
																														    else {    
																															if ($line =~ m/(jmpn)\s+(\d+)/) {   
																															    
																															    if ($pdebug) {print "jmp $2\n";}
																															    printf ("$opcodeMap{$1}0000001%.19b\n",$2); 
																															}
																															
# assambling jmp ry instruction
																															else {    
																															    if ($line =~ m/(jmpr)\s+(r\d+)/) {   
																																
																																if ($pdebug) {print "jmp $2\n";}
																																printf ("$opcodeMap{$1}$registerMap{$2}10000000000000000000\n"); 
																															    }
# assambling reti instruction
																															    else {    
																																if ($line =~ m/(reti)/) {   
																																    
																																    if ($pdebug) {print "$1\n";}
																																    printf ("$opcodeMap{$1}00000000000000000000000000\n"); 
																																}
# assambling trap instruction
																																else {    
																																    if ($line =~ m/(trap)/) {   
																																	
																																	if ($pdebug) {print "$1\n";}
																																	printf ("$opcodeMap{$1}00000000000000000000000000\n"); 
																																    }
																																    
																																    
#assambling halt instruction
																																    else {
																																	if($line =~ m/(halt)/) {
																																	    
																																	    if ($pdebug) {print "$1\n";}
																																	    printf ("$opcodeMap{$1}00000000000000000000000000\n");
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
			}
		    }
		}
	    }
	}
    }
}
