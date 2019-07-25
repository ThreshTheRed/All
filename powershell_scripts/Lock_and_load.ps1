# Script will list all the dirs and subdirs (and it's content). It delete everything but folders, when no extension given - deletes everything.

# Define variables

$global:_DirName = "*"
$global:_Extension = ""

Get-ChildItem "$_DirName" -Recurse 

if 
	($_Extension -eq "")

# To try
#	([string]::IsNullOrEmpty($extension)) 

	{
		remove-Item "$_DirName" -recurse 
	}

else

	{
		Get-ChildItem "$_DirName" -Recurse -Include "*.$_Extension" | remove-Item -recurse 
	}

Read-Host -Prompt: "Press Enter to exit"