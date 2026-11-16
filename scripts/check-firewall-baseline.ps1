#Requires -Version 5.1
<#
.SYNOPSIS
Reads effective firewall state and saves a timestamped JSON assessment locally.
.DESCRIPTION
Assesses only five selected effective-configuration targets. Not a CIS-CAT scan.
No policy, rule, service, network-category, or GPO changes are performed.
The sole persistent change is a new report in an existing output directory.
No hostname, domain, raw rules, gpresult output, or secrets are collected.
.PARAMETER OutputDirectory
An existing writable local directory. Defaults to the current directory.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$OutputDirectory = '.'
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

if ($env:OS -ne 'Windows_NT') {
    throw 'This script requires Windows; no collection performed.'
}

# Require an existing local filesystem directory; do not create directories.
$directory = Get-Item -LiteralPath $OutputDirectory -ErrorAction Stop
if (-not $directory.PSIsContainer -or $directory.PSProvider.Name -ne 'FileSystem') {
    throw 'OutputDirectory must be an existing filesystem directory.'
}
$directoryPath = $directory.FullName
if ($directoryPath.StartsWith('\\')) {
    throw 'Choose a local output directory, not a UNC network path.'
}
$drive = [System.IO.DriveInfo]::new([System.IO.Path]::GetPathRoot($directoryPath))
if ($drive.DriveType -eq [System.IO.DriveType]::Network) {
    throw 'Choose a local output directory, not a mapped network drive.'
}

function Get-SelectedCheckResult {
    param(
        [string]$Id,
        [string]$Profile,
        [string]$Property,
        [string]$Expected,
        [object]$Observed
    )
    $value = [string]$Observed
    $status = if ($value -notin @('True', 'False')) {
        'Review required'
    }
    elseif ($value -eq $Expected) { 'Pass' }
    else { 'Fail' }

    [pscustomobject]@{
        CheckId = $Id
        Profile = $Profile
        Property = $Property
        Expected = $Expected
        Observed = $value
        Result = $status
    }
}

# Select explicit fields; never collect complete rule or policy diagnostics.
$profiles = @(Get-NetFirewallProfile -PolicyStore ActiveStore -ErrorAction Stop |
    Select-Object Name, Enabled, AllowLocalFirewallRules, AllowLocalIPsecRules)
foreach ($name in @('Domain', 'Private', 'Public')) {
    if (@($profiles | Where-Object { $_.Name -eq $name }).Count -ne 1) {
        throw 'Expected one effective profile per Domain, Private, and Public. No report saved.'
    }
}
$domain = $profiles | Where-Object { $_.Name -eq 'Domain' }
$private = $profiles | Where-Object { $_.Name -eq 'Private' }
$public = $profiles | Where-Object { $_.Name -eq 'Public' }
$checks = @(
    Get-SelectedCheckResult '9.1.1' 'Domain' 'Enabled' 'True' $domain.Enabled
    Get-SelectedCheckResult '9.2.1' 'Private' 'Enabled' 'True' $private.Enabled
    Get-SelectedCheckResult '9.3.1' 'Public' 'Enabled' 'True' $public.Enabled
    Get-SelectedCheckResult '9.3.4' 'Public' 'AllowLocalFirewallRules' 'False' $public.AllowLocalFirewallRules
    Get-SelectedCheckResult '9.3.5' 'Public' 'AllowLocalIPsecRules' 'False' $public.AllowLocalIPsecRules
)
$collectedAt = [DateTime]::UtcNow
$report = [pscustomobject]@{
    CollectedAtUtc = $collectedAt.ToString('o')
    Reference = 'CIS Microsoft Windows Server 2022 Benchmark v5.1.0, Level 1 Member Server'
    Scope = 'Five selected effective-configuration validations; not official CIS-CAT results'
    PolicyStore = 'ActiveStore'
    Checks = $checks
}
$fileName = 'firewall-baseline-{0}-{1}.json' -f $collectedAt.ToString('yyyyMMddTHHmmssfffZ'), [Guid]::NewGuid().ToString('N')
$reportPath = Join-Path -Path $directoryPath -ChildPath $fileName
$json = $report | ConvertTo-Json -Depth 5

# CreateNew prevents overwriting an existing file, even on a name collision.
$stream = [System.IO.File]::Open($reportPath, [System.IO.FileMode]::CreateNew,
    [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
try {
    $bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($json + [Environment]::NewLine)
    $stream.Write($bytes, 0, $bytes.Length)
}
finally { $stream.Dispose() }

[pscustomobject]@{
    ReportPath = $reportPath
    CollectedAtUtc = $report.CollectedAtUtc
    Checks = $checks
}
