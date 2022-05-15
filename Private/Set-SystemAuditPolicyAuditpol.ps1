function Set-SystemAuditPolicyAuditpol {
    <#
    .SYNOPSIS
    This command is used to set the audit policy for the system using auditpol.exe

    .DESCRIPTION
    This command is used to set the audit policy for the system using auditpol.exe

    .PARAMETER Policies
    This parameter is used to specify the audit policy to be set.

    .PARAMETER Value
    This parameter is used to specify the value of the audit policy to be set. Options are: NotConfigured, Success, Failure, and SuccessAndFailure.

    .PARAMETER Suppress
    Suppresses the output of the command

    .EXAMPLE
    Set-SystemAuditPolicyLocalSecurity -AccountManagement 'Computer Account Management' -Value Failure -Verbose -WhatIf

    .EXAMPLE
    Set-SystemAuditPolicyLocalSecurity -AccountManagement 'Application Group Management' -Value Success -Verbose -WhatIf

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][ValidateSet(
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
        )][string[]] $Policies,
        [parameter(Mandatory)][validateSet('NoAuditing', 'NotConfigured', 'Success', 'Failure', 'SuccessAndFailure')][string] $Value
    )
    if ($Value -in 'NotConfigured', 'NoAuditing') {
        $Success = 'disable'
        $Failure = 'disable'
    } elseif ($Value -eq 'Success') {
        $Success = 'enable'
        $Failure = 'disable'
    } elseif ($Value -eq 'Failure') {
        $Success = 'disable'
        $Failure = 'enable'
    } elseif ($Value -eq 'SuccessAndFailure') {
        $Success = 'enable'
        $Failure = 'enable'
    }

    foreach ($Policy in $Policies) {
        if ($PSCmdlet.ShouldProcess("SubCategory $Policy", "Setting $Value (Success: $Success / Failure: $Failure)")) {
            Write-Verbose -Message "Set-SystemAuditPolicyAuditpol - Executing: auditpol.exe /set /subcategory:$Policy /success:$Success /failure:$Failure"
            #$Output = auditpol.exe /set /subcategory:$Policy /success:$Success /failure:$Failure
            $pinfo = [System.Diagnostics.ProcessStartInfo]::new()
            $pinfo.FileName = "auditpol.exe"
            $pinfo.RedirectStandardError = $true
            $pinfo.RedirectStandardOutput = $true
            $pinfo.UseShellExecute = $false
            $pinfo.Arguments = " /set /subcategory:`"$Policy`" /success:`"$Success`" /failure:`"$Failure`""
            $p = [System.Diagnostics.Process]::new()
            $p.StartInfo = $pinfo
            $p.Start() | Out-Null
            $p.WaitForExit()
            $Output = $p.StandardOutput.ReadToEnd()
            $Errors = $p.StandardError.ReadToEnd()

            if ($Output -like "*The command was successfully*" -and -not $Errors) {
                if (-not $Suppress) {
                    [PSCustomObject] @{
                        'Policy' = $Policy
                        'Value'  = $Value
                        'Result' = 'Success'
                        'Error'  = ''
                    }
                }
            } else {
                if (-not $Suppress) {
                    $SplitErrors = ($Errors -split "\n").Trim() -join " "
                    [PSCustomObject] @{
                        'Policy' = $Policy
                        'Value'  = $Value
                        'Result' = 'Failed'
                        'Error'  = $SplitErrors
                    }
                }
            }
        } else {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    'Policy' = $Policy
                    'Value'  = $Value
                    'Result' = 'WhatIf'
                    'Error'  = 'WhatIf in use.'
                }
            }
        }
    }
}