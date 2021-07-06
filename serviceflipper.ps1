#######################################################
# Spooler service flipper script
# Author: Florido Paganelli florido.paganelli@gmail.com 
# Date: 20210706
# Web: https://github.com/floridop/serviceflipper
# Use at your own risk!
######################################################

param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

'running with full privileges'


# Check server status

$statusvar = Get-Service -Name Spooler
$statuscode = $statusvar.Status

if ( $statuscode -ne 'Running' ){
   Write-Host "Turning Spooler on"
   Set-Service -Name Spooler -StartupType Manual
   Start-Service -Name Spooler
} else {
   Write-Host "Turning Spooler off"
   Set-Service -Name Spooler -StartupType Disabled
   Stop-Service -Name Spooler -Force
}

$statusvar = Get-Service -Name Spooler
$statuscode = $statusvar.Status

Write-Host "Spool Service is $statuscode"

Write-Host "Press any key to close this window"
cmd /c pause
