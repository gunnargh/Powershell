function EnterTheMatrix() {
$console = $host.UI.RawUI
$Console.BackgroundColor = "black"
$Console.ForegroundColor = "green"
clear-host
$a = @()
for ($i = 0;$i -lt 150)
{
$a += Get-Random(1,0)
write-host $a
$i++
}
}

function SaveHistory($filename) {
$History = history
$name = "C:\temp\" + $filename + ".txt"
$history | out-file $name
}

function SaveLastCommand() {
$id = history | measure  | select Count
$history = history($id.count)
$historyname =  "C:\temp\GoodCommands.csv"
$history | Export-Csv $historyname
}

function Get-GoodCommands()
{
	$imp = Import-Csv "C:\temp\GoodCommands.csv"
	$imp
}

