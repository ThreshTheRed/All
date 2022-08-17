$hostname=$args[0]
Get-ADComputer -Filter 'Name -eq $hostname' | Remove-ADComputer -Confirm:$False