Function GetResourceGroupForWebApp ([string] $webappNameParam)
{

    $script:ResourceGroupName = ""
    Get-AzureRmResource | where { ($_.ResourceType -match "Microsoft.Web/sites") -and ($_.ResourceId.ToLower().EndsWith($webappNameParam.ToLower()))} | foreach {        
       $script:ResourceGroupName= $_.ResourceGroupName
       return
    }
    return $script:ResourceGroupName
}

