<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>
PARAM (
    $VersionType = 'Patch',
    $m,
    $branch = 'dev'
)

task UpdateHelp {
    "Import Module $PSScriptRoot\RobocopyPS"
    Import-Module $PSScriptRoot\RobocopyPS -Force
    Update-MarkdownHelpModule -Path $PSScriptRoot\docs
    New-ExternalHelp -Path $PSScriptRoot\docs -OutputPath .\RobocopyPS\en-US -Force
}

#region Task to run all Pester tests in folder .\tests
task Test {
    $Result = Invoke-Pester .\tests -PassThru -Output Normal
    if ($Result.FailedCount -gt 0) {
        throw 'Pester tests failed'
    }
}

task TestComp {
    $result = Invoke-ScriptAnalyzer -Path .\RobocopyPS\* -Settings .\tests\CompabilitySettings.psd1 -Severity Warning
    If ($result.count -gt 0) {
        $result | Format-Table -AutoSize
        throw 'Invoke-ScriptAnalyzer tests failed'
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

Task push UpdateHelp, Test, TestComp,{
    git add .
    git commit -a -m $m
    git push origin $branch
}