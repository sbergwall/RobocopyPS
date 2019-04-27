<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>
PARAM (
    $VersionType = 'Patch'
)

task UpdateHelp {
    Import-Module $PSScriptRoot\RobocopyPS -Force
    Update-MarkdownHelp $PSScriptRoot\docs -Force
    New-ExternalHelp -Path $PSScriptRoot\docs -OutputPath .\en-US -Force
}

#region Task to run all Pester tests in folder .\tests
task Test {
    $Result = Invoke-Pester .\tests -PassThru
    if ($Result.FailedCount -gt 0) {
        throw 'Pester tests failed'
    }

}
#endregion

Task UpdateModuleVersion {
    [version]$version = Get-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion'
    $NewVersion = [version] (Step-Version -Version $version -Type $VersionType)

    "  Setting version [$NewVersion]"
    Update-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion' -Value $NewVersion

    (Get-Content -Path $env:BHPSModuleManifest -Raw -Encoding UTF8) |
    ForEach-Object { $_.TrimEnd() } |
    Set-Content -Path $env:BHPSModuleManifest -Encoding UTF8
}