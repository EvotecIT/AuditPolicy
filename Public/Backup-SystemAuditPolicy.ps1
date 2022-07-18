function Backup-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Backups the current system audit policy to a file or json or as object

    .DESCRIPTION
    Backups the current system audit policy to a file or json or as object

    .PARAMETER ComputerName
    ComputerName for remote system to read audit policy from. Requires permissions on the destination.

    .PARAMETER FilePath
    FilePath to write the audit policy to. If not given will be returned as JSON

    .PARAMETER AsJson
    If true will return the audit policy as JSON

    .PARAMETER AsObject
    If true will return the audit policy as an object

    .PARAMETER Policy
    Returns the specified policy, and only that policy.

    .EXAMPLE
    Backup-SystemAuditPolicy | Out-File -FilePath $PSScriptRoot\Backups\AuditPolicy.json

    .NOTES
    General notes
    #>
    [cmdletBinding(DefaultParameterSetName = 'File')]
    param(
        [string] $ComputerName,
        [parameter(ParameterSetName = 'File')] [string] $FilePath,
        [parameter(ParameterSetName = 'AsObject')][switch] $AsObject,
        [parameter(ParameterSetName = 'AsJson')][switch] $AsJson,

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
            "Other Account Logon Events",
            "Kerberos Authentication Service",
            "Credential Validation"
        )][alias('Policies')][string] $Policy
    )
    if ($Policy) {
        $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName -Policy $Policy
    } else {
        $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName
    }
    if ($FilePath) {
        $AuditPolicy | ConvertTo-JsonLiteral -Depth 5 | Out-File -LiteralPath $FilePath
    } elseif ($AsObject) {
        $AuditPolicy
    } else {
        $AuditPolicy | ConvertTo-JsonLiteral -Depth 5
    }
}