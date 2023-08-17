# COMMAND LINE PARAMETERS
param (
    [switch]$system,
    [switch]$disks,
    [switch]$network
)
# RUNNING WITHOUT ANY PARAMETER
if ( !($system) -and !($network) -and !($disks)) {
    Write-Output "======================"
    Write-Output "COMPLETE SYSTEM REPORT"
    Write-Output "======================"
    hardwareReport
    
    operatingSystemReport
    
    graphicsReport
    diskReport
    networkReport
}
# -system PARAMETER
if ($system) {
    Write-Output "======================"
    Write-Output "    SYSTEM REPORT"
    Write-Output "======================"
    hardwareReport
    
    operatingSystemReport
    
    graphicsReport
}
# -network PARAMETER
if ($network) {
    Write-Output "======================"
    Write-Output "    NETWORK REPORT"
    Write-Output "======================"
    networkReport
}
# -disks PARAMETER
if ($disks) {
    Write-Output "======================"
    Write-Output "     DISKS REPORT"
    Write-Output "======================"
    diskReport
}
