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

/usr/bin/perl $WORK/test/scripts/assign/assign_scripts.sh
/usr/bin/perl $WORK/test/scripts/connect_by_name/conn_name_scripts.sh
/usr/bin/perl $WORK/test/scripts/connect_by_pattern/conn_pattern_scripts.sh
/usr/bin/perl $WORK/test/scripts/connect_units/conn_units_scripts.sh
/usr/bin/perl $WORK/test/scripts/csl_field/field_scripts.sh
/usr/bin/perl $WORK/test/scripts/csl_language/language_scripts.sh
/usr/bin/perl $WORK/test/scripts/csl_parameter/parameter_scripts.sh
/usr/bin/perl $WORK/test/scripts/csl_testbench/testbench_scripts.sh
/usr/bin/perl $WORK/test/scripts/enum/enum_scripts.sh
/usr/bin/perl $WORK/test/scripts/f2a/f2a_scripts.sh


# DO NOT EDIT BELOW
echo Done generating.

