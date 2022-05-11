function Get-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Small functions that reads Audit Policy (the same way as auditpol.exe) and returns a hashtable with the values.

    .DESCRIPTION
    Small functions that reads Audit Policy (the same way as auditpol.exe) and returns a hashtable with the values.

    .PARAMETER ComputerName
    ComputerName for remote system to read audit policy from. Requires permissions on the destination.

    .PARAMETER Policy
    Returns the specified policy, and only that policy.

    .PARAMETER Categories
    Forces display in category view

    .EXAMPLE
    $AuditPolicies = Get-SystemAuditPolicy
    $AuditPolicies | Format-Table
    $AuditPolicies.AccountLogon | Format-Table
    $AuditPolicies.AccountManagement | Format-Table
    $AuditPolicies.DetailedTracking | Format-Table

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string] $ComputerName,
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
        [switch] $Categories
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

    $IsSystem = [System.Security.Principal.WindowsIdentity]::GetCurrent().IsSystem
    if (-not $IsSystem) {
        $SID = ConvertFrom-SID -SID "S-1-5-32-544"
        Set-SystemAuditPolicyPermissions -Identity $SID.Name -Permissions FullControl
    }

    $Audit = Get-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName

    if (-not $IsSystem) {
        $SID = ConvertFrom-SID -SID "S-1-5-32-544"
        Remove-SystemAuditPolicyPermissions -Identity $SID.Name -Permissions FullControl
    }

    if ($Audit.PSConnection -eq $true -and $Audit.PSError -eq $false) {
        $Data = $Audit.PSValue

        $AuditPolicies = [ordered] @{
            System            = [ordered] @{
                'Security State Change'     = [AuditPolicies.Events] $Data[12]
                'Security System Extension' = [AuditPolicies.Events] $Data[14]
                'System Integrity'          = [AuditPolicies.Events] $Data[16]
                'IPsec Driver'              = [AuditPolicies.Events] $Data[18]
                'Other System Events'       = [AuditPolicies.Events] $Data[20]
            }
            LogonLogoff       = [ordered] @{
                'Logon'                     = [AuditPolicies.Events] $Data[22]
                'Logoff'                    = [AuditPolicies.Events] $Data[24]
                'Account Lockout'           = [AuditPolicies.Events] $Data[26]
                'IPSec Main Mode'           = [AuditPolicies.Events] $Data[28]
                'Special Logon'             = [AuditPolicies.Events] $Data[30]
                'IPSec Quick Mode'          = [AuditPolicies.Events] $Data[32]
                'IPSec Extended Mode'       = [AuditPolicies.Events] $Data[34]
                'Other Logon/Logoff Events' = [AuditPolicies.Events] $Data[36]
                'Network Policy Server'     = [AuditPolicies.Events] $Data[38]
                'User / Device Claims'      = [AuditPolicies.Events] $Data[40]
                'Group Membership'          = [AuditPolicies.Events] $Data[42]
            }
            ObjectAccess      = [ordered] @{
                'File System'                    = [AuditPolicies.Events] $Data[44]
                'Registry'                       = [AuditPolicies.Events] $Data[46]
                'Kernel Object'                  = [AuditPolicies.Events] $Data[48]
                'SAM'                            = [AuditPolicies.Events] $Data[50]
                'Other Object Access Events'     = [AuditPolicies.Events] $Data[52]
                'Certification Services'         = [AuditPolicies.Events] $Data[54]
                'Application Generated'          = [AuditPolicies.Events] $Data[56]
                'Handle Manipulation'            = [AuditPolicies.Events] $Data[58]
                'File Share'                     = [AuditPolicies.Events] $Data[60]
                'Filtering Platform Packet Drop' = [AuditPolicies.Events] $Data[62]
                'Filtering Platform Connection'  = [AuditPolicies.Events] $Data[64]
                'Detailed File Share'            = [AuditPolicies.Events] $Data[66]
                'Removable Storage'              = [AuditPolicies.Events] $Data[68]
                'Central Policy Staging'         = [AuditPolicies.Events] $Data[70]
            }
            PrivilegeUse      = [ordered] @{
                'Sensitive Privilege Use'     = [AuditPolicies.Events] $Data[72]
                'Non Sensitive Privilege Use' = [AuditPolicies.Events] $Data[74]
                'Other Privilege Use Events'  = [AuditPolicies.Events] $Data[76]
            }
            DetailedTracking  = [ordered] @{
                'Process Creation'            = [AuditPolicies.Events] $Data[78]
                'Process Termination'         = [AuditPolicies.Events] $Data[80]
                'DPAPI Activity'              = [AuditPolicies.Events] $Data[82]
                'RPC Events'                  = [AuditPolicies.Events] $Data[84]
                'Plug and Play Events'        = [AuditPolicies.Events] $Data[86]
                'Token Right Adjusted Events' = [AuditPolicies.Events] $Data[88]
            }
            PolicyChange      = [ordered] @{
                'Audit Policy Change'              = [AuditPolicies.Events] $Data[90]
                'Authentication Policy Change'     = [AuditPolicies.Events] $Data[92]
                'Authorization Policy Change'      = [AuditPolicies.Events] $Data[94]
                'MPSSVC Rule-Level Policy Change'  = [AuditPolicies.Events] $Data[96]
                'Filtering Platform Policy Change' = [AuditPolicies.Events] $Data[98]
                'Other Policy Change Events'       = [AuditPolicies.Events] $Data[100]
            }
            AccountManagement = [ordered] @{
                'User Account Management'         = [AuditPolicies.Events] $Data[102]
                'Computer Account Management'     = [AuditPolicies.Events] $Data[104]
                'Security Group Management'       = [AuditPolicies.Events] $Data[106]
                'Distribution Group Management'   = [AuditPolicies.Events] $Data[108]
                'Application Group Management'    = [AuditPolicies.Events] $Data[110]
                'Other Account Management Events' = [AuditPolicies.Events] $Data[112]
            }
            DSAccess          = [ordered] @{
                'Directory Service Access'               = [AuditPolicies.Events] $Data[114]
                'Directory Service Changes'              = [AuditPolicies.Events] $Data[116]
                'Directory Service Replication'          = [AuditPolicies.Events] $Data[118]
                'Detailed Directory Service Replication' = [AuditPolicies.Events] $Data[120]
            }
            AccountLogon      = [ordered] @{
                'Credential Validation'              = [AuditPolicies.Events] $Data[122]
                'Kerberos Service Ticket Operations' = [AuditPolicies.Events] $Data[124]
                'Other Account Logon Events'         = [AuditPolicies.Events] $Data[126]
                'Kerberos Authentication Service'    = [AuditPolicies.Events] $Data[128]
            }
        }
        if ($Policy) {
            foreach ($Entry in $AuditPolicies.Keys) {
                foreach ($Key in $AuditPolicies[$Entry].Keys) {
                    if ($Policy -eq $Key) {
                        return [PSCustomObject] @{
                            'Category' = $Entry
                            'Policy'   = $Policy
                            'Value'    = $AuditPolicies[$Entry][$Key]
                        }
                    }
                }
            }
        } else {
            if (-not $Categories) {
                $OutputObject = [ordered] @{}
                foreach ($Entry in $AuditPolicies.Keys) {
                    foreach ($Key in $AuditPolicies[$Entry].Keys) {
                        $OutputObject[$Key] = $AuditPolicies[$Entry][$Key]
                    }
                }
                $OutputObject
            } else {
                $AuditPolicies
            }
        }
    } else {
        Write-Warning -Message "Get-SystemAuditPolicies - Audit policies couldn't be read: $($Audit.PSErrorMessage)"
    }
}