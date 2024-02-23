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

/usr/bin/perl $WORK/test/scripts/csl_language/br_invalid_gen.pl                 
/usr/bin/perl $WORK/test/scripts/csl_language/inter_gen_uniq_rtl_invalid1.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_gen_uniq_rtl_invalid2.pl
/usr/bin/perl $WORK/test/scripts/csl_language/br_part_sel_invalid.pl            
/usr/bin/perl $WORK/test/scripts/csl_language/inter_gen_uniq_rtl_invalid3.pl
/usr/bin/perl $WORK/test/scripts/csl_language/concat_expr_invalid.pl            
/usr/bin/perl $WORK/test/scripts/csl_language/inter_gen_uniq_rtl_invalid4.pl
/usr/bin/perl $WORK/test/scripts/csl_language/ifc_prefix_suffix_valid.pl        
/usr/bin/perl $WORK/test/scripts/csl_language/inter_gen_uniq_rtl_valid.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_invalid1.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_part_sel_invalid.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_invalid2.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_reg_ios_invalid1.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_invalid3.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_reg_ios_invalid2.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_invalid4.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_reg_ios_invalid3.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_invalid5.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_reg_ios_valid.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_cpp_valid.pl     
/usr/bin/perl $WORK/test/scripts/csl_language/inter_set_clock_invalid1.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_invalid1.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_set_clock_invalid2.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_invalid2.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_set_clock_invalid3.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_invalid3.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_set_clock_invalid4.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_invalid4.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/inter_set_clock_valid.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_invalid5.pl  
/usr/bin/perl $WORK/test/scripts/csl_language/invalid_prefix_suffix.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_valid1.pl    
/usr/bin/perl $WORK/test/scripts/csl_language/sgr_prefix_suffix.pl
/usr/bin/perl $WORK/test/scripts/csl_language/inter_do_not_gen_rtl_valid2.pl   

# DO NOT EDIT BELOW
echo Done generating.