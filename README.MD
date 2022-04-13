# AuditPolicy - PowerShell Module

<p align="center">
  <a href="https://dev.azure.com/evotecpl/AuditPolicy/_build/latest?definitionId=3"><img src="https://img.shields.io/azure-devops/build/evotecpl/a5ce5d3e-9ae2-49a0-9905-53eb41205fc9/7?label=Azure%20Pipelines&style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/AuditPolicy"><img src="https://img.shields.io/powershellgallery/v/AuditPolicy.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/AuditPolicy"><img src="https://img.shields.io/powershellgallery/vpre/AuditPolicy.svg?label=powershell%20gallery%20preview&colorB=yellow&style=flat-square"></a>
  <a href="https://github.com/EvotecIT/AuditPolicy"><img src="https://img.shields.io/github/license/EvotecIT/AuditPolicy.svg?style=flat-square"></a>

</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/AuditPolicy"><img src="https://img.shields.io/powershellgallery/p/AuditPolicy.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/AuditPolicy"><img src="https://img.shields.io/github/languages/top/evotecit/AuditPolicy.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/AuditPolicy"><img src="https://img.shields.io/github/languages/code-size/evotecit/AuditPolicy.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/AuditPolicy"><img src="https://img.shields.io/powershellgallery/dt/AuditPolicy.svg?style=flat-square"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=flat-square"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg?style=flat-square"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn&style=flat-square"></a>
</p>

## Supported Systems

This module was tested using Windows PowerShell 5.1 on:
- Windows 11
- Windows 2016

It should work correctly on Windows 2019, Windows 2022, and Windows 10.
I belive it should work on Windows 2012+ but that requires confirmation.
For Windows 2008 the registry information may not be the same, so probably won't work correctly.
As it's already not supported by Microsoft there's no need to investigate this.

### Installing

```powershell
Install-Module -Name AuditPolicy -AllowClobber -Force
```

Force and AllowClobber aren't necessary but they do skip errors in case some appear.

### Updating

```powershell
Update-Module -Name AuditPolicy
```

That's it. Whenever there's a new version you simply run the command and you can enjoy it. Remember, that you may need to close, reopen the PowerShell session if you have already used the module before updating it.

**The important thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update will break your code. For example, small rename to a parameter and your code stops working! Be responsible!