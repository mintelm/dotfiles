# Installs all .ttf files from -Src for the current Windows user (no admin
# needed): copies them to the per-user font dir and registers them in HKCU.
# Called by maple-font.sh on WSL. Compatible with Windows PowerShell 5.1.
param([Parameter(Mandatory = $true)][string]$Src)

$dir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
$reg = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
New-Item -ItemType Directory -Force -Path $dir | Out-Null

$failed = 0
foreach ($font in Get-ChildItem -Path $Src -Filter *.ttf) {
    $dest = Join-Path $dir $font.Name
    try {
        Copy-Item -Path $font.FullName -Destination $dest -Force -ErrorAction Stop
        New-ItemProperty -Path $reg -Name "$($font.BaseName) (TrueType)" -Value $dest `
            -PropertyType String -Force | Out-Null
    } catch {
        Write-Warning "Could not install $($font.Name): $($_.Exception.Message)"
        $failed++
    }
}

if ($failed) {
    Write-Warning "$failed font(s) failed, probably in use. Close apps using the font (e.g. Windows Terminal) and run again from another terminal."
    exit 1
}
