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

/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_ifc_sg_u_mem_fifo_reg_rf_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_mem_fifo_reg_rf_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_mem_fifo_reg_rf_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_p_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_ps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_pps_s_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_ps_s_ps_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_pps_sps_u_mem_fifo_reg_rf_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_s_ifc_sg_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_s_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_p_s_u_mem_fifo_reg_rf_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_s_s_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_s_sps_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_u_mem_fifo_reg_rf_invalid1.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_u_mem_fifo_reg_rf_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_u_u_invalid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_u_u_param_valid.pl
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_u_u_valid.pl



# DO NOT EDIT BELOW
echo Done generating.