function Clear-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Clears all audit policies to their default values (Not Configured)

    .DESCRIPTION
    Clears all audit policies to their default values (Not Configured)

    .PARAMETER ComputerName
    ComputerName for remote system to clear audit policy from. Requires permissions on the destination.

    .EXAMPLE
    Clear-SystemAuditPolicy -WhatIf

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [string] $ComputerName
    )
    $CurrentPolicies = Get-SystemAuditPolicy -ComputerName $ComputerName
    foreach ($Policy in $CurrentPolicies.Keys) {
        $Value = $CurrentPolicies[$Policy]
        if ($Value -ne 'NotConfigured') {
            $setSystemAuditPolicySplat = @{
                Policy       = $Policy
                ComputerName = $ComputerName
                WhatIf       = $WhatIfPreference
                Value        = 'NotConfigured'
            }
            $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
            if ($Success.Result -in 'Success', 'Not Required') {

            } elseif ($Success.Result -eq 'WhatIf') {

            } else {
                Write-Warning -Message " Clear-SystemAuditPolicy - Failed to clear $Policy, status: $($Success.Result) error: $($Success.Error)"
            }
        }
    }
}