function Remove-SystemAuditPolicyPermissions {
    <#
    .SYNOPSIS
    Removes audit policy permissions from a user or group.

    .DESCRIPTION
    Removes audit policy permissions from a user or group.
    By default only SYSTEM account has any permissions.
    This command can be used to remove audit policy permissions from a user or group.

    .PARAMETER Identity
    Specifies the user or group to remove audit policy permissions from.

    .PARAMETER Permissions
    Specifies the audit policy permissions to remove. By default FullControl

    .EXAMPLE
    Remove-SystemAuditPolicyPermissions -Identity "przemyslaw.klys" -Verbose -WhatIf

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][string] $Identity,
        [System.Security.AccessControl.RegistryRights] $Permissions = [System.Security.AccessControl.RegistryRights]::FullControl,
        [string] $ComputerName
    )
    try {
        if ($ComputerName) {
            $BaseHive = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LOCAL', $ComputerName, 0 )
            $RegistryKeyControl = $BaseHive.OpenSubKey(
                'SECURITY',
                [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
                [System.Security.AccessControl.RegistryRights]::ChangePermissions
            )
        } else {
            $RegistryKeyControl = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey(
                'SECURITY',
                [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
                [System.Security.AccessControl.RegistryRights]::ChangePermissions
            )
        }
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw
        } else {
            Write-Warning -Message "Remove-SystemAuditPolicyPermissions - Opening registry failed $($_.Exception.Message)"
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
    if ($PSCmdlet.ShouldProcess("Registry HKLM\SECURITY", "Removing 'FullControl' access to $Identity for SECURITY subkey")) {
        try {
            $Output = $AccessControlList.RemoveAccessRule($AccessRule)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                if ($null -ne $BaseHive) {
                    $BaseHive.Close()
                    $BaseHive.Dispose()
                }
                throw
            } else {
                Write-Warning -Message "Remove-SystemAuditPolicyPermissions - Removing access rule failed $($_.Exception.Message)"
            }
        }
        if ($Output) {
            $RegistryKeyControl.SetAccessControl($AccessControlList)
        }
    }
    if ($null -ne $BaseHive) {
        $BaseHive.Close()
        $BaseHive.Dispose()
    }
}
