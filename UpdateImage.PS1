#Injects Windows patches into the WIM file ready for VHD Builds
Param (
    [Parameter(Mandatory=$true)]$SccmPSDrive,
    [Parameter(Mandatory=$true)]$OSImageFilter
)

import-module 'C:\Program Files (x86)\Configuration Manager Console\bin\ConfigurationManager.psd1'

Set-Location $SccmPSDrive

$OSImages = Get-CMOperatingSystemImage | ? {$_.Name -Match $OSImageFilter}
$Updates = Get-CMSoftwareUpdate -Fast

Foreach ($OSImage in $OSImages) {
    
    Write-Host "Running Updates for Image " -ForegroundColor Yellow -NoNewline
    Write-Host $OSImage.Name -ForegroundColor Cyan

    $OSImage | New-CMOperatingSystemImageUpdateSchedule `
        -RunNow -SoftwareUpdate $Updates `
        -ContinueOnError $True -UpdateDistributionPoint $True
}
