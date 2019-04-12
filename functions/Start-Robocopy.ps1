Function Start-RoboCopy {

    <#
    .SYNOPSIS
    Start Robocopy with PowerShell

    .DESCRIPTION
    See https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx for an extensive documentation on Robocopy switches

    Some parameters are in use by the function: /bytes /TEE /np /njh /fp /v /ndl 

    .NOTES
    Original script by Keith S. Garner (KeithGa@KeithGa.com) - 6/23/2014
    Originally posted on https://keithga.wordpress.com/2014/06/23/copy-itemwithprogress

    With inspiration by Trevor Sullivan @pcgeek86
    https://stackoverflow.com/a/21209726

    Updated by Ninjigen - 01/08/2018
    https://github.com/Ninjigen/PowerShell/tree/master/Robocopy
    #>

    [CmdletBinding(SupportsShouldProcess)]

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

        # Copies subdirectories. Note that this option excludes empty directories.
        [Parameter(ParameterSetName = 'IncludeSubDirectories')]
        [Alias('s')]
        [switch]$IncludeSubDirectories,

        # Copies subdirectories. Note that this option includes empty directories.
        [Parameter(ParameterSetName = 'IncludeEmptySubDirectories')]
        [Alias('e', 'Recurse')]
        [switch]$IncludeEmptySubDirectories,

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

        # Deletes destination files and directories that no longer exist in the source.
        [switch]$Purge,

        # Mirrors a directory tree
        [Parameter(ParameterSetName = 'Mirror')]
        [Alias('mir', 'Sync')]
        [switch]$Mirror,

        # Moves files, recursively, and deletes them from the source after they are copied. Folders will still be in source directory.
        [Parameter(ParameterSetName = 'MoveFiles')]
        [Alias('mov')]
        [switch]$MoveFiles,

        # Moves files and directories, and deletes them from the source after they are copied.
        [Parameter(ParameterSetName = 'MoveFilesAndDirectories')]
        [Alias('move')]
        [switch]$MoveFilesAndDirectories,

        # Adds the specified attributes to copied files.
        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
        [String[]]$AddAttribute,

        # Removes the specified attributes from copied files.
        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
        [String[]]$RemoveAttribute,

        # Creates a directory tree and zero-length files only.
        [switch]$Create,

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
        [Int]$Threads,

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
        [String]$Unit = 'Auto',

        # Specifies that files are to be listed only (and not copied, deleted, or time stamped).
        [Alias('l')]
        [Switch]$List
    )

    Begin { }

    Process {

        # Remove trailing backslash because Robocopy can sometimes error out when spaces are in path names
        $ModifiedSource = $Source -replace '\\$'
        $ModifiedDestination = $Destination -replace '\\$'

        # We place "" so we can use spaces in path names
        $ModifiedSource = '"' + $ModifiedSource + '"'
        $ModifiedDestination = '"' + $ModifiedDestination + '"'

        # RobocopyArguments are not the final variable that countain all robocopy parameters
        $RobocopyArguments = $ModifiedSource, $ModifiedDestination + $Files

        # We add wait and retry with the default from their parameters, else Robocopy will try a million time before time out
        $RobocopyArguments += '/r:' + $Retry
        $RobocopyArguments += '/w:' + $Wait

        if ($IncludeSubDirectories) { $RobocopyArguments += '/s'; $action = 'Copy' }
        if ($IncludeEmptySubDirectories) { $RobocopyArguments += '/e'; $action = 'Copy' }
        If ($LogFile) { $RobocopyArguments += '/log:' + $LogFile }
        if ($Level) { $RobocopyArguments += '/lev:' + $Level }
        if ($BackupMode) { $RobocopyArguments += '/b' }
        if ($RestartMode) { $RobocopyArguments += '/z' }
        if ($EFSRaw) { $RobocopyArguments += '/efsraw' }
        if ($CopyFlags) { $RobocopyArguments += '/copy:' + (($CopyFlags | Sort-Object -Unique) -join '') }
        if ($NoCopy) { $RobocopyArguments += '/nocopy' }
        if ($SecurityFix) { $RobocopyArguments += '/secfix' }
        if ($Timefix) { $RobocopyArguments += '/timfix' }
        if ($Purge) { $RobocopyArguments += '/purge' ; $action = 'Purge' }
        if ($Mirror) { $RobocopyArguments += '/mir'; $action = 'Mirror' }
        if ($MoveFiles) { $RobocopyArguments += '/mov'; $action = 'Move' }
        if ($MoveFilesAndDirectories) { $RobocopyArguments += '/move' ; $action = 'Move' }
        if ($AddAttribute) { $RobocopyArguments += '/a+:' + (($AddAttribute | Sort-Object-Unique) -join '') }
        if ($RemoveAttribute) { $RobocopyArguments += '/a-:' + (($RemoveAttribute | Sort-Object-Unique) -join '') }
        if ($Create) { $RobocopyArguments += '/create' }
        if ($fat) { $RobocopyArguments += '/fat' }
        if ($IgnoreLongPath) { $RobocopyArguments += '/256' }
        if ($MonitorChanges) { $RobocopyArguments += '/mon:' + $MonitorChanges }
        if ($MonitorMinutes) { $RobocopyArguments += '/mot:' + $MonitorMinutes }
        if ($Threads) { $RobocopyArguments += '/MT:' + $Threads }
        if ($RunTimes) { $RobocopyArguments += '/rh:' + $RunTimes }
        if ($UsePerFileRunTimes) { $RobocopyArguments += '/pf' }
        if ($InterPacketGap) { $RobocopyArguments += '/ipg:' + $InterPacketGap }
        if ($SymbolicLink) { $RobocopyArguments += '/sl' }
        if ($Archive) { $RobocopyArguments += '/a' }
        if ($ResetArchiveAttribute) { $RobocopyArguments += '/m' }
        if ($IncludeAttribute) { $RobocopyArguments += '/ia:' + ($IncludeAttribute | Sort-Object-Unique) -join '' }
        if ($ExcludeAttribute) { $RobocopyArguments += '/xa:' + ($ExcludeAttribute | Sort-Object-Unique) -join '' }
        if ($ExcludeFileName) { $RobocopyArguments += '/xf ' + $ExcludeFileName -join ' ' }
        if ($ExcludeDirectory) { $RobocopyArguments += '/xd ' + $ExcludeDirectory -join ' ' }
        if ($ExcludeChangedFiles) { $RobocopyArguments += '/xct' }
        if ($ExcludeNewerFiles) { $RobocopyArguments += '/xn' }
        if ($ExcludeOlderFiles) { $RobocopyArguments += '/xo' }
        if ($ExcludeExtraFiles) { $RobocopyArguments += '/xx' }
        if ($ExcludeLonelyFiles) { $RobocopyArguments += '/xl' }
        if ($IncludeSameFiles) { $RobocopyArguments += '/is' }
        if ($IncludeTweakedFiles) { $RobocopyArguments += '/it' }
        if ($MaximumFileSize) { $RobocopyArguments += '/max:' + $MaximumFileSize }
        if ($MinimumFileSize) { $RobocopyArguments += '/min:' + $MinimumFileSize }
        if ($MaximumFileAge) { $RobocopyArguments += '/maxage:' + $MaximumFileAge }
        if ($MinimumFileAge) { $RobocopyArguments += '/minage:' + $MinimumFileAge }
        if ($MaximumFileLastAccessDate) { $RobocopyArguments += '/maxlad:' + $MaximumFileLastAccessDate }
        if ($MinimumFileLastAccessDate) { $RobocopyArguments += '/minlad:' + $MinimumFileLastAccessDate }
        if ($ExcludeJunctionPoints) { $RobocopyArguments += '/xj' }
        if ($ExcludeFileJunctionPoints) { $RobocopyArguments += '/xjf' }
        if ($ExcludeDirectoryJunctionPoints) { $RobocopyArguments += '/xjd' }
        if ($AssumeFATFileTime) { $RobocopyArguments += '/fft' }
        if ($CompensateDST) { $RobocopyArguments += '/dst' }
        if ($SaveRetrySettings) { $RobocopyArguments += '/reg' }
        if ($WaitForShareName) { $RobocopyArguments += '/tbd' }
        If ($List) { $RobocopyArguments += '/l' ; $action = 'List' }

        # Reason why ShouldProcess is this far down is because $action is not set before this part 
        If ($PSCmdlet.ShouldProcess("$Destination from $Source" , $action)) {

            # Regex filter used for finding strings we want to handle in Robocopy output
            [regex] $HeaderRegex = '\s+Total\s*Copied\s+Skipped\s+Mismatch\s+FAILED\s+Extras'
            [regex] $DirLineRegex = 'Dirs\s*:\s*(?<DirCount>\d+)(?:\s+\d+){3}\s+(?<DirFailed>\d+)\s+\d+'
            [regex] $FileLineRegex = 'Files\s*:\s*(?<FileCount>\d+)(?:\s+\d+){3}\s+(?<FileFailed>\d+)\s+\d+'
            [regex] $BytesLineRegex = 'Bytes\s*:\s*(?<ByteCount>\d+)(?:\s+\d+){3}\s+(?<BytesFailed>\d+)\s+\d+'
            [regex] $TimeLineRegex = 'Times\s*:\s*(?<TimeElapsed>\d+).*'
            [regex] $EndedLineRegex = 'Ended\s*:\s*(?<EndedTime>.+)'
            [regex] $SpeedLineRegex = 'Speed\s:\s+(\d+)\sBytes\/sec'
            [regex] $JobSummaryEndLineRegex = '[-]{78}'
            [regex] $SpeedInMinutesRegex = 'Speed\s:\s+(\d+).(\d+)\sMegaBytes\/min'

            $StartTime = $(Get-Date)

            # Arguments of the copy command. Fills in the $RoboLog temp file
            $RoboArgs = $RobocopyArguments + "/bytes /TEE /np /njh /fp /v /ndl /ts" -split " "

            #region All Logic for the robocopy process is handled here. Including what to do with the output etc. 
            (Robocopy.exe $RoboArgs).Where({$PSItem -ne ""}).ForEach({

                If ($PSitem -match 'ERROR \d \(0x\d{1,11}\)|ERROR : *') {
                    # First rule is if we catch an error we will write to the error stream inc the path and error text from Robocopy
                    Write-Error $PSitem.Trim()
                }

                elseif ($PSitem -like "*$Source*" -or $PSitem -like "*$Destination*") {
                    # If no error is found we will output the file name. We are using split because when we use /bytes in the Robocopy args we also output each files size by default.
                    $Line = $PSitem.Trim().Split("`t")

                    If ($Line[0] -notmatch '[0-9]') {
                        # This should capture all output
                        $Size,[datetime]$TimeStamp = $line[2].Trim().Split(" ",2) # Trimming and splitting on this line instead of in Write-Verbose for readability
                        Write-Verbose -Message ('"{0} File" on "Item {1}" Status on Item "{2}". Size on Item "{3}". TimeStamp on Item "{4}"' -f $action, $line[3], $line[0].Trim(), $Size, $TimeStamp)
                        
                    }
                    else {
                        Write-Verbose -Message $PSitem 
                    } # end else in ElseIf
                }

                elseif ($PSitem -match "$HeaderRegex|$DirLineRegex|$FileLineRegex|$BytesLineRegex|$TimeLineRegex|$EndedLineRegex|$SpeedLineRegex|$JobSummaryEndLineRegex|$SpeedInMinutesRegex") {

                    # Catch all the summary lines and transform it if no error was found and the passed text didnt contain text from the source.
                    # Some we will just assign to variables and dont use or dont do anything with
                    Switch -Regex ($PSitem) {
                        $JobSummaryEndLine { }
                        $HeaderRegex { }
                        $DirLineRegex { $TotalDirs, $TotalDirCopied, $TotalDirIgnored, $TotalDirMismatched, $TotalDirFailed, $TotalDirExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                        $FileLineRegex { $TotalFiles, $TotalFileCopied, $TotalFileIgnored, $TotalFileMismatched, $TotalFileFailed, $TotalFileExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                        $BytesLineRegex { $TotalBytes, $TotalBytesCopied, $TotalBytesIgnored, $TotalBytesMismatched, $TotalBytesFailed, $TotalBytesExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                        $TimeLineRegex { [TimeSpan]$TotalDuration, [TimeSpan]$CopyDuration, [TimeSpan]$FailedDuration, [TimeSpan]$ExtraDuration = $PSitem | Select-String -Pattern '\d?\d\:\d{2}\:\d{2}' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                        $EndedLineRegex { }
                        $SpeedLineRegex { $TotalSpeedBytes = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                        $SpeedInMinutesRegex { }
                    } # Switch end in ElseIf
                }

                else {
                    # Output all lines we dont have rules for to verbose stream
                    "Outside logic"
                    # Write-Verbose $PSitem
                    $PSitem
                }
            })
            #endregion

            $endtime = $(Get-Date) 
    
            # Exit Code lookup "table"
            $LastExitCodeMessage = switch ($LASTEXITCODE) {
                0 { '[SUCCESS]No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped.' }
                1 { '[SUCCESS]All files were copied successfully.' }
                2 { '[SUCCESS]There are some additional files in the destination directory that are not present in the source directory. No files were copied.' }
                3 { '[SUCCESS]Some files were copied. Additional files were present. No failure was encountered.' }
                4 { '[WARNING]Some Mismatched files or directories were detected. Examine the output log. Housekeeping might be required.' }
                5 { '[WARNING]Some files were copied. Some files were mismatched. No failure was encountered.' }
                6 { '[WARNING]Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory.' }
                7 { '[WARNING]Files were copied, a file mismatch was present, and additional files were present.' }
                8 { '[ERRROR]Several files did not copy.(copy errors occurred and the retry limit was exceeded). Check these errors further.' }
                9 { '[ERRROR]Some files did copy, but copy errors occurred and the retry limit was exceeded. Check these errors further.' }
                10 { '[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.' }
                11 { '[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.' }
                12 { '[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.' }
                13 { '[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.' }
                14 { '[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.' }
                15 { '[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.' }
                16 { '[ERRROR]Robocopy did not copy any files. Either a usage error or an error due to insufficient access privileges on the source or destination directories.' }
                default { '[WARNING]No message associated with this exit code. ExitCode: {0}' -f $LASTEXITCODE }
            }

            $Output = [PSCustomObject]@{
                'Source'              = [System.IO.DirectoryInfo]$Source
                'Destination'         = [System.IO.DirectoryInfo]$Destination
                'Command'             = 'Robocopy.exe ' + $RoboArgs -join " "
                'DirCount'            = [int]$TotalDirs
                'FileCount'           = [int]$TotalFiles
                #'Duration'     = $TotalDuration
                'DirCopied'           = [int]$TotalDirCopied
                'FileCopied'          = [int]$TotalFileCopied
                #'CopyDuration' = $CopyDuration
                'DirIgnored'          = [int]$TotalDirIgnored
                'FileIgnored'         = [int]$TotalFileIgnored
                'DirMismatched'       = [int]$TotalDirMismatched
                'FileMismatched'      = [int]$TotalFileMismatched
                'DirFailed'           = [int]$TotalDirFailed
                'FileFailed'          = [int]$TotalFileFailed
                #'FailedDuration'   = $FailedDuration
                'DirExtra'            = [int]$TotalDirExtra
                'FileExtra'           = [int]$TotalFileExtra
                #'ExtraDuration'    = $ExtraDuration
                'TotalTime'           = "{0:HH:mm:ss}" -f ([datetime]$($endtime - $StartTime).Ticks)
                'StartedTime'         = [datetime]$StartTime
                'EndedTime'           = [datetime]$endTime
                'TotalSize'           = (Format-SpeedHumanReadable $Totalbytes -Unit $Unit)
                'TotalSizeCopied'     = (Format-SpeedHumanReadable $TotalBytesCopied -Unit $Unit)
                'TotalSizeIgnored'    = (Format-SpeedHumanReadable $TotalBytesIgnored -Unit $Unit)
                'TotalSizeMismatched' = (Format-SpeedHumanReadable $TotalBytesMismatched -Unit $Unit)
                'TotalSizeFailed'     = (Format-SpeedHumanReadable $TotalBytesFailed -Unit $Unit)
                'TotalSizeExtra'      = (Format-SpeedHumanReadable $TotalBytesExtra -Unit $Unit)
                'Speed'               = (Format-SpeedHumanReadable $TotalSpeedBytes -Unit $Unit) + '/s'
                'ExitCode'            = $LASTEXITCODE
                'Success'             = If ($RoboRun.ExitCode -lt 8) { $true } else { $false }
                'LastExitCodeMessage' = [string]$LastExitCodeMessage
            }

            $Output
        }
    }
}