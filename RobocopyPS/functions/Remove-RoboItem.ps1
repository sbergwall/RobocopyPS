Function Remove-RoboItem {
    [CmdletBinding(SupportsShouldProcess = $True)]

    PARAM (
        # Path to directory
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('FullPath')]
        [String[]]$Path,

        # Remove files in restartable mode.
        [Alias('z')]
        [switch]$RestartMode,

        # Remove files in Backup mode.
        [Alias('b')]
        [switch]$BackupMode,

        # Remove files in restartable mode. If file access is denied, switches to backup mode.
        [Alias('zb')]
        [switch]$RestartAndBackupMode,

        <#Retry Options#>

        # Specifies the number of retries on failed copies. Default is 3.
        [Alias('r')]
        [int]$Retry = 3,

        # Specifies the wait time between retries, in seconds. The default value of N is 3.
        [Alias('w')]
        [int]$Wait = 3

    )

    Begin {
    }

    Process {
        foreach ($Location in $Path) {
            If ($PSCmdlet.ShouldProcess("$Location" , "Remove")) {
                try {
                    # Verify that both Source and Destination exists and are a directory
                    If (!(Test-Path -path $Location -PathType Container)) {
                        throw "Cannot find path $location because it does not exist."
                    }

                    $tempDirectory = New-Item -Path $env:temp -Name (New-Guid).Guid -ItemType Directory -ErrorAction Stop
                    Invoke-RoboCopy -Source $tempDirectory -Destination $Location -Mirror -ErrorAction Stop @PSBoundParameters
                    Remove-Item -Path $tempDirectory, $Location -ErrorAction Stop
                }
                catch {
                    $PSCmdlet.WriteError($PSitem)
                }

            }
        }
    }

    End {
    }
}