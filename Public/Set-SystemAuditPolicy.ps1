function Set-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Sets the audit policy similary to what auditpol.exe does.

    .DESCRIPTION
    Sets the audit policy similary to what auditpol.exe does.

    .PARAMETER ComputerName
    ComputerName for remote system to clear audit policy from. Requires permissions on the destination.

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

    .EXAMPLE
    $WhatIf = $false

    Set-SystemAuditPolicy -AccountLogon KerberosServiceTicketOperations -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon OtherAccountLogonEvents -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon KerberosAuthenticationService -Value SuccessAndFailure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountLogon CredentialValidation -Value Success -Verbose -WhatIf:$WhatIf

    Set-SystemAuditPolicy -AccountManagement ComputerAccountManagement -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement ApplicationGroupManagement -Value Success -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement DistributionGroupManagement -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement OtherAccountManagementEvents -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement SecurityGroupManagement -Value Failure -Verbose -WhatIf:$WhatIf
    Set-SystemAuditPolicy -AccountManagement UserAccountManagement -Value Failure -Verbose -WhatIf:$WhatIf

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [string] $ComputerName,
        [parameter(Mandatory, ParameterSetName = 'AccountLogon')][ValidateSet(
            'CredentialValidation',
            'KerberosServiceTicketOperations',
            'OtherAccountLogonEvents',
            'KerberosAuthenticationService'
        )][string] $AccountLogon,

        [parameter(Mandatory, ParameterSetName = 'AccountManagement')][ValidateSet(
            'UserAccountManagement',
            'ComputerAccountManagement',
            'SecurityGroupManagement',
            'DistributionGroupManagement',
            'ApplicationGroupManagement',
            'OtherAccountManagementEvents'
        )][string] $AccountManagement,

        [parameter(Mandatory, ParameterSetName = 'DetailedTracking')][ValidateSet(
            'ProcessCreation',
            'ProcessTermination',
            'DPAPIActivity' ,
            'RPCEvents' ,
            'PNPActivity' ,
            'TokenRightAdjusted'
        )][string] $DetailedTracking,

        [parameter(Mandatory, ParameterSetName = 'DSAccess')][ValidateSet(
            'DirectoryServiceAccess',
            'DirectoryServiceChanges',
            'DirectoryServiceReplication',
            'DetailedDirectoryServiceReplication'
        )][string] $DSAccess,

        [parameter(Mandatory, ParameterSetName = 'LogonLogoff')][ValidateSet(
            'Logon',
            'Logoff',
            'AccountLockout',
            'IPSecMainMode',
            'SpecialLogon',
            'IPSecQuickMode',
            'IPSecExtendedMode',
            'OtherLogonLogoffEvents',
            'NetworkPolicyServer',
            'UserDeviceClaims',
            'GroupMembership'
        )][string] $LogonLogoff,

        [parameter(Mandatory, ParameterSetName = 'ObjectAccess')][ValidateSet(
            'FileSystem',
            'Registry',
            'KernelObject',
            'SAM',
            'OtherObjectAccessEvents',
            'CertificationServices',
            'ApplicationGenerated',
            'HandleManipulation',
            'FileShare',
            'FilteringPlatformPacketDrop',
            'FilteringPlatformConnection',
            'DetailedFileShare',
            'RemovableStorage',
            'CentralAccessPolicyStaging'
        )][string] $ObjectAccess,

        [parameter(Mandatory, ParameterSetName = 'PolicyChange')][ValidateSet(
            'FileSystem',
            'AuditPolicyChange',
            'AuthenticationPolicyChange',
            'AuthorizationPolicyChange',
            'MPSSVCRuleLevelPolicyChange',
            'FilteringPlatformPolicyChange',
            'OtherPolicyChangeEvents'
        )][string] $PolicyChange,

        [parameter(Mandatory, ParameterSetName = 'PrivilegeUse')][ValidateSet(
            'SensitivePrivilegeUse',
            'NonSensitivePrivilegeUse',
            'OtherPrivilegeUseEvents'
        )][string] $PrivilegeUse,

        [parameter(Mandatory, ParameterSetName = 'System')][ValidateSet(
            'SecurityStateChange',
            'SecuritySystemExtension',
            'SystemIntegrity',
            'IPsecDriver',
            'OtherSystemEvents'
        )][string] $System,

        [parameter(Mandatory)][validateSet('NotConfigured', 'Success', 'Failure', 'SuccessAndFailure')][string] $Value
    )

    Add-Type -TypeDefinition @"
        using System;

        namespace AuditPolicies
        {
            public enum Events {
                NotConfigured    = 0,
                Success          = 1,
                Failure          = 2,
                SuccessAndFailure = 3
            }
        }
"@

    $AuditValues = @{
        'NotConfigured'     = 0
        'Success'           = 1
        'Failure'           = 2
        'SuccessAndFailure' = 3
    }
    $AuditPoliciesByte = [ordered] @{
        AccountLogon      = [ordered] @{
            'CredentialValidation'            = 122
            'KerberosServiceTicketOperations' = 124
            'OtherAccountLogonEvents'         = 126
            'KerberosAuthenticationService'   = 128
        }
        AccountManagement = [ordered] @{
            'UserAccountManagement'        = 102
            'ComputerAccountManagement'    = 104
            'SecurityGroupManagement'      = 106
            'DistributionGroupManagement'  = 108
            'ApplicationGroupManagement'   = 110
            'OtherAccountManagementEvents' = 112
        }
        DetailedTracking  = [ordered] @{
            'ProcessCreation'    = 78
            'ProcessTermination' = 80
            'DPAPIActivity'      = 82
            'RPCEvents'          = 84
            'PNPActivity'        = 86
            'TokenRightAdjusted' = 88
        }
        DSAccess          = [ordered] @{
            'DirectoryServiceAccess'              = 114
            'DirectoryServiceChanges'             = 116
            'DirectoryServiceReplication'         = 118
            'DetailedDirectoryServiceReplication' = 120
        }
        LogonLogoff       = [ordered] @{
            'Logon'                  = 22
            'Logoff'                 = 24
            'AccountLockout'         = 26
            'IPSecMainMode'          = 28
            'SpecialLogon'           = 30
            'IPSecQuickMode'         = 32
            'IPSecExtendedMode'      = 34
            'OtherLogonLogoffEvents' = 36
            'NetworkPolicyServer'    = 38
            'UserDeviceClaims'       = 40
            'GroupMembership'        = 42
        }
        ObjectAccess      = [ordered] @{
            'FileSystem'                  = 44
            'Registry'                    = 46
            'KernelObject'                = 48
            'SAM'                         = 50
            'OtherObjectAccessEvents'     = 52
            'CertificationServices'       = 54
            'ApplicationGenerated'        = 56
            'HandleManipulation'          = 58
            'FileShare'                   = 60
            'FilteringPlatformPacketDrop' = 62
            'FilteringPlatformConnection' = 64
            'DetailedFileShare'           = 66
            'RemovableStorage'            = 68
            'CentralAccessPolicyStaging'  = 70
        }
        PolicyChange      = [ordered] @{
            'AuditPolicyChange'             = 90
            'AuthenticationPolicyChange'    = 92
            'AuthorizationPolicyChange'     = 94
            'MPSSVCRuleLevelPolicyChange'   = 96
            'FilteringPlatformPolicyChange' = 98
            'OtherPolicyChangeEvents'       = 100
        }
        PrivilegeUse      = [ordered] @{
            'SensitivePrivilegeUse'    = 72
            'NonSensitivePrivilegeUse' = 74
            'OtherPrivilegeUseEvents'  = 76
        }
        System            = [ordered] @{
            'SecurityStateChange'     = 12
            'SecuritySystemExtension' = 14
            'SystemIntegrity'         = 16
            'IPsecDriver'             = 18
            'OtherSystemEvents'       = 20
        }
    }

    $Audit = Get-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName
    if ($Audit.PSConnection -eq $true -and $Audit.PSError -eq $false) {

    } else {
        Write-Warning -Message "Set-SystemAuditPolicies - Audit policies couldn't be read: $($Audit.PSErrorMessage)"
        return
    }

    $BoundParameters = $PSBoundParameters
    $CurrentParameterSet = $PsCmdlet.ParameterSetName
    $ChosenParameter = $BoundParameters.$CurrentParameterSet

    if ($CurrentParameterSet) {
        $ByteNumber = $AuditPoliciesByte[$CurrentParameterSet][$ChosenParameter]
        $ExpectedValue = $AuditValues[$Value]

        $CurrentValue = $Audit.PSValue[$ByteNumber]
        $CurrentTranslatedValue = [AuditPolicies.Events] $CurrentValue
        $ExpectedTranslatedValue = [AuditPolicies.Events] $ExpectedValue

        Write-Verbose -Message "Set-SystemAuditPolicies - Current value for $CurrentParameterSet\$ChosenParameter is $CurrentTranslatedValue ($CurrentValue) to be replaced with $ExpectedTranslatedValue ($ExpectedValue)"
        if ($CurrentTranslatedValue -ne $ExpectedTranslatedValue) {
            # we get value from registry as is
            $ValueToSet = $Audit.PSValue
            # and then we modify single byte
            $ValueToSet[$ByteNumber] = $ExpectedValue
            # and set it back to registry
            $AuditOutput = Set-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName -Type None -Value $ValueToSet -WhatIf:$WhatIfPreference
            $AuditOutput
        } else {
            Write-Verbose -Message "Set-SystemAuditPolicies - Current value for $CurrentParameterSet\$ChosenParameter ($ByteNumber) is $CurrentTranslatedValue ($CurrentValue) - nothing to do."
        }
    }
}