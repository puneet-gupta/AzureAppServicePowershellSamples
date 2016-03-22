. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId
     
$rgName = GetResourceGroupForWebApp $webAppName
$resource = Invoke-AzureRmResourceAction -ResourceGroupName $ResourceGroupName -ResourceType Microsoft.Web/sites/config -ResourceName $webAppName/appsettings -Action list -ApiVersion 2015-08-01 -Force
$appSettings = $resource.Properties

$script:NewAppSettingHashTable = @{}
$appSettings.psobject.properties | Foreach { 
    $script:NewAppSettingHashTable.Add($_.Name,$_.Value) 
}

#Add APPSETTING with the name MyAppSettingName=MyAppSettingValue
      
$script:NewAppSettingHashTable.Add("MyNewAppSettingName", "MyNewAppSettingValue")

New-AzureRmResource -PropertyObject $script:NewAppSettingHashTable -ResourceGroupName $ResourceGroupName -ResourceType Microsoft.Web/sites/config -ResourceName $webAppName/appsettings -ApiVersion 2015-08-01 -Force


