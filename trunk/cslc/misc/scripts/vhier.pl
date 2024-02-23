#!/usr/bin/perl -w -I/opt/tools/perl_pm
###############################################################################
#
# vhier
#
#  Description:
#    Print out the hierarchy of the listed verilog files
#  
#  Format:
#    vhier [<verilog_file>]* 
#          [-f <verilog_list>]*
#          [-inc <include_file>]*
#          [-incdir <inc_dir>]*
#          [-libdir <lib_dir>]*
#          [-libext <lib_ext>]*
#          [-l <log_file>]*
#          [-v|-version] 
#          [-q|-Q]
#          [-h|-help] 
#
#  Where:
#    verilog.list contains list of verilog files
#    to be parsed.
#
#  This software is a creation of:
#      Muted Trumpet Technologies, Inc
#
#      Written by: Vince Parrilla 
#            Date: Sep  5, 2001
#        Last Rev: Sep  6, 2001
#
#    Please report any bugs to the following email address.
#
#   Copyright (c)2001 Vincent J. Parrilla <parrilla@ix.netcom.com>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!                    DISCLAIMER                              !!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!  This software is non-proprietary, free and without warranty.    !!
# !!  It may be distributed without charge or restriction for         !!
# !!  private use only provided that credit remains with the original !!
# !!  author.   Commercial redistribution for profit is prohibited    !!
# !!  and must obtain author's consent.                               !!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
########################################################################
require rvp;
use strict;
use vars qw($debug @files @inc_dirs @lib_dirs $lib_ext $v_db $m );
use Cwd;

my ($QUIET)=0;
my (@INCFILE,@FILELIST,@VLOGFILES,@PLUSARG);
my (@INCDIRS,@LIBDIRS,@LIBEXTS,@INCLUDES);
my (%PLUSARG);
my ($RESULTSLOG)="vhier.log";
my $PERLVERS=$];
my $VERSION=1.1;
my $REVDATE="Sept 7, 2001";
chomp(my $INFODATE=`date`);     # Get current date and time
#####################################################################
if($#ARGV<0){&Unknown("");exit 0}
# Get command line options
GET_COMMAND: while ($_=shift @ARGV) {
   #####################################################################
   # Get command line variables
   SWITCH: {
         if (/\A-f\Z/)       {push @INCFILE,shift @ARGV;last SWITCH} # Files to include
      elsif (/\A-(?:v|version)\Z/)      {&PrintRev;exit;last SWITCH} # Print revision number only
      elsif (/\A-inc\Z/)   {push(@INCLUDES,shift @ARGV);last SWITCH} # Collect include directories
      elsif (/\A-incdir\Z/) {push(@INCDIRS,shift @ARGV);last SWITCH} # Collect include directories
      elsif (/\A-libdir\Z/) {push(@LIBDIRS,shift @ARGV);last SWITCH} # Collect library directories
      elsif (/\A-libext\Z/) {push(@LIBEXTS,shift @ARGV);last SWITCH} # Include library extensions
      elsif (/\A-l\Z/)         {$RESULTSLOG=shift @ARGV;last SWITCH} # Log results
      elsif (/\A-q\Z/)                      {$QUIET="1";last SWITCH} # Quiet mode
      elsif (/\A-Q\Z/)                      {$QUIET="2";last SWITCH} # Really Quiet mode
      elsif (/\A-(?:h|help)\Z/)    {&PrintBanner;exit 0;last SWITCH} # Help menu
      elsif (/\A-.*?\Z/)          {&Unknown($&); exit 0;last SWITCH} # Unknown option
      elsif (/\A\+(.*?)(?:=(.*?))?\Z/) {$PLUSARG{$1}=$2;last SWITCH} # Plusargs 
      else                         {push(@VLOGFILES,$_);last SWITCH} # Verilog file
   } #####################################################################
}
######################################################################
# Openning banner
&OpeningBanner($QUIET);
######################################################################
@FILELIST=GetFileList(\@INCFILE,\%PLUSARG);
push(@FILELIST,$_) foreach @VLOGFILES;

@FILELIST = map {rel2abs($_)} @FILELIST;
@INCLUDES = map {rel2abs($_)} @INCLUDES;
@INCDIRS  = map {rel2abs($_)} @INCDIRS;
@LIBDIRS  = map {rel2abs($_)} @LIBDIRS;
#####################################################################
# Document about parsing the verilog
#  read_verilog(\@FILELIST,[],{},1,[],[],"");
#  Args: - reference to array of files to read (can have paths)
#        - reference to array of files to include in B<all> read files.
#        - reference to hash of defines with names as keys
#        - quite flag. 1=be quiet, 0=be chatty.
#        - reference to array of include directories
#        - reference to array of library directories
#        - library extension string (eg '.v') or reference to array of strings
#        - expand defines flag. 1=expand defines before parsing, 0=do not expand (faster)
#
#  Returns: 
#        - a pointer to the internal data structure.
#
#  Example:
#    $defines{'TRUE'}=1;  # same as +define+TRUE=1 on verilog cmd line
#    $verilog_db = &rvp::read_verilog(\@files,\@includes,\%defines,1,
#                                     \@inc_dirs,\@lib_dirs,\@lib_exts,0);
#####################################################################
# Parse the verilog
$v_db = &rvp::read_verilog( \@FILELIST, #  Reference to array of verilog files 
                            \@INCLUDES, #  Reference to array of include files
                            \%PLUSARG,  #  Reference to hash of defines 
                            $QUIET,     #  Quite flag. 1=quiet, 0=verbose
                            \@INCDIRS,  #  Reference to array of include directories
                            \@LIBDIRS,  #  Reference to array of library directories
                            \@LIBEXTS,  #  Library extension string (eg '.v') 
                            ""          #  Expand defines flag. 1=expand,0=not expand 
                           );

open(RL,">$RESULTSLOG") or die "ERROR!  Unable to open results log:$RESULTSLOG. $!\n";
# Find modules at the top of the hierarchy (have no instantiators)
#  and call hierPrint on them.
foreach $m (&rvp::get_modules($v_db)) {
    if  (! &rvp::get_first_instantiator($v_db,$m)) {
       printline("-") unless($QUIET>1);
       hierPrint($v_db,0,$m);
    }
}
printline("-") unless($QUIET>1);
close(RL);

exit 0;
#####################################################################
# Subroutines
sub hierPrint {
    my ($v_db,$indent,$m) = @_;
    my ($imod,$mf,$iname,$l,@subMods);

    print "" . (" " x $indent) . "$m\n";
    print RL "" . (" " x $indent) . "$m\n";

    # get a list of sub modules
    for (($imod,$mf,$iname,$l) = &rvp::get_first_instantiation($v_db,$m ); 
          $imod;
         ($imod,$mf,$iname,$l) = &rvp::get_next_instantiation($v_db)) {
         push(@subMods,$imod);
    }
    
    # recurse down hierarchy
    foreach $imod (@subMods){
        hierPrint($v_db,$indent+4,$imod);
    }
}

#####################################################################
sub PrintRev {PrintVersion($INFODATE);}

# Print current Version number
sub PrintVersion{
   my($info)=@_;

   printline("-");
   print <<EOF;
         vhier - A verilog hierarchy extracting tool
                  Version: $VERSION
                 Last rev: $REVDATE
               Written by: Vince Parrilla
                    Email: parrilla\@ix.netcom.com
             Current time: $info
             perl version: $PERLVERS
EOF
   printline("-");
}
#####################################################################
sub OpeningBanner{
   my($q)=shift;
   unless($q>1){
      printline("="); 
      print " vhier - A verilog hierarchical extractor\n";
      printline("="); 
   }
}
#####################################################################
sub Unknown {    # Print line of characters
   my $opt = shift;

  print "Unknown option \"$opt\"!\n" if($opt);
 
   print <<EOF

  Format:
    vhier [<verilog_file>]* 
          [-f <verilog_list>]*
          [-inc <include_file>]*
          [-incdir <inc_dir>]*
          [-libdir <lib_dir>]*
          [-libext <lib_ext>]*
          [-l <log_file>]*
          [-v|-version] 
          [-q|-Q]
          [-h|-help] 
 

  NOTE: Command line is order independent.
 
  For addition info, try \"vhier -h\".
EOF
}
#####################################################################
# Print line of characters
sub printline {
   my $l=shift;
   print "$l" x 70 . "\n";
}        

#####################################################################
# Convert relative path to absolute
sub rel2abs{
  my ($r)=shift;
  my $cwd=cwd();
  ($r=~/^\//)? return $r: return GetShortFilename("$cwd/$r");
}
#####################################################################
# Tighten file name to shortest possible
sub GetShortFilename{
  my ($path)=@_;
  my @a;
  foreach (split('/',$path)) {
    next if /^[.]{1}$/;
    (/^[.][.]$/)?pop @a:
                 push @a,$_;
  }
  return join '/',@a;
}
#####################################################################
sub GetFileList{  # Get unique and sorted file list
   my ($r_incfile,$r_plusarg)=@_;
   my (%filelist,%plusarg);
   %plusarg=%{$r_plusarg};
   foreach (@{$r_incfile}){
      $_=rel2abs($_);
      open (FH,"<$_") or die "Unable to open file:$_. $!\n";
      print "Reading file list: $_\n" unless($QUIET>1);
      my ($y,$q)=(0,0);
      my ($k)=1;
      while (<FH>) {
         ########################################################
         # First, some cleanup
          chomp;
          s/^\s+//;               # Remove leading white space
          next if (/^$/);         # Skip blank
          next if (/^(#|\/{2})/); # Ignore line comments  (# and //)
          s/(#|\/{2}).*$//g;      # Ignore comments after text
         ########################################################
         # Simple ifdef/elseif/else/endif parser. No nesting allowed.
          if (/^[`]ifdef\s+\(?\s*([.a-zA-Z0-9_-]+)\s*\)?\s*$/) { # Check if defined
             die "\nError! Nested `ifdef at line $. is not permitted.\n\n" if($q); 
             $y+=$k=exists $plusarg{$1}; $q=1; next;
          } 
      
          if (/^[`]elseif\s+\(?\s*([.a-zA-Z0-9_-]+)\s*\)?\s*$/){
             if($y) {$k=0; next;}                        # Off, was previously defined 
              else  {$y+=$k=defined $plusarg{$1}; next;} # Check,  was previously not defined 
          } 
      
          if (/^[`]else\s*$/) {
             if($y)  {$k=0; next;}  # Off, was previously defined 
              else   {$k=1; next;}  # On,  was previously not defined 
          } 
      
          if (/^[`]endif/) {   # Reset
             $y=0;$k=1;$q=0;next;
          } 
          next if (!$k);       # Skip if not needed
          $filelist{$_}=1;
         ########################################################
      }
      close (FH);
   }
   return sort keys %filelist;
}
#####################################################################
sub PrintBanner{
print <<EOF;
  vhier                                        Last Rev: Sept 7, 2001
 
  Description:
    Simple verilog module extractor.   Formats module hierarchy 
    of the listed verilog files and prints to standard out an 
    indented form of the results.
  
  Format:
    vhier [<verilog_file>]* 
          [-f <verilog_list>]*
          [-inc <include_file>]*
          [-incdir <inc_dir>]*
          [-libdir <lib_dir>]*
          [-libext <lib_ext>]*
          [-l <log_file>]*
          [-v|-version] 
          [-q|-Q]
          [-h|-help] 
 
    Notations:
        <> Filetype 
        [] Optional entry
        *  Indicates zero or more entries.
 
 
    Where:
    vhier is the command itself.  Displays this help menu if invoked
          without any arguments.
 
      -f  List of verilog files to be parsed and ordered for hierarchical
          evaluation.   One verilog file per line.   

          Unlike a manifest list for say vcs, the <verilog_list> can 
          contain comments (must begin with a "#" or "//") and, Verilog 
          style `ifdef,`elseif,`else,`endif runtime pragmas.

          I.e 
                #######################
                # Comments can go here
                <vfile1>     # Here 
                <vfile2>     // Or here

                `ifdef DEF1
                   <vfile3>
                `elseif (DEF2)
                   <vfile4>
                `else
                   <vfile5>
                `endif

          Where the "DEFs" are defined via the runtime define option 
          +<plusarg>.  ()s around DEFs are optional.  Any number of 
          `ifdef constructs may be used, however, only single level 
          is allowed at a time - that is, no nesting.

  -inc    Include file.  File, to be inlcuded in all verilog files.

  -incdir Include directories.  Directories which will be searched
          when the `include <file> pragma is called within a verilog
          file.

  -libdir Library directories.  Directories which will be searched
          when there is an unresolved reference to a module.

  -libext Include library extensions.   File extension to to searched
          when there is an unresolved reference to a module.
          (I.e. v,h, etc).
         
    -l    Log Results.   Logs results to <log_file> in the directory
          where invoked. 
 
    -q    Quiet mode.  Turns off banner printing.
 
    -Q    Super quiet mode.  Turns off banner printing as in "-q", plus
          supresses deliniation and information not pertinent to the 
          hierarchical structure.
 
  -v | -version  Returns version number.
 
  -h | -help     This help menu.
 
 
  Examples:
    vhier <vfile1.v> <vfile2.v> <vfile3.v>  ...
    vhier -f verilog.list
    vhier -f verilog.list -incdir ../testbench/  -l vhier_2.log
 
  =================================================== 
          Written by: Vince Parrilla
                Date: Sept 6, 2001
          Muted Trumpet Technologies, Inc
          parrilla\@ix.netcom.com
  =================================================== 
 
EOF
}
#####################################################################
