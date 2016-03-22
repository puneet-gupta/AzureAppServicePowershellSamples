Function GetResourceGroupForWebApp ([string] $webappNameParam)
{

    $ResourceGroupName = ""
    Get-AzureRmResource | where { ($_.ResourceType -match "Microsoft.Web/sites") -and ($_.ResourceId.ToLower().EndsWith($webappNameParam.ToLower()))} | foreach     
    {        
       $ResourceGroupName = $_.ResourceGroupName
        break
    }
    return $ResourceGroupName
}
