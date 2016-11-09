$SPServer = "http://"
$spweb = get-spWeb $SPServer 
$listTemplate = [Microsoft.SharePoint.SPListTemplateType]::GenericList 
$spListCollection = $spWeb.Lists 
$spListCollection.Add("My Generic List","Description",$listTemplate)
$spFieldType = [Microsoft.SharePoint.SPFieldType]::Text 
$spList = $spWeb.Lists["My Generic List"]
$spList.Fields.Add("TextField",$spFieldType,$false)