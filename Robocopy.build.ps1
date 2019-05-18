<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>
PARAM (
    $VersionType = 'Patch',
    $m
)

task UpdateHelp {
    "Import Module $PSScriptRoot\RobocopyPS"
    Import-Module $PSScriptRoot\RobocopyPS -Force
    New-MarkdownHelp -Module RobocopyPS -OutputFolder .\docs -force
    New-ExternalHelp -Path $PSScriptRoot\docs -OutputPath .\en-US -Force
}

#region Task to run all Pester tests in folder .\tests
task Test {
    $Result = Invoke-Pester .\tests -PassThru
    if ($Result.FailedCount -gt 0) {
        throw 'Pester tests failed'
    }
}

task TestCompability {
    $result = Invoke-ScriptAnalyzer -Path .\RobocopyPS\* -Settings .\tests\CompabilitySettings.psd1 -Severity Warning
    If ($result.count -gt 0) {
        $result | ft -AutoSize
        throw 'Pester tests failed'
    }
}
#endregion

Task UpdateModuleVersion {
    Set-BuildEnvironment -Force

    [version]$version = Get-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion'
    $NewVersion = [version] (Step-Version -Version $version -Type $VersionType)

    "  Setting version [$NewVersion]"
    Update-Metadata -Path $env:BHPSModuleManifest -PropertyName 'ModuleVersion' -Value $NewVersion

    (Get-Content -Path $env:BHPSModuleManifest -Raw -Encoding UTF8) |
    ForEach-Object { $_.TrimEnd() } |
    Set-Content -Path $env:BHPSModuleManifest -Encoding UTF8
}

Task push {
    git add .
    git commit -a -m $m
    git push
}