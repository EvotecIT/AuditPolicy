---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Backup-SystemAuditPolicy

## SYNOPSIS
Backups the current system audit policy to a file or json or as object

## SYNTAX

### File (Default)
```
Backup-SystemAuditPolicy [-ComputerName <String>] [-FilePath <String>] [-Policy <String>] [<CommonParameters>]
```

### AsObject
```
Backup-SystemAuditPolicy [-ComputerName <String>] [-AsObject] [-Policy <String>] [<CommonParameters>]
```

### AsJson
```
Backup-SystemAuditPolicy [-ComputerName <String>] [-AsJson] [-Policy <String>] [<CommonParameters>]
```

## DESCRIPTION
Backups the current system audit policy to a file or json or as object

## EXAMPLES

### EXAMPLE 1
```
Backup-SystemAuditPolicy | Out-File -FilePath $PSScriptRoot\Backups\AuditPolicy.json
```

## PARAMETERS

### -ComputerName
ComputerName for remote system to read audit policy from.
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

### -FilePath
FilePath to write the audit policy to.
If not given will be returned as JSON

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsObject
If true will return the audit policy as an object

```yaml
Type: SwitchParameter
Parameter Sets: AsObject
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJson
If true will return the audit policy as JSON

```yaml
Type: SwitchParameter
Parameter Sets: AsJson
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Policy
Returns the specified policy, and only that policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Policies

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
