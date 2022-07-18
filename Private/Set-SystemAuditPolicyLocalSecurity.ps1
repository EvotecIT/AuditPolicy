function Set-SystemAuditPolicyLocalSecurity {
    <#
    .SYNOPSIS
    This function will set the audit policy for the local machine using Local Security Policy (audit.csv)

    .DESCRIPTION
    This function will set the audit policy for the local machine using Local Security Policy (audit.csv)
    It's IMPORTANT to know that Local Security Policy doesn't apply until next GPO refresh

    .PARAMETER Policies
    This parameter is used to specify the audit policy to be set.

    .PARAMETER Value
    This parameter is used to specify the value of the audit policy to be set. Options are: NoAuditing, NotConfigured, Success, Failure, and SuccessAndFailure.

    .PARAMETER Suppress
    Suppresses the output of the command

    .EXAMPLE
    Set-SystemAuditPolicyLocalSecurity -AccountManagement 'Computer Account Management' -Value Failure -Verbose -WhatIf

    .EXAMPLE
    Set-SystemAuditPolicyLocalSecurity -AccountManagement 'Application Group Management' -Value Success -Verbose -WhatIf

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
            "Other Account Logon Events",
            "Kerberos Authentication Service",
            "Credential Validation"
        )][alias('Policies')][string] $Policy,
        [parameter(Mandatory)][validateSet('NotConfigured', 'Success', 'Failure', 'SuccessAndFailure', 'NoAuditing')][string] $Value
    )

    $AuditPoliciesGuids = [ordered] @{
        'IPsec Driver'                           = '{0CCE9213-69AE-11D9-BED3-505054503030}'
        'System Integrity'                       = '{0CCE9212-69AE-11D9-BED3-505054503030}'
        'Security System Extension'              = '{0CCE9211-69AE-11D9-BED3-505054503030}'
        'Security State Change'                  = '{0CCE9210-69AE-11D9-BED3-505054503030}'
        'Other System Events'                    = '{0CCE9214-69AE-11D9-BED3-505054503030}'
        'Group Membership'                       = '{0CCE9249-69AE-11D9-BED3-505054503030}'
        'User / Device Claims'                   = '{0CCE9247-69AE-11D9-BED3-505054503030}'
        'Network Policy Server'                  = '{0CCE9243-69AE-11D9-BED3-505054503030}'
        'Other Logon/Logoff Events'              = '{0CCE921C-69AE-11D9-BED3-505054503030}'
        'Special Logon'                          = '{0CCE921B-69AE-11D9-BED3-505054503030}'
        'IPsec Extended Mode'                    = '{0CCE921A-69AE-11D9-BED3-505054503030}'
        'IPsec Quick Mode'                       = '{0CCE9219-69AE-11D9-BED3-505054503030}'
        'IPsec Main Mode'                        = '{0CCE9218-69AE-11D9-BED3-505054503030}'
        'Account Lockout'                        = '{0CCE9217-69AE-11D9-BED3-505054503030}'
        'Logoff'                                 = '{0CCE9216-69AE-11D9-BED3-505054503030}'
        'Logon'                                  = '{0CCE9215-69AE-11D9-BED3-505054503030}'
        'Handle Manipulation'                    = '{0CCE9223-69AE-11D9-BED3-505054503030}'
        'Central Policy Staging'                 = '{0CCE9246-69AE-11D9-BED3-505054503030}'
        'Removable Storage'                      = '{0CCE9245-69AE-11D9-BED3-505054503030}'
        'Detailed File Share'                    = '{0CCE9244-69AE-11D9-BED3-505054503030}'
        'Other Object Access Events'             = '{0CCE9227-69AE-11D9-BED3-505054503030}'
        'Filtering Platform Connection'          = '{0CCE9226-69AE-11D9-BED3-505054503030}'
        'Filtering Platform Packet Drop'         = '{0CCE9225-69AE-11D9-BED3-505054503030}'
        'File Share'                             = '{0CCE9224-69AE-11D9-BED3-505054503030}'
        'Application Generated'                  = '{0CCE9222-69AE-11D9-BED3-505054503030}'
        'Certification Services'                 = '{0CCE9221-69AE-11D9-BED3-505054503030}'
        'SAM'                                    = '{0CCE9220-69AE-11D9-BED3-505054503030}'
        'Kernel Object'                          = '{0CCE921F-69AE-11D9-BED3-505054503030}'
        'Registry'                               = '{0CCE921E-69AE-11D9-BED3-505054503030}'
        'File System'                            = '{0CCE921D-69AE-11D9-BED3-505054503030}'
        'Other Privilege Use Events'             = '{0CCE922A-69AE-11D9-BED3-505054503030}'
        'Non Sensitive Privilege Use'            = '{0CCE9229-69AE-11D9-BED3-505054503030}'
        'Sensitive Privilege Use'                = '{0CCE9228-69AE-11D9-BED3-505054503030}'
        'RPC Events'                             = '{0CCE922E-69AE-11D9-BED3-505054503030}'
        'Token Right Adjusted Events'            = '{0CCE924A-69AE-11D9-BED3-505054503030}'
        'Process Creation'                       = '{0CCE922B-69AE-11D9-BED3-505054503030}'
        'Process Termination'                    = '{0CCE922C-69AE-11D9-BED3-505054503030}'
        'Plug and Play Events'                   = '{0CCE9248-69AE-11D9-BED3-505054503030}'
        'DPAPI Activity'                         = '{0CCE922D-69AE-11D9-BED3-505054503030}'
        'Other Policy Change Events'             = '{0CCE9234-69AE-11D9-BED3-505054503030}'
        'Authentication Policy Change'           = '{0CCE9230-69AE-11D9-BED3-505054503030}'
        'Audit Policy Change'                    = '{0CCE922F-69AE-11D9-BED3-505054503030}'
        'Filtering Platform Policy Change'       = '{0CCE9233-69AE-11D9-BED3-505054503030}'
        'Authorization Policy Change'            = '{0CCE9231-69AE-11D9-BED3-505054503030}'
        'MPSSVC Rule-Level Policy Change'        = '{0CCE9232-69AE-11D9-BED3-505054503030}'
        'Other Account Management Events'        = '{0CCE923A-69AE-11D9-BED3-505054503030}'
        'Application Group Management'           = '{0CCE9239-69AE-11D9-BED3-505054503030}'
        'Distribution Group Management'          = '{0CCE9238-69AE-11D9-BED3-505054503030}'
        'Security Group Management'              = '{0CCE9237-69AE-11D9-BED3-505054503030}'
        'Computer Account Management'            = '{0CCE9236-69AE-11D9-BED3-505054503030}'
        'User Account Management'                = '{0CCE9235-69AE-11D9-BED3-505054503030}'
        'Directory Service Replication'          = '{0CCE923D-69AE-11D9-BED3-505054503030}'
        'Directory Service Access'               = '{0CCE923B-69AE-11D9-BED3-505054503030}'
        'Detailed Directory Service Replication' = '{0CCE923E-69AE-11D9-BED3-505054503030}'
        'Directory Service Changes'              = '{0CCE923C-69AE-11D9-BED3-505054503030}'
        'Other Account Logon Events'             = '{0CCE9241-69AE-11D9-BED3-505054503030}'
        'Kerberos Service Ticket Operations'     = '{0CCE9240-69AE-11D9-BED3-505054503030}'
        'Credential Validation'                  = '{0CCE923F-69AE-11D9-BED3-505054503030}'
        'Kerberos Authentication Service'        = '{0CCE9242-69AE-11D9-BED3-505054503030}'
    }

    $ListTranslated = @{
        'NoAuditing'        = 'No Auditing'
        'NotConfigured'     = ''
        'Success'           = 'Success'
        'Failure'           = 'Failure'
        'SuccessAndFailure' = 'Success and Failure'
    }
    $ValuesTranslated = @{
        'NoAuditing'        = 0
        'NotConfigured'     = -1
        'Success'           = 1
        'Failure'           = 2
        'SuccessAndFailure' = 3
    }


    $LocalSecurity = [ordered] @{}

    $LocalSecurityPolicyFolder = [io.path]::Combine($Env:SystemRoot, "System32", "GroupPolicy", "Machine", "Microsoft", "Windows NT", "Audit")
    $LocalSecurityPolicy = [io.path]::Combine($Env:SystemRoot, "System32", "GroupPolicy", "Machine", "Microsoft", "Windows NT", "Audit", 'Audit.csv')
    if (Test-Path -LiteralPath $LocalSecurityPolicy) {
        $CurrentCSV = Get-Content -LiteralPath $LocalSecurityPolicy -Raw | ConvertFrom-Csv
        foreach ($C in $CurrentCSV) {
            $LocalSecurity[$C.Subcategory] = $C
        }
    }

    if ($Value -eq 'NotConfigured') {
        $LocalSecurity.Remove($Policy)
    } else {
        $InputValue = [PScustomObject] @{
            'Machine Name'      = ''
            'Policy Target'     = 'System'
            'Subcategory'       = $Policy
            'Subcategory GUID'  = $AuditPoliciesGuids[$Policy]
            'Inclusion Setting' = $ListTranslated[$Value]
            'Exclusion Setting' = ''
            'Setting Value'     = $ValuesTranslated[$Value]
        }

        $LocalSecurity[$Policy] = $InputValue
    }
    if ($PSCmdlet.ShouldProcess("SubCategory $Policy", "Setting $Value")) {
        try {
            if (-not (Test-Path -LiteralPath $LocalSecurityPolicyFolder -ErrorAction SilentlyContinue)) {
                $null = New-Item -ItemType Directory -Path $LocalSecurityPolicyFolder -Force
            }
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning -Message "Set-SystemAuditPolicyLocalSecurityPolicy - Couldn't create folder $LocalSecurityPolicyFolder. Error: $($_.Exception.Message)"
            }
        }
        try {
            $LocalSecurity.Values | ConvertTo-Csv -NoTypeInformation -Delimiter "," | ForEach-Object { $_ -replace '"', '' } | Set-Content -LiteralPath $LocalSecurityPolicy -ErrorAction Stop
            $Message = ''
            $Result = 'Success'
        } catch {
            $Result = 'Failed'
            $Message = $($_.Exception.Message)
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning -Message "Set-SystemAuditPolicyLocalSecurityPolicy - Audit policies couldn't be saved to $LocalSecurityPolicy. Error: $($_.Exception.Message)"
            }
        }
    } else {
        $Message = 'WhatIf in use.'
        $Result = 'WhatIf'
    }
    if (-not $Suppress) {
        [PSCustomObject] @{
            'Policy' = $Policy
            'Value'  = $Value
            'Result' = $Result
            'Error'  = $Message
        }
    }
}