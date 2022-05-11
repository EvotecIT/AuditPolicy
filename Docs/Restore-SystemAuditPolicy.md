---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Restore-SystemAuditPolicy

## SYNOPSIS
Restore the system audit policy to the one from backup.

## SYNTAX

### File (Default)
```
Restore-SystemAuditPolicy [-ComputerName <String>] -FilePath <String> [-Policy <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Object
```
Restore-SystemAuditPolicy [-ComputerName <String>] -Object <IDictionary> [-Policy <String[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### JSON
```
Restore-SystemAuditPolicy [-ComputerName <String>] -JSON <String> [-Policy <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Restore the system audit policy to the one from backup.

## EXAMPLES

### EXAMPLE 1
```
An example
```

## PARAMETERS

### -ComputerName
ComputerName for remote system to restore audit policy on.
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

### -Object
Object to restore audit policy from

```yaml
Type: IDictionary
Parameter Sets: Object
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JSON
JSON object to restore audit policy from

```yaml
Type: String
Parameter Sets: JSON
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
File path to restore audit policy from

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Policy
Pick policy/policies to restore from all policies provided

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Policies

Required: False
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
