#
# iisRM.ps1
#
# This is the file that your PSScriptPath field in your RM Template points to.

# Default Parameters from RM ready to be used.
#$ServerName           # Name of the server in RM
#$UserName             # Username of the account that runs this file
#$Password             # Password of the account that runs this file
#$ComponentName        # Name of the component in RM
#$PSSScript            # The relative path to this file
#$PSConfigurationPath  # The relateive path to the configuration file (Powershell DSC)
#$UseCredSSP           # Will help avoid various privilege related issues
#$UseHTTPS             # Force HTTPS
#$SkipCaCheck          # Client validates that the server certificate is signed by a trusted certificate authority 

# I'm setting this values for demo purpose, will be set from RM client in a real environment 
# Remove or comment all the demo parameters if you want to run this file in RM
$SiteName = "DemoSite"
$SitePath = "C:\DemoSite"
$AppPoolName = "DemoAppPool"
$ApplicationName = "DemoApp"
$ApplicationPath = "C:\DemoSite\DemoApp"
$VirtualDirectoryName1 = "DemoVirtualDir1"
$VirtualDirectoryName2 = "DemoVirtualDir2"  
$VirtualDirecotryPath1 = "C:\DemoSite\DemoVirtualDir1"
$VirtualDirecotryPath2 = "C:\DemoSite\DemoVirtualDir2"

# Run the example file with parameters from RM
$folder = Split-Path -Parent $MyInvocation.MyCommand.Definition
& $folder\TrvIISReleaseExample.ps1 -SiteName $SiteName -SitePath $SitePath -AppPoolName $AppPoolName -ApplicationName $ApplicationName -ApplicationPath $ApplicationPath -VirtualDirectoryName1 $VirtualDirectoryName1 -VirtualDirectoryName2 $VirtualDirectoryName2 -VirtualDirecotryPath1 $VirtualDirecotryPath1 -VirtualDirecotryPath2 $VirtualDirecotryPath2
