Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

$WhatIf = $false

$Policies = Get-SystemAuditPolicy
foreach ($Policy in $Policies.Keys) {
    Set-SystemAuditPolicy -Policies $Policy -Value SuccessAndFailure -Verbose -WhatIf:$WhatIf
}