Function Get-RoboItem {
    [CmdletBinding()]

    PARAM (
        # Path to directory
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('FullPath')]
        [String[]]$Path,

        # Specifies the file or files. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.
        [String[]] $Files = '*.*',

        # Includes subdirectories and files.
        [Switch]$Recurse,

        # Get only the top N levels of the source directory tree.
        [Parameter(Mandatory = $False)]
        [Alias('lev', 'Depth')]
        [Int]$Level,

        # Get files in restartable mode.
        [Alias('z')]
        [switch]$RestartMode,

        # Get files in Backup mode.
        [Alias('b')]
        [switch]$BackupMode,

        # Get files in restartable mode. If file access is denied, switches to backup mode.
        [Alias('zb')]
        [switch]$RestartAndBackupMode

    )

    Begin {
    }

    Process {
        try {
            $PSBoundParameters.Remove('Path') | Out-Null

            foreach ($Location in $Path) {
                Invoke-RoboCopy -Source $location -Destination $env:TEMP -List @PSBoundParameters
            }
        }
        catch {
            $PSCmdlet.WriteError($PSitem)
        }
    }

    End {
    }
}