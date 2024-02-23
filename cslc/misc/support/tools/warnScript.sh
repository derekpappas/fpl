#!/bin/bash
echo "====>Starting to update svn repo... please wait!"
svn up $WORK/
echo "<====Finished updating svn repo"
rm $WORK/trunk/src/csl_xml_warn_error/CSLC_Errors.h
echo "Removed .h"
rm $WORK/trunk/src/csl_xml_warn_error/CSLC_Errors.cpp
echo "Removed .cpp"
echo "====>Starting to run warnerr binary over csl_warn_error.xml file... please wait!"
cd $WORK/trunk/src/csl_xml_warn_error/
./warnerr csl_warn_error.xml CSLC_Errors.h
echo "<====Finished running warnerr binary over csl_warn_error.xml file"
echo "====>Starting compiling CSLC_Errors.* ... please wait!"
gcc -c $WORK/trunk/src/csl_xml_warn_error/CSLC_Errors.cpp -o $WORK/trunk/src/csl_xml_warn_error/CSLC_Errors.o
echo "<===Finished compiling CSLC_Errors.*"
echo "====>Starting builing error library... please wait!"
ar -cq $WORK/trunk/src/csl_xml_warn_error/libCSLC_Errors.a $WORK/trunk/src/csl_xml_warn_error/CSLC_Errors.o
echo "<====Finished builing library"
echo "====>Starting svn revert... please wait!"
svn revert $WORK/trunk/build/linux/x86_64/csl_xml_warn_error/libCSLC_Errors.a
echo "<====Reverted error library to prevent conflicts"
echo "====>Started copying error library to build inode(directory/folder)"
cp $WORK/trunk/src/csl_xml_warn_error/libCSLC_Errors.a $WORK/trunk/build/linux/x86_64/csl_xml_warn_error/libCSLC_Errors.a
echo "<====Finished copying error library to build inode(directory/folder)"
echo "!!!done!!!"
