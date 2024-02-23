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

/usr/bin/perl $WORK/test/scripts/assign/assign_concat_repl_valid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_concat_repl_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_concat_valid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_concat_valid2.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_concat_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_f2a_concat_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_f2a_concat_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_f2a_conn_valid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_f2a_conn_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_ifc_ifc_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_op_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_pps_op_concat_replic_invalid.pl 
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_pps_pps_invalid.pl 
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_sig_op_concat_replic_invalid.pl 
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_sig_sg_valid.pl 
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_sps_pps_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_minus_sps_p_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_pps_op_concat_replic_invalid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_pps_op_concat_replic_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_pps_pps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_pps_pps_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_pps_sg_ifc_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sig_sg_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sps_op_concat_replic_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sps_p_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sps_pps_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sps_pps_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_select_sps_p_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid2.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid3.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid4.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid5.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_invalid6.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_sig_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_valid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_part_sel_valid2.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_port_ifc_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_port_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_port_sig_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_ps_cc_repl_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_ps_op_cc_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_repl_valid1.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_repl_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_sg_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_sig_sig_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_sps_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_sp_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_verinum_invalid.pl
/usr/bin/perl $WORK/test/scripts/assign/assign_verinum_valid.pl
/usr/bin/perl $WORK/test/scripts/assign/replic_in_assign_invalid.pl


# DO NOT EDIT BELOW
echo Done generating.

