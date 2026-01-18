param([string]$version)

$sourceDir = ".\bin\Release\$version\"
$targetDir = "$env:APPDATA\Autodesk\Revit\Addins\$version\RevitAddin\"
$manifestPath = "$env:APPDATA\Autodesk\Revit\Addins\$version\RevitAddin.addin"

# 1. Create directory formation
if (!(Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force }

# 2. Copy DLLs and unblock for Windows 11 Security
# Note: In a real CI/CD or build script, we might not want to rely on APPDATA, but this is per instructions.
Copy-Item -Path "$sourceDir\*" -Destination $targetDir -Force
Get-ChildItem -Path $targetDir -Recurse | Unblock-File

Write-Host "Deployment for Revit $version complete." -ForegroundColor Cyan
