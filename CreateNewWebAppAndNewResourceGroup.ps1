$webAppName = "powershelldemowebapp"
$ResourceGroupName = "PowerShellResourceGroup"          
$Location = "East Asia"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRMAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location
New-AzureRmWebApp -Name $webAppName  -ResourceGroupName $ResourceGroupName  -Location $Location 
