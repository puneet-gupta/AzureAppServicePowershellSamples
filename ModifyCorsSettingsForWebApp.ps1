Login-AzureRmAccount

$siteName = "buggybits"
$rgGroup = "buggybits"

$allowedOrigins = @()

$allowedOrigins += "*"
$allowedOrigins += "www.yourdomain.com"

$allowedOrigins

$PropertiesObject = @{cors = @{allowedOrigins= $allowedOrigins}}

Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName $rgGroup -ResourceType Microsoft.Web/sites/config -ResourceName $siteName/web -ApiVersion 2015-08-01 -Force
