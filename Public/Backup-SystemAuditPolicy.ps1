function Backup-SystemAuditPolicy {
    <#
    .SYNOPSIS
    Backups the current system audit policy to a file or json

    .DESCRIPTION
    Backups the current system audit policy to a file or json

    .PARAMETER ComputerName
    ComputerName for remote system to read audit policy from. Requires permissions on the destination.

    .PARAMETER FilePath
    FilePath to write the audit policy to. If not given will be returned as JSON

    .EXAMPLE
    Backup-SystemAuditPolicy | Out-File -FilePath $PSScriptRoot\Backups\AuditPolicy.json

    .NOTES
    General notes
    #>
    [cmdletBinding(DefaultParameterSetName = 'File')]
    param(
        [string] $ComputerName,
        [parameter()] [string] $FilePath
    )
    $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName
    if ($FilePath) {
        $AuditPolicy | ConvertTo-Json -Depth 5 | Out-File -LiteralPath $FilePath
    } else {
        $AuditPolicy | ConvertTo-Json -Depth 5
    }
}