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

/usr/bin/perl $WORK/test/scripts/csl_testbench/tb_verif_comp_valid.pl    
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_exp_invalid.pl  
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_invalid.pl          
/usr/bin/perl $WORK/test/scripts/csl_testbench/testbench_fifo_valid.pl   
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_exp_valid.pl    
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_stim_exp_invalid.pl  
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_stim_invalid.pl
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_stim_exp_valid.pl    
/usr/bin/perl $WORK/test/scripts/csl_testbench/verif_comp_stim_valid.pl
  


# DO NOT EDIT BELOW
echo Done generating.