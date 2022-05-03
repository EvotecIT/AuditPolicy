Clear-Host
Import-Module .\AuditPolicy.psd1 -Force

Backup-SystemAuditPolicy | Out-File -FilePath $PSScriptRoot\Backups\AuditPolicy.json