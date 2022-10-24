﻿Get-Mailbox -ResultSize Unlimited | Select-Object DisplayName,PrimarySmtpAddress | Sort-Object DisplayName | Export-CSV "C:\temp\ListSMTPAddresses.csv" -NoTypeInformation -Encoding UTF8