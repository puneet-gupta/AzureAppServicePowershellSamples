. .\Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId


$rgName = GetResourceGroupForWebApp $webAppName
$resource = Invoke-AzureRmResourceAction -ResourceGroupName $rgName `
    -ResourceType Microsoft.Web/sites/config `
    -ResourceName $webAppName/connectionstrings `
    -Action list -ApiVersion 2015-08-01 -Force

$connectionStrings = $resource.Properties

$script:NewConnectionStringsTables = @{}

$connectionStrings.psobject.properties | Foreach { 
    $script:NewConnectionStringsTables.Add($_.Name,$_.Value) 
}

#Add ConnectiongString with the name ConnstringKey	 
#Type=2 is SQL Database (Which means SQL Azure)
#Type=1 is a SQL Server.
      
$script:NewConnectionStringsTables.Add("ConnstringKey", @{ value = "The Actual connecting string here" ; Type = 2 })

	    
New-AzureRmResource -PropertyObject $script:NewConnectionStringsTables `
-ResourceGroupName $rgName `
-ResourceType Microsoft.Web/sites/config `
-ResourceName $webAppName/connectionstrings `
-ApiVersion 2015-08-01 -Force
	    
