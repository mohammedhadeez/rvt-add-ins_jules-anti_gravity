param([string]$version)

# The configuration name in csproj is "Release 2024" or "Release 2020" (with space)
# Standard .NET SDK output is bin/Configuration/TargetFramework/
# e.g., bin/Release 2024/net48/
$buildConfig = "Release $version"
$sourceDir = ".\bin\$buildConfig\net48\"

# Check if the path exists, if not try without net48 (just in case)
if (!(Test-Path $sourceDir)) {
    $sourceDir = ".\bin\$buildConfig\"
}

if (!(Test-Path $sourceDir)) {
    Write-Error "Could not find build output at $sourceDir. Did you build with -c '$buildConfig'?"
    exit 1
}

$addinDir = "$env:APPDATA\Autodesk\Revit\Addins\$version\"
$pluginSubDir = "$addinDir\RevitAddin\"

# 1. Create directory formation
if (!(Test-Path $pluginSubDir)) { New-Item -ItemType Directory -Path $pluginSubDir -Force }

# 2. Copy DLLs and resources to the subdirectory
# Exclude .addin files from the subdirectory copy to keep it clean
Get-ChildItem -Path $sourceDir -Exclude "*.addin" | Copy-Item -Destination $pluginSubDir -Force -Recurse

# 3. Copy .addin manifest to the ROOT Addins folder (Required for Revit to find it)
# We assume the .addin file is in the build output. If not, we might need to copy it from source.
# Let's check source if not in build output.
$addinFile = Get-ChildItem -Path $sourceDir -Filter "*.addin" | Select-Object -First 1

if ($null -eq $addinFile) {
    # Fallback: Look in the Shared source folder
    $sourceAddin = ".\src\RevitAddin.Shared\RevitAddin.addin"
    if (Test-Path $sourceAddin) {
        Copy-Item -Path $sourceAddin -Destination "$addinDir\RevitAddin.addin" -Force
        Write-Host "Deployed manifest from source."
    } else {
        Write-Warning "No .addin manifest found in build output or source!"
    }
} else {
    Copy-Item -Path $addinFile.FullName -Destination $addinDir -Force
    Write-Host "Deployed manifest from build output."
}

# 4. Unblock files for Windows 11 Security
Get-ChildItem -Path $pluginSubDir -Recurse | Unblock-File
Get-ChildItem -Path "$addinDir\*.addin" | Unblock-File

Write-Host "Deployment for Revit $version complete." -ForegroundColor Cyan
Write-Host "Manifest located at: $addinDir"
Write-Host "Binaries located at: $pluginSubDir"
