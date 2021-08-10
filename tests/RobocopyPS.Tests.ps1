BeforeDiscovery {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module

    $Module = Import-Module $ModulePath -PassThru -ErrorAction Stop
    $commands = Get-Command -Module $module -CommandType Cmdlet, Function  # Not alias

    # Get all Robocopy options without slash
    $RobocopyHelp = Robocopy.exe /?
    $RobocopyOptionsIgnore = "/bytes", "/TEE", "/np", "/njh", "/fp", "/v", "/ndl", "/ts", "/NJS", "ETA"
    $RobocopyOptions = $RobocopyHelp | ForEach-Object { $_ -split ("`r`n") -split (" ") -split ("\[") -split (" :: ") -split (":") -replace ("\s", "") } | ForEach-Object { $_ | Where-Object { $_ -match "^/[A-Z]{1,}\b$|^/[0-9]{1,}\b$" -and $_ -notin $RobocopyOptionsIgnore } } | Sort-Object -Unique | ForEach-Object { $_ -replace ("/", "") }
}

Describe "<command>" -ForEach $commands {
    BeforeAll {
        $command = $_
        $help = Get-Help $command

        $Common = 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutBuffer', 'OutVariable',
        'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable'

        $parameters = $command.ParameterSets.Parameters | Sort-Object -Property Name -Unique | Where-Object Name -notin $common

    }

    Context '<command> parameters and aliases' -Foreach $RobocopyOptions {
        BeforeEach {
        $RobocopyOption = $_
        $allParameterNameAndAlias = $parameters.Name + $parameters.aliases
        $RobocopyOption | Should -BeIn $allParameterNameAndAlias
        }

        It '<RobocopyOption> Shold have a parameter name or alias' {
            $RobocopyOption | Should -BeIn $allParameterNameAndAlias
        }
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
    Context '<command> Parameters' -foreach $parameters {
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