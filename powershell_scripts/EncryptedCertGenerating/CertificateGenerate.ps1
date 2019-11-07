if ($PSVersionTable.PSVersion.Major -ge 5) {
    $Certname = Read-Host "Enter Certname"
	$CertSubject = Read-Host "Enter Subject Name"
    [int]$YearsToExpire = Read-Host "Enter expiration (from today certificate will expire after years you declare)"

    Write-Host "Creating Certifcate $Certname" -ForegroundColor Green
    
	#Create certificate
    $Cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -NotAfter (Get-Date).AddYears($YearsToExpire) -KeyLength 4096 -KeyAlgorithm RSA  -FriendlyName "LiveBankEncryptedStore" -KeyUsage DigitalSignature,NonRepudiation,KeyEncipherment -Subject $CertSubject -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider"

    Write-Host "Exporting Certificate $Certname to $pwd" -ForegroundColor Green
    $pw = Read-Host "Enter the new password" -AsSecureString 
    $thumbprint = $Cert.Thumbprint

    # Export certificate
    Export-PfxCertificate -cert cert:\localMachine\my\$thumbprint -FilePath .\$Certname.pfx -Password $pw
    Write-Host "Script is generated and added to certificate store" -ForegroundColor Green

}
else {
    Write-Host "This version is not supported by script. You need at least Powershell 5.0" -ForegroundColor Green
}