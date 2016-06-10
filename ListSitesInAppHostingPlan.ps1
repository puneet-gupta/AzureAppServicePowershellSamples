$serverFarmName = "ServicePlan"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"
$rgName = "yourresourcegroupname"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId

$listOfSites = Get-AzureRmResource -ResourceGroupName $rgName `
            -ResourceType Microsoft.Web/serverfarms/sites `
            -ResourceName $serverFarmName `
            -ApiVersion 2015-08-01

foreach ($site in $listOfSites)
{

    "Site Name:" + $site.Name
}
