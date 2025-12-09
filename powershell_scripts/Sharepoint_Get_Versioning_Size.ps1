# ====== CONFIG (edit these) ======
$SiteUrl     = "https://your_sharepoint.sharepoint.com/sites/Share_name"  # <-- put your site here
$LibraryName = "Insert_library_name_here"                      # default
$ClientId    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"          # Azure App ID xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
$FolderServerRelativeUrl = ""                                  # optional: "/sites/Finance/Documents/SubFolder"
$CsvPath = "C:\temp\history_ver.csv"
$SearchPageSize = 200
# =================================

function Format-Bytes {
    param([long]$Bytes)
    if ($null -eq $Bytes) { return $null }
    if ($Bytes -ge 1TB) { return "{0:N2} TB" -f ($Bytes / 1TB) }
    if ($Bytes -ge 1GB) { return "{0:N2} GB" -f ($Bytes / 1GB) }
    if ($Bytes -ge 1MB) { return "{0:N2} MB" -f ($Bytes / 1MB) }
    if ($Bytes -ge 1KB) { return "{0:N2} KB" -f ($Bytes / 1KB) }
    return "$Bytes B"
}

# Ensure module is present
if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
    throw "PnP.PowerShell is not installed. Run: Install-Module PnP.PowerShell -Scope CurrentUser"
}
Import-Module PnP.PowerShell -ErrorAction Stop

# Connect
Connect-PnPOnline -Url $SiteUrl -Interactive -ClientId $ClientId
Write-Host "Connected to: $SiteUrl" -ForegroundColor Cyan
Write-Host "Library: $LibraryName" -ForegroundColor Cyan

# Get list (safe; does not enumerate items)
$lib = Get-PnPList -Identity $LibraryName
$libId = $lib.Id.Guid

# Enumerate ALL files via list paging (includes audio/video/images; no Search quirks)
Write-Host "Enumerating files via list paging (threshold-safe)..." -ForegroundColor DarkCyan

# FSObjType: 0=file, 1=folder
$allFileRefs = Get-PnPListItem -List $LibraryName -PageSize 2000 -Fields "FileRef","FSObjType" |
    Where-Object { $_["FSObjType"] -eq 0 -and $_["FileRef"] } |
    ForEach-Object { [string]$_["FileRef"] }

Write-Host ("Found {0} files." -f $allFileRefs.Count) -ForegroundColor Green

# Prep CSOM objects
$ctx = Get-PnPContext
$web = Get-PnPWeb

$totalCurrentBytes  = 0L
$totalVersionBytes  = 0L
$totalVersionCount  = 0
$results = New-Object System.Collections.Generic.List[object]

$i = 0
foreach ($fileRef in $allFileRefs) {
    $i++
    $name = [System.IO.Path]::GetFileName($fileRef)

    Write-Progress -Activity "Processing file versions" -Status "$i / $($allFileRefs.Count): $name" `
        -PercentComplete (($i / [Math]::Max(1,$allFileRefs.Count)) * 100)

    try {
        $file = $web.GetFileByServerRelativeUrl($fileRef)

        # Load file and versions
        $ctx.Load($file)
        $ctx.Load($file.Versions)
        $ctx.ExecuteQuery()

        $currentBytes = [long]$file.Length

        $versionBytes = 0L
        $versionCount = 0
        foreach ($v in $file.Versions) {
            $versionBytes += [long]$v.Size
            $versionCount++
        }

        $totalCurrentBytes += $currentBytes
        $totalVersionBytes += $versionBytes
        $totalVersionCount += $versionCount

        $results.Add([pscustomobject]@{
            FileName              = $name
            FileRef               = $fileRef
            CurrentSizeBytes       = $currentBytes
            CurrentSize            = (Format-Bytes $currentBytes)
            VersionCount           = $versionCount
            VersionHistoryBytes    = $versionBytes
            VersionHistorySize     = (Format-Bytes $versionBytes)
            TotalWithVersionsBytes = ($currentBytes + $versionBytes)
            TotalWithVersions      = (Format-Bytes ($currentBytes + $versionBytes))
        })
    }
    catch {
        $results.Add([pscustomobject]@{
            FileName              = $name
            FileRef               = $fileRef
            CurrentSizeBytes       = $null
            CurrentSize            = $null
            VersionCount           = $null
            VersionHistoryBytes    = $null
            VersionHistorySize     = "ERROR: $($_.Exception.Message)"
            TotalWithVersionsBytes = $null
            TotalWithVersions      = $null
        })
    }
}

# Export CSV (largest version history first)
$results | Sort-Object -Property VersionHistoryBytes -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $CsvPath

# Summary
$errCount = ($results | Where-Object { $_.VersionHistorySize -like "ERROR:*" }).Count

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host ("Total current file size:        {0} ({1} bytes)" -f (Format-Bytes $totalCurrentBytes), $totalCurrentBytes)
Write-Host ("Total version history size:     {0} ({1} bytes)" -f (Format-Bytes $totalVersionBytes), $totalVersionBytes)
Write-Host ("Total size incl. versions:      {0} ({1} bytes)" -f (Format-Bytes ($totalCurrentBytes + $totalVersionBytes)), ($totalCurrentBytes + $totalVersionBytes))
Write-Host ("Total number of versions found: {0}" -f $totalVersionCount)
Write-Host ("Files with errors:              {0}" -f $errCount)
Write-Host ("CSV exported to:                {0}" -f (Resolve-Path $CsvPath))
