function Get-SystemAuditPolicyFromFile {
    [cmdletBinding()]
    param(

    )
    $Output = [ordered] @{}

    $GPOPath = [io.path]::Combine($Env:SystemRoot, "System32", "GroupPolicy", 'DataStore')

    $GPOWithAudit = Get-ChildItem -LiteralPath $GPOPath -Filter "Audit.csv" -Recurse -Force
    if ($GPOWithAudit) {
        foreach ($File in $GPOWithAudit) {

            #Regex pattern to compare two strings
            $pattern = "Policies\\(.*?)\\Machine\\"

            #Perform the opperation
            $GUID = [regex]::Match($File.FullName, $pattern).Groups[1].Value
            if ($GUID) {
                $Output[$GUID] = Get-Content -LiteralPath $File.FullName -Raw | ConvertFrom-Csv
            }
        }
    }
    $LocalSecurityPolicy = [io.path]::Combine($Env:SystemRoot, "System32", "GroupPolicy", "Machine", "Microsoft", "Windows NT", "Audit", 'Audit.csv')
    if (Test-Path -LiteralPath $LocalSecurityPolicy) {
        $Output["LocalSecurityPolicy"] = Get-Content -LiteralPath $LocalSecurityPolicy -Raw | ConvertFrom-Csv
    }
    $Output
}
