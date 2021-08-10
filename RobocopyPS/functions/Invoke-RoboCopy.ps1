Function Invoke-RoboCopy {
    <#
    .SYNOPSIS
    Invoke Robocopy with PowerShell

    .DESCRIPTION
    See https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx for an extensive documentation on Robocopy switches.
    Some parameters are in use by the function: /bytes /TEE /np /njh /fp /v /ndl /ts.

    .PARAMETER Confirm
    Prompts you for confirmation before running the function.

    .PARAMETER WhatIf
    Shows what would happen if the function runs. The function is not run.

    .EXAMPLE
    Invoke-RoboCopy -Source "E:\Google Drive\Script Library" -Destination G:\Temp\ -Recurse  -Unit Bytes

    Source              : E:\Google Drive\Script Library
    Destination         : G:\Temp\
    Command             : Robocopy.exe "E:\Google Drive\Script Library" "G:\Temp" *.* /r:3 /w:3 /e /bytes /TEE /np /njh /fp /v /ndl /ts
    DirCount            : 589
    FileCount           : 1220
    DirCopied           : 588
    FileCopied          : 1220
    DirIgnored          : 1
    FileIgnored         : 0
    DirMismatched       : 0
    FileMismatched      : 0
    DirFailed           : 0
    FileFailed          : 0
    DirExtra            : 0
    FileExtra           : 1
    TotalTime           : 00:00:02
    StartedTime         : 7/16/2019 10:03:28 PM
    EndedTime           : 7/16/2019 10:03:30 PM
    TotalSize           : 18839977 B
    TotalSizeCopied     : 18839977 B
    TotalSizeIgnored    : 0 B
    TotalSizeMismatched : 0 B
    TotalSizeFailed     : 0 B
    TotalSizeExtra      : 557048280 B
    Speed               : 12957343 B/s
    ExitCode            : 3
    Success             : True
    LastExitCodeMessage : [SUCCESS]Some files were copied. Additional files were present. No failure was encountered.

    .EXAMPLE
    Invoke-RoboCopy -Source C:\temp\from -Destination C:\temp\to -Mirror -SaveJob C:\temp\job

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
        [Alias('Path', 'FullPath')]
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

        <#Copy options: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy#copy-options#>

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

        # Copies files in restartable mode.
        [Alias('z')]
        [switch]$RestartMode,

        # Copies files in Backup mode.
        [Alias('b')]
        [switch]$BackupMode,

        # Copies using unbuffered I/O (recommended for large files).
        [Alias('j')]
        [Switch]$UnbufferedIO,

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
        [ValidateSet('R', 'A', 'S', 'H','C', 'N', 'E', 'T')]
        [String[]]$AddAttribute,

        # Removes the specified attributes from copied files.
        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S', 'H','C', 'N', 'E', 'T')]
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

        # Creates multi-threaded copies with N threads. N must be an integer between 1 and 128. Cannot be used with the InterPacketGap and EFSRAW parameters. The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
        [Parameter(Mandatory = $False)]
        [Alias('MT','MultiThread')]
        [string]$Threads,

        # Copies files without using the Windows Copy Offload mechanism.
        [Switch]$NoOffload,

        # Requests network compression during file transfer, if applicable.
        [Switch]$Compress,

        <# File selection options: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy#file-selection-options #>

        # Copies only files for which the Archive attribute is set.
        [Alias('a')]
        [switch]$Archive,

        # Copies only files for which the Archive attribute is set, and resets the Archive attribute.
        [Alias('m')]
        [switch]$ResetArchiveAttribute,

        # Includes only files for which any of the specified attributes are set.
        [Parameter(Mandatory = $False)]
        [Alias('ia')]
        [ValidateSet('R', 'A', 'S','C' ,'H', 'N', 'E', 'T', 'O')]
        [String[]]$IncludeAttribute,

        # Excludes files for which any of the specified attributes are set.
        [Parameter(Mandatory = $False)]
        [ValidateSet('R', 'A', 'S','C' ,'H', 'N', 'E', 'T', 'O')]
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
        [Alias('xc')]
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

        # Include modified files (differing change times).
        [Alias('im')]
        [switch]$IncludeModifiedFile,

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

        # Assumes FAT file times (two-second precision).
        [Alias('fft')]
        [switch]$AssumeFATFileTime,

        # Compensates for one-hour DST time differences.
        [Alias('dst')]
        [switch]$CompensateDST,

        # Excludes junction points for directories.
        [Alias('xjd')]
        [switch]$ExcludeDirectoryJunctionPoints,

        # Excludes junction points for files.
        [Alias('xjf')]
        [switch]$ExcludeFileJunctionPoints,

        <#Retry Options#>

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

        # Using /LFSM requests robocopy to operate in 'low free space mode'. In that mode, robocopy will pause whenever a file copy would cause the destination volume's free space to go below ten percent of the destination volume's size.
        [Alias('lfsm')]
        [switch]$LowFreeSpaceMode,

        # Using /LFSM requests robocopy to operate in 'low free space mode'. In that mode, robocopy will pause whenever a file copy would cause the destination volume's free space to go below a 'floor' value, which can be explicitly specified by the n[KMG] form of the flag where n=number and K:kilobytes ,M:megabytes or G:gigabytes.
        [ValidatePattern("[0-9]{1,}[K]|[0-9]{1,}[M]|[0-9]{1,}[G]")]
        [String]$LowFreeSpaceModeValue,

        <# Logging #>
        # Specifies that files are to be listed only (and not copied, deleted, or time stamped).
        [Alias('l')]
        [Switch]$List,

        <#Job options#>

        # Specifies that parameters are to be derived from the named job file.
        [Alias('Job')]
        [string]$JobName,

        # Specifies that parameters are to be saved to the named job file.
        [Alias('Save')]
        [string]$SaveJob,

        # Quits after processing command line to view parameters.
        [switch]$Quit,

        # NO Source Directory is specified.
        [Alias('NOSD')]
        [switch]$NoSourceDirectory,

        # NO Destination Directory is specified.
        [Alias('NODD')]
        [switch]$NoDestinationDirectory,

        # Include the following Files.
        [Alias('IF')]
        [string]$IncludeFollowingFile,

        <# Other #>

        # What unit the sizes are shown as
        [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
        [String]$Unit = 'Auto'
    )

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

        # Copy options
        if ($IncludeSubDirectories) { $RobocopyArguments += '/s'; $action = 'Copy' }
        if ($IncludeEmptySubDirectories) { $RobocopyArguments += '/e'; $action = 'Copy' }
        If ($LogFile) { $RobocopyArguments += '/log:' + $LogFile }
        if ($Level) { $RobocopyArguments += '/lev:' + $Level }
        if ($BackupMode) { $RobocopyArguments += '/b' }
        if ($RestartMode) { $RobocopyArguments += '/z' }
        if ($UnbufferedIO) { $RobocopyArguments += '/j'}
        if ($EFSRaw) { $RobocopyArguments += '/efsraw' }
        if ($CopyFlags) { $RobocopyArguments += '/copy:' + (($CopyFlags | Sort-Object -Unique) -join '') }
        if ($NoCopy) { $RobocopyArguments += '/nocopy' }
        if ($SecurityFix) { $RobocopyArguments += '/secfix' }
        if ($Timefix) { $RobocopyArguments += '/timfix' }
        if ($Purge) { $RobocopyArguments += '/purge' ; $action = 'Purge' }
        if ($Mirror) { $RobocopyArguments += '/mir'; $action = 'Mirror' }
        if ($MoveFiles) { $RobocopyArguments += '/mov'; $action = 'Move' }
        if ($MoveFilesAndDirectories) { $RobocopyArguments += '/move' ; $action = 'Move' }
        if ($AddAttribute) { $RobocopyArguments += '/a+:' + (($AddAttribute | Sort-Object -Unique) -join '') }
        if ($RemoveAttribute) { $RobocopyArguments += '/a-:' + (($RemoveAttribute | Sort-Object -Unique) -join '') }
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
        if ($NoOffload) { $RobocopyArguments += '/nooffload' }
        if ($Compress) { $RobocopyArguments += '/compress' }

        # File selection options
        if ($Archive) { $RobocopyArguments += '/a' }
        if ($ResetArchiveAttribute) { $RobocopyArguments += '/m' }
        if ($IncludeAttribute) { $RobocopyArguments += '/ia:' + ($IncludeAttribute | Sort-Object -Unique) -join '' }
        if ($ExcludeAttribute) { $RobocopyArguments += '/xa:' + ($ExcludeAttribute | Sort-Object -Unique) -join '' }
        if ($ExcludeFileName) { $RobocopyArguments += '/xf ' + ($ExcludeFileName | ForEach-Object { '"' + $_ + '"' }) -join ' '}
        if ($ExcludeDirectory) { $RobocopyArguments += '/xd ' + ($ExcludeDirectory | ForEach-Object { '"' + $_ + '"' }) -join ' '}
        if ($ExcludeChangedFiles) { $RobocopyArguments += '/xc' }
        if ($ExcludeNewerFiles) { $RobocopyArguments += '/xn' }
        if ($ExcludeOlderFiles) { $RobocopyArguments += '/xo' }
        if ($ExcludeExtraFiles) { $RobocopyArguments += '/xx' }
        if ($ExcludeLonelyFiles) { $RobocopyArguments += '/xl' }
        if ($IncludeModifiedFile) { $RobocopyArguments += '/im' }
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
        If ($LowFreeSpaceMode) { $RobocopyArguments += '/LFSM'}
        If ($LowFreeSpaceModeValue) { $RobocopyArguments += '/LFSM:' + $LowFreeSpaceModeValue}

        # Logging Options

        # Job Options
        If ($JobName) { $RobocopyArguments += '/job:' + $JobName}
        If ($SaveJob) { $RobocopyArguments += '/save:' + $SaveJob}
        If ($Quit) { $RobocopyArguments += '/quit'}
        If ($NoSourceDirectory) { $RobocopyArguments += '/NOSD'}
        If ($NoDestinationDirectory) { $RobocopyArguments += '/NODD'}
        If ($NoDestinationDirectory) { $RobocopyArguments += '/IF' + }


        # Reason why ShouldProcess is this far down is because $action is not set before this part
        If ($PSCmdlet.ShouldProcess("$Destination from $Source" , $action)) {

            if (-not (Get-Command -Name robocopy -ErrorAction SilentlyContinue)) {
                Write-Warning -Message "Action failed because robocopy.exe could not be found."
                break
            }

            # Arguments of the copy command. Fills in the $RoboLog temp file
            $RoboArgs = $RobocopyArguments + "/bytes /TEE /np /njh /fp /v /ndl /ts" -split " "

            If ($Quit) {
                # If Quit is used output parameters and break
                Robocopy.exe $RoboArgs
                break
            }

            #region All Logic for the robocopy process is handled here. Including what to do with the output etc.
            Robocopy.exe $RoboArgs | Where-Object { $PSItem -ne "" } | Invoke-RobocopyParser -Unit $unit | & {
                process {
                    If ($psitem.stream -eq "Verbose") {
                        Write-Verbose -Message ('"{0} File" on "Item {1}" to target "{2}" Status on Item "{3}". Length on Item "{4}". TimeStamp on Item "{5}"' -f $action, $psitem.FullName , $Destination, $psitem.status, $psitem.length, $psitem.TimeStamp)
                    }

                    ElseIf ($psitem.stream -eq "Error") {

                        If ($psitem.exception) {
                            $Exception = [Exception]::new($psitem.exception)
                        }
                        Else {
                            $Exception = [Exception]::new($psitem.Value)
                        }

                        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                            $Exception,
                            $Psitem.ErrorID,
                            [System.Management.Automation.ErrorCategory]::NotSpecified,
                            $TargetObject # usually the object that triggered the error, if possible
                        )
                        $PSCmdlet.WriteError($ErrorRecord)
                    }

                    ElseIf ($psitem.stream -eq "Warning") {
                        Write-Warning $psitem.value
                    }

                    ElseIf ($psitem.stream -eq "Information") {
                        Write-Information $psitem.Value
                    }

                    Else {
                        # This will output the pscustomobject with information as source, destination, success and more
                        $Psitem
                    }
                }
            }
        }
    }
}