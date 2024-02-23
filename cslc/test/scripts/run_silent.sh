#!/bin/bash
exec 2>/dev/null
$* 2> /dev/null
echo "REGRESSION DONE"
echo ""
