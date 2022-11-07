[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = "Computer's description"
$desc   = "Enter user's full name (ex. John Doe):"

$text = [Microsoft.VisualBasic.Interaction]::InputBox($desc, $title)
 
#$desc = Read-Host "Enter computer's description (full name of user) "
Set-ADComputer -Identity $env:computername -Description $text