# Simple script to show some basic info about a system. For future developement, some things still need to be polished and improved.
# To do - ogarnąć logi.

function Show-Menu
{
    cls
    Write-Host "================ Menu ================" -ForegroundColor Green
    Write-Host "= 1: Press '1' to see PC info.       =" -ForegroundColor Green
    Write-Host "= 2: Press '2' to see disk usage.    =" -ForegroundColor Green
    Write-Host "= Q: Press 'Q'.                      =" -ForegroundColor Green
    Write-Host "======================================" -ForegroundColor Green
}

function PC-Info
{
    cls
    $cpu_info = (Get-WmiObject Win32_Processor | Select-Object -ExpandProperty Name) # cpu
    $memory_info = (Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb # Ram
    $drive_capacity = (Get-WmiObject Win32_DiskDrive | Measure-Object -Property size -Sum).sum /1gb # Drive 
    
    Write-Host "CPU:" $cpu_info
    Write-Host "RAM Capacity:" $memory_info
    Write-Host "Drive Capacity:" $drive_capacity    
}

function Disk-Usage
{
    cls
    Write-Host "Drive: " -NoNewLine
    $dl = Read-Host
    Get-PSDrive $dl
}

do
{
    Show-Menu
    Write-Host "Wybierz: " -ForegroundColor Green -NoNewLine
    $input = Read-Host
    switch($input)
    {
        '1'{
            cls
            PC-Info
        }'2'{
            cls
            Disk-Usage
        }'Q'{
            return
        }
    }
    pause
}
until($input -eq 'q')