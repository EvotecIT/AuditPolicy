#### 0.0.6 - 2022.07.18
- Detection of current settings with support for 2012R2 and earlier versions of Windows.
- Fix for `Set-SystemAuditPolicy` when using LocalSecurityPolicy returning new object on creation of directory
- Fixes setting permissions for remote registry which would not work in earlier versions

#### 0.0.5 - 2022.05.27
- Small fix for LocalSecurityPolicy if folder doesn't exists

#### 0.0.4 - 2022.05.19
- Small fix for enum values

#### 0.0.3 - 2022.05.15
- Added `UseLocalSecurityPolicy` to `Set-SystemAuditPolicy` parameter allowing setting via local policy rather than directly
- Small adjustments to help
- Small fixes to suppress and output when using `Set-SystemAuditPolicy`

#### 0.0.2 - 2022.05.11
- Rewritten cmdlets to be more flexible
- Using policy names the same as in auditpol
- Added a few more cmdlets

#### 0.0.1 - 2022.04.12
- Initial release