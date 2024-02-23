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

/usr/bin/perl $WORK/test/scripts/enum/enum_ei_eq_ei.pl  
/usr/bin/perl $WORK/test/scripts/enum/enum_no_char_float_invalid_gen.pl  
/usr/bin/perl $WORK/test/scripts/enum/enum_no_neg_values_valid_gen.pl  
/usr/bin/perl $WORK/test/scripts/enum/enum_verilog_invalid_gen.pl  
/usr/bin/perl $WORK/test/scripts/enum/enum_verilog_valid_gen.pl


# DO NOT EDIT BELOW
echo Done generating.