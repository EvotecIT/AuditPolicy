---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Get-SystemAuditPolicy

## SYNOPSIS
Small functions that reads Audit Policy (the same way as auditpol.exe) and returns a hashtable with the values.

## SYNTAX

```
Get-SystemAuditPolicy [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Small functions that reads Audit Policy (the same way as auditpol.exe) and returns a hashtable with the values.

## EXAMPLES

### EXAMPLE 1
```
$AuditPolicies = Get-SystemAuditPolicy
```

$AuditPolicies | Format-Table
$AuditPolicies.AccountLogon | Format-Table
$AuditPolicies.AccountManagement | Format-Table
$AuditPolicies.DetailedTracking | Format-Table

## PARAMETERS

### -ComputerName
ComputerName for remote system to read audit policy from.
Requires permissions on the destination.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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