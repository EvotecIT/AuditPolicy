Import-Module .\AuditPolicy.psd1 -Force

$T = Get-SystemAuditPolicyFromFile
$T['LocalSecurityPolicy'] | Format-Table *

Set-SystemAuditPolicy -Policy 'Account Lockout' -Value SuccessAndFailure -UseLocalSecurityPolicy -WhatIf
Set-SystemAuditPolicy -Policy 'Group Membership' -Value Failure -UseLocalSecurityPolicy

$T = Get-SystemAuditPolicyFromFile
$T['LocalSecurityPolicy'] | Format-Table *