Function Start-RoboCopy {
    <#
.SYNOPSIS
Start Robocopy with PowerShell

.DESCRIPTION
See https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx for an extensive documentation on Robocopy switches

Some Jobs parameters cannot be used.

.PARAMETER Source
Specifies the path to the source directory. Must be a folder.
.PARAMETER Destination
Specifies the path to the destination directory. Must be a folder.
.PARAMETER Files
Specifies the file or files to be copied. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.
.PARAMETER LogFile
Writes the status output to the log file (overwrites the existing log file).
.PARAMETER IncludeSubDirectories
Copies subdirectories. Note that this option excludes empty directories.
.PARAMETER IncludeEmptySubDirectories
Copies subdirectories. Note that this option includes empty directories.
.PARAMETER Level
Copies only the top N levels of the source directory tree.
.PARAMETER BackupMode
Copies files in restartable mode.
.PARAMETER RestartMode
Copies files in Backup mode.
.PARAMETER EFSRaw
Copies all encrypted files in EFS RAW mode.
.PARAMETER CopyFlags
Specifies the file properties to be copied. The default value for CopyFlags is DAT (data, attributes, and time stamps).
D Data
A Attributes
T Time stamps
S NTFS access control list (ACL)
O Owner information
U Auditing information
.PARAMETER NoCopy
Copies no file information.
.PARAMETER SecurityFix
Fixes file security on all files, even skipped ones.
.PARAMETER Timefix
Fixes file times on all files, even skipped ones.
.PARAMETER Purge
Deletes destination files and directories that no longer exist in the source.
.PARAMETER Mirror
Mirrors a directory tree
.PARAMETER MoveFiles
Moves files, recursively, and deletes them from the source after they are copied. Folders will still be in source directory.
.PARAMETER MoveFilesAndDirectories
Moves files and directories, and deletes them from the source after they are copied.
.PARAMETER AddAttribute
Adds the specified attributes to copied files.
.PARAMETER RemoveAttribute
Removes the specified attributes from copied files.
.PARAMETER Create
Creates a directory tree and zero-length files only.
.PARAMETER fat
Creates destination files by using 8.3 character-length FAT file names only.
.PARAMETER IgnoreLongPath
Turns off support for very long paths.
.PARAMETER MonitorChanges
Monitors the source, and runs again when more than N changes are detected.
.PARAMETER MonitorMinutes
Monitors source, and runs again in M minutes if changes are detected.
.PARAMETER Threads
Creates multi-threaded copies with N threads. N must be an integer between 1 and 128. Cannot be used with the InterPacketGap and EFSRAW parameters. The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
.PARAMETER RunTimes
Specifies run times when new copies may be started.
.PARAMETER UsePerFileRunTimes
Checks run times on a per-file (not per-pass) basis.
.PARAMETER InterPacketGap
Specifies the inter-packet gap to free bandwidth on slow lines.
.PARAMETER SymbolicLink
Follows the symbolic link and copies the target.
.PARAMETER Archive
Copies only files for which the Archive attribute is set.
.PARAMETER ResetArchiveAttribute
Copies only files for which the Archive attribute is set, and resets the Archive attribute.
.PARAMETER IncludeAttribute
Includes only files for which any of the specified attributes are set.
.PARAMETER ExcludeAttribute
Excludes files for which any of the specified attributes are set.
.PARAMETER ExcludeFileName
Excludes files that match the specified names or paths. Note that FileName can include wildcard characters (* and ?).
.PARAMETER ExcludeDirectory
Excludes directories that match the specified names and paths.
.PARAMETER ExcludeChangedFiles
Excludes changed files.
.PARAMETER ExcludeNewerFiles
Excludes newer files.
.PARAMETER ExcludeOlderFiles
Excludes older files.
.PARAMETER ExcludeExtraFiles
Excludes extra files and directories.
.PARAMETER ExcludeLonelyFiles
Excludes "lonely" files and directories.
.PARAMETER IncludeSameFiles
Includes the same files.
.PARAMETER IncludeTweakedFiles
Includes "tweaked" files.
.PARAMETER MaximumFileSize
Specifies the maximum file size (to exclude files bigger than N bytes).
.PARAMETER MinimumFileSize
Specifies the minimum file size (to exclude files smaller than N bytes).
.PARAMETER MaximumFileAge
Specifies the maximum file age (to exclude files older than N days or date).
.PARAMETER MinimumFileAge
Specifies the minimum file age (exclude files newer than N days or date).
.PARAMETER MaximumFileLastAccessDate
Specifies the maximum last access date (excludes files unused since N).
.PARAMETER MinimumFileLastAccessDate
Specifies the minimum last access date (excludes files used since N) If N is less than 1900, N specifies the number of days. Otherwise, N specifies a date in the format YYYYMMDD.
.PARAMETER ExcludeJunctionPoints
Excludes junction points, which are normally included by default.
.PARAMETER ExcludeFileJunctionPoints
Excludes junction points for files.
.PARAMETER ExcludeDirectoryJunctionPoints
Excludes junction points for directories.
.PARAMETER AssumeFATFileTime
Assumes FAT file times (two-second precision).
.PARAMETER CompensateDST
Compensates for one-hour DST time differences.
.PARAMETER Retry
Specifies the number of retries on failed copies. The default value of N is 0.
.PARAMETER Wait
Specifies the wait time between retries, in seconds. The default value of N is 0.
.PARAMETER SaveRetrySettings
Saves the values specified in the /r and /w options as default settings in the registry.
.PARAMETER WaitForShareName
Specifies that the system will wait for share names to be defined (retry error 67).
    
.NOTES
Original script by Keith S. Garner (KeithGa@KeithGa.com) - 6/23/2014
Originally posted on https://keithga.wordpress.com/2014/06/23/copy-itemwithprogress

With inspiration by Trevor Sullivan @pcgeek86
https://stackoverflow.com/a/21209726

Updated by Ninjigen - 01/08/2018
https://github.com/Ninjigen/PowerShell/tree/master/Robocopy
#>


    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('RoboCopyView')]

    Param (
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specifies the path to the source directory. Must be a folder.')]
        [Alias('Path')]
        [String]$Source,

        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Specifies the path to the destination directory. Must be a folder.')]
        [Alias('Target')]
        [String]$Destination,

        [Parameter(Mandatory = $False)]
        [String[]] $Files = '*.*',

        [Parameter(Mandatory = $False)]
        [String]$LogFile,

        [Alias('s')]
        [switch]$IncludeSubDirectories,

        [Alias('e', 'Recurse')]
        [switch]$IncludeEmptySubDirectories,

        [Parameter(Mandatory = $False)]
        [Alias('lev')]
        [Int]$Level,

        [Alias('b')]
        [switch]$BackupMode,

        [Alias('z')]
        [switch]$RestartMode,

        [switch]$EFSRaw,

        [Parameter(Mandatory = $False)]
        [Alias('copy')]
        [ValidateSet('D', 'A', 'T', 'S', 'O', 'U')]
        [String[]]$CopyFlags,

        [switch]$NoCopy,

        [Alias('secfix')]
        [switch]$SecurityFix,

        [Alias('timfix')]
        [switch]$Timefix,

        [switch]$Purge,

        [Alias('mir', 'Sync')]
        [switch]$Mirror,

        [Alias('mov')]
        [switch]$MoveFiles,

        [Alias('move')]
        [switch]$MoveFilesAndDirectories,

        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
        [String[]]$AddAttribute,

        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T')]
        [String[]]$RemoveAttribute,

        [switch]$Create,

        [switch]$fat,

        [Alias('256')]
        [switch]$IgnoreLongPath,

        [Parameter(Mandatory = $False)]
        [Alias('mon')]
        [Int]$MonitorChanges,

        [Parameter(Mandatory = $False)]
        [Alias('mot')]
        [Int]$MonitorMinutes,

        [Parameter(Mandatory = $False)]
        [Alias('MT')]
        [Int]$Threads,

        [Parameter(Mandatory = $False)]
        [Alias('rh')]
        [String]$RunTimes,

        [Alias('pf')]
        [switch]$UsePerFileRunTimes,

        [Parameter(Mandatory = $False)]
        [Alias('ipg')]
        [Int]$InterPacketGap,

        [Alias('sl')]
        [switch]$SymbolicLink,

        [Alias('a')]
        [switch]$Archive,

        [Alias('m')]
        [switch]$ResetArchiveAttribute,

        [Parameter(Mandatory = $False)]
        [Alias('ia')]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T', 'O')]
        [String[]]$IncludeAttribute,

        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H', 'N', 'E', 'T', 'O')]
        [Alias('xa')]
        [String[]]$ExcludeAttribute,

        [Parameter(Mandatory = $False)]
        [Alias('xf')]
        [String[]]$ExcludeFileName,

        [Parameter(Mandatory = $False)]
        [Alias('xd')]
        [String[]]$ExcludeDirectory,

        [Alias('xct')]
        [switch]$ExcludeChangedFiles,

        [Alias('xn')]
        [switch]$ExcludeNewerFiles,

        [Alias('xo')]
        [switch]$ExcludeOlderFiles,

        [Alias('xx')]
        [switch]$ExcludeExtraFiles,

        [Alias('xl')]
        [switch]$ExcludeLonelyFiles,

        [Alias('is')]
        [switch]$IncludeSameFiles,

        [Alias('it')]
        [switch]$IncludeTweakedFiles,

        [Parameter(Mandatory = $False)]
        [Alias('max')]
        [String]$MaximumFileSize,

        [Parameter(Mandatory = $False)]
        [Alias('min')]
        [String]$MinimumFileSize,

        [Parameter(Mandatory = $False)]
        [Alias('maxage')]
        [String]$MaximumFileAge,

        [Parameter(Mandatory = $False)]
        [Alias('minage')]
        [String]$MinimumFileAge,

        [Parameter(Mandatory = $False)]
        [Alias('maxlad')]
        [String]$MaximumFileLastAccessDate,

        [Parameter(Mandatory = $False)]
        [Alias('minlad')]
        [String]$MinimumFileLastAccessDate,

        [Alias('xj')]
        [switch]$ExcludeJunctionPoints,

        [Alias('xjf')]
        [switch]$ExcludeFileJunctionPoints,

        [Alias('xjd')]
        [switch]$ExcludeDirectoryJunctionPoints,

        [Alias('fft')]
        [switch]$AssumeFATFileTime,

        [Alias('dst')]
        [switch]$CompensateDST,

        [Alias('r')]
        [int]$Retry = 3,

        [Alias('w')]
        [int]$Wait = 3,

        [Alias('reg')]
        [switch]$SaveRetrySettings,

        [Alias('tbd')]
        [switch]$WaitForShareName
    )

    Process {

        # Remove trailing backslash because Robocopy can sometimes error out when spaces are in path names
        $ModifiedSource = $Source -replace '\\$'
        $ModifiedDestination = $Destination -replace '\\$'

        # We place "" so we can use spaces in path names
        $ModifiedSource = '"' + $ModifiedSource + '"'
        $ModifiedDestination = '"' + $ModifiedDestination + '"'

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

        # RobocopyArguments are not the final variable that countain all robocopy parameters
        $RobocopyArguments = $Source, $Destination + $Files

        # We add wait and retry with the default from their parameters, else Robocopy will try a million time before time out
        $RobocopyArguments += ' /r:' + $Retry
        $RobocopyArguments += ' /w:' + $Wait

        if ($IncludeSubDirectories) {$RobocopyArguments += '/s'; $action = 'Copy'}
        if ($IncludeEmptySubDirectories) {$RobocopyArguments += '/e'; $action = 'Copy'}
        if ($Level) {$RobocopyArguments += '/lev:' + $Level}
        if ($BackupMode) {$RobocopyArguments += '/b'}
        if ($RestartMode) {$RobocopyArguments += '/z'}
        if ($EFSRaw) {$RobocopyArguments += '/efsraw'}
        if ($CopyFlags) {$RobocopyArguments += '/copy:' + (($CopyFlags | Sort-Object -Unique) -join '')}
        if ($NoCopy) {$RobocopyArguments += '/nocopy'}
        if ($SecurityFix) {$RobocopyArguments += '/secfix'}
        if ($Timefix) {$RobocopyArguments += '/timfix'}
        if ($Purge) {$RobocopyArguments += '/purge' ; $action = 'Purge'}
        if ($Mirror) {$RobocopyArguments += '/mir'; $action = 'Mirror'}
        if ($MoveFiles) {$RobocopyArguments += '/mov'; $action = 'Move'}
        if ($MoveFilesAndDirectories) {$RobocopyArguments += '/move' ; $action = 'Move'}
        if ($AddAttribute) {$RobocopyArguments += '/a+:' + (($AddAttribute | Sort-Object-Unique) -join '')}
        if ($RemoveAttribute) {$RobocopyArguments += '/a-:' + (($RemoveAttribute | Sort-Object-Unique) -join '')}
        if ($Create) {$RobocopyArguments += '/create'}
        if ($fat) {$RobocopyArguments += '/fat'}
        if ($IgnoreLongPath) {$RobocopyArguments += '/256'}
        if ($MonitorChanges) {$RobocopyArguments += '/mon:' + $MonitorChanges}
        if ($MonitorMinutes) {$RobocopyArguments += '/mot:' + $MonitorMinutes}
        if ($Threads) {$RobocopyArguments += '/MT:' + $Threads}
        if ($RunTimes) {$RobocopyArguments += '/rh:' + $RunTimes}
        if ($UsePerFileRunTimes) {$RobocopyArguments += '/pf'}
        if ($InterPacketGap) {$RobocopyArguments += '/ipg:' + $InterPacketGap}
        if ($SymbolicLink) {$RobocopyArguments += '/sl'}
        if ($Archive) {$RobocopyArguments += '/a'}
        if ($ResetArchiveAttribute) {$RobocopyArguments += '/m'}
        if ($IncludeAttribute) {$RobocopyArguments += '/ia:' + ($IncludeAttribute | Sort-Object-Unique) -join ''}
        if ($ExcludeAttribute) {$RobocopyArguments += '/xa:' + ($ExcludeAttribute | Sort-Object-Unique) -join ''}
        if ($ExcludeFileName) {$RobocopyArguments += '/xf ' + $ExcludeFileName -join ' '}
        if ($ExcludeDirectory) {$RobocopyArguments += '/xd ' + $ExcludeDirectory -join ' '}
        if ($ExcludeChangedFiles) {$RobocopyArguments += '/xct'}
        if ($ExcludeNewerFiles) {$RobocopyArguments += '/xn'}
        if ($ExcludeOlderFiles) {$RobocopyArguments += '/xo'}
        if ($ExcludeExtraFiles) {$RobocopyArguments += '/xx'}
        if ($ExcludeLonelyFiles) {$RobocopyArguments += '/xl'}
        if ($IncludeSameFiles) {$RobocopyArguments += '/is'}
        if ($IncludeTweakedFiles) {$RobocopyArguments += '/it'}
        if ($MaximumFileSize) {$RobocopyArguments += '/max:' + $MaximumFileSize}
        if ($MinimumFileSize) {$RobocopyArguments += '/min:' + $MinimumFileSize}
        if ($MaximumFileAge) {$RobocopyArguments += '/maxage:' + $MaximumFileAge}
        if ($MinimumFileAge) {$RobocopyArguments += '/minage:' + $MinimumFileAge}
        if ($MaximumFileLastAccessDate) {$RobocopyArguments += '/maxlad:' + $MaximumFileLastAccessDate}
        if ($MinimumFileLastAccessDate) {$RobocopyArguments += '/minlad:' + $MinimumFileLastAccessDate}
        if ($ExcludeJunctionPoints) {$RobocopyArguments += '/xj'}
        if ($ExcludeFileJunctionPoints) {$RobocopyArguments += '/xjf'}
        if ($ExcludeDirectoryJunctionPoints) {$RobocopyArguments += '/xjd'}
        if ($AssumeFATFileTime) {$RobocopyArguments += '/fft'}
        if ($CompensateDST) {$RobocopyArguments += '/dst'}
        if ($SaveRetrySettings) {$RobocopyArguments += '/reg'}
        if ($WaitForShareName) {$RobocopyArguments += '/tbd'}

        $StartTime = $(Get-Date)

        # Testing PowerShell filter 
        filter isRc { if ($_ -ne "") { $_ } }
        $RoboArgs = " /bytes /mir /tee /np /ns /njh /nc /fp /r:1 /w:1" -split " " # Space before /bytes so output object look correct
        Robocopy.exe $ModifiedSource $ModifiedDestination $RoboArgs | isRc | ForEach-Object {

            If ($_ -match 'ERROR \d \(0x\d{1,11}\)') {
                # First rule is if we catch an error we will write a warning with the path and error text from Robocopy
                Write-Warning $_
            }

            elseif ($_ -like "*$Source*") {
                # If no error is found we will output the file name. We are using split because when we use /bytes in the Robocopy args we also output each files size.
                Write-Verbose -Message ("Processing {1}" -f $PSitem.Trim().Split("`t"))
            }

            elseif ($_ -match "$HeaderRegex|$DirLineRegex|$FileLineRegex|$BytesLineRegex|$TimeLineRegex|$EndedLineRegex|$SpeedLineRegex|$JobSummaryEndLineRegex|$SpeedInMinutesRegex") {

                # Catch all the summary lines and transform it if no error was found and the passed text didnt contain text from the source.
                # Some we will just assign to variables or dont do anything with
                Switch -Regex ($_) {
                    $JobSummaryEndLine { }
                    $HeaderRegex { }
                    $DirLineRegex { $TotalDirs, $TotalDirCopied, $TotalDirIgnored, $TotalDirMismatched, $TotalDirFailed, $TotalDirExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
                    $FileLineRegex { $TotalFiles, $TotalFileCopied, $TotalFileIgnored, $TotalFileMismatched, $TotalFileFailed, $TotalFileExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
                    $BytesLineRegex { $TotalBytes, $TotalBytesCopied, $TotalBytesIgnored, $TotalBytesMismatched, $TotalBytesFailed, $TotalBytesExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
                    $TimeLineRegex { [TimeSpan]$TotalDuration, [TimeSpan]$CopyDuration, [TimeSpan]$FailedDuration, [TimeSpan]$ExtraDuration = $PSitem | Select-String -Pattern '\d?\d\:\d{2}\:\d{2}' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
                    $EndedLineRegex { }
                    $SpeedLineRegex { $TotalSpeedBytes = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
                    $SpeedInMinutesRegex { }
                } # end Switch 
            }

            else {
                # Output all lines we dont have rules for
                $PSitem
            }
        }


        $endtime = $(Get-Date) 
    

        [PSCustomObject][ordered]@{
            'Source'               = $Source
            'Destination'          = $Destination
            'Command'              = 'Robocopy.exe' + $RoboArgs -join " "
            'DirCount'             = $TotalDirs
            'FileCount'            = $TotalFiles
            #'Duration'     = $TotalDuration
            'DirCopied'            = $TotalDirCopied
            'FileCopied'           = $TotalFileCopied
            #'CopyDuration' = $CopyDuration
            'DirIgnored'           = $TotalDirIgnored
            'FileIgnored'          = $TotalFileIgnored
            'DirMismatched'        = $TotalDirMismatched
            'FileMismatched'       = $TotalFileMismatched
            'DirFailed'            = $TotalDirFailed
            'FileFailed'           = $TotalFileFailed
            #'FailedDuration'   = $FailedDuration
            'DirExtra'             = $TotalDirExtra
            'FileExtra'            = $TotalFileExtra
            #'ExtraDuration'    = $ExtraDuration
            'TotalTime'            = "{0:HH:mm:ss}" -f ([datetime]$($endtime - $StartTime).Ticks)
            'StartedTime'          = $StartTime
            'EndedTime'            = $endTime
            'TotalBytes'           = $TotalBytes
            'TotalBytesCopied'     = $TotalBytesCopied
            'TotalBytesIgnored'    = $TotalBytesIgnored
            'TotalBytesMismatched' = $TotalBytesMismatched
            'TotalBytesFailed'     = $TotalBytesFailed
            'TotalBytesExtra'      = $TotalBytesExtra
            'Speed'                = (Format-SpeedHumanReadable $TotalSpeedBytes) + '/s'
            'ExitCode'             = $LASTEXITCODE
            'Success'              = If ($RoboRun.ExitCode -lt 8) { $true } else { $false }
        }
    }
}