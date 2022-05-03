Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

$WhatIf = $false

Set-SystemAuditPolicy -System 'Security State Change' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -System 'Security State Change' -Value SuccessAndFailure -WhatIf:$WhatIf -UseAuditPol
Set-SystemAuditPolicy -AccountLogon 'Other AccountLogon Events' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountLogon 'Kerberos Authentication Service' -Value SuccessAndFailure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountLogon 'Credential Validation' -Value Success -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'Computer Account Management' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'Application Group Management' -Value Success -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'Distribution Group Management' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'Other AccountManagement Events' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'Security Group Management' -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement 'User Account Management' -Value Failure -Verbose -WhatIf:$WhatIf