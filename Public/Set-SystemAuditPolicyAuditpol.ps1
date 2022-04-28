function Set-SystemAuditPolicyAuditpol {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][ValidateSet(
            #System
            "Security System Extension",
            "System Integrity",
            "IPsec Driver",
            "Other System Events",
            "Security State Change",
            #Logon/Logoff#
            "Logon",
            "Logoff",
            "Account Lockout",
            "IPsec Main Mode",
            "IPsec Quick Mode",
            "IPsec Extended Mode",
            "Special Logon",
            "Other Logon/Logoff Events",
            "Network Policy Server",
            "User / Device Claims",
            "Group Membership",
            # Object Access#
            "File System",
            "Registry",
            "Kernel Object",
            "SAM",
            "Certification Services",
            "Application Generated",
            "Handle Manipulation",
            "File Share",
            "Filtering Platform Packet Drop",
            "Filtering Platform Connection",
            "Other Object Access Events",
            "Detailed File Share",
            "Removable Storage",
            "Central Policy Staging",
            #Privilege Use#
            "Non Sensitive Privilege Use",
            "Other Privilege Use Events",
            "Sensitive Privilege Use",
            #Detailed Tracking#
            "Process Creation",
            "Process Termination",
            "DPAPI Activity",
            "RPC Events",
            "Plug and Play Events",
            "Token Right Adjusted Events",
            #Policy Change#
            "Audit Policy Change",
            "Authentication Policy Change",
            "Authorization Policy Change",
            "MPSSVC Rule-Level Policy Change",
            "Filtering Platform Policy Change",
            "Other Policy Change Events",
            #Account Management#
            "Computer Account Management",
            "Security Group Management",
            "Distribution Group Management",
            "Application Group Management",
            "Other Account Management Events",
            "User Account Management",
            #DS Access#
            "Directory Service Access",
            "Directory Service Changes",
            "Directory Service Replication",
            "Detailed Directory Service Replication",
            #Account Logon#
            "Kerberos Service Ticket Operations",
            "Kerberos Service Ticket Operations",
            "Other Account Logon Events",
            "Kerberos Authentication Service",
            "Credential Validation"

        )][string[]] $Policies,
        [parameter(Mandatory)][validateSet('NotConfigured', 'Success', 'Failure', 'SuccessAndFailure')][string] $Value
    )
    <#
    $AllPolicies = @(
        #System
        "Security System Extension"               #No Auditing
        "System Integrity"                    #No Auditing
        "IPsec Driver"                           #No Auditing
        "Other System Events"                     #No Auditing
        "Security State Change"                   #No Auditing
        #Logon/Logoff#
        "Logon"                                   #No Auditing
        "Logoff"                                  #No Auditing
        "Account Lockout"                         #No Auditing
        "IPsec Main Mode"                         #No Auditing
        "IPsec Quick Mode"                        #No Auditing
        "IPsec Extended Mode"                     #No Auditing
        "Special Logon"                           #No Auditing
        "Other Logon/Logoff Events"               #No Auditing
        "Network Policy Server"                   #No Auditing
        "User / Device Claims"                    #No Auditing
        "Group Membership"                        #No Auditing
        # Object Access#
        "File System"                             #No Auditing
        "Registry"                                #No Auditing
        "Kernel Object"                          #No Auditing
        "SAM"                                     #No Auditing
        "Certification Services"                  #No Auditing
        "Application Generated"                   #No Auditing
        "Handle Manipulation"                     #No Auditing
        "File Share"                              #No Auditing
        "Filtering Platform Packet Drop"          #No Auditing
        "Filtering Platform Connection"           #No Auditing
        "Other Object Access Events"              #No Auditing
        "Detailed File Share"                     #No Auditing
        "Removable Storage"                       #No Auditing
        "Central Policy Staging"                  #No Auditing
        #Privilege Use#
        "Non Sensitive Privilege Use"             #No Auditing
        "Other Privilege Use Events"              #No Auditing
        "Sensitive Privilege Use"                 #No Auditing
        #Detailed Tracking#
        "Process Creation"                        #No Auditing
        "Process Termination"                     #Success and Failure
        "DPAPI Activity"                          #No Auditing
        "RPC Events"                              #No Auditing
        "Plug and Play Events"                    #No Auditing
        "Token Right Adjusted Events"             #Success and Failure
        #Policy Change#
        "Audit Policy Change"                     #No Auditing
        "Authentication Policy Change"            #No Auditing
        "Authorization Policy Change"             #No Auditing
        "MPSSVC Rule-Level Policy Change"         #No Auditing
        "Filtering Platform Policy Change"        #No Auditing
        "Other Policy Change Events"              #No Auditing
        #Account Management#
        "Computer Account Management"             #No Auditing
        "Security Group Management"               #No Auditing
        "Distribution Group Management"           #No Auditing
        "Application Group Management"           #No Auditing
        "Other Account Management Events"         #No Auditing
        "User Account Management"                 #No Auditing
        #DS Access#
        "Directory Service Access"                #No Auditing
        "Directory Service Changes"               #No Auditing
        "Directory Service Replication"           #No Auditing
        "Detailed Directory Service Replication"  #No Auditing
        #Account Logon#
        "Kerberos Service Ticket Operations"      #No Auditing
        "Kerberos Service Ticket Operations"      #No Auditing
        "Other Account Logon Events"              #No Auditing
        "Kerberos Authentication Service"         #No Auditing
        "Credential Validation"                   #Success and Failure
    )
    #>
    if ($Value -eq 'NotConfigured') {
        $Success = 'disable'
        $Failure = 'disable'
    } elseif ($Value -eq 'Success') {
        $Success = 'enable'
        $Failure = 'disable'
    } elseif ($Value -eq 'Failure') {
        $Success = 'disable'
        $Failure = 'enable'
    } elseif ($Value -eq 'SuccessAndFailure') {
        $Success = 'enable'
        $Failure = 'enable'
    }

    foreach ($Policy in $Policies) {
        if ($PSCmdlet.ShouldProcess("SubCategory $Policy", "Setting $Value (Success: $Success / Failure: $Failure)")) {
            #Write-Verbose -Message "Set-SystemAuditPolicyAuditpol - Executing: auditpol.exe /set /subcategory:$Policy /success:$Success /failure:$Failure"
            auditpol.exe /set /subcategory:$Policy /success:$Success /failure:$Failure
        }
    }
}