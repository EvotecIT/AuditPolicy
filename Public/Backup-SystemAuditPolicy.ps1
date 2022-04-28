function Backup-SystemAuditPolicy {
    [cmdletBinding(DefaultParameterSetName = 'File')]
    param(
        [string] $ComputerName,
        [parameter(ParameterSetName = 'File', Mandatory)] [string] $FilePath,
        [parameter(ParameterSetName = 'AsJson')][switch] $AsJson
    )
    $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName
    if ($FilePath) {
        $AuditPolicy | ConvertTo-Json -Depth 5 | Out-File -LiteralPath $FilePath
    }
    if ($AsJson) {
        $AuditPolicy | ConvertTo-Json -Depth 5
    }
}