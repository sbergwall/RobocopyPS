BeforeDiscovery {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module

    $Module = Import-Module $ModulePath -PassThru -ErrorAction Stop
    $commands = Get-Command -Module $module -CommandType Cmdlet, Function  # Not alias
}

Describe "<command>" -ForEach $commands {
    BeforeAll {
        $command = $_
        $help = Get-Help $command

        $Common = 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutBuffer', 'OutVariable',
        'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable'

        $parameters = $command.ParameterSets.Parameters | Sort-Object -Property Name -Unique | Where-Object Name -notin $common
    }

    Context '<command> Help' {
        It '<command> Help Synopsis is not null' {
            $help.Synopsis | Should -Not -BeNullOrEmpty
        }
        It '<command> Help Description is not null' {
            $help.Description.Text | Should -Not -BeNullOrEmpty
        }
        It '<command> Help Example is not null' {
            ($Help.Examples.Example | Select-Object -First 1).Code | Should -Not -BeNullOrEmpty
        }
        It '<command> Help Example Remarks is not null' {
            ($Help.Examples.Example.Remarks | Select-Object -First 1).Text | Should -Not -BeNullOrEmpty
        }
    }

    Context '<command> Parameters' -Foreach $parameters {
        BeforeEach {
            $parameter = $_
            $parameterName = $parameter.Name
            $parameterHelp = $Help.parameters.parameter | Where-Object Name -EQ $parameterName
            $HelpParameterNames = $Help.Parameters.Parameter.Name | Sort-Object -Unique
        }
        It '<parameter> Help Description should exist' {
            $parameterHelpDescription = $($parameterHelp.Description.Text)
            $parameterHelpDescription | Should -Not -BeNullOrEmpty
        }
        It 'help for <parameter> has correct Mandatory value' {
            $codeMandatory = $parameter.IsMandatory.toString()
            $parameterHelp.Required | Should -Be $codeMandatory
        }
        It 'help for <command> has correct parameter type for <parameterName>' {
            $codeType = $parameter.ParameterType.Name
            # To avoid calling Trim method on a null object.
            $helpType = if ($parameterHelp.parameterValue) {$parameterHelp.parameterValue.Trim()}
            $helpType | Should -be $codeType
        }
    }
}