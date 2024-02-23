#!/usr/bin/perl

$platform_details = `uname -a`;
if( @platform_type = $platform_details =~ m/x86_64/g ) 
{
    $libdir  = "/usr/lib64";
} 
elsif ( @platformType = $platform_details =~ m/i[3|6]86/g  ) 
{
    $libdir  = "/usr/lib";
}

#more to follow

print $libdir;
