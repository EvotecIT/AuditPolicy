Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

Set-SystemAuditPolicyPermissions -Identity "przemyslaw.klys" -Verbose
Set-SystemAuditPolicyPermissions -Identity "test" -Verbose

Remove-SystemAuditPolicyPermissions -Identity "test" -Verbose
Remove-SystemAuditPolicyPermissions -Identity "przemyslaw.klys" -Verbose -WhatIf