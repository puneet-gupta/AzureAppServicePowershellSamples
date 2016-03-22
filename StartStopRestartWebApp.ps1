. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount 
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$rgName = GetResourceGroupForWebApp $webAppName 

# Action Stop
"Stopping WebApp [$webAppName]" 
Invoke-AzureRmResourceAction –ResourceGroupName $rgName -ResourceType Microsoft.Web/sites -ResourceName $webAppName -Action stop -ApiVersion 2015-08-01 -Force

# Action stop
"Starting WebApp [$webAppName]"
Invoke-AzureRmResourceAction -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites -ResourceName $webAppName -Action start -ApiVersion 2015-08-01 -Force

# Action Restart
"Re-Starting WebApp [$webAppName]"
Invoke-AzureRmResourceAction -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites -ResourceName $webAppName -Action restart -ApiVersion 2015-08-01 -Force
