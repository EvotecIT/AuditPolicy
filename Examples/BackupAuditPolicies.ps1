Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

Backup-SystemAuditPolicy -AsJson | Out-File -FilePath $PSScriptRoot\Backups\AuditPolicy.json