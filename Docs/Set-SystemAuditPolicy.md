---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Set-SystemAuditPolicy

## SYNOPSIS
Sets the audit policy similary to what auditpol.exe does.

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
Sets the audit policy similary to what auditpol.exe does.

## EXAMPLES

### EXAMPLE 1
```
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
```
## PARAMETERS

### -ComputerName
ComputerName for remote system to clear audit policy from.
Requires permissions on the destination.

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

### -AccountLogon
Choose one of the options for the AccountLogon parameter.

```yaml
Type: String
Parameter Sets: AccountLogon
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccountManagement
Choose one of the options for the AccountManagement parameter.

```yaml
Type: String
Parameter Sets: AccountManagement
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DetailedTracking
Choose one of the options for the DetailedTracking parameter.

```yaml
Type: String
Parameter Sets: DetailedTracking
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DSAccess
Choose one of the options for the DSAccess parameter.

```yaml
Type: String
Parameter Sets: DSAccess
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogonLogoff
Choose one of the options for the LogonLogoff parameter.

```yaml
Type: String
Parameter Sets: LogonLogoff
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectAccess
Choose one of the options for the ObjectAccess parameter.

```yaml
Type: String
Parameter Sets: ObjectAccess
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyChange
Choose one of the options for the PolicyChange parameter.

```yaml
Type: String
Parameter Sets: PolicyChange
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivilegeUse
Choose one of the options for the PrivilegeUse parameter.

```yaml
Type: String
Parameter Sets: PrivilegeUse
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -System
Choose one of the options for the System parameter.

```yaml
Type: String
Parameter Sets: System
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
Choose one of the options for the Value parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS