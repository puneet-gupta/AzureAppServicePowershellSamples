# It is important to understand that the Set-AzureRmWebApp cmdlet overwrites the hostnames for the web app. 
# Hence the above PowerShell snippet is appending to the existing list of the host names for the web app. 
# Also for the above command to succeed , the appropriate DNS mappings should be configured else you will
# get an error for missing CNAME or AWVERIFY records.

. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId

$rgName = GetResourceGroupForWebApp $webAppName 
$webApp = Get-AzureRmWebApp -Name $webAppName -ResourceGroupName $rgName
$hostNames = $webApp.HostNames
$HostNames.Add("www.contoso.com")  
Set-AzureRmWebApp -Name $webAppName -ResourceGroupName $rgName -HostNames $HostNames   
