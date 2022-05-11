Clear-Host
Import-Module .\AuditPolicy.psd1 -Force


$FilePath = "$PSScriptRoot\Backups\AuditPolicy.json"

Restore-SystemAuditPolicy -FilePath $FilePath -Verbose -WhatIf
Restore-SystemAuditPolicy -FilePath $FilePath -Verbose -Policy 'Application Group Management' -WhatIf

$System = Get-SystemAuditPolicy
Restore-SystemAuditPolicy -Object $System -Verbose -WhatIf