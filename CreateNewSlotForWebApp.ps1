. .\Functions.ps1

$webAppName = "powershelldemowebapp"
$slotName = "staging"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$rgName = GetResourceGroupForWebApp $webAppName 
	
New-AzureRmWebAppSlot -ResourceGroupName $rgName -Name $webAppName -Slot $slotName   
