
function CreateList ($url, $listName)
{
	$spweb = get-spWeb $url
	$listTemplate = [Microsoft.SharePoint.SPListTemplateType]::GenericList
	$spListCollection = $spWeb.Lists
	
	$spListCollection.Add($listName, "Description", $listTemplate)
}

function AddFields($fieldName, $listName, $type, $url)
{
	$spweb = get-spWeb $url
	$spList = $spWeb.Lists[$listName]
	$spList.Fields.Add($fieldName, [Microsoft.SharePoint.SPFieldType]::$type, $false)
	$spview = $spList.DefaultView
	$spView.ViewFields.Add($fieldName)
	$spView.Update()
}

function AddLookupField($ParentListName, $ChildLookupName, $url, $listname)
{
	$spweb = get-spWeb $url
	$spList = $spWeb.Lists[$listName]
	$ParentList = $spWeb.Lists.item($ParentListName)
	$spList.Fields.AddLookup($ChildLookupName, $ParentList.id, $false)
	$spChildListLookupField = $spList.Fields[$ChildLookupName]
	$spChildListLookupField.LookupField = $ParentList.Fields[$ChildLookupName]
	
}

function AddMutliChoice($listname, $fieldName, $choices)
{
	$spweb = get-spWeb $url
	$spList = $spWeb.Lists[$listName]
	$spList.Fields.Add($fieldName, [Microsoft.SharePoint.SPFieldType]::MultiChoice, $false, $false, $choices)
	$spview = $spList.DefaultView
	$spView.ViewFields.Add($fieldName)
	$spView.Update()
}
