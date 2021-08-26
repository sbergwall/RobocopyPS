$ModuleName = 'RobocopyPS'

BeforeAll {
    $ModuleName = 'RobocopyPS'
    $ModuleBase = Split-Path -Parent $PSScriptRoot
    $ModulePath = Join-Path $ModuleBase -ChildPath $ModuleName

    # Removes all versions of the module from the session before importing
    Get-Module $ModuleName | Remove-Module
    Import-Module $ModulePath -PassThru -ErrorAction Stop
}


Describe "$ModuleName" {

    $ModuleName = 'RobocopyPS'
    $commands = Get-Command -Module $ModuleName -CommandType Cmdlet, Function  # Not alias

    foreach ($command in $commands) {
        Context "$command" {

            $Help = @{ Help = Get-Help -Name $Command -Full | Select-Object -Property * }

            It "Has Synopsis" -TestCases $Help {
                $Help.Synopsis | Should -Not -BeNullOrEmpty
            }

            It "Has Description" -TestCases $Help {
                $Help.Description | Should -Not -BeNullOrEmpty
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
        It "$Option" -TestCases @{'o' = $Option ; 'all' = $allParameterNameAndAlias} {
            $o | Should -BeIn $all
        }
    }
}