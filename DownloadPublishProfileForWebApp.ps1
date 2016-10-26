
$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId


$rgName = GetResourceGroupForWebApp $webAppName


$publishProfileString = Invoke-AzureRmResourceAction -ResourceGroupName $rgName `
     -ResourceType Microsoft.Web/sites `
     -ResourceName $webAppName `
     -Action publishxml `
     -ApiVersion 2015-08-01 -Force

$publishProfileString | Out-File -FilePath c:\temp\publishprofile.xml

notepad.exe c:\temp\publishprofile.xml

$publishProfileXml =[xml]$publishProfileString

$webDeployPublishUrl = $publishProfileXml.publishData.publishProfile[0].publishUrl
$webDeployPublishUserName = $publishProfileXml.publishData.publishProfile[0].userName
$webDeployPublishPassword = $publishProfileXml.publishData.publishProfile[0].userPWD

　
$ftpPublishUrl = $publishProfileXml.publishData.publishProfile[1].publishUrl
$ftpPublishUserName = $publishProfileXml.publishData.publishProfile[1].userName
$ftpPublishPassword = $publishProfileXml.publishData.publishProfile[1].userPWD

"webDeployPublishUrl = " + $webDeployPublishUrl 
"webDeployPublishUserName = " + $webDeployPublishUserName  
"webDeployPublishPassword = " + $webDeployPublishPassword 

"ftpPublishUrl = " + $ftpPublishUrl 
"ftpPublishUserName = " + $ftpPublishUserName 
"ftpPublishPassword = " + $ftpPublishPassword 
 
