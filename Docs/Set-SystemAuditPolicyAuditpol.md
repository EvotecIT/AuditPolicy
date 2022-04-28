---
external help file: AuditPolicy-help.xml
Module Name: AuditPolicy
online version:
schema: 2.0.0
---

# Set-SystemAuditPolicyAuditpol

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Set-SystemAuditPolicyAuditpol [-Policies] <String[]> [-Value] <String> [-WhatIf] [-Confirm]
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

### -Policies
{{ Fill Policies Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Security System Extension, System Integrity, IPsec Driver, Other System Events, Security State Change, Logon, Logoff, Account Lockout, IPsec Main Mode, IPsec Quick Mode, IPsec Extended Mode, Special Logon, Other Logon/Logoff Events, Network Policy Server, User / Device Claims, Group Membership, File System, Registry, Kernel Object, SAM, Certification Services, Application Generated, Handle Manipulation, File Share, Filtering Platform Packet Drop, Filtering Platform Connection, Other Object Access Events, Detailed File Share, Removable Storage, Central Policy Staging, Non Sensitive Privilege Use, Other Privilege Use Events, Sensitive Privilege Use, Process Creation, Process Termination, DPAPI Activity, RPC Events, Plug and Play Events, Token Right Adjusted Events, Audit Policy Change, Authentication Policy Change, Authorization Policy Change, MPSSVC Rule-Level Policy Change, Filtering Platform Policy Change, Other Policy Change Events, Computer Account Management, Security Group Management, Distribution Group Management, Application Group Management, Other Account Management Events, User Account Management, Directory Service Access, Directory Service Changes, Directory Service Replication, Detailed Directory Service Replication, Kerberos Service Ticket Operations, Kerberos Service Ticket Operations, Other Account Logon Events, Kerberos Authentication Service, Credential Validation

Required: True
Position: 0
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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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
