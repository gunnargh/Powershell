Add-Type -Assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -ComObject Outlook.Application
$Namespace = $Outlook.GetNameSpace("MAPI")
$Email = $NameSpace.Folders.Item(1).Folders.Item("Inbox").Items
$Object = @()
foreach ($mail in $email) {
$Data = New-Object PSObject -Property @{
		Mail = ""
		Type = ""
	} 
$Data.Mail = $mail
	if ($mail.to -ne "Gunnar Geir Helgason") {
		$Data.Type = "Dist" 
	} else {
		$Data.Type = "Me"
	}
$object += $data
}

$senders = $object.mail.sender.name | select -unique
foreach($sender in $senders) {
	$Folder.add($sender)
}
foreach ($obj in $object.mail) {
	$obj.move($NameSpace.Folders.Item(1).Folders.Item($obj.SenderName))
}


<#$h = $Namespace.Folders.Item(1).folders
$dist = $NameSpace.Folders.Item(1).Folders.Item("Distrubution Groups")
foreach ($mail in $email) { 
	if ($mail.to -ne  "ggh@flowit.dk")
	{
		$Folder.add($mail.Sender.Name)
		$mail.move($dist)
	}
}
$NameSpace.Folders.Item(1).Folders.Item($mail.Sender.Name).moveto($dist)
$Folder = $Namespace.Folders.Item(1).folders
foreach ($mail in $email) { 
	$Folder.add($mail.Sender.Name)
	$mail.move($NameSpace.Folders.Item(1).Folders.Item($mail.sender.name))
}#>