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

        # Creates multi-threaded copies with N threads. N must be an integer between 1 and 128. Cannot be used with the InterPacketGap and EFSRAW parameters. The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
        [Parameter(Mandatory = $False)]
        [ValidateRange(1, 128)]
        [Alias('MT', 'MultiThread')]
        [int]$Threads,

        <#Retry Options#>

        # Specifies the number of retries on failed copies. Default is 3.
        [Alias('r')]
        [int]$Retry = 3,

        # Specifies the wait time between retries, in seconds. The default value of N is 3.
        [Alias('w')]
        [int]$Wait = 3

    )

    Begin {}

    Process {
        foreach ($Location in $Path) {
            If ($PSCmdlet.ShouldProcess("$Location" , 'Remove')) {

                # Because we are using -Destination in Invoke-RoboCopy, and no validation to check if the Destination directory
                # actually exists we need to create the validation here instead

                If (!(Test-Path -Path $Location -PathType Container)) {
                    $Exception = [Exception]::new("Cannot find directory $Location because it does not exist.")
                    $TargetObject = $Location
                    $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                        $Exception,
                        'errorID',
                        [System.Management.Automation.ErrorCategory]::NotSpecified,
                        $TargetObject
                    )
                    $PSCmdlet.WriteError($ErrorRecord)
                    Continue
                }

                try {
                    $tempDirectory = New-Item -Path $env:temp -Name (New-Guid).Guid -ItemType Directory -ErrorAction Stop
                    $PSBoundParameters.Set_Item('Path', $tempDirectory)

                    Invoke-RoboCopy -Destination $Location -Mirror @PSBoundParameters
                    Get-Item -Path $Location | ForEach-Object {$_.Delete()}
                }
                catch {
                    $PSCmdlet.WriteError($PSitem)
                }
                finally {
                    Get-Item -Path $tempDirectory | ForEach-Object {$_.Delete()}
                }
            } # end WhatIf
        } #end foreach
    }

    End {}
}