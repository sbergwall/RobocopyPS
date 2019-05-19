---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Start-RoboCopy

## SYNOPSIS
Start Robocopy with PowerShell

## SYNTAX

### IncludeSubDirectories
```
Start-RoboCopy -Source <String> -Destination <String> [-Files <String[]>] [-LogFile <String>]
 [-IncludeSubDirectories] [-Level <Int32>] [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>]
 [-NoCopy] [-SecurityFix] [-Timefix] [-Purge] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>]
 [-Create] [-FAT] [-IgnoreLongPath] [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <String>]
 [-RunTimes <String>] [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive]
 [-ResetArchiveAttribute] [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>]
 [-ExcludeFileName <String[]>] [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles]
 [-ExcludeOlderFiles] [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### IncludeEmptySubDirectories
```
Start-RoboCopy -Source <String> -Destination <String> [-Files <String[]>] [-LogFile <String>]
 [-IncludeEmptySubDirectories] [-Level <Int32>] [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>]
 [-NoCopy] [-SecurityFix] [-Timefix] [-Purge] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>]
 [-Create] [-FAT] [-IgnoreLongPath] [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <String>]
 [-RunTimes <String>] [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive]
 [-ResetArchiveAttribute] [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>]
 [-ExcludeFileName <String[]>] [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles]
 [-ExcludeOlderFiles] [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Mirror
```
Start-RoboCopy -Source <String> -Destination <String> [-Files <String[]>] [-LogFile <String>] [-Level <Int32>]
 [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>] [-NoCopy] [-SecurityFix] [-Timefix] [-Purge]
 [-Mirror] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>] [-Create] [-FAT] [-IgnoreLongPath]
 [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <String>] [-RunTimes <String>]
 [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive] [-ResetArchiveAttribute]
 [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>] [-ExcludeFileName <String[]>]
 [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### MoveFiles
```
Start-RoboCopy -Source <String> -Destination <String> [-Files <String[]>] [-LogFile <String>] [-Level <Int32>]
 [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>] [-NoCopy] [-SecurityFix] [-Timefix] [-Purge]
 [-MoveFiles] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>] [-Create] [-FAT] [-IgnoreLongPath]
 [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <String>] [-RunTimes <String>]
 [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive] [-ResetArchiveAttribute]
 [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>] [-ExcludeFileName <String[]>]
 [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### MoveFilesAndDirectories
```
Start-RoboCopy -Source <String> -Destination <String> [-Files <String[]>] [-LogFile <String>] [-Level <Int32>]
 [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>] [-NoCopy] [-SecurityFix] [-Timefix] [-Purge]
 [-MoveFilesAndDirectories] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>] [-Create] [-FAT]
 [-IgnoreLongPath] [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <String>] [-RunTimes <String>]
 [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive] [-ResetArchiveAttribute]
 [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>] [-ExcludeFileName <String[]>]
 [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
See https://technet.microsoft.com/en-us/library/cc733145(v=ws.11).aspx for an extensive documentation on Robocopy switches
Some parameters are in use by the function: /bytes /TEE /np /njh /fp /v /ndl /ts

## EXAMPLES

### EXAMPLE 1
```
Start-RoboCopy -Source C:\temp\ -Destination C:\temp2\ -Mirror
```

Source              : C:\temp\
Destination         : C:\temp2\
Command             : Robocopy.exe "C:\temp" "C:\temp2" *.* /r:3 /w:3 /mir /bytes /TEE /np /njh /fp /v /ndl /ts
DirCount            : 11
FileCount           : 34
DirCopied           : 1
FileCopied          : 6
DirIgnored          : 10
FileIgnored         : 28
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 0
FileExtra           : 1
TotalTime           : 00:00:00
StartedTime         : 2019-04-13 18:14:20
EndedTime           : 2019-04-13 18:14:20
TotalSize           : 1,4 MB
TotalSizeCopied     : 1,2 MB
TotalSizeIgnored    : 155 KB
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 9 KB
Speed               : 72,5 MB/s
ExitCode            : 3
Success             : True
LastExitCodeMessage : \[SUCCESS\]Some files were copied.
Additional files were present.
No failure was encountered.

## PARAMETERS

### -Source
Specifies the path to the source directory.
Must be a folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Destination
Specifies the path to the destination directory.
Must be a folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Target

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Files
Specifies the file or files to be copied.
You can use wildcard characters (* or ?), if you want.
If the File parameter is not specified, *.* is used as the default value.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *.*
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
Writes the status output to the log file (overwrites the existing log file).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSubDirectories
Copies subdirectories.
Note that this option excludes empty directories.

```yaml
Type: SwitchParameter
Parameter Sets: IncludeSubDirectories
Aliases: s

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeEmptySubDirectories
Copies subdirectories.
Note that this option includes empty directories.

```yaml
Type: SwitchParameter
Parameter Sets: IncludeEmptySubDirectories
Aliases: e, Recurse

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Level
Copies only the top N levels of the source directory tree.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: lev, Depth

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupMode
Copies files in Backup mode.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: b

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestartMode
Copies files in restartable mode.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: z

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EFSRaw
Copies all encrypted files in EFS RAW mode.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyFlags
Specifies the file properties to be copied.
The default value for CopyFlags is DAT (data, attributes, and time stamps).
D = Data.
A = Attributes.
T = Time stamps.S = NTFS access control list (ACL).
O =Owner information.
U = Auditing information

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: copy

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoCopy
Copies no file information.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityFix
Fixes file security on all files, even skipped ones.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: secfix

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timefix
Fixes file times on all files, even skipped ones.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: timfix

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Purge
Deletes destination files and directories that no longer exist in the source.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mirror
Mirrors a directory tree

```yaml
Type: SwitchParameter
Parameter Sets: Mirror
Aliases: mir, Sync

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MoveFiles
Moves files, recursively, and deletes them from the source after they are copied.
Folders will still be in source directory.

```yaml
Type: SwitchParameter
Parameter Sets: MoveFiles
Aliases: mov

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MoveFilesAndDirectories
Moves files and directories, and deletes them from the source after they are copied.

```yaml
Type: SwitchParameter
Parameter Sets: MoveFilesAndDirectories
Aliases: move

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddAttribute
Adds the specified attributes to copied files.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveAttribute
Removes the specified attributes from copied files.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Create
Creates a directory tree and zero-length files only.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FAT
Creates destination files by using 8.3 character-length FAT file names only.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreLongPath
Turns off support for very long paths.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 256

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonitorChanges
Monitors the source, and runs again when more than N changes are detected.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: mon

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonitorMinutes
Monitors source, and runs again in M minutes if changes are detected.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: mot

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Threads
Creates multi-threaded copies with N threads.
N must be an integer between 1 and 128.
Cannot be used with the InterPacketGap and EFSRAW parameters.
The /MT parameter applies to Windows Server 2008 R2 and Windows 7.

```yaml
Type: String
Parameter Sets: (All)
Aliases: MT

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunTimes
Specifies run times when new copies may be started.

```yaml
Type: String
Parameter Sets: (All)
Aliases: rh

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsePerFileRunTimes
Checks run times on a per-file (not per-pass) basis.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: pf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InterPacketGap
Specifies the inter-packet gap to free bandwidth on slow lines.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ipg

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SymbolicLink
Follows the symbolic link and copies the target.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: sl

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archive
Copies only files for which the Archive attribute is set.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: a

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResetArchiveAttribute
Copies only files for which the Archive attribute is set, and resets the Archive attribute.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: m

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeAttribute
Includes only files for which any of the specified attributes are set.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ia

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeAttribute
Excludes files for which any of the specified attributes are set.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeFileName
Excludes files that match the specified names or paths.
Note that FileName can include wildcard characters (* and ?).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeDirectory
Excludes directories that match the specified names and paths.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xd

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeChangedFiles
Excludes changed files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xct

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeNewerFiles
Excludes newer files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xn

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeOlderFiles
Excludes older files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xo

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeExtraFiles
Excludes extra files and directories.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeLonelyFiles
Excludes "lonely" files and directories.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xl

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSameFiles
Includes the same files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTweakedFiles
Includes "tweaked" files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: it

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileSize
Specifies the maximum file size (to exclude files bigger than N bytes).

```yaml
Type: String
Parameter Sets: (All)
Aliases: max

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileSize
Specifies the minimum file size (to exclude files smaller than N bytes).

```yaml
Type: String
Parameter Sets: (All)
Aliases: min

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileAge
Specifies the maximum file age (to exclude files older than N days or date).

```yaml
Type: String
Parameter Sets: (All)
Aliases: maxage

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileAge
Specifies the minimum file age (exclude files newer than N days or date).

```yaml
Type: String
Parameter Sets: (All)
Aliases: minage

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileLastAccessDate
Specifies the maximum last access date (excludes files unused since N).

```yaml
Type: String
Parameter Sets: (All)
Aliases: maxlad

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileLastAccessDate
Specifies the minimum last access date (excludes files used since N) If N is less than 1900, N specifies the number of days.
Otherwise, N specifies a date in the format YYYYMMDD.

```yaml
Type: String
Parameter Sets: (All)
Aliases: minlad

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeJunctionPoints
Excludes junction points, which are normally included by default.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xj

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeFileJunctionPoints
Excludes junction points for files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xjf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeDirectoryJunctionPoints
Excludes junction points for directories.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xjd

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssumeFATFileTime
Assumes FAT file times (two-second precision).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: fft

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompensateDST
Compensates for one-hour DST time differences.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: dst

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retry
Specifies the number of retries on failed copies.
Default is 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: r

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Specifies the wait time between retries, in seconds.
The default value of N is 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: w

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -SaveRetrySettings
Saves the values specified in the /r and /w options as default settings in the registry.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: reg

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaitForShareName
Specifies that the system will wait for share names to be defined (retry error 67).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: tbd

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unit
What unit the sizes are shown as

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Auto
Accept pipeline input: False
Accept wildcard characters: False
```

### -List
Specifies that files are to be listed only (and not copied, deleted, or time stamped).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: l

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Original script by Keith S.
Garner (KeithGa@KeithGa.com) - 6/23/2014
Originally posted on https://keithga.wordpress.com/2014/06/23/copy-itemwithprogress

With inspiration by Trevor Sullivan @pcgeek86
https://stackoverflow.com/a/21209726

Updated by Ninjigen - 01/08/2018
https://github.com/Ninjigen/PowerShell/tree/master/Robocopy

## RELATED LINKS
