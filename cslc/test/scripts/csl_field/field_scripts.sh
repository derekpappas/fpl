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

/usr/bin/perl $WORK/test/scripts/csl_field/field2gen.pl 
/usr/bin/perl $WORK/test/scripts/csl_field/field3gen.pl  
/usr/bin/perl $WORK/test/scripts/csl_field/field4gen.pl  
/usr/bin/perl $WORK/test/scripts/csl_field/field_part_sel_invalid1.pl  
/usr/bin/perl $WORK/test/scripts/csl_field/field_part_sel_invalid.pl

# DO NOT EDIT BELOW
echo Done generating.