param(
  [string]$Source = (Join-Path $env:USERPROFILE '.agents\skills\guild-appoint'),
  [string]$SkillsDirectory = (Join-Path $env:USERPROFILE '.dsh\skills')
)
$ErrorActionPreference = 'Stop'
$sourcePath = (Resolve-Path -LiteralPath $Source).Path
if (-not (Test-Path -LiteralPath (Join-Path $sourcePath 'SKILL.md') -PathType Leaf)) { throw 'Source is not a skill directory.' }
$parentPath = [IO.Path]::GetFullPath($SkillsDirectory)
$destination = Join-Path $parentPath 'guild-appoint'
if ($sourcePath -eq $destination -or $sourcePath.StartsWith($destination + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'Source cannot be inside destination.' }
New-Item -ItemType Directory -Force -Path $parentPath | Out-Null
$existing = Get-Item -LiteralPath $destination -Force -ErrorAction SilentlyContinue
if ($existing) {
  $existingTarget = if ($existing.LinkType) { [IO.Path]::GetFullPath([string](@($existing.Target)[0])) } else { '' }
  if ($existing.LinkType -and $existingTarget.Equals($sourcePath, [StringComparison]::OrdinalIgnoreCase)) {
    Write-Output "Already linked: $destination -> $sourcePath"
    return
  }
  # Backup is outside the skills scan directory so it cannot register a duplicate skill.
  $backupRoot = Join-Path (Split-Path $parentPath -Parent) 'skill-backups'
  New-Item -ItemType Directory -Force -Path $backupRoot | Out-Null
  $backup = Join-Path $backupRoot ('guild-appoint-' + [guid]::NewGuid().ToString('N'))
  if ([IO.Path]::GetFullPath($destination) -ne (Join-Path $parentPath 'guild-appoint')) { throw 'Unexpected destination.' }
  Move-Item -LiteralPath $destination -Destination $backup
  Write-Output "Previous installation preserved: $backup"
}
try {
  New-Item -ItemType Junction -Path $destination -Target $sourcePath | Out-Null
} catch {
  if ($backup -and -not (Test-Path -LiteralPath $destination)) { Move-Item -LiteralPath $backup -Destination $destination }
  throw
}
Write-Output "Linked: $destination -> $sourcePath"