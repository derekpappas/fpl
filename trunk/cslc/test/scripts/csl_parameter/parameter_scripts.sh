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

/usr/bin/perl $WORK/test/scripts/csl_parameter/ifc_sgr_parameter_valid.pl   
/usr/bin/perl $WORK/test/scripts/csl_parameter/mem_parameter_valid.pl            
/usr/bin/perl $WORK/test/scripts/csl_parameter/reg_parameter_valid.pl     
/usr/bin/perl $WORK/test/scripts/csl_parameter/unit_parameter_valid.pl
/usr/bin/perl $WORK/test/scripts/csl_parameter/reg_file_fifo_parameter_valid.pl  
/usr/bin/perl $WORK/test/scripts/csl_parameter/mem_parameter_invalid.pl     
/usr/bin/perl $WORK/test/scripts/csl_parameter/reg_parameter_invalid.pl          
/usr/bin/perl $WORK/test/scripts/csl_parameter/unit_parameter_invalid.pl
    

# DO NOT EDIT BELOW
echo Done generating.