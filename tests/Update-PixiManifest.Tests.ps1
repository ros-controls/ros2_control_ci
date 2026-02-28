Describe "Update-PixiManifestDependencies" {
  BeforeAll {
    $scriptPath = Join-Path $PSScriptRoot "..\scripts\Update-PixiManifest.ps1"
    . $scriptPath
  }

  BeforeEach {
    $tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
    New-Item -ItemType Directory -Path $tempDir | Out-Null
    $manifestPath = Join-Path $tempDir "pixi.toml"
  }

  AfterEach {
    if (Test-Path $tempDir) {
      Remove-Item -Path $tempDir -Recurse -Force
    }
  }

  It "ignores leading whitespace and never inserts an empty dependency key" {
    @"
[project]
name = ""test""

[dependencies]
numpy = ""*""
"@ | Set-Content -Path $manifestPath

    Update-PixiManifestDependencies -ManifestPath $manifestPath -Dependencies " rosinstall_generator"

    $result = Get-Content -Path $manifestPath
    ($result -join "`n") | Should -Match 'rosinstall_generator\s*=\s*"\*"'
    ($result -join "`n") | Should -Not -Match '^\s*=\s*"\*"'
  }

  It "does not duplicate dependencies that already exist" {
    @"
[dependencies]
rosinstall_generator = ""*""
"@ | Set-Content -Path $manifestPath

    Update-PixiManifestDependencies -ManifestPath $manifestPath -Dependencies "rosinstall_generator"

    $matches = Select-String -Path $manifestPath -Pattern '^\s*rosinstall_generator\s*=' -AllMatches
    $matches.Count | Should -Be 1
  }

  It "adds dependencies section if missing" {
    @"
[project]
name = ""test""
"@ | Set-Content -Path $manifestPath

    Update-PixiManifestDependencies -ManifestPath $manifestPath -Dependencies "rosinstall_generator"

    $result = Get-Content -Path $manifestPath
    ($result -join "`n") | Should -Match '\[dependencies\]'
    ($result -join "`n") | Should -Match 'rosinstall_generator\s*=\s*"\*"'
  }

  It "treats regex special characters as literal dependency names" {
    @"
[dependencies]
"@ | Set-Content -Path $manifestPath

    Update-PixiManifestDependencies -ManifestPath $manifestPath -Dependencies "dep+name"
    Update-PixiManifestDependencies -ManifestPath $manifestPath -Dependencies "dep+name"

    $matches = Select-String -Path $manifestPath -Pattern '^\s*dep\+name\s*=' -AllMatches
    $matches.Count | Should -Be 1
  }
}
