#
# Example script to deploy changes to a webbserver running IIS.
# This file can be run stand alone. But if you want it to work with RM vNext you need run "TrvIISReleaseInstaller.ps1" from RM.
# The account running this script requires admin on the machine.
# 
# Custom Parameters
Param ($SiteName, $SitePath, $AppPoolName, $ApplicationName, $ApplicationPath, $VirtualDirectoryName1, $VirtualDirectoryName2, $VirtualDirecotryPath1, $VirtualDirecotryPath2)

#Include File
$folder = Split-Path -parent $MyInvocation.MyCommand.Definition
. (Join-Path $folder /TrvIISReleaseModule.ps1)

# Script Root Parent
$ScriptRootParent = (Get-Item $folder).parent.FullName

# Begin PreRelease
Write-Verbose "Starting PreRelease" -Verbose

#Recycle The AppPool
Restart-TrvApplicationPool $AppPoolName

#Remove Binding
Get-WebBinding -Name $SiteName | Remove-WebBinding
#Delete the site site so we can recreate it later.
Delete-TrvSite $SiteName

## Begin Release
Write-Verbose "Starting Release" -Verbose

##Copy all files
#CopyFolder (Join-Path $ScriptRootParent /*) $SourceFolder

#Create Application Pool
Create-TrvApplicationPool $AppPoolName

#Create the site
Create-TrvSite $SiteName $SitePath $AppPoolName
#Create an application under the Site.
Create-TrvApplication $SiteName $ApplicationName $ApplicationPath $AppPoolName
# Create a virtual directory under the Site
Create-TrvVirtualDirectory $SiteName '' $VirtualDirectoryName1 $VirtualDirecotryPath1 $AppPoolName
# Create a virtual directory under the Application
Create-TrvVirtualDirectory $SiteName $ApplicationName $VirtualDirectoryName1 $VirtualDirecotryPath1 $AppPoolName
#Add Binding
New-WebBinding $SiteName


#Release Done
Write-Verbose "Release Done" -Verbose


