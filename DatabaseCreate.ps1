Import-Module SQLPS

try {
	Get-SqlDatabase -ServerInstance $env:computername
	$inst = $env:computername
}
catch { 
	Write-Host "There is currently no SQL Instance running on your at this moment"
	Write-Host "Would you like to specify another name of SQL Instance/Server"
	$Inst = Read-Host
}
$error.clear()
try {
	$Srvr = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $inst
	$DBName = "CoreFlow"
	$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($Srvr, $DBName)
	$db.Create()
	invoke-sqlcmd -inputfile ".\DatabaseCreateScript.sql" -serverinstance "$inst" -database $DBName
 }
 catch {
	 Write-Host "Could not Create Database!"
	 $error
 }

	