BeforeDiscovery {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module
    Import-Module $ModulePath -PassThru -ErrorAction Stop
}
Describe "when parsing robocopy output" {
    InModuleScope $ModuleName {
        It "should not raise exception when parsing fails" -ForEach @(
            @{ line = '	  		New File	  		     4924 1988/10/11 13:40:54	C:\Source\New-Credential2.ps1'; source='C:\Source'; destination='C:\Temp';Status='New File' }
            @{ line = '	  		Newer	  		     82424 2022/01/01 23:40:54	C:\Source\New-Credential2.ps1'; source='C:\Source'; destination='C:\Temp';Status='Newer' }
            @{ line = '	  		*EXTRA File	  		     42804 2022/10/11 03:40:54	C:\Temp\New-Credential2.ps1'; source='C:\Source'; destination='C:\Temp';Status='*EXTRA File' }
            @{ line = '	  			  		     42804 2022/10/11 03:40:54	C:\Temp\New-Credential2.ps1'; source='C:\Source'; destination='C:\Temp';Status='' }
        ) {

            { $parsed = Invoke-RobocopyParser -InputObject $line } | Should -Not -Throw
            $parsed = Invoke-RobocopyParser -InputObject $line
            #Write-Warning "$($parsed | ConvertTo-Json)" # Commented out this block as it just write to the host, but I'll keep it as a comment if needed further down the line
            $parsed[0].Status | Should -Be $Status
        }
    }
}



# TBD - Write tests for commented lines
Describe "Parsing Robocopy Speed output" {
    InModuleScope $ModuleName {
        It 'Should parse speed information from native Robocopy' -ForEach @(
            @{ line = '   Speed :           22,361,666 Bytes/sec.'; Out = '22361666 B/s' }
            #@{ line = '   Speed :           22,361 Bytes/sec.' }
            #@{ line = '   Speed :             8385625 Bytes/sec.' }
            #@{ line = '   Speed :           989 125 Bytes/sec.' }
        ) {
            $Output = Invoke-RobocopyParser -InputObject $line -Unit Bytes
            $Output[0].Speed | Should -Be $Out
        }
    }
}