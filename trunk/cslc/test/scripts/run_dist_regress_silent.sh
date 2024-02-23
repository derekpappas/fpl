#!/bin/bash
export WORK=/storage/users/dist_regress/repo1/cslc
#exec 2>/dev/null
nice -n 5 perl ./ssh_dist_regress.pl $* #> /dev/null 2> /dev/null
echo "REGRESSION DONE"
echo ""
