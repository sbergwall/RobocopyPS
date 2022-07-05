---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Sync-RoboItem

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Sync-RoboItem [-WhatIf] [-Confirm] [-Source] <String> [-Destination] <String> [-Force] [[-Level] <Int32>]
 [-RestartMode] [-BackupMode] [-RestartAndBackupMode] [-UnbufferedIO] [-EFSRaw] [[-CopyFlags] <String[]>]
 [[-DirectoryCopyFlags] <String[]>] [-CopyWithSecurity] [-CopyAllFileInformation] [-NoCopy] [-SecurityFix]
 [-Timefix] [-Purge] [[-AddAttribute] <String[]>] [[-RemoveAttribute] <String[]>] [-Create] [-FAT]
 [-IgnoreLongPath] [[-MonitorChanges] <Int32>] [[-MonitorMinutes] <Int32>] [[-Threads] <Int32>]
 [[-RunTimes] <String>] [-UsePerFileRunTimes] [[-InterPacketGap] <Int32>] [-CopyJunction] [-SymbolicLink]
 [-NoDirectoryInformation] [-NoOffload] [-Compress] [-Archive] [-ResetArchiveAttribute]
 [[-IncludeAttribute] <String[]>] [[-ExcludeAttribute] <String[]>] [[-ExcludeFileName] <String[]>]
 [[-ExcludeDirectory] <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeModifiedFile] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [[-MaximumFileSize] <String>] [[-MinimumFileSize] <String>] [[-MaximumFileAge] <String>]
 [[-MinimumFileAge] <String>] [[-MaximumFileLastAccessDate] <String>] [[-MinimumFileLastAccessDate] <String>]
 [-ExcludeJunctionPoints] [-AssumeFATFileTime] [-CompensateDST] [-ExcludeDirectoryJunctionPoints]
 [-ExcludeFileJunctionPoints] [[-Retry] <Int32>] [[-Wait] <Int32>] [-SaveRetrySettings] [-WaitForShareName]
 [-LowFreeSpaceMode] [[-LowFreeSpaceModeValue] <String>] [-List] [-ReportExtraFile] [-NoSizeToLog]
 [-NoClassToLog] [[-NoFileNameToLog] <Object>] [[-LogFile] <String>] [[-LogFileWithAppend] <String>] [-Unicode]
 [[-UnicodeLog] <String>] [[-UnicodeLogWithAppend] <String>] [[-JobName] <String>] [[-SaveJob] <String>]
 [-Quit] [-NoSourceDirectory] [-NoDestinationDirectory] [[-IncludeFollowingFile] <String>] [[-Unit] <String>]
 [[-Precision] <Int64>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AddAttribute
{{ Fill AddAttribute Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: R, A, S, H, C, N, E, T

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Archive
{{ Fill Archive Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: a

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssumeFATFileTime
{{ Fill AssumeFATFileTime Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: fft

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackupMode
{{ Fill BackupMode Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: b

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompensateDST
{{ Fill CompensateDST Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: dst

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Compress
{{ Fill Compress Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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

### -CopyAllFileInformation
{{ Fill CopyAllFileInformation Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: copyall

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyFlags
{{ Fill CopyFlags Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: copy
Accepted values: D, A, T, S, O, U

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyJunction
{{ Fill CopyJunction Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: sj

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CopyWithSecurity
{{ Fill CopyWithSecurity Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: sec

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Create
{{ Fill Create Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Destination
{{ Fill Destination Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Target

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DirectoryCopyFlags
{{ Fill DirectoryCopyFlags Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: dcopy
Accepted values: D, A, T

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EFSRaw
{{ Fill EFSRaw Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeAttribute
{{ Fill ExcludeAttribute Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xa
Accepted values: R, A, S, C, H, N, E, T, O

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeChangedFiles
{{ Fill ExcludeChangedFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xc

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeDirectory
{{ Fill ExcludeDirectory Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xd

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeDirectoryJunctionPoints
{{ Fill ExcludeDirectoryJunctionPoints Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xjd

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeExtraFiles
{{ Fill ExcludeExtraFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xx

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeFileJunctionPoints
{{ Fill ExcludeFileJunctionPoints Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xjf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeFileName
{{ Fill ExcludeFileName Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: xf

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeJunctionPoints
{{ Fill ExcludeJunctionPoints Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xj

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeLonelyFiles
{{ Fill ExcludeLonelyFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xl

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeNewerFiles
{{ Fill ExcludeNewerFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xn

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeOlderFiles
{{ Fill ExcludeOlderFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xo

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FAT
{{ Fill FAT Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreLongPath
{{ Fill IgnoreLongPath Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 256

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeAttribute
{{ Fill IncludeAttribute Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: ia
Accepted values: R, A, S, C, H, N, E, T, O

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeFollowingFile
{{ Fill IncludeFollowingFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: IF

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeModifiedFile
{{ Fill IncludeModifiedFile Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: im

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSameFiles
{{ Fill IncludeSameFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTweakedFiles
{{ Fill IncludeTweakedFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: it

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InterPacketGap
{{ Fill InterPacketGap Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ipg

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobName
{{ Fill JobName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Job

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Level
{{ Fill Level Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: lev, Depth

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -List
{{ Fill List Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: l

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
{{ Fill LogFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: log

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFileWithAppend
{{ Fill LogFileWithAppend Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LowFreeSpaceMode
{{ Fill LowFreeSpaceMode Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: lfsm

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LowFreeSpaceModeValue
{{ Fill LowFreeSpaceModeValue Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileAge
{{ Fill MaximumFileAge Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: maxage

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileLastAccessDate
{{ Fill MaximumFileLastAccessDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: maxlad

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumFileSize
{{ Fill MaximumFileSize Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: max

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileAge
{{ Fill MinimumFileAge Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: minage

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileLastAccessDate
{{ Fill MinimumFileLastAccessDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: minlad

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumFileSize
{{ Fill MinimumFileSize Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: min

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonitorChanges
{{ Fill MonitorChanges Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: mon

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonitorMinutes
{{ Fill MonitorMinutes Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: mot

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClassToLog
{{ Fill NoClassToLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: nc

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoCopy
{{ Fill NoCopy Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoDestinationDirectory
{{ Fill NoDestinationDirectory Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NODD

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoDirectoryInformation
{{ Fill NoDirectoryInformation Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: nodcopy

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoFileNameToLog
{{ Fill NoFileNameToLog Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases: nfl

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoOffload
{{ Fill NoOffload Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoSizeToLog
{{ Fill NoSizeToLog Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: ns

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoSourceDirectory
{{ Fill NoSourceDirectory Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NOSD

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Precision
{{ Fill Precision Description }}

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Purge
{{ Fill Purge Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quit
{{ Fill Quit Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveAttribute
{{ Fill RemoveAttribute Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: R, A, S, H, C, N, E, T

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReportExtraFile
{{ Fill ReportExtraFile Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: x

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResetArchiveAttribute
{{ Fill ResetArchiveAttribute Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: m

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestartAndBackupMode
{{ Fill RestartAndBackupMode Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: zb

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestartMode
{{ Fill RestartMode Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: z

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retry
{{ Fill Retry Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: r

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunTimes
{{ Fill RunTimes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: rh

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SaveJob
{{ Fill SaveJob Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Save

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SaveRetrySettings
{{ Fill SaveRetrySettings Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: reg

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityFix
{{ Fill SecurityFix Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: secfix

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
{{ Fill Source Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path, FullPath

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SymbolicLink
{{ Fill SymbolicLink Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: sl

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Threads
{{ Fill Threads Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: MT, MultiThread

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timefix
{{ Fill Timefix Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: timfix

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnbufferedIO
{{ Fill UnbufferedIO Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: j

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unicode
{{ Fill Unicode Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnicodeLog
{{ Fill UnicodeLog Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: unilog

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnicodeLogWithAppend
{{ Fill UnicodeLogWithAppend Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Unit
{{ Fill Unit Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Auto, PB, TB, GB, MB, KB, Bytes

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsePerFileRunTimes
{{ Fill UsePerFileRunTimes Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: pf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
{{ Fill Wait Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: w

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaitForShareName
{{ Fill WaitForShareName Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: tbd

Required: False
Position: Named
Default value: None
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
