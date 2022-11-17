$conf_name = Read-Host -Prompt 'Input config name: '

New-Item -Path "c:\" -Name $conf_name'.conf' -ItemType "file"