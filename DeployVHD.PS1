Param (
    [Parameter(Mandatory=$true)]$SccmPSDrive,
    [Parameter(Mandatory=$true)]$VHDOutputLocation,
    [Parameter(Mandatory=$true)]$TaskSequenceId,
    [Parameter(Mandatory=$true)]$sccmServer,
    [Parameter(Mandatory=$true)]$TaskName,
    $TaskDescription = $TaskName
)

import-module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'

Set-Location $SccmPSDrive

#TODO: Check to see if the image(s) is in the updating state and wait before deploy

New-CMVhd -path $VHDOutputLocation `
    -Name $TaskName `
    -VHDsize 50 -TaskSequencePackageId $TaskSequenceId `
    -DistributionPointServerNames $sccmServer `
    -Version "X64" -Description $TaskDescription `

