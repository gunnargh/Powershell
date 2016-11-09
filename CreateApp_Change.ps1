

Get-MsolServicePrincipal  | foreach-object{
    $principalId = $_.AppPrincipalId
    $principalName = $_.DisplayName

    Get-MsolServicePrincipalCredential -AppPrincipalId $principalId -ReturnKeyValues $true | Where-Object { ($_.Type -ne "Other") -and ($_.Type -ne "Asymmetric") } |  foreach-object{
        $date = $_.EndDate.ToShortDateString()
        write-output "$($principalName);$($principalId);$($_.KeyId);$($_.type);$($date);$($_.Usage);$($_.Value)"
    }
} > c:\temp\appsec.txt





$clientId = '2251d07c-b4e2-42f4-b8b0-57746835b884'
$bytes = New-Object Byte[] 32
$rand = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$rand.GetBytes($bytes)
$newClientSecret = [System.Convert]::ToBase64String($bytes)
New-MsolServicePrincipalCredential -AppPrincipalId $clientId -Type Password -Usage Verify -Value $newClientSecret
New-MsolServicePrincipalCredential -AppPrincipalId $clientId -Type Symmetric -Usage Sign -Value $newClientSecret
New-MsolServicePrincipalCredential -AppPrincipalId $clientId -Type Symmetric -Usage Verify -Value $newClientSecret
$newClientSecret

$bytes = New-Object Byte[] 32
$rand = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$rand.GetBytes($bytes)
$reply = "https://www.helloworld1234.com/" 
$newClientSecret = [System.Convert]::ToBase64String($bytes)
$id = [System.Guid]::NewGuid()
$val = @($id, ($id +"/domain.local"))
$hi = New-Object Microsoft.Online.Administration.RedirectUri
$hi.Address = "https://localhost/"
$hi.AddressType = "Reply"
New-MsolServicePrincipal -DisplayName "Test_Gunnar" -AppPrincipalId $id -Value $newClientSecret -ServicePrincipalNames $val -Addresses $hi

