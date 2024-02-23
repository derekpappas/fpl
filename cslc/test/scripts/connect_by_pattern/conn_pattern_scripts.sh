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

/usr/bin/perl $WORK/test/scripts/connect_by_pattern/ar_conn_pattern_p_s_ifcp_sgs_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_ifc_sg_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_pps_sps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_pps_sps_minus_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_replication_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_replication_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_replication_pps_sps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_concat_units_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_ifcp_sgsig_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_ifc_sg_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_minus_p_ps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_minus_pps_s_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_minus_pps_sps_ifc_sg_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_minus_p_ps_s_ps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_ifc_sg_ifc_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_ifc_sg_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_ps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_pps_s_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_pps_sps_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_pps_sps_ifc_sg_valid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_ps_s_ps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_ps_s_ps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_p_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_s_ifcp_sgsig_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_param_p_s_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_ps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_pps_s_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_pps_sps_ifc_sg_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_pps_sps_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_ps_s_ps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_p_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_s_ifcp_sgsig_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_s_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_s_ifc_sg_u_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_p_s_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_concat_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_ifc_sg_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_minus_pps_sps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_pps_sps_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_replication_units_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_sigps_sgsig_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_sps_sps_invalid.pl


# DO NOT EDIT BELOW
echo Done generating.