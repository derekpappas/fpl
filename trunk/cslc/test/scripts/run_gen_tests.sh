#!/bin/bash
exec 2>/dev/null
#/usr/bin/perl ./run_gen_tests.pl > /dev/null 2> /dev/null
#/usr/bin/perl ./run_gen_tests1.pl > /dev/null 2> /dev/null
/usr/bin/perl ./run_all_gen_tests.pl > /dev/null 2> /dev/null
echo "REGRESSION DONE"
echo ""
