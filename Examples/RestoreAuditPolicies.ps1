Clear-Host
Import-Module .\AuditPolicy.psd1 -Force


$FilePath = "$PSScriptRoot\Backups\AuditPolicy.json"

Restore-SystemAuditPolicy -FilePath $FilePath #-WhatIf -Verbose