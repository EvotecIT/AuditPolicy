function Get-SystemAuditPolicy {
    [CmdletBinding()]
    param(
        [string] $ComputerName
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

    $Audit = Get-PSRegistry -RegistryPath "HKEY_LOCAL_MACHINE\SECURITY\Policy\PolAdtEv" -Key "" -ComputerName $ComputerName
    if ($Audit.PSConnection -eq $true -and $Audit.PSError -eq $false) {
        $Data = $Audit.PSValue

        $AuditPolicies = [ordered] @{
            AccountLogon      = [ordered] @{
                'CredentialValidation'            = [AuditPolicies.Events] $Data[122]
                'KerberosServiceTicketOperations' = [AuditPolicies.Events] $Data[124]
                'OtherAccountLogonEvents'         = [AuditPolicies.Events] $Data[126]
                'KerberosAuthenticationService'   = [AuditPolicies.Events] $Data[128]
            }
            AccountManagement = [ordered] @{
                'UserAccountManagement'        = [AuditPolicies.Events] $Data[102]
                'ComputerAccountManagement'    = [AuditPolicies.Events] $Data[104]
                'SecurityGroupManagement'      = [AuditPolicies.Events] $Data[106]
                'DistributionGroupManagement'  = [AuditPolicies.Events] $Data[108]
                'ApplicationGroupManagement'   = [AuditPolicies.Events] $Data[110]
                'OtherAccountManagementEvents' = [AuditPolicies.Events] $Data[112]
            }
            DetailedTracking  = [ordered] @{
                'ProcessCreation'    = [AuditPolicies.Events] $Data[78]
                'ProcessTermination' = [AuditPolicies.Events] $Data[80]
                'DPAPIActivity'      = [AuditPolicies.Events] $Data[82]
                'RPCEvents'          = [AuditPolicies.Events] $Data[84]
                'PNPActivity'        = [AuditPolicies.Events] $Data[86]
                'TokenRightAdjusted' = [AuditPolicies.Events] $Data[88]
            }
            DSAccess          = [ordered] @{
                'DirectoryServiceAccess'              = [AuditPolicies.Events] $Data[114]
                'DirectoryServiceChanges'             = [AuditPolicies.Events] $Data[116]
                'DirectoryServiceReplication'         = [AuditPolicies.Events] $Data[118]
                'DetailedDirectoryServiceReplication' = [AuditPolicies.Events] $Data[120]
            }
            LogonLogoff       = [ordered] @{
                'Logon'                  = [AuditPolicies.Events] $Data[22]
                'Logoff'                 = [AuditPolicies.Events] $Data[24]
                'AccountLockout'         = [AuditPolicies.Events] $Data[26]
                'IPSecMainMode'          = [AuditPolicies.Events] $Data[28]
                'SpecialLogon'           = [AuditPolicies.Events] $Data[30]
                'IPSecQuickMode'         = [AuditPolicies.Events] $Data[32]
                'IPSecExtendedMode'      = [AuditPolicies.Events] $Data[34]
                'OtherLogonLogoffEvents' = [AuditPolicies.Events] $Data[36]
                'NetworkPolicyServer'    = [AuditPolicies.Events] $Data[38]
                'UserDeviceClaims'       = [AuditPolicies.Events] $Data[40]
                'GroupMembership'        = [AuditPolicies.Events] $Data[42]
            }
            ObjectAccess      = [ordered] @{
                'FileSystem'                  = [AuditPolicies.Events] $Data[44]
                'Registry'                    = [AuditPolicies.Events] $Data[46]
                'KernelObject'                = [AuditPolicies.Events] $Data[48]
                'SAM'                         = [AuditPolicies.Events] $Data[50]
                'OtherObjectAccessEvents'     = [AuditPolicies.Events] $Data[52]
                'CertificationServices'       = [AuditPolicies.Events] $Data[54]
                'ApplicationGenerated'        = [AuditPolicies.Events] $Data[56]
                'HandleManipulation'          = [AuditPolicies.Events] $Data[58]
                'FileShare'                   = [AuditPolicies.Events] $Data[60]
                'FilteringPlatformPacketDrop' = [AuditPolicies.Events] $Data[62]
                'FilteringPlatformConnection' = [AuditPolicies.Events] $Data[64]
                'DetailedFileShare'           = [AuditPolicies.Events] $Data[66]
                'RemovableStorage'            = [AuditPolicies.Events] $Data[68]
                'CentralAccessPolicyStaging'  = [AuditPolicies.Events] $Data[70]
            }
            PolicyChange      = [ordered] @{
                'AuditPolicyChange'             = [AuditPolicies.Events] $Data[90]
                'AuthenticationPolicyChange'    = [AuditPolicies.Events] $Data[92]
                'AuthorizationPolicyChange'     = [AuditPolicies.Events] $Data[94]
                'MPSSVCRuleLevelPolicyChange'   = [AuditPolicies.Events] $Data[96]
                'FilteringPlatformPolicyChange' = [AuditPolicies.Events] $Data[98]
                'OtherPolicyChangeEvents'       = [AuditPolicies.Events] $Data[100]
            }
            PrivilegeUse      = [ordered] @{
                'SensitivePrivilegeUse'    = [AuditPolicies.Events] $Data[72]
                'NonSensitivePrivilegeUse' = [AuditPolicies.Events] $Data[74]
                'OtherPrivilegeUseEvents'  = [AuditPolicies.Events] $Data[76]
            }
            System            = [ordered] @{
                'SecurityStateChange'     = [AuditPolicies.Events] $Data[12]
                'SecuritySystemExtension' = [AuditPolicies.Events] $Data[14]
                'SystemIntegrity'         = [AuditPolicies.Events] $Data[16]
                'IPsecDriver'             = [AuditPolicies.Events] $Data[18]
                'OtherSystemEvents'       = [AuditPolicies.Events] $Data[20]
            }
        }
        $AuditPolicies
    } else {
        Write-Warning -Message "Get-SystemAuditPolicies - Audit policies couldn't be read: $($Audit.PSErrorMessage)"
    }
}