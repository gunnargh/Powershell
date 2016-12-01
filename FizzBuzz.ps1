for($i = 1;$i -lt 100; $i++){
    $a = ""
    $Res = ""
    $b = [int32]::TryParse( $i/3 , [ref]$a )
    if ($b -eq $true) {
        $Res += "Fizz"
    }
    $e = [int32]::TryParse( $i/5 , [ref]$a )
    if ($e -eq $true) {
        $Res += "Buzz"
    }
    if ($e -eq $false -and $b -eq $false) {
        $Res = $i
    }
    Write-Host $res
}