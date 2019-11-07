1. Execute CertificateGenerate.ps1 as administrator.
2. Enter the name of the cert
3. Enter expiration time - for example, if it's typed "3" and command is exectued 20.08.2019, then expiration date of cert will be set to 20.08.2022.
4. Enter the password you want to use for this cert.

Additional notes:
- Declared name of certificate it's only a file.
- Cert is generated in the same directory where script is executed
- "-NotAfter" parameter is supported only in powershell 5.0 version and above, and it allows to set an expiration date for certificate. Without it default expire date is set to 1 year
- If cert is generated on a workstation then it's necessary to install it on a server.