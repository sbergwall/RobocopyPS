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
                    $tempDirectory = New-Item -Path $env:temp -Name (New-Guid).Guid -ItemType Directory
                    Invoke-RoboCopy -Source $tempDirectory -Destination $Location -Mirror @PSBoundParameters
                    Remove-Item -Path $tempDirectory
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