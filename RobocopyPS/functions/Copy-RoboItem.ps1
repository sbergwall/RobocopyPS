<#
.Synopsis
   Copy files using Robocopy.
.DESCRIPTION
   Function for moving file and folders with Robocopy.
.EXAMPLE
    Copy-RoboItem -Source E:\Logs\ -Destination D:\LogArchive\ -Files *logs*.*

    Source              : E:\Logs\
    Destination         : D:\LogArchive\
    Command             : Robocopy.exe "E:\Logs" "D:\LogArchive" *logs*.* /r:3 /w:3 /e /bytes /TEE /np /njh /fp /v /ndl /ts
    DirCount            : 389
    FileCount           : 20
    DirCopied           : 388
    FileCopied          : 17
    DirIgnored          : 1
    FileIgnored         : 3
    DirMismatched       : 0
    FileMismatched      : 0
    DirFailed           : 0
    FileFailed          : 0
    DirExtra            : 47
    FileExtra           : 3
    TotalTime           : 00:00:56
    StartedTime         : 2019-05-19 11:46:12
    EndedTime           : 2019-05-19 11:47:08
    TotalSize           : 5,5 GB
    TotalSizeCopied     : 4,3 GB
    TotalSizeIgnored    : 1,1 GB
    TotalSizeMismatched : 0 B
    TotalSizeFailed     : 0 B
    TotalSizeExtra      : 2,4 GB
    Speed               : 81,9 MB/s
    ExitCode            : 3
    Success             : True
    LastExitCodeMessage : [SUCCESS]Some files were copied. Additional files were present. No failure was encountered.
.EXAMPLE
    Copy-RoboItem -Source E:\Logs\ -Destination D:\LogArchive\
.NOTES
   This function uses Robocopy.exe as its primary tool for copying files and folders.
#>
function Copy-RoboItem {
    
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium',
        DefaultParameterSetName = 'Level')]


        Param (

            # Specifies the path to the source directory. Must be a folder.
            [Parameter( Mandatory = $True,
                ValueFromPipelineByPropertyName,
                ValueFromPipeline)]
            [Alias('Path')]
            [String]$Source,
    
            # Specifies the path to the destination directory. Must be a folder.
            [Parameter( Mandatory = $True,
                ValueFromPipelineByPropertyName,
                ValueFromPipeline)]
            [Alias('Target')]
            [String]$Destination,

            # Specifies the file or files to be copied. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.
            [Parameter(Mandatory = $False)]
            [String[]] $Files = '*.*',

            # Writes the status output to the log file (overwrites the existing log file).
            [Parameter(Mandatory = $False)]
            [String]$LogFile,
    
            # Copies only the top N levels of the source directory tree.
            [Parameter(Mandatory = $False)]
            [Alias('lev', 'Depth')]
            [Int]$Level,
    
            # Copies files in Backup mode.
            [Alias('b')]
            [switch]$BackupMode,
    
            # Copies files in restartable mode.
            [Alias('z')]
            [switch]$RestartMode,
    
            # Copies all encrypted files in EFS RAW mode.
            [switch]$EFSRaw,
    
            # Specifies the file properties to be copied. The default value for CopyFlags is DAT (data, attributes, and time stamps). D = Data. A = Attributes. T = Time stamps.S = NTFS access control list (ACL). O =Owner information. U = Auditing information
            [Parameter(Mandatory = $False)]
            [Alias('copy')]
            [ValidateSet('D', 'A', 'T', 'S', 'O', 'U')]
            [String[]]$CopyFlags,
    
            # Copies no file information.
            [switch]$NoCopy,
    
            # Fixes file security on all files, even skipped ones.
            [Alias('secfix')]
            [switch]$SecurityFix,
    
            # Fixes file times on all files, even skipped ones.
            [Alias('timfix')]
            [switch]$Timefix,
    
            # Adds the specified attributes to copied files.
            [Parameter(Mandatory = $False)]
            [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
            [String[]]$AddAttribute,
    
            # Removes the specified attributes from copied files.
            [Parameter(Mandatory = $False)]
            [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
            [String[]]$RemoveAttribute,
    
            # Creates destination files by using 8.3 character-length FAT file names only.
            [switch]$FAT,
    
            # Turns off support for very long paths.
            [Alias('256')]
            [switch]$IgnoreLongPath,
    
            # Monitors the source, and runs again when more than N changes are detected.
            [Parameter(Mandatory = $False)]
            [Alias('mon')]
            [Int]$MonitorChanges,
    
            # Monitors source, and runs again in M minutes if changes are detected.
            [Parameter(Mandatory = $False)]
            [Alias('mot')]
            [Int]$MonitorMinutes,
    
            # Creates multi-threaded copies with N threads. N must be an integer between 1 and 128. Cannot be used with the InterPacketGap and EFSRAW parameters. The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
            [Parameter(Mandatory = $False)]
            [Alias('MT')]
            [string]$Threads,
    
            # Specifies run times when new copies may be started.
            [Parameter(Mandatory = $False)]
            [Alias('rh')]
            [ValidatePattern("[0-2]{1}[0-3]{1}[0-5]{1}[0-9]{1}-[0-2]{1}[0-3]{1}[0-5]{1}[0-9]{1}")]
            [String]$RunTimes,
    
            # Checks run times on a per-file (not per-pass) basis.
            [Alias('pf')]
            [switch]$UsePerFileRunTimes,
    
            # Specifies the inter-packet gap to free bandwidth on slow lines.
            [Parameter(Mandatory = $False)]
            [Alias('ipg')]
            [Int]$InterPacketGap,
    
            # Follows the symbolic link and copies the target.
            [Alias('sl')]
            [switch]$SymbolicLink,
    
            # Copies only files for which the Archive attribute is set.
            [Alias('a')]
            [switch]$Archive,
    
            # Copies only files for which the Archive attribute is set, and resets the Archive attribute.
            [Alias('m')]
            [switch]$ResetArchiveAttribute,
    
            # Includes only files for which any of the specified attributes are set.
            [Parameter(Mandatory = $False)]
            [Alias('ia')]
            [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T', 'O')]
            [String[]]$IncludeAttribute,
    
            # Excludes files for which any of the specified attributes are set.
            [Parameter(Mandatory = $False)]
            [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T', 'O')]
            [Alias('xa')]
            [String[]]$ExcludeAttribute,
    
            # Excludes files that match the specified names or paths. Note that FileName can include wildcard characters (* and ?).
            [Parameter(Mandatory = $False)]
            [Alias('xf')]
            [String[]]$ExcludeFileName,
    
            # Excludes directories that match the specified names and paths.
            [Parameter(Mandatory = $False)]
            [Alias('xd')]
            [String[]]$ExcludeDirectory,
    
            # Excludes changed files.
            [Alias('xct')]
            [switch]$ExcludeChangedFiles,
    
            # Excludes newer files.
            [Alias('xn')]
            [switch]$ExcludeNewerFiles,
    
            # Excludes older files.
            [Alias('xo')]
            [switch]$ExcludeOlderFiles,
    
            # Excludes extra files and directories.
            [Alias('xx')]
            [switch]$ExcludeExtraFiles,
    
            # Excludes "lonely" files and directories.
            [Alias('xl')]
            [switch]$ExcludeLonelyFiles,
    
            # Includes the same files.
            [Alias('is')]
            [switch]$IncludeSameFiles,
    
            # Includes "tweaked" files.
            [Alias('it')]
            [switch]$IncludeTweakedFiles,
    
            # Specifies the maximum file size (to exclude files bigger than N bytes).
            [Parameter(Mandatory = $False)]
            [Alias('max')]
            [String]$MaximumFileSize,
    
            # Specifies the minimum file size (to exclude files smaller than N bytes).
            [Parameter(Mandatory = $False)]
            [Alias('min')]
            [String]$MinimumFileSize,
    
            # Specifies the maximum file age (to exclude files older than N days or date).
            [Parameter(Mandatory = $False)]
            [Alias('maxage')]
            [String]$MaximumFileAge,
    
            # Specifies the minimum file age (exclude files newer than N days or date).
            [Parameter(Mandatory = $False)]
            [Alias('minage')]
            [String]$MinimumFileAge,
    
            # Specifies the maximum last access date (excludes files unused since N).
            [Parameter(Mandatory = $False)]
            [Alias('maxlad')]
            [String]$MaximumFileLastAccessDate,
    
            # Specifies the minimum last access date (excludes files used since N) If N is less than 1900, N specifies the number of days. Otherwise, N specifies a date in the format YYYYMMDD.
            [Parameter(Mandatory = $False)]
            [Alias('minlad')]
            [String]$MinimumFileLastAccessDate,
    
            # Excludes junction points, which are normally included by default.
            [Alias('xj')]
            [switch]$ExcludeJunctionPoints,
    
            # Excludes junction points for files.
            [Alias('xjf')]
            [switch]$ExcludeFileJunctionPoints,
    
            # Excludes junction points for directories.
            [Alias('xjd')]
            [switch]$ExcludeDirectoryJunctionPoints,
    
            # Assumes FAT file times (two-second precision).
            [Alias('fft')]
            [switch]$AssumeFATFileTime,
    
            # Compensates for one-hour DST time differences.
            [Alias('dst')]
            [switch]$CompensateDST,
    
            # Specifies the number of retries on failed copies. Default is 3.
            [Alias('r')]
            [int]$Retry = 3,
    
            # Specifies the wait time between retries, in seconds. The default value of N is 3.
            [Alias('w')]
            [int]$Wait = 3,
    
            # Saves the values specified in the /r and /w options as default settings in the registry.
            [Alias('reg')]
            [switch]$SaveRetrySettings,
    
            # Specifies that the system will wait for share names to be defined (retry error 67).
            [Alias('tbd')]
            [switch]$WaitForShareName,
    
            # What unit the sizes are shown as
            [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
            [String]$Unit = 'Auto'
        )

    Begin { }

    Process {
        if ($pscmdlet.ShouldProcess("$Destination from $Source", 'Copy')) {
            try {

                $Item = Get-Item -Path $Source -ErrorAction Stop
                If (($Item).PSIsContainer -eq $false -and !$PSBoundParameters.ContainsKey('Files')) {
                    # If source is a file and -Files parameter isnt specified we do some magic because RoboCopy doesnt like pointing to files without -Files parameter
                    $PSBoundParameters.Add('Files', $Item.Name)
                    $PSBoundParameters.Remove('Source') | Out-Null # Out-null so we supress True or false statement remove the remove method

                    # Add Source back with the directory name and now the file is specified in -Files parameter
                    $PSBoundParameters.Add('Source', $Item.Directory.Fullname)
                    
                    # If level is specified but poiting to a file we ignore it
                    $PSBoundParameters.Remove('Level') | Out-Null
                    $PSBoundParameters.Add('Level', [int]1)
                    $PSBoundParameters.Remove('Recurse') | Out-Null

                }
                elseif (($Item).PSIsContainer -eq $false -and $PSBoundParameters.ContainsKey('Files')) {

                    Write-Warning "Both -Files Parameter and a specific file was pointed to, we will override -Files parameter and only copy file"
                    $PSBoundParameters.Remove('Files') | Out-Null 
                    $PSBoundParameters.Add('Files', $Item.Name)
                    $PSBoundParameters.Remove('Source') | Out-Null # Out-null so we supress True or false statement remove the remove method

                    # Add Source back with the directory name and now the file is specified in -Files parameter
                    $PSBoundParameters.Add('Source', $Item.Directory.Fullname)
                    
                    # If level is specified but poiting to a file we ignore it
                    $PSBoundParameters.Remove('Level') | Out-Null
                    $PSBoundParameters.Add('Level', [int]1)
                    $PSBoundParameters.Remove('Recurse') | Out-Null
                }
                else {
                }

                $PSBoundParameters.Add('IncludeEmptySubDirectories', [bool]$true)
                Start-RoboCopy @PSBoundParameters 
            }
            catch {
                $PSCmdlet.WriteError($PSitem)
            }
        }
    }
    End { }
}