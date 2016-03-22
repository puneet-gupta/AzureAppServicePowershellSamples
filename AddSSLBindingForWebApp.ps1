# Note that before adding a SSL binding to a web app, you must have a host name (custom domain) already configured. 
# If the host name is not configured , then you will get an error 'hostname' does not exist while running New-AzureRmWebAppSSLBinding. 
# You can add a hostname directly using the above PowerShell example of adding the hostname

. .\Functions.ps1

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"
$PathToPfxFile = "C:\TEST.PFX"
$HostName = "www.contoso.com"
$PlainTextPwd = "PasswordToPFXFile!!!"

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$rgName = GetResourceGroupForWebApp $webAppName 
New-AzureRmWebAppSSLBinding -Name $HostName -ResourceGroupName $rgName `
    -WebAppName $webAppName `
    -CertificateFilePath $PathToPfxFile `
    -CertificatePassword $PlainTextPwd  `

