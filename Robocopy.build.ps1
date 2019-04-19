<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>

param ($Configuration = 'Development')

#region use the most strict mode
#Set-StrictMode -Version 2.0
#endregion

task UpdateHelp {
    Import-Module $PSScriptRoot\RobocopyPS.psd1 -Force
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
