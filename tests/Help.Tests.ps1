$ModuleName = 'RobocopyPS'

BeforeDiscovery {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module
    Import-Module $ModulePath -PassThru -ErrorAction Stop

    $commands = Get-Command -Module $ModuleName -CommandType Cmdlet, Function  # Not alias
}

Describe "$ModuleName" {

    $ModuleName = 'RobocopyPS'
    $commands = Get-Command -Module $ModuleName -CommandType Cmdlet, Function  # Not alias

    foreach ($command in $commands) {
        Context "$command" {

            $Help = @{ Help = Get-Help -Name $Command -Full | Select-Object -Property * }

            It "Has Synopsis and not have synopsis from PlatyPS" -TestCases $Help {
                $Help.Synopsis | Should -Not -BeNullOrEmpty
                $Help.Synopsis | should -Not -BeLike "*{{ Fill in the Synopsis }}*"
            }

            It "Has Description and not have description from PlatyPS" -TestCases $Help {
                $Help.Description | Should -Not -BeNullOrEmpty
                $Help.Description | should -Not -BeLike "*{{ Fill in the Description }}*"
            }

            It "Has Examples and not have examples from PlatyPS" -TestCases $Help {
                $help.Examples.Example | Should -Not -BeNullOrEmpty
                $Help.Examples.Example | should -Not -BeLike "*{{ Add example code here }}*"
            }
        }
    }
}


Describe "Invoke-Robocopy" {

    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module
    Import-Module $ModulePath -PassThru -ErrorAction Stop

    $Command = get-command -Name "Invoke-Robocopy" -Module "RobocopyPS"
    $parameters = $command.ParameterSets.Parameters | Sort-Object -Property Name -Unique
    $allParameterNameAndAlias = $parameters.Name + $parameters.aliases

    # Get all Robocopy options without slash
    $RobocopyHelp = Robocopy.exe /?
    $RobocopyOptionsIgnore = "/bytes", "/TEE", "/np", "/njh", "/fp", "/v", "/ndl", "/ts", "/NJS", "/ETA"
    $RobocopyOptions = $RobocopyHelp | ForEach-Object { $_ -split ("`r`n") -split (" ") -split ("\[") -split (" :: ") -split (":") -replace ("\s", "") } | ForEach-Object { $_ | Where-Object { $_ -match "^/[A-Z]{1,}\b$|^/[0-9]{1,}\b$" -and $_ -notin $RobocopyOptionsIgnore } } | Sort-Object -Unique | ForEach-Object { $_ -replace ("/", "") }

    foreach ($Option in $RobocopyOptions) {
        It "$Option has a parameter or alias" -TestCases @{'o' = $Option ; 'all' = $allParameterNameAndAlias} {
            $o | Should -BeIn $all
        }
    }
}

Describe "$ModuleName" -ForEach $commands {
    BeforeDiscovery {
        $commandName = $_.Name
        $help = Get-Help $_.Name
        $examples = $help.Examples.example
        $parameters = $help.parameters.parameter
    }

    Context "$commandname parameters" -Foreach @{param = $parameters} {
        It "<_.Name> Should not have auto filled description from PlatyPS" -TestCases $param {
            $param.description | should -Not -BeLike "*{{ Fill * Description }}*"
        }
    }
}