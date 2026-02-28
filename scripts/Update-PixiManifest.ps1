function Update-PixiManifestDependencies {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ManifestPath,

    [Parameter(Mandatory = $false)]
    [string]$Dependencies = ""
  )

  if (-not [string]::IsNullOrWhiteSpace($Dependencies)) {
    Write-Host "Extra dependencies specified: $Dependencies"

    [string[]]$content = Get-Content $ManifestPath

    $depIndex = $content.IndexOf("[dependencies]")

    if ($depIndex -eq -1) {
      Add-Content $ManifestPath "`n[dependencies]"
      $content = Get-Content $ManifestPath
      $depIndex = $content.IndexOf("[dependencies]")
    }

    $contentList = New-Object 'System.Collections.Generic.List[string]'
    $contentList.AddRange([string[]]$content)

    $insertIndex = $depIndex + 1

    foreach ($dep in $Dependencies.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)) {
      $dep = $dep.Trim()
      if ([string]::IsNullOrWhiteSpace($dep)) {
        continue
      }

      $depPattern = [regex]::Escape($dep)
      if (-not ($contentList -match "^\s*$depPattern\s*=")) {
        $contentList.Insert($insertIndex, "$dep = `"*`"")
        $insertIndex++
      }
    }

    $contentList | Set-Content $ManifestPath
  }
  else {
    Write-Host "No additional dependencies specified."
  }
}
