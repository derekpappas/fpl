#!/bin/bash
exec 2>/dev/null
nice -n 5 ./run_regress.pl $* > /dev/null 2> /dev/null
echo "REGRESSION DONE"
echo ""
