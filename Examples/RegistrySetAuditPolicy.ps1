Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

$WhatIf = $false

Set-SystemAuditPolicy -AccountLogon KerberosServiceTicketOperations -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountLogon OtherAccountLogonEvents -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountLogon KerberosAuthenticationService -Value SuccessAndFailure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountLogon CredentialValidation -Value Success -Verbose -WhatIf:$WhatIf

Set-SystemAuditPolicy -AccountManagement ComputerAccountManagement -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement ApplicationGroupManagement -Value Success -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement DistributionGroupManagement -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement OtherAccountManagementEvents -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement SecurityGroupManagement -Value Failure -Verbose -WhatIf:$WhatIf
Set-SystemAuditPolicy -AccountManagement UserAccountManagement -Value Failure -Verbose -WhatIf:$WhatIf