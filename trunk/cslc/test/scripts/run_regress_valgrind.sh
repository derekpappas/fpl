#!/bin/bash
exec 2>/dev/null
./run_regress_valgrind.pl $* 2>/dev/null
