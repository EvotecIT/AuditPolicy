Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

$AuditPolicies = Get-SystemAuditPolicy -Categories
$AuditPolicies | Format-Table
$AuditPolicies.AccountLogon | Format-Table
$AuditPolicies.AccountManagement | Format-Table
$AuditPolicies.DetailedTracking | Format-Table
$AuditPolicies.DSAccess | Format-Table
$AuditPolicies.LogonLogoff | Format-Table
$AuditPolicies.ObjectAccess | Format-Table
$AuditPolicies.PolicyChange | Format-Table
$AuditPolicies.PrivilegeUse | Format-Table
$AuditPolicies.System | Format-Table

# In single level

$AuditPolicies = Get-SystemAuditPolicy
$AuditPolicies | Format-List