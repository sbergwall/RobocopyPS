---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Copy-RoboItem

## SYNOPSIS
Short description

## SYNTAX

### Level (Default)
```
Copy-RoboItem -Source <String> -Destination <String> [-Files <String[]>] [-Level <Int32>] [-WhatIf] [-Confirm]
 [-LogFile <String>] [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>] [-NoCopy] [-SecurityFix]
 [-Timefix] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>] [-FAT] [-IgnoreLongPath]
 [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <Int32>] [-RunTimes <String>]
 [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive] [-ResetArchiveAttribute]
 [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>] [-ExcludeFileName <String[]>]
 [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List]
 [<CommonParameters>]
```

### Recurse
```
Copy-RoboItem -Source <String> -Destination <String> [-Files <String[]>] [-Recurse] [-WhatIf] [-Confirm]
 [-LogFile <String>] [-BackupMode] [-RestartMode] [-EFSRaw] [-CopyFlags <String[]>] [-NoCopy] [-SecurityFix]
 [-Timefix] [-AddAttribute <String[]>] [-RemoveAttribute <String[]>] [-FAT] [-IgnoreLongPath]
 [-MonitorChanges <Int32>] [-MonitorMinutes <Int32>] [-Threads <Int32>] [-RunTimes <String>]
 [-UsePerFileRunTimes] [-InterPacketGap <Int32>] [-SymbolicLink] [-Archive] [-ResetArchiveAttribute]
 [-IncludeAttribute <String[]>] [-ExcludeAttribute <String[]>] [-ExcludeFileName <String[]>]
 [-ExcludeDirectory <String[]>] [-ExcludeChangedFiles] [-ExcludeNewerFiles] [-ExcludeOlderFiles]
 [-ExcludeExtraFiles] [-ExcludeLonelyFiles] [-IncludeSameFiles] [-IncludeTweakedFiles]
 [-MaximumFileSize <String>] [-MinimumFileSize <String>] [-MaximumFileAge <String>] [-MinimumFileAge <String>]
 [-MaximumFileLastAccessDate <String>] [-MinimumFileLastAccessDate <String>] [-ExcludeJunctionPoints]
 [-ExcludeFileJunctionPoints] [-ExcludeDirectoryJunctionPoints] [-AssumeFATFileTime] [-CompensateDST]
 [-Retry <Int32>] [-Wait <Int32>] [-SaveRetrySettings] [-WaitForShareName] [-Unit <String>] [-List]
 [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
Example of how to use this cmdlet
```

### EXAMPLE 2
```
Another example of how to use this cmdlet
```

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

### -Level
{{ Fill Level Description }}

```yaml
Type: Int32
Parameter Sets: Level
Aliases: lev, Depth

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse
{{ Fill Recurse Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Recurse
Aliases:

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

### -AddAttribute
{{ Fill AddAttribute Description }}

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

### -CopyFlags
{{ Fill CopyFlags Description }}

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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeChangedFiles
{{ Fill ExcludeChangedFiles Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: xct

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
Position: Named
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
Position: Named
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
Position: Named
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
Aliases:

Required: False
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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

### -RemoveAttribute
{{ Fill RemoveAttribute Description }}

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
Position: Named
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
Position: Named
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
Aliases: MT

Required: False
Position: Named
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

### -Unit
{{ Fill Unit Description }}

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
Position: Named
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
