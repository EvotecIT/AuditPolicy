function Restore-SystemAuditPolicy {
    [cmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "File")]
    param(
        [string] $ComputerName,
        [parameter(Mandatory, ParameterSetName = 'Object')][string] $Object,
        [parameter(Mandatory, ParameterSetName = 'JSON')][string] $JSON,
        [parameter(Mandatory, ParameterSetName = 'File')][string] $FilePath
    )

    if ($PSBoundParameters.ContainsKey('FilePath')) {
        if ($FilePath -and (Test-Path -LiteralPath $FilePath)) {
            try {
                $FileContent = Get-Content -LiteralPath $FilePath -Raw -ErrorAction Stop
                $SystemPolicies = $FileContent | ConvertFrom-Json -ErrorAction Stop
            } catch {
                Write-Warning -Message "Restore-SystemAuditPolicy - JSON $JSON is not valid. Restore aborted. Error: $($_.Exception.Message)"
            }
        } else {
            Write-Warning -Message "Restore-SystemAuditPolicy - File $FilePath not found. Restore aborted."
        }
    } elseif ($PSBoundParameters.ContainsKey('Object')) {
        $SystemPolicies = $Object
    } elseif ($PSBoundParameters.ContainsKey('JSON')) {
        try {
            $SystemPolicies = $JSON | ConvertFrom-Json -ErrorAction Stop
        } catch {
            Write-Warning -Message "Restore-SystemAuditPolicy - JSON $JSON is not valid. Restore aborted. Error: $($_.Exception.Message)"
            return
        }
    } else {
        Write-Warning -Message "Restore-SystemAuditPolicy - No file or object specified. Restore aborted."
        return
    }


    if ($SystemPolicies) {
        $AuditPolicy = Get-SystemAuditPolicy -ComputerName $ComputerName
        if ($AuditPolicy) {
            if ($SystemPolicies.GetType().Name -eq 'PSCustomObject') {
                foreach ($Policy in $SystemPolicies.PSObject.Properties.Name) {
                    $SubPolicies = $SystemPolicies.$Policy
                    foreach ($Sub in $SubPolicies.PSObject.Properties.Name) {
                        $Value = [AuditPolicies.Events] $SystemPolicies.$Policy.$Sub
                        if ($Value -ne $AuditPolicy[$Policy][$Sub]) {
                            Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $Policy \ $Sub is $($AuditPolicy[$Policy][$Sub]) to be replaced with $Value"
                            $setSystemAuditPolicySplat = @{
                                "$Policy"    = $Sub
                                ComputerName = $ComputerName
                                WhatIf       = $WhatIfPreference
                                Value        = $Value
                            }
                            $Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                            if ($Success.PSError -eq $false -and $Success.PSConnection -eq $true) {

                            } else {
                                if ($Success.PSErrorMessage -eq "WhatIf used - skipping registry setting") {

                                } else {
                                    Write-Warning -Message "Restore-SystemAuditPolicies - Failed to set $Policy \ $Sub. Error: $($Success.PSErrorMessage)"
                                }
                            }
                        } else {
                            #Write-Verbose -Message "Restore-SystemAuditPolicies - Current value for $Policy \ $Sub is $($AuditPolicy[$Policy][$Sub]) is the same as requested $Value"
                        }
                    }
                }
            }
            foreach ($Policy in $SystemPolicies.Keys) {
                $SubPolicies = $SystemPolicies[$Policy]
                foreach ($Sub in $SubPolicies.Keys) {
                    if ($SubPolicies[$Sub] -ne 'NotConfigured') {
                        $setSystemAuditPolicySplat = @{
                            "$Policy"    = $Sub
                            ComputerName = $ComputerName
                            WhatIf       = $WhatIfPreference
                            Value        = 'NotConfigured'
                        }
                        #$Success = Set-SystemAuditPolicy @setSystemAuditPolicySplat
                        if ($Success.PSError -eq $false -and $Success.PSConnection -eq $true) {

                        } else {
                            Write-Warning -Message " Clear-SystemAuditPolicy - Failed to clear $Policy\$Sub. Error: $($Success.PSErrorMessage)"
                        }
                    }
                }
            }
        }
    }
}