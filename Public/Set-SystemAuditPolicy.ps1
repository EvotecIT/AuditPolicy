function Set-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Sets the audit policy similary to what auditpol.exe does.

    .DESCRIPTION
    Sets the audit policy similary to what auditpol.exe does.

    .PARAMETER ComputerName
    ComputerName for remote system to clear audit policy from. Requires permissions on the destination.

    .PARAMETER Policy
    The policy to set from all categories

    .PARAMETER AccountLogon
    Choose one of the options for the AccountLogon parameter.

    .PARAMETER AccountManagement
    Choose one of the options for the AccountManagement parameter.

    .PARAMETER DetailedTracking
    Choose one of the options for the DetailedTracking parameter.

    .PARAMETER DSAccess
    Choose one of the options for the DSAccess parameter.

    .PARAMETER LogonLogoff
    Choose one of the options for the LogonLogoff parameter.

    .PARAMETER ObjectAccess
    Choose one of the options for the ObjectAccess parameter.

    .PARAMETER PolicyChange
    Choose one of the options for the PolicyChange parameter.

    .PARAMETER PrivilegeUse
    Choose one of the options for the PrivilegeUse parameter.

    .PARAMETER System
    Choose one of the options for the System parameter.

    .PARAMETER Value
    Choose one of the options for the Value parameter.

    .PARAMETER UseAuditPol
    Forces use of AuditPol.exe instead of registry approach

    .PARAMETER UseLocalSecurityPolicy
    Forces use of LocalSecurityPolicy (audit.csv) to instead of registry approach
    It's important to know that refresh of policies happens on next GPO refresh rather than being applied immediately.

    .PARAMETER Suppress
    Suppresses the output of the command

    .EXAMPLE
    $WhatIf = $false

    Set-SystemAuditPolicy -AccountLogon 'Kerberos Service Ticket Operations' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon 'Other AccountLogon Events' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon 'Kerberos Authentication Service' -Value SuccessAndFailure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon 'Credential Validation' -Value Success -Verbose -WhatIf:$WhatIf

    Set-SystemAuditPolicy -AccountManagement 'Computer Account Management' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement 'Application Group Management' -Value Success -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement 'Distribution Group Management' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement 'Other Account ManagementEvents' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement 'Security Group Management' -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement 'User Account Management' -Value Failure -Verbose -WhatIf:$WhatIf

    .EXAMPLE
    Set-SystemAuditPolicy -AccountManagement 'User Account Management' -Value Failure -Verbose -WhatIf -UseLocalSecurityPolicy

    .EXAMPLE
    Set-SystemAuditPolicy -AccountManagement 'User Account Management' -Value Failure -Verbose -WhatIf -UseAuditPol

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'AllPolicies')]
    param(
        [string] $ComputerName,
        [parameter(Mandatory, ParameterSetName = 'AllPolicies')]
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
        )][alias('Policies')][string] $Policy,

        [parameter(Mandatory, ParameterSetName = 'AccountLogon')][ValidateSet(
            'Credential Validation',
            'Kerberos Service Ticket Operations',
            'Other Account Logon Events',
            'Kerberos Authentication Service'
        )][string] $AccountLogon,

        [parameter(Mandatory, ParameterSetName = 'AccountManagement')][ValidateSet(
            'User Account Management',
            'Computer Account Management',
            'Security Group Management',
            'Distribution Group Management',
            'Application Group Management',
            'Other Account Management Events'
        )][string] $AccountManagement,

        [parameter(Mandatory, ParameterSetName = 'DetailedTracking')][ValidateSet(
            'Process Creation',
            'Process Termination',
            'DPAPI Activity',
            'RPC Events',
            'Plug and Play Events',
            'Token Right Adjusted Events'
        )][string] $DetailedTracking,

        [parameter(Mandatory, ParameterSetName = 'DSAccess')][ValidateSet(
            'Directory Service Access',
            'Directory Service Changes',
            'Directory Service Replication',
            'Detailed Directory Service Replication'
        )][string] $DSAccess,

        [parameter(Mandatory, ParameterSetName = 'LogonLogoff')][ValidateSet(
            'Logon',
            'Logoff',
            'Account Lockout',
            'IPSec Main Mode',
            'Special Logon',
            'IPSec Quick Mode',
            'IPSec Extended Mode',
            'Other Logon/Logoff Events',
            'Network Policy Server',
            'User / Device Claims',
            'Group Membership'
        )][string] $LogonLogoff,

        [parameter(Mandatory, ParameterSetName = 'ObjectAccess')][ValidateSet(
            'File System',
            'Registry',
            'Kernel Object',
            'SAM',
            'Other Object Access Events',
            'Certification Services',
            'Application Generated',
            'Handle Manipulation',
            'File Share',
            'Filtering Platform Packet Drop',
            'Filtering Platform Connection',
            'Detailed File Share',
            'Removable Storage',
            'Central Policy Staging'
        )][string] $ObjectAccess,

        [parameter(Mandatory, ParameterSetName = 'PolicyChange')][ValidateSet(
            'Audit Policy Change',
            'Authentication Policy Change',
            'Authorization Policy Change',
            'MPSSVC Rule-Level Policy Change',
            'Filtering Platform Policy Change',
            'Other Policy Change Events'
        )][string] $PolicyChange,

        [parameter(Mandatory, ParameterSetName = 'PrivilegeUse')][ValidateSet(
            'Sensitive Privilege Use',
            'Non Sensitive Privilege Use',
            'Other Privilege Use Events'
        )][string] $PrivilegeUse,

        [parameter(Mandatory, ParameterSetName = 'System')][ValidateSet(
            'Security State Change',
            'Security System Extension',
            'System Integrity',
            'IPsec Driver',
            'Other System Events'
        )][string] $System,

        [parameter(Mandatory)][validateSet('NoAuditing', 'NotConfigured', 'Success', 'Failure', 'SuccessAndFailure')][string] $Value,
        [switch] $UseAuditPol,
        [switch] $UseLocalSecurityPolicy,
        [switch] $Suppress
    )

    Add-Type -TypeDefinition @"
        using System;

        namespace AuditPolicies
        {
            public enum Events {
                NoAuditing    = 0,
                NotConfigured    = 0,
                Success          = 1,
                Failure          = 2,
                SuccessAndFailure = 3
            }
        }
"@

    $AuditValues = @{
        'NoAuditing'        = 0
        'NotConfigured'     = 0
        'Success'           = 1
        'Failure'           = 2
        'SuccessAndFailure' = 3
    }
    $AuditPoliciesByte = [ordered] @{
        AccountLogon      = [ordered] @{
            'Credential Validation'              = 122
            'Kerberos Service Ticket Operations' = 124
            'Other Account Logon Events'         = 126
            'Kerberos Authentication Service'    = 128
        }
        AccountManagement = [ordered] @{
            'User Account Management'         = 102
            'Computer Account Management'     = 104
            'Security Group Management'       = 106
            'Distribution Group Management'   = 108
            'Application Group Management'    = 110
            'Other Account Management Events' = 112
        }
        DetailedTracking  = [ordered] @{
            'Process Creation'            = 78
            'Process Termination'         = 80
            'DPAPI Activity'              = 82
            'RPC Events'                  = 84
            'Plug and Play Events'        = 86
            'Token Right Adjusted Events' = 88
        }
        DSAccess          = [ordered] @{
            'Directory Service Access'               = 114
            'Directory Service Changes'              = 116
            'Directory Service Replication'          = 118
            'Detailed Directory Service Replication' = 120
        }
        LogonLogoff       = [ordered] @{
            'Logon'                     = 22
            'Logoff'                    = 24
            'Account Lockout'           = 26
            'IPSec Main Mode'           = 28
            'Special Logon'             = 30
            'IPSec Quick Mode'          = 32
            'IPSec Extended Mode'       = 34
            'Other Logon/Logoff Events' = 36
            'Network Policy Server'     = 38
            'User / Device Claims'      = 40
            'Group Membership'          = 42
        }
        ObjectAccess      = [ordered] @{
            'File System'                    = 44
            'Registry'                       = 46
            'Kernel Object'                  = 48
            'SAM'                            = 50
            'Other Object Access Events'     = 52
            'Certification Services'         = 54
            'Application Generated'          = 56
            'Handle Manipulation'            = 58
            'File Share'                     = 60
            'Filtering Platform Packet Drop' = 62
            'Filtering Platform Connection'  = 64
            'Detailed File Share'            = 66
            'Removable Storage'              = 68
            'Central Policy Staging'         = 70
        }
        PolicyChange      = [ordered] @{
            'Audit Policy Change'              = 90
            'Authentication Policy Change'     = 92
            'Authorization Policy Change'      = 94
            'MPSSVC Rule-Level Policy Change'  = 96
            'Filtering Platform Policy Change' = 98
            'Other Policy Change Events'       = 100
        }
        PrivilegeUse      = [ordered] @{
            'Sensitive Privilege Use'     = 72
            'Non Sensitive Privilege Use' = 74
            'Other Privilege Use Events'  = 76
        }
        System            = [ordered] @{
            'Security State Change'     = 12
            'Security System Extension' = 14
            'System Integrity'          = 16
            'IPsec Driver'              = 18
            'Other System Events'       = 20
        }
    }



    $BoundParameters = $PSBoundParameters
    $CurrentParameterSet = $PsCmdlet.ParameterSetName
    $ChosenParameter = $BoundParameters.$CurrentParameterSet

    if ($UseAuditPol) {
        if ($Policy) {
            Set-SystemAuditPolicyAuditpol -Policies $Policy -Value $Value -WhatIf:$WhatIfPreference
        } elseif ($ChosenParameter) {
            Set-SystemAuditPolicyAuditpol -Policies $ChosenParameter -Value $Value -WhatIf:$WhatIfPreference
        }
    } elseif ($UseLocalSecurityPolicy) {
        if ($Policy) {
            Set-SystemAuditPolicyLocalSecurity -Policies $Policy -Value $Value -WhatIf:$WhatIfPreference
        } elseif ($ChosenParameter) {
            Set-SystemAuditPolicyLocalSecurity -Policies $ChosenParameter -Value $Value -WhatIf:$WhatIfPreference
        }
    } else {
        $IsSystem = [System.Security.Principal.WindowsIdentity]::GetCurrent().IsSystem
        if (-not $IsSystem) {
            $SID = ConvertFrom-SID -SID "S-1-5-32-544"
            Set-SystemAuditPolicyPermissions -Identity $SID.Name -Permissions FullControl -WhatIf:$false
        }

        $Audit = Get-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName
        if ($Audit.PSConnection -eq $true -and $Audit.PSError -eq $false) {

        } else {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw $($Audit.PSErrorMessage)
            } else {
                Write-Warning -Message "Set-SystemAuditPolicy - Audit policies couldn't be read: $($Audit.PSErrorMessage)"
            }
            return
        }
        if ($CurrentParameterSet) {
            if ($CurrentParameterSet -eq 'AllPolicies') {
                foreach ($Key in $AuditPoliciesByte.Keys) {
                    if ($AuditPoliciesByte[$Key][$Policy]) {
                        $ByteNumber = $AuditPoliciesByte[$Key][$Policy]
                        $CurrentParameterSet = $Key
                        $ChosenParameter = $Policy
                        break
                    }
                }
            } else {
                $ByteNumber = $AuditPoliciesByte[$CurrentParameterSet][$ChosenParameter]
            }
            $ExpectedValue = $AuditValues[$Value]

            $CurrentValue = $Audit.PSValue[$ByteNumber]
            $CurrentTranslatedValue = [AuditPolicies.Events] $CurrentValue
            $ExpectedTranslatedValue = [AuditPolicies.Events] $ExpectedValue

            Write-Verbose -Message "Set-SystemAuditPolicy - Current value for $CurrentParameterSet\$ChosenParameter is $CurrentTranslatedValue ($CurrentValue) to be replaced with $ExpectedTranslatedValue ($ExpectedValue)"
            if ($CurrentTranslatedValue -ne $ExpectedTranslatedValue) {
                # we get value from registry as is
                $ValueToSet = $Audit.PSValue
                # and then we modify single byte
                $ValueToSet[$ByteNumber] = $ExpectedValue
                # and set it back to registry
                if ($PSCmdlet.ShouldProcess("SubCategory $Policy", "Setting $Value on $Policy")) {
                    $AuditOutput = Set-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName -Type None -Value $ValueToSet -WhatIf:$WhatIfPreference
                    if ($AuditOutput.PSConnection -eq $true -and $AuditOutput.PSError -eq $false) {
                        $Result = 'Success'
                        $Message = ''
                    } else {
                        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                            throw $($AuditOutput.PSErrorMessage)
                        } else {
                            Write-Warning -Message "Set-SystemAuditPolicy - Audit policies couldn't be set because: $($AuditOutput.PSErrorMessage)"
                        }
                        $Result = 'Failed'
                        $Message = $($AuditOutput.PSErrorMessage)
                    }
                } else {
                    $Result = 'WhatIf'
                    $Message = 'WhatIf in use.'
                }
            } else {
                $Result = 'Not required'
                Write-Verbose -Message "Set-SystemAuditPolicy - Current value for $CurrentParameterSet\$ChosenParameter ($ByteNumber) is $CurrentTranslatedValue ($CurrentValue) - nothing to do."
            }
        }
        if (-not $IsSystem) {
            $SID = ConvertFrom-SID -SID "S-1-5-32-544"
            Remove-SystemAuditPolicyPermissions -Identity $SID.Name -Permissions FullControl -WhatIf:$false
        }
        if (-not $Suppress) {
            [PSCustomObject] @{
                'Policy' = $ChosenParameter
                'Value'  = $ExpectedTranslatedValue
                'Result' = $Result
                'Error'  = $Message
            }
        }
    }
}