param(
  [Parameter(Mandatory = $true)]
  [string]$Message,
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $repo

$allowedRoots = @(
  'index.html', 'portal-proveedores/', 'assets/', 'form-config.js',
  'FORMULARIOS.md', 'MAINTENANCE.md', 'productos/', 'scripts/', 'skills/'
)
$protected = @('firma-email-bymtech.html', 'generador-firma.html', 'logo-email.png')

function Is-Allowed([string]$path) {
  foreach ($root in $allowedRoots) {
    if ($path -eq $root.TrimEnd('/') -or $path.StartsWith($root)) { return $true }
  }
  return $false
}

$changes = @(git status --porcelain=v1)
$deployPaths = @()
foreach ($line in $changes) {
  if ($line.Length -lt 4) { continue }
  $path = $line.Substring(3).Trim('"') -replace '\\', '/'
  if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1] }
  if ($protected -contains $path) { continue }
  if (Is-Allowed $path) { $deployPaths += $path }
}
$deployPaths = @($deployPaths | Sort-Object -Unique)
if ($deployPaths.Count -eq 0) { throw 'No hay cambios publicables dentro del alcance seguro.' }

Write-Host 'Archivos incluidos:' -ForegroundColor Cyan
$deployPaths | ForEach-Object { Write-Host "  $_" }
Write-Host 'Archivos de firma protegidos y excluidos automáticamente.' -ForegroundColor DarkGray

git diff --check -- @deployPaths

$html = Get-Content -LiteralPath 'index.html' -Raw
$scripts = [regex]::Matches($html, '<script(?![^>]*src=)[^>]*>([\s\S]*?)</script>', 'IgnoreCase')
$checkFile = Join-Path ([System.IO.Path]::GetTempPath()) 'bymtech-inline-check.js'
try {
  ($scripts | ForEach-Object { $_.Groups[1].Value }) -join "`n" | Set-Content -LiteralPath $checkFile -Encoding UTF8
  node --check $checkFile
} finally {
  Remove-Item -LiteralPath $checkFile -ErrorAction SilentlyContinue
}

if ($DryRun) {
  Write-Host 'Validación completa. No se modificó Git ni se publicó.' -ForegroundColor Green
  exit 0
}

git add -- @deployPaths
$staged = @(git diff --cached --name-only)
if ($staged.Count -eq 0) { throw 'No quedaron cambios preparados para publicar.' }
git commit -m $Message
$branch = (git branch --show-current).Trim()
if (-not $branch) { throw 'No se pudo determinar la rama actual.' }
git push origin $branch
git push origin HEAD:main

Write-Host 'Publicado en main. GitHub Pages procesará el nuevo commit.' -ForegroundColor Green
Write-Host 'Sitio: https://bymtech.com.ar/'

