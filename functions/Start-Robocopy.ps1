Function Start-RoboCopy {
    <#
.SYNOPSIS
Start Robocopy with PowerShell

.DESCRIPTION
Performs file copy with RoboCopy. Output from RoboCopy is captured, parsed, and returned as a Powershell object.
Robocopy only copy the content from the source folder, and does not include the source folder itself. No parameters are by default used, so if running without a copy or mirror flag, nothing will happen.
This does not catch failures for specific files or folders while running, but if you get an exit code greater or equal to 4 you will get a warning, and if greater of equal to 8 you will get an error. The errors and warnings will also appear after Robocopy is done copying.

This function is used as a proxy function, so changes to this function can impact the other functions in this module.
No parameter sets are done, which means you can run all robocopy flags together.

See https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx for an extensive documentation on Robocopy switches

The following switches can't be used :
 - Logging Options
 - Job Options

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

.OUTPUTS
Returns an object with the status of final copy.

.EXAMPLE
C:\PS> TBD after deciding what format we want to use

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
        [ValidateNotNullOrEmpty()]
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

        # Validate so we have correct paths
        Foreach ($TestPath in $Source, $Destination) {
            If (-not (Test-Path -Path $TestPath -PathType Container)) {
                Write-Warning "$TestPath is not a valid folder path"
                return
            }
        }

        # Remove trailing backslash because Robocopy can sometimes error out when spaces are in path names
        $Source = $Source -replace '\\$'
        $Destination = $Destination -replace '\\$'

        # We want source and destination variables without double quotes.
        ## Source is used when we are tracking what file we are currently moving, and when we output the Source path
        ## Destination is only used without double quotation when we output destination path
        $SourceWithoutDoubleQuote = $Source
        $DestinationWithoutDoubleQuote = $Destination

        # We place "" so we can use spaces in path names
        $Source = '"' + $Source + '"'
        $Destination = '"' + $Destination + '"'

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

        # Code to handle CTRL+C
        $CurrentTreatControlCAsInput = [console]::TreatControlCAsInput 
        [console]::TreatControlCAsInput = $true
        Start-Sleep -Seconds 1
        $Host.UI.RawUI.FlushInputBuffer()

        If ($PSCmdlet.ShouldProcess("$DestinationWithoutDoubleQuote from $SourceWithoutDoubleQuote" , $action)) {

            $HashTable = @{
                "ERROR 2 (0x00000002)" = "The system cannot find the file specified."
                "ERROR 3 (0x00000003)" = "The system cannot find the path specified."
                "ERROR 5 (0x00000005)" = "Access is denied."
            }
               

            # creates a temporary file to monitor the progress of the copy. This file is to be disposed unless the $LogFile parameter is used
            if ($LogFile) {
                $RoboLog = $LogFile
                $DisposeRoboLog = $False
            }
            else {
                $RoboLog = [IO.Path]::GetTempFileName()
                $DisposeRoboLog = $True
            }

            # Arguments of the copy command. Fills in the $RoboLog temp file
            $RoboArgs = $RobocopyArguments + "/Log:$RoboLog /tee /np /njh /ndl /nc /ns /fp"


            # NEW CODE
            $RoboRun = Start-Process robocopy -PassThru -WindowStyle Hidden -ArgumentList $RoboArgs -ErrorAction Stop

            # Wait until log file is created by Robocopy 
            while ((Test-Path $RoboLog) -ne $true) {} 


            while ($true) {

                Get-Content -Path $RoboLog -Wait -Tail 2 | ForEach-Object {
            
                    # If CTRL+C is pressed we will stop the script at next possible time and begin cleaning running processes etc
                    if ([console]::KeyAvailable) {
                        $key = [system.console]::readkey($true)
        
                        if (($key.modifiers -band [consolemodifiers]"control") -and ($key.key -eq "C")) {
                            "Terminating..."
                            break
                        }
                    }

                    foreach($key in $HashTable.getenumerator()){
                        If ($_ -match [regex]::Escape($($Key.key))) {
                            Write-Warning -Message ("{0}: {1} {2}" -f $Key.Key,$_ ,$key.Value)
                        }
                    }
                

                    If ($_ -like "*$SourceWithoutDoubleQuote*") {
                        Write-Verbose  ($_.Trim())
                    }

                    If ($RoboRun.HasExited) {
                        break
                    }
                } # end Get-Content part, continue code for rest of function here 

            } # end main While state. Most code should be inside this statement so we can handle CTRL+C 

            "start script"

        
            # Stopping Robocopy process if needed
            If (Get-process -id $RoboRun.id -ErrorAction SilentlyContinue) {
                Write-Verbose -Message ("Robocopy still running, stopping process id {0}" -f $RoboRun.ID)
                Stop-Process -Id $RoboRun.Id
            }

            # Reset TreatControlCAsInput back to before
            [console]::TreatControlCAsInput = $CurrentTreatControlCAsInput

            # Cleans up copy log file unless the $LogFile parameter has been used
            if ($DisposeRoboLog) {
                
                # Need to add a while statement on the roocopy process so we stop it before we try to remove the log file
                do {
                    Write-Verbose ("Waiting for Robocopy to stop, PID {0}" -f $RoboRun.id)
                    Start-Sleep -Seconds 1                    
                } while ($RoboRun.HasExited -ne $true) 

                Remove-Item -Path $RoboLog
            }
        }
    }
}
