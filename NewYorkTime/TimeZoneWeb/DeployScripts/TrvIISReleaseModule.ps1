#Examples from:
#http://www.iis.net/learn/manage/powershell/powershell-snap-in-creating-web-sites-web-applications-virtual-directories-and-application-pools

#Import IIS Module, Requires Admin Rights
Import-Module "WebAdministration"

#Remove a site under \Sites\
function Delete-TrvSite($SiteName)
{
	$SiteNameFull = "IIS:\Sites\$SiteName" 
	if(Test-Path $SiteNameFull)
	{
		Remove-Item $SiteNameFull -recurse
		Write-Verbose "Removed $SiteNameFull" -Verbose
	}
	else
	{
		Write-Verbose "Cannot remove site $SiteNameFull, it does not exist" -Verbose
	}
}

# Creates a site under \Sites\
function Create-TrvSite($SiteName, $SitePath, $AppPoolName)
{
	$SiteNameFull = "\Sites\$SiteName"
	New-Item IIS:$SiteNameFull -physicalPath $SitePath -bindings @{protocol="http";bindingInformation=":8080:"} -force
	Set-ItemProperty IIS:$SiteNameFull -name applicationPool -value $AppPoolName 
}

#Creates an Application under the site.
function Create-TrvApplication($SiteName, $ApplicationName, $ApplicationPath, $AppPoolName)
{
	$SiteNameFull = "\Sites\$SiteName"
	$ApplicationNameFull = "$SiteNameFull\$ApplicationName"
	
	Write-Verbose "Create Application $ApplicationNameFull with path $ApplicationPath" -Verbose
	New-Item IIS:$ApplicationNameFull -physicalPath $ApplicationPath -type Application
	Write-Verbose "Create Application Pool $AppPoolName for application $ApplicationNameFull" -Verbose
	Set-ItemProperty IIS:$ApplicationNameFull -name applicationPool -value $AppPoolName 
}

#Creates a virtual directory under site 
#ApplicationName is optional
function Create-TrvVirtualDirectory($SiteName, $ApplicationName, $VirtualDirectoryName, $VirtualDirectoryPath, $AppPoolName)
{
	$VirtualDirectoryNameFull = "\Sites\$SiteName"
	if ($ApplicationName)
	{ 
		$VirtualDirectoryNameFull = "$VirtualDirectoryNameFull\$ApplicationName"
	}
	
	$VirtualDirectoryNameFull = "$VirtualDirectoryNameFull\$VirtualDirectoryName" 
	Write-Verbose "Creating $VirtualDirectoryNameFull with path $VirtualDirectoryPath" -Verbose
	New-Item IIS:$VirtualDirectoryNameFull -physicalPath $VirtualDirectoryPath -type VirtualDirectory -force
	
}
# Create Application Pool
function Create-TrvApplicationPool($AppPoolName)
{
    #check if the app pool exists
    if (!(Test-Path "IIS:\AppPools\$AppPoolName" -pathType container))
    {
        #create the app pool
        New-Item "IIS:\AppPools\$AppPoolName"
        #$appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value "v4.0"
        Write-Verbose "Created Apppool '$AppPoolName'" -Verbose
    }
    else
    {
        Write-Verbose "Cannot create Appool '$AppPoolName' it already exists" -Verbose
    }
}
# Recycle Application Pool if it exists
function Restart-TrvApplicationPool($AppPoolName)
{
	if(Test-Path IIS:\AppPools\$AppPoolName)
	{
		Write-Verbose "Restart $AppPoolName" -Verbose
		Restart-WebAppPool $AppPoolName
	}
    else
    {
        Write-Verbose "Did not find $AppPoolName" -Verbose
    }
}

# Safely copy folder (no errors when folder not found)
function Copy-TrvFolder($source, $target)
{
    if (Test-Path $source)
    {
		Write-Verbose "Copying files in $source to $target" -Verbose
        Copy-Item $source $target -recurse -force
       
    }
    else
    {
        Write-Verbose "Failed to move files, $source not found!" -Verbose
    }
}