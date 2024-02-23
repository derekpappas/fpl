#!/bin/bash
./run_regress.pl -hdl csl -val
x="$?"
#./run_regress.pl -hdl csl -no_exec -results_dir `cat /storage/users/luntbuild_repo/test/report/last_ran`
./run_regress.pl -hdl csl_new_bug -val
#./run_regress.pl -hdl csl_new_bug -no_exec -results_dir `cat /storage/users/luntbuild_repo/test/report/last_ran`
./run_regress.pl -hdl csl_v2 -no_post_compile
cd ../../test/scripts
./ar_connect.pl
./ar_ifc_connect.pl
cd ../../trunk/scripts
./run_regress.pl -hdl csl_ar_gen -no_post_compile
./run_regress.pl -hdl csl_cc_gen -no_post_compile
./run_regress.pl -hdl verilog -no_post_compile
exit $x
