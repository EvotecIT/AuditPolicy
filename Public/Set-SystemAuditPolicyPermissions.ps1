function Set-SystemAuditPolicyPermissions {
    <#
    .SYNOPSIS
    This function will set the audit policy permissions for the specified user or group to FullControl.

    .DESCRIPTION
    This function will set the audit policy permissions for the specified user or group to FullControl.
    By default only SYSTEM account has any permission.
    This command can be used to add audit policy permissions for the specified user or group.

    .PARAMETER Identity
    The identity of the user or group to set the audit policy permissions for

    .PARAMETER Permissions
    The permissions to set for the specified user or group. By default FullControl.

    .EXAMPLE
    Set-SystemAuditPolicyPermissions -Identity "przemyslaw.klys" -Verbose -WhatIf

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][string] $Identity,
        [System.Security.AccessControl.RegistryRights] $Permissions = [System.Security.AccessControl.RegistryRights]::FullControl
    )
    try {
        $RegistryKeyControl = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey(
            'SECURITY',
            [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
            [System.Security.AccessControl.RegistryRights]::ChangePermissions
        )
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw
        } else {
            Write-Warning -Message "Set-SystemAuditPolicyPermissions - Opening registry failed $($_.Exception.Message)"
        }
        return
    }

    $AccessControlList = $RegistryKeyControl.GetAccessControl()

    $Account = [System.Security.Principal.NTAccount] $Identity # 'BUILTIN\Administrators'
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]'ContainerInherit,ObjectInherit'
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
    $AccessType = [System.Security.AccessControl.AccessControlType]::Allow

    $AccessRule = [System.Security.AccessControl.RegistryAccessRule]::new(
        $Account,
        $Permissions,
        $InheritanceFlag,
        $PropagationFlag,
        $AccessType
    )
    if ($PSCmdlet.ShouldProcess("Registry HKLM\Security", "Adding 'FullControl' access to $Identity for SECURITY subkey")) {
        try {
            $AccessControlList.AddAccessRule($AccessRule)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning -Message "Set-SystemAuditPolicyPermissions - Adding access rule failed $($_.Exception.Message)"
            }
        }
        $RegistryKeyControl.SetAccessControl($AccessControlList)
    }
}
