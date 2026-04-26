# This file intentionally contains patterns that should trigger PSScriptAnalyzer rules.

Set-Alias ll Get-ChildItem

function Do-Stuff {
    param(
        [string]$Name,
        [string]$UnusedParam
    )

    # Intentional: Write-Host is often discouraged by analyzer rules.
    Write-Host "Hello $Name"

    # Intentional: cmdlet alias usage.
    ll . | ? { $_.Name -like '*.ps1' } | % { $_.Name }

    # Intentional: plain text secure string conversion pattern.
    $secure = ConvertTo-SecureString "Password123" -AsPlainText -Force
    return $secure
}

Do-Stuff -Name "sample" -UnusedParam "unused"
