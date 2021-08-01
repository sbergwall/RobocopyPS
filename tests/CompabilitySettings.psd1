@{
    Rules = @{
        PSUseCompatibleCommands = @{
            # Turns the rule on
            Enable = $true

            # Lists the PowerShell platforms we want to check compatibility with
            TargetProfiles = @(

                'win-8_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework',  # Windows Server 2019 5.1
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'  # Windows 10 5.1
            )
        }
        PSUseCompatibleSyntax = @{
            # This turns the rule on (setting it to false will turn it off)
            Enable = $true

            # Simply list the targeted versions of PowerShell here
            TargetVersions = @(
                '5.1',
                '6.2',
                '7.1'
            )
        }
    }
}