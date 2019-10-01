function CreateFolder
{
    $dir_name = Read-Host
    if(Test-Path -Path $dir_name)
    { 
        Write-Host "Directory already exised"
    }   
    else    
    {
        New-Item -Path $dir_name -ItemType "directory"
    }
}

function DeleteFolder
{
    $dir_name = Read-Host
    if(-not(Test-Path -Path $dir_name))
    { 
        Write-Host "Directory does not exist."
    }
    else    
    {
        Remove-Item -Path $dir_name
    }
}