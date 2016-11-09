#######################################
#Generates "Fake Data" into Sharepoint#
#######################################
$SPServer = "http://"
$SPApplist="/Lists/DummyData/"
#You have to create the list before with valid Fields
$spweb = get-spWeb $SPServer
$spData = $spweb.GetList($SPApplist)


$tblData = Import-CSV "C:\temp\datadump.csv" -Delimiter ";"

foreach ($row in $tblData) { 
   $spAdd = $spData.AddItem()
   write-host $row.Name
   $spadd["Name"] = $row.Name
   $spadd["Username"] = $row.Username
   $spadd["idNumber"] = $row.idNumber
   $spadd["PhoneNumber"] = $row.PhoneNumber
   $spadd.update()	
   #$row.blalba is the field in Excel and the $sp[""] is the field in Sharepoint.
}
$spWeb.Dispose()	