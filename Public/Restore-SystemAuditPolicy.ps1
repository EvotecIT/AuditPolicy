function Restore-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Restore the system audit policy to the one from backup.

    .DESCRIPTION
    Restore the system audit policy to the one from backup.

    .PARAMETER ComputerName
    ComputerName for remote system to restore audit policy on. Requires permissions on the destination.

    .PARAMETER Object
    Object to restore audit policy from

    .PARAMETER JSON
    JSON object to restore audit policy from

    .PARAMETER FilePath
    File path to restore audit policy from

    .PARAMETER Policy
    Pick policy/policies to restore from all policies provided

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "File")]
    param(
        [string] $ComputerName,
        [parameter(Mandatory, ParameterSetName = 'Object')][string] $Object,
        [parameter(Mandatory, ParameterSetName = 'JSON')][string] $JSON,
        [parameter(Mandatory, ParameterSetName = 'File')][string] $FilePath,

        [ValidateSet(
            #System
            "Security System Extension",
            "System Integrity",
            "IPsec Driver",
            "Other System Events",
            "Security State Change",
            #Logon/Logoff#
            "Logon",
            "Logoff",
            "Account Lockout",
            "IPsec Main Mode",
            "IPsec Quick Mode",
            "IPsec Extended Mode",
            "Special Logon",
            "Other Logon/Logoff Events",
            "Network Policy Server",
            "User / Device Claims",
            "Group Membership",
            # Object Access#
            "File System",
            "Registry",
            "Kernel Object",
            "SAM",
            "Certification Services",
            "Application Generated",
            "Handle Manipulation",
            "File Share",
            "Filtering Platform Packet Drop",
            "Filtering Platform Connection",
            "Other Object Access Events",
            "Detailed File Share",
            "Removable Storage",
            "Central Policy Staging",
            #Privilege Use#
            "Non Sensitive Privilege Use",
            "Other Privilege Use Events",
            "Sensitive Privilege Use",
            #Detailed Tracking#
            "Process Creation",
            "Process Termination",
            "DPAPI Activity",
            "RPC Events",
            "Plug and Play Events",
            "Token Right Adjusted Events",
            #Policy Change#
            "Audit Policy Change",
            "Authentication Policy Change",
            "Authorization Policy Change",
            "MPSSVC Rule-Level Policy Change",
            "Filtering Platform Policy Change",
            "Other Policy Change Events",
            #Account Management#
            "Computer Account Management",
            "Security Group Management",
            "Distribution Group Management",
            "Application Group Management",
            "Other Account Management Events",
            "User Account Management",
            #DS Access#
            "Directory Service Access",
            "Directory Service Changes",
            "Directory Service Replication",
            "Detailed Directory Service Replication",
            #Account Logon#
            "Kerberos Service Ticket Operations",
            "Kerberos Service Ticket Operations",
            "Other Account Logon Events",
            "Kerberos Authentication Service",
            "Credential Validation"
        )][alias('Policies')][string[]] $Policy
    )

    if ($PSBoundParameters.ContainsKey('FilePath')) {
        if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
            try {
                $FileContent = Get-Content -LiteralPath $FilePath -Raw -ErrorAction Stop
                $SystemPolicies = $FileContent | ConvertFrom-Json -ErrorAction Stop
            } catch {
                Write-Warning -Message "Restore-SystemAuditPolicy - JSON $JSON is not valid. Restore aborted. Error: $($_.Exception.Message)"
            }
        } else {
            Write-Warning -Message "Restore-SystemAuditPolicy - File $FilePath not found. Restore aborted."
        }
    } elseif ($PSBoundParameters.ContainsKey('Object')) {
        $SystemPolicies = $Object
    } elseif ($PSBoundParameters.ContainsKey('JSON')) {
        try {
            $SystemPolicies = $JSON | ConvertFrom-Json -ErrorAction Stop
        } catch {
            Write-Warning -Message "Restore-SystemAuditPolicy - JSON $JSON is not valid. Restore aborted. Error: $($_.Exception.Message)"
            return
        }
    } else {
        Write-Warning -Message "Restore-SystemAuditPolicy - No file or object specified. Restore aborted."
        return
    }


    if ($SystemPolicies) {
        $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName
        if ($AuditPolicy) {
            if ($SystemPolicies -is [System.Collections.IDictionary]) {
                foreach ($CurrentPolicy in $SystemPolicies.Keys) {
                    # lets skip policies which are not meant for restore
                    if ($Policy) {
                        if ($CurrentPolicy -notin $Policy) {
                            continue
                        }
                    }

                    $Value = $SystemPolicies[$CurrentPolicy]
                    if ($Value -ne 'NotConfigured') {
                        $setSystemAuditPolicySplat = @{
                            Policy       = $CurrentPolicy
                            ComputerName = $ComputerName
                            WhatIf       = $WhatIfPreference
                            Value        = $Value
                        }
                        $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                        $Success
                    } else {
                        [PSCustomObject] @{
                            'Policy' = $CurrentPolicy
                            'Value'  = $Value
                            'Result' = 'Not required'
                            'Error'  = ''
                        }
                    }
                }
            } else {
                foreach ($CurrentPolicy in $SystemPolicies.PSObject.Properties.Name) {
                    # lets skip policies which are not meant for restore
                    if ($Policy) {
                        if ($CurrentPolicy -notin $Policy) {
                            continue
                        }
                    }

                    $Value = $SystemPolicies.$CurrentPolicy
                    if ($Value -ne $AuditPolicy[$CurrentPolicy]) {
                        Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $CurrentPolicy is $($AuditPolicy[$CurrentPolicy]) to be replaced with $Value"
                        $setSystemAuditPolicySplat = @{
                            Policy       = $CurrentPolicy
                            ComputerName = $ComputerName
                            WhatIf       = $WhatIfPreference
                            Value        = $Value
                        }
                        $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                        $Success
                        # if ($Success.PSError -eq $false -and $Success.PSConnection -eq $true) {

                        # } else {
                        #     if ($Success.PSErrorMessage -eq "WhatIf used - skipping registry setting") {

                        #     } else {
                        #         Write-Warning -Message "Restore-SystemAuditPolicies - Failed to set $Policy. Error: $($Success.PSErrorMessage)"
                        #     }
                        # }
                    } else {
                        [PSCustomObject] @{
                            'Policy' = $CurrentPolicy
                            'Value'  = $Value
                            'Result' = 'Not required'
                            'Error'  = ''
                        }
                        Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $CurrentPolicy is $($AuditPolicy[$CurrentPolicy]) is the same as requested $Value"
                    }

                    # foreach ($Sub in $SubPolicies.PSObject.Properties.Name) {
                    #     $Value = $SystemPolicies.$Policy.$Sub
                    #     if ($Value -ne $AuditPolicy[$Policy][$Sub]) {
                    #         Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $Policy \ $Sub is $($AuditPolicy[$Policy][$Sub]) to be replaced with $Value"
                    #         $setSystemAuditPolicySplat = @{
                    #             "$Policy"    = $Sub
                    #             ComputerName = $ComputerName
                    #             WhatIf       = $WhatIfPreference
                    #             Value        = $Value
                    #         }
                    #         $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                    #         if ($Success.PSError -eq $false -and $Success.PSConnection -eq $true) {

                    #         } else {
                    #             if ($Success.PSErrorMessage -eq "WhatIf used - skipping registry setting") {

                    #             } else {
                    #                 Write-Warning -Message "Restore-SystemAuditPolicies - Failed to set $Policy \ $Sub. Error: $($Success.PSErrorMessage)"
                    #             }
                    #         }
                    #     } else {
                    #         #Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $Policy \ $Sub is $($AuditPolicy[$Policy][$Sub]) is the same as requested $Value"
                    #     }
                    # }
                }

            }
        }
    }
}