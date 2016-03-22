. .\Functions.ps1


$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"
$webAppName = "powershelldemowebapp"
$slotName = "staging"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$rgName = GetResourceGroupForWebApp $webAppName 

$PropertiesObject = @{"ThisIsSticky" = "stickyValue";}       

   
#You basically set the AppSetting value on the slot
New-AzureRmResource -PropertyObject $PropertiesObject `
-ResourceGroupName $rgName `
-ResourceType Microsoft.Web/sites/slots/config `
-ResourceName $webAppName/$slotName/appsettings `
-ApiVersion 2015-08-01 -Force

# SET slotConfigNames
$stickSlotConfigObject = @{
"connectionStringNames" = @();
"appSettingNames" =  @("ThisIsSticky");  
}

#The below command sets the "ThisIsSticky" setting as a sticky setting on all the slots
Set-AzureRmResource -PropertyObject $stickSlotConfigObject `
-ResourceGroupName $rgName `
-ResourceType Microsoft.Web/sites/config `
-ResourceName  $webAppName/slotConfigNames `
-ApiVersion 2015-08-01 -Force     
