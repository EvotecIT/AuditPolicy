---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Set-SystemAuditPolicyPermissions

## SYNOPSIS
This function will set the audit policy permissions for the specified user or group to FullControl.

## SYNTAX

```
Set-SystemAuditPolicyPermissions [-Identity] <String> [[-Permissions] <RegistryRights>]
 [[-ComputerName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function will set the audit policy permissions for the specified user or group to FullControl.
By default only SYSTEM account has any permission.
This command can be used to add audit policy permissions for the specified user or group.

## EXAMPLES

### EXAMPLE 1
```
Set-SystemAuditPolicyPermissions -Identity "przemyslaw.klys" -Verbose -WhatIf
```

## PARAMETERS

### -Identity
The identity of the user or group to set the audit policy permissions for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Permissions
The permissions to set for the specified user or group.
By default FullControl.

```yaml
Type: RegistryRights
Parameter Sets: (All)
Aliases:
Accepted values: QueryValues, SetValue, CreateSubKey, EnumerateSubKeys, Notify, CreateLink, Delete, ReadPermissions, WriteKey, ExecuteKey, ReadKey, ChangePermissions, TakeOwnership, FullControl

Required: False
Position: 2
Default value: FullControl
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
Position: 3
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
