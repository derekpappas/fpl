#!/bin/bash
#/bin/tar -pczf "/storage/logs/report_`date`.tar.gz" /storage/users/luntbuild_repo/test/report
#rm /storage/users/luntbuild_repo/test/report/* -Rf
#exit 0


#cp /srv/luntbuild/work/CSLC/trunk/scripts/regress_html_templates/style.css /srv/luntbuild/work/CSLC/test/report/ #copy template - useless for now
#rm -Rf /storage/back-up/logs/CSLS/latest3
#rm -Rf /storage/back-up/logs/CSLS/latest2
#rm -Rf /storage/back-up/logs/CSLS/latest
#
#
#latestName="Hourly"
#
#if [ "$1" == "nightly" ]
#then
#  latestName="Nightly"
#fi
#
#latestBuildName=`ls -t /storage/back-up/logs/CSLC/${latestName}_Regression/ | head -n 1` # search for latest build in appropriate category
#/bin/tar -pczf "/storage/back-up/logs/CSLC/report_${latestBuildName}_`date`$2.tar.gz" /srv/luntbuild/work/CSLC/test/report #archive report
#
#cp /srv/luntbuild/work/CSLC/test/report /storage/back-up/logs/CSLC/latest2 -r 	#copy report in a temp dir
#find /storage/back-up/logs/CSLC/latest2 -type f -exec chmod 644 {} \; && find /storage/back-up/logs/CSLC/latest2 -type d -exec chmod 755 {} \;	#set permissions for web access
#
#latestDir="latestHourly"							#check if we are moving a Nightly build report
#
#if [ "$1" == "nightly" ]
#then
#  latestDir="latestNightly"
#fi
#
##mv /storage/back-up/logs/CSLC/latest2/results* /storage/back-up/logs/CSLC/latest2/results 	#move results one level up
#										
#												###move results fast first to provide
#												###maximum result uptime
#
#mv /storage/back-up/logs/CSLC/$latestDir /storage/back-up/logs/CSLC/latest3			#move current results in a temp dir
#mv /storage/back-up/logs/CSLC/latest2 /storage/back-up/logs/CSLC/$latestDir			#move report temp dir to current dir
#rm /storage/back-up/logs/CSLC/latest3 -Rf							#now remove the old report
#rm /storage/back-up/logs/CSLC/latest2 -Rf							#be safe
#rm /srv/luntbuild/work/CSLC/test/report -Rf							#clean-up build
#find /storage/back-up/logs/CSLC -type f -exec chmod 644 {} \; && find /storage/back-up/logs/CSLC -type d -exec chmod 755 {} \;	#set permissions for web access
#exit 0												#exit with non-error code
# modified by eugennc to fit the architecture of fpl64-14 2008 - Aug


cp /srv/luntbuild/work/CSLC/trunk/scripts/regress_html_templates/style.css /srv/luntbuild/work/CSLC/test/report/        #copy .css template for archival purposes
cp /srv/luntbuild/work/CSLC/trunk/scripts/regress_html_templates/style.css /storage/back-up/logs/trunk/scripts/regress_html_templates/ #copy .css template for html viewing

cp /srv/luntbuild/work/CSLC/test/report /storage/back-up/logs/CSLC/tempdir -r                                           #copy report in a temp dir
find /storage/back-up/logs/CSLC/tempdir -type f -exec chmod 644 {} \; && find /storage/back-up/logs/CSLC/tempdir -type d -exec chmod 755 {} \;	#set permissions for web access

if [ "$1" == "nightly" ]
then
    archiveName="/storage/back-up/logs/CSLC/report__`date`$2.tar.gz"
    /bin/tar -pczf "$archiveName"  "/storage/back-up/logs/CSLC/today" #archive daily reports
    chmod 644 "$archiveName"
    rm -Rf /storage/back-up/logs/CSLC/today/*
fi

mv /storage/back-up/logs/CSLC/tempdir/* /storage/back-up/logs/CSLC/today/

lastRun=`cat /storage/back-up/logs/CSLC/today/last_run`		#latest report name extraction
if [ $? -eq "0" ]						#only if cat succeeded ( in finding file et caetera )
then
  name=`basename "$lastRun"`
  echo "From last: $lastRun has been extracted the name $name"
  rm -f /storage/back-up/logs/CSLC/today/latest
  ln -s -f "/storage/back-up/logs/CSLC/today/$name" "/storage/back-up/logs/CSLC/today/latest" #create link
fi

rm -Rf /storage/back-up/logs/CSLC/tempdir
rm -Rf /srv/luntbuild/work/CSLC/test/report
#find /storage/back-up/logs/CSLC -type f -exec chmod 644 {} \; && find /storage/back-up/logs/CSLC -type d -exec chmod 755 {} \;	#set permissions for web access
exit 0
