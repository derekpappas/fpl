#!/usr/bin/perl

$version_details = `gcc --version`;
@version = $version_details  =~ /[3-9].[0-9].[0-9]{0,1}/g;
if( @version[0] =~ m/[3-9].[4-9].[0-9]{0,1}/g or @version[0] =~ m/[4-9].[0-9].[0-9]{0,1}/g ) # at least GCC 3.4.x or GCC 4.x
{
    $isValid = 1;
} 
else 
{
    $isValid = 0;
}
print "$isValid";

