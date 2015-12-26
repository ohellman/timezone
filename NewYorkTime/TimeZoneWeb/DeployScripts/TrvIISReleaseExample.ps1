#
# Example script to deploy changes to a webbserver running IIS.
# This file can be run stand alone. But if you want it to work with RM vNext you need run "TrvIISReleaseInstaller.ps1" from RM.
# The account running this script requires admin on the machine.
# 
# Custom Parameters
Param ($SiteName, $SitePath, $AppPoolName, $PortNr)

#Include File
$folder = Split-Path -parent $MyInvocation.MyCommand.Definition
. (Join-Path $folder /TrvIISReleaseModule.ps1)

# Script Root Parent
$ScriptRootParent = (Get-Item $folder).parent.FullName

$RoslynPath = Join-Path (Get-Item $ScriptRootParent).parent.parent.FullName /Roslyn
# Begin PreRelease
Write-Verbose "Starting UnInstall" -Verbose

# Stop Site
Stop-TrvSite $SiteName

#Delete The AppPool
Delete-TrvApplicationPool $AppPoolName

#Delete the site site so we can recreate it later.
Delete-TrvSite $SiteName

#Delete files
Delete-TrvContent $SitePath 

## Begin Release
Write-Verbose "Starting Release" -Verbose

##Copy all files
Copy-TrvFolder (Join-Path $ScriptRootParent /*) $SitePath

##Copy Roslyn
Copy-TrvFolder (Join-Path $RoslynPath /*) (Join-Path $SitePath /bin/roslyn)


#Create Application Pool
Create-TrvApplicationPool $AppPoolName

#Create the site
Create-TrvSite $SiteName $SitePath $AppPoolName $PortNr

#Release Done
Write-Verbose "Release Done" -Verbose


