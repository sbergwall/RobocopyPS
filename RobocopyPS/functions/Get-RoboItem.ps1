Function Get-RoboItem {
    [CmdletBinding(SupportsShouldProcess = $True)]

    PARAM (
        # Path to directory
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('FullPath')]
        [String[]]$Path,

        # Specifies the file or files. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.
        [String[]]$Files = '*.*',

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

        # Excludes files that match the specified names or paths. Note that FileName can include wildcard characters (* and ?).
        [Parameter(Mandatory = $False)]
        [Alias('xf')]
        [String[]]$ExcludeFileName,

        # Excludes directories that match the specified names and paths.
        [Parameter(Mandatory = $False)]
        [Alias('xd')]
        [String[]]$ExcludeDirectory,

        # Creates multi-threaded copies with N threads. N must be an integer between 1 and 128. Cannot be used with the InterPacketGap and EFSRAW parameters. The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
        [Parameter(Mandatory = $False)]
        [ValidateRange(1, 128)]
        [Alias('MT', 'MultiThread')]
        [int]$Threads,

        # What unit the sizes are shown as
        [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
        [String]$Unit = 'Auto',

        [System.Int64]$Precision = 4
    )

    Begin {
    }

    Process {
        foreach ($Location in $Path) {
            If ($PSCmdlet.ShouldProcess("$location" , 'Get')) {
                try {
                    $PSBoundParameters.Set_Item('Path', $location)
                    Invoke-RoboCopy -Destination NULL -List -ErrorAction Stop @PSBoundParameters
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