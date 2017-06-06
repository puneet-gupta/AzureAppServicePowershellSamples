. .\Functions.ps1 # This script contains the GetResourceGroupForWebApp Function and code of this script is @ https://github.com/puneet-gupta/AzureAppServicePowershellSamples/blob/master/Functions.ps1

#Format-FileSize() from https://superuser.com/questions/468782/show-human-readable-file-sizes-in-the-default-powershell-ls-command
Function Format-FileSize() 
{
    Param ([double]$size)
    If     ($size -gt 1TB) {[string]::Format("{0:0.00} TB", $size / 1TB)}
    ElseIf ($size -gt 1GB) {[string]::Format("{0:0.00} GB", $size / 1GB)}
    ElseIf ($size -gt 1MB) {[string]::Format("{0:0.00} MB", $size / 1MB)}
    ElseIf ($size -gt 1KB) {[string]::Format("{0:0.00} kB", $size / 1KB)}
    ElseIf ($size -gt 0)   {[string]::Format("{0:0.00} B", $size)}
    Else                   {""}
}

$webAppName = "powershelldemowebapp"
$subscriptionId = "31af7401-5a70-49be-80c7-7a6b85da7287"

Login-AzureRmAccount 
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$rgName = GetResourceGroupForWebApp $webAppName


$appServicePlanBytes = 0
$serverFarmUsage = Get-AzureRmResource -ResourceGroupName $serverFarm.ResourceGroupName -ResourceType Microsoft.Web/serverfarms/usages -ResourceName $serverFarm.Name -ApiVersion 2016-03-01 
foreach ($metric in $serverFarmUsage)
{
    if ($metric.name.value -eq "FileSystemStorage")
    {
        $appServicePlanBytes = $metric.currentValue 
        $bytesToPrint = Format-FileSize $appServicePlanBytes
        "App Service Plan " + $serverFarm.Name  +  " is consuming " + $bytesToPrint +  "  bytes of disk space"
    }
}

$webApp = Get-AzureRmResource -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites -ResourceName $webAppName -ApiVersion 2016-03-01
$serverFarmId = $webApp.Properties.ServerFarmId
$serverFarm = Get-AzureRmResource -ResourceId $serverFarmId

$listOfSites = Get-AzureRmResource -ResourceGroupName $rgName `
            -ResourceType Microsoft.Web/serverfarms/sites `
            -ResourceName $serverFarm.Name `
            -ApiVersion 2015-08-01


foreach($site in $listOfSites)
{   
        $usage = Get-AzureRmResource -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites/usages -ResourceName $site.Name -ApiVersion 2016-03-01
        foreach ($metric in $usage)
        {
            if ($metric.name.value -eq "FileSystemStorage")
            {           
                $bytesToPrint =  Format-FileSize $metric.currentValue 
                "WebApp " + $site.Name  + " is consuming " + $bytesToPrint +  "  of disk space. This is " + [string]::Format("{0:0.00} % ", ($metric.currentValue/$appServicePlanBytes)*100) + " of the Total App Service Plan disk usage"

            }
        }

        $slots = Get-AzureRmResource -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites/slots -ResourceName $site.Name -ApiVersion 2016-03-01

        foreach($siteslot in $slots)
        {            
            $usage = Get-AzureRmResource -ResourceGroupName $rgName -ResourceType Microsoft.Web/sites/slots/usages -ResourceName $siteslot.Name -ApiVersion 2016-03-01
            foreach ($metric in $usage)
            {
                if ($metric.name.value -eq "FileSystemStorage")
                {           
                    $bytesToPrint =  Format-FileSize $metric.currentValue                    
                    "WebApp(slot) " + $siteslot.Name  + " is consuming " + $bytesToPrint +  "  of disk space. This is " + [string]::Format("{0:0.00} % ", ($metric.currentValue/$appServicePlanBytes)*100) + " of the Total App Service Plan disk usage"

                }
            }
        }
    
}
