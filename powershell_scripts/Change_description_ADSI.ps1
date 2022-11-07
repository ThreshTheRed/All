$UserName = $env:COMUTERNAME 
$filter = "(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))"
$DN = ([adsisearcher]$filter).FindOne().Properties.distinguishedname
$ObjClient = [ADSI]"LDAP://$DN"

[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = "Computer's description"
$desc   = "Enter user's full name (ex. John Doe):"

$text = [Microsoft.VisualBasic.Interaction]::InputBox($desc, $title) 

$ObjClient.Description = $text
$ObjClient.SetInfo()
Exit
