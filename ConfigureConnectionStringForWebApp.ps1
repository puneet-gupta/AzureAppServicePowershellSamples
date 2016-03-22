. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId

$rgName = GetResourceGroupForWebApp $webAppName 
	 
#Type=2 is SQL Database (Which means SQL Azure)
#Type=1 is a SQL Server.
$PropertiesObject = @{ ConnstringKey = @{ value = "The Actual connecting string here" ; Type = 2 };}
	    
New-AzureRmResource -PropertyObject $PropertiesObject `
-ResourceGroupName $rgName `
-ResourceType Microsoft.Web/sites/config `
-ResourceName $webAppName/connectionstrings `
-ApiVersion 2015-08-01 -Force
	    
