Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

$SystemPolicies = Get-SystemAuditPolicyFromFile
foreach ($Policy in $SystemPolicies.Keys) {
    $SystemPolicies[$Policy] | Format-Table -AutoSize
}