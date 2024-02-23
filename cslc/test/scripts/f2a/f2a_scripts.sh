#!/bin/bash

#
# Just add here the perl CSL generators in the following format:
# /usr/bin/perl $WORK/test/scripts/PERL_SCRIPT.pl
# and replace PERL_SCRIPT.pl with the actual script name
#

# Do NOT modify the following 4 lines pl1x pl0x
#/srv/luntbuild/work/CSLC/trunk/build/linux/x86_64/csl_gen/cGenCmds_tb
#/srv/luntbuild/work/CSLC/trunk/build/linux/x86_64/csl_gen/cGenDecl_tb
#/srv/luntbuild/work/CSLC/trunk/build/linux/x86_64/csl_gen/cGenInstCmds_tb
#/srv/luntbuild/work/CSLC/trunk/build/linux/x86_64/csl_gen/cGenInstDecl_tb

# Add testgens here

/usr/bin/perl $WORK/test/scripts/f2a/f2a_ifc_ifc_p_valid.pl    
/usr/bin/perl $WORK/test/scripts/f2a/f2a_ifc_p_sg_s_valid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_invalid1.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_invalid2.pl  
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_invalid1.pl 
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_invalid2.pl 
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_valid1.pl 
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_valid2.pl 
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_valid3.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_part_sel_valid4.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_port_port_valid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_sg_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_sg_sg_s_ifc_p_valid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_signal_signal_invalid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_verinum_invalid.pl
/usr/bin/perl $WORK/test/scripts/f2a/f2a_verinum_valid.pl



# DO NOT EDIT BELOW
echo Done generating.