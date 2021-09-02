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

                # Because we are using -Destination in Invoke-RoboCopy, and no validation to check if the Destination directory
                # actually exists we need to create the validation here instead

                If (!(Test-Path -path $Location -PathType Container)) {
                    $Exception = [Exception]::new("Cannot find directory $Location because it does not exist.")
                    $TargetObject = $Location
                    $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                        $Exception,
                        "errorID",
                        [System.Management.Automation.ErrorCategory]::NotSpecified,
                        $TargetObject
                    )
                    $PSCmdlet.ThrowTerminatingError($ErrorRecord)
                }

                try {
                    $tempDirectory = New-Item -Path $env:temp -Name (New-Guid).Guid -ItemType Directory -ErrorAction Stop
                    Invoke-RoboCopy -Source $tempDirectory -Destination $Location -Mirror -ErrorAction Stop @PSBoundParameters
                    Remove-Item -Path $tempDirectory, $Location -ErrorAction Stop
                }
                catch {
                    $PSCmdlet.WriteError($PSitem)
                }

            } # end WhatIf
        } #end foreach
    }

    End {
    }
}