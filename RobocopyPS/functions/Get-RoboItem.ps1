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
        [switch]$RestartAndBackupMode,

        # What unit the sizes are shown as
        [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
        [String]$Unit = 'Auto'
    )

    Begin {
    }

    Process {
        foreach ($Location in $Path) {
            try {
                # Verify that both Source and Destination exists and are a directory
                If (!(Test-Path -path $Location -PathType Container)) {
                    throw "Cannot find path $location because it does not exist."
                }

                Invoke-RoboCopy -Source $location -Destination NULL -List -ErrorAction Stop @PSBoundParameters
            }
            catch {
                $PSCmdlet.WriteError($PSitem)
            }
        }
    }

    End {
    }
}