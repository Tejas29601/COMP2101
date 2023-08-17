function diskReport {
    Write-Output "----------- Physical Disk Information -----------"
    $diskdrives = Get-CIMInstance CIM_diskdrive | Where-Object DeviceID -ne $null

    foreach ($disk in $diskdrives) {
        $partitions = $disk | Get-CimAssociatedInstance -resultclassname CIM_diskpartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                new-object -typename psobject -property @{
                    Model          = $disk.Model
                    Manufacturer   = $disk.Manufacturer
                    Location       = $partition.deviceid
                    Drive          = $logicaldisk.deviceid
                    "Size(GB)"     = [string]($logicaldisk.size / 1gb -as [int]) + "gb"
                    FreeSpace      = [string]($logicaldisk.FreeSpace / 1gb -as [int]) + "gb"
                    "FreeSpace(%)" = [string]((($logicaldisk.FreeSpace / $logicaldisk.size) * 100) -as [int]) + "%"
                } | Format-Table -AutoSize
            }
        }
    }
}

function hardwareReport {
    Write-Output "----------- Hardware Description -----------"
    Get-WmiObject win32_computersystem | Format-List Domain, Manufacturer, Model, Name, TotalPhysicalMemory
    
}
function operatingSystemReport {
    Write-Output "----------- OS Information -----------"
    Get-WmiObject win32_operatingsystem | Select-Object Caption, Version | Format-List
   
}


function networkReport {
    Write-Output "----------- Network Adapter Information -----------"
    get-ciminstance win32_networkadapterconfiguration |
    Where-Object { $_.IPEnabled -eq $True } |
    Format-Table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder -AutoSize
    
}

function graphicsReport {
    Write-Output "----------- Video Information -----------"
    $video = Get-WmiObject win32_videocontroller
    $info = New-Object -TypeName psObject -Property @{
        Name             = $video.Name
        Description      = $video.Description
        ScreenResolution = [string]($video.CurrentHorizontalResolution) + 'px x ' + [string] ($video.CurrentVerticalResolution) + "px"
    } |
    Format-List Name, Description, ScreenResolution
    $info
    
}
