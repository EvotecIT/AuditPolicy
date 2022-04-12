function Clear-SystemAuditPolicy {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [string] $ComputerName
    )
    $CurrentPolicies = Get-SystemAuditPolicy -ComputerName $ComputerName
    foreach ($Policy in $CurrentPolicies.Keys) {

        $SubPolicies = $CurrentPolicies[$Policy]
        foreach ($Sub in $SubPolicies.Keys) {
            if ($SubPolicies[$Sub] -ne 'NotConfigured') {
                $setSystemAuditPolicySplat = @{
                    "$Policy"    = $Sub
                    ComputerName = $ComputerName
                    WhatIf       = $WhatIfPreference
                    Value        = 'NotConfigured'
                }
                $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                if ($Success.PSError -eq $false -and $Success.PSConnection -eq $true) {

                } else {
                    Write-Warning -Message " Clear-SystemAuditPolicy - Failed to clear $Policy\$Sub. Error: $($Success.PSErrorMessage)"
                }
            }
        }
    }
}