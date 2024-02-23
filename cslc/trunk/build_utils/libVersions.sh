#!/bin/bash
if [ `uname -a|grep x86_64|wc -l` == '1' ];
then
    LIBDIR="/usr/lib64"
else
    LIBDIR="/usr/lib"
fi

# Boost
ls $LIBDIR/libboost*so.*
ls $LIBDIR/libxerces-c*so.*

