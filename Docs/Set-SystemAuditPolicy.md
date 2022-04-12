---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Set-SystemAuditPolicy

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### AccountLogon
```
Set-SystemAuditPolicy [-ComputerName <String>] -AccountLogon <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### AccountManagement
```
Set-SystemAuditPolicy [-ComputerName <String>] -AccountManagement <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DetailedTracking
```
Set-SystemAuditPolicy [-ComputerName <String>] -DetailedTracking <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DSAccess
```
Set-SystemAuditPolicy [-ComputerName <String>] -DSAccess <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### LogonLogoff
```
Set-SystemAuditPolicy [-ComputerName <String>] -LogonLogoff <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ObjectAccess
```
Set-SystemAuditPolicy [-ComputerName <String>] -ObjectAccess <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PolicyChange
```
Set-SystemAuditPolicy [-ComputerName <String>] -PolicyChange <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PrivilegeUse
```
Set-SystemAuditPolicy [-ComputerName <String>] -PrivilegeUse <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### System
```
Set-SystemAuditPolicy [-ComputerName <String>] -System <String> -Value <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AccountLogon
{{ Fill AccountLogon Description }}

```yaml
Type: String
Parameter Sets: AccountLogon
Aliases:
Accepted values: CredentialValidation, KerberosServiceTicketOperations, OtherAccountLogonEvents, KerberosAuthenticationService

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccountManagement
{{ Fill AccountManagement Description }}

```yaml
Type: String
Parameter Sets: AccountManagement
Aliases:
Accepted values: UserAccountManagement, ComputerAccountManagement, SecurityGroupManagement, DistributionGroupManagement, ApplicationGroupManagement, OtherAccountManagementEvents

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
{{ Fill ComputerName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DSAccess
{{ Fill DSAccess Description }}

```yaml
Type: String
Parameter Sets: DSAccess
Aliases:
Accepted values: DirectoryServiceAccess, DirectoryServiceChanges, DirectoryServiceReplication, DetailedDirectoryServiceReplication

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DetailedTracking
{{ Fill DetailedTracking Description }}

```yaml
Type: String
Parameter Sets: DetailedTracking
Aliases:
Accepted values: ProcessCreation, ProcessTermination, DPAPIActivity, RPCEvents, PNPActivity, TokenRightAdjusted

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogonLogoff
{{ Fill LogonLogoff Description }}

```yaml
Type: String
Parameter Sets: LogonLogoff
Aliases:
Accepted values: Logon, Logoff, AccountLockout, IPSecMainMode, SpecialLogon, IPSecQuickMode, IPSecExtendedMode, OtherLogonLogoffEvents, NetworkPolicyServer, UserDeviceClaims, GroupMembership

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectAccess
{{ Fill ObjectAccess Description }}

```yaml
Type: String
Parameter Sets: ObjectAccess
Aliases:
Accepted values: FileSystem, Registry, KernelObject, SAM, OtherObjectAccessEvents, CertificationServices, ApplicationGenerated, HandleManipulation, FileShare, FilteringPlatformPacketDrop, FilteringPlatformConnection, DetailedFileShare, RemovableStorage, CentralAccessPolicyStaging

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyChange
{{ Fill PolicyChange Description }}

```yaml
Type: String
Parameter Sets: PolicyChange
Aliases:
Accepted values: FileSystem, AuditPolicyChange, AuthenticationPolicyChange, AuthorizationPolicyChange, MPSSVCRuleLevelPolicyChange, FilteringPlatformPolicyChange, OtherPolicyChangeEvents

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivilegeUse
{{ Fill PrivilegeUse Description }}

```yaml
Type: String
Parameter Sets: PrivilegeUse
Aliases:
Accepted values: SensitivePrivilegeUse, NonSensitivePrivilegeUse, OtherPrivilegeUseEvents

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -System
{{ Fill System Description }}

```yaml
Type: String
Parameter Sets: System
Aliases:
Accepted values: SecurityStateChange, SecuritySystemExtension, SystemIntegrity, IPsecDriver, OtherSystemEvents

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
{{ Fill Value Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NotConfigured, Success, Failure, SuccessAndFailure

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
