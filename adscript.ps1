import-module activedirectory
$ErrorOccured = $false
$rootOU = "Business Units"
$domain = "DC=domain,DC=local"
$domains = $domain.Split(",")
$domains = $domains.replace("DC=","")
$domains = "@" + $domains[0] + "." + $domains[1]
$adusers = get-aduser -filter * | select samaccountname, name

try {
	$getou = Get-ADOrganizationalUnit ("OU=" + $rootOU + "," + $domain)
	write-host $rootOU "already exists!"
	$choice = ""
	while ($choice -notmatch "[y|n]"){
		$choice = read-host "OU " $getou.name "Already exists. Do you want to continue? (Y/N)"
	}
	if ($choice -ne "y"){
		exit
	}
} catch {
	New-ADOrganizationalUnit -Name $rootOU -path $domain -ProtectedFromAccidentalDeletion $false
}
$UserList = import-csv ".\users.csv" -Delimiter ";"
$oulist = $UserList.department | select -unique
foreach ($ou in $oulist){
	try {
		$choice = ""
		$path =  ("OU=$ou,OU=$rootou,$domain")
		$getou = Get-ADOrganizationalUnit $path
		while ($choice -notmatch "[y|n]"){
			$choice = read-host "OU " $getou.name "Already exists. Do you want to continue? (Y/N)"
		}
		if ($choice -ne "y"){
			exit
		}
	} catch {
		New-ADOrganizationalUnit -Name $ou -path "OU=$rootOU,$domain" -ProtectedFromAccidentalDeletion $false
		Write-Host "Creating OU: " $ou
		$groupname = $ou + " All Users"
		New-ADGroup –name $groupname –groupscope Global –path $path
		Write-Host "Creating AD Group: " $groupname
	}
}

foreach ($user in $UserList){
	try {
		$userpath = ("OU=" + $user.Department + ",OU=$rootOU,$domain")
		write-host "Createing AD User: " $user.Name
		new-aduser  `
			-Name $user.Name `
			-displayname $user.Name `
			-Path $userpath `
			-UserPrincipalName ($user.uid + $domains) `
			-SamAccountName $user.uid `
			-Givenname $user.FirstName `
			-surname $user.LastName `
			-ChangePasswordAtLogon $false `
			-AccountPassword  (convertto-securestring "Password" -asplaintext -force) `
			-EmailAddress ($user.uid + "@domain.local") `
			-enabled $true 

		$group = ($user.Department + " All Users")
		Add-ADGroupMember $group $user.uid
		} catch {
			$ADuser = Get-ADUser -Identity $user.uid
			write-host "Skipping User:" $user.uid "Because he already exist!"
	}
}
		
	