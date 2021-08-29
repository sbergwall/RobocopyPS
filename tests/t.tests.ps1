BeforeDiscovery {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module
    Import-Module $ModulePath -PassThru -ErrorAction Stop

    $commands = Get-Command -Module $ModuleName -CommandType Cmdlet, Function  # Not alias
}

Describe "$ModuleName" -ForEach $commands {
    BeforeDiscovery {
        $commandName = $_.Name
        $help = Get-Help $_.Name
        $examples = $help.Examples.example
        $parameters = $help.parameters.parameter
    }
    Context "$commandName" -Foreach @{help = $help} {
        It "Should not be auto-generated help" {
            $help.Synopsis | Should -Not -BeLike "*<CommonParameters>*"
        }
    }
    Context "$commandname parameters" -Foreach @{param = $parameters} {
        It "<_.Name> Should not have auto filled description from PlatyPS" -TestCases $param {
            $param.description | should -Not -BeLike "*{{ Fill * Description }}*"
        }
    }
}