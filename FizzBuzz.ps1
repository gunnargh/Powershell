for($i = 1;$i -lt 100; $i++){
    $a = ""
    $b = [int32]::TryParse( $i/3 , [ref]$a )
    if ($b -eq $true) {
        Write-Host "Fizz"
    }
    $e = [int32]::TryParse( $i/5 , [ref]$a )
    if ($e -eq $true) {
        Write-Host "Buzz"
    }
    if ($e -eq $false -and $b -eq $false) {
        Write-Host $i
    }
}