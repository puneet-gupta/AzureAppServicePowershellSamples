. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRMAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId

$rgName = GetResourceGroupForWebApp $webAppName 

$webApp = Get-AzureRmResource -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites -ResourceName $webAppName  -ApiVersion 2015-08-01
$serverFarmId = $webApp.Properties.ServerFarmId

$SkuHashTable = @{Capacity=1 ; Family = "S" ; Size = "S2" ; Name="S2" ;Tier = "Standard"}

$serverFarm = Get-AzureRmResource -ResourceId $serverFarmId

Set-AzureRmResource -Sku $SkuHashTable -ResourceGroupName $serverFarm.ResourceGroupName -ResourceType Microsoft.Web/serverfarms -ResourceName $serverFarm.Name -ApiVersion 2015-08-01 -Force
