#!/usr/bin/perl

$platform_details = `uname -a`;
if( @platform_type = $platform_details =~ m/x86_64/g ) 
{
    $platform_type  = "64";
} 
elsif ( @platformType = $platform_details =~ m/i[3|6]86/gi  ) 
{
    $platform_type  = "32";
}

#more to follow

print $platform_type;
