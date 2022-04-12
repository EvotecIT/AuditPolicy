﻿@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2022 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Module that replaces auditpol.exe with a custom version that can be used to audit or make changes to the Windows Security Policy.'
    FunctionsToExport    = @('Get-SystemAuditPolicies', 'Set-SystemAuditPolicies')
    GUID                 = '14651643-e1f8-4123-9250-9ed210b86963'
    ModuleVersion        = '0.0.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = @('Windows', 'AuditPol', 'Policies', 'Audit')
            ProjectUri = 'https://github.com/EvotecIT/AuditPolicy'
        }
    }
    RequiredModules      = @(@{
            ModuleVersion = '0.0.225'
            ModuleName    = 'PSSharedGoods'
            Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
        })
    RootModule           = 'AuditPolicy.psm1'
}