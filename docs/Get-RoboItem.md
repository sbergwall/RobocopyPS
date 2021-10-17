---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Get-RoboItem

## SYNOPSIS
Get information about file or directories with Robocopy.

## SYNTAX

```
Get-RoboItem [-Path] <String[]> [[-Files] <String[]>] [-Recurse] [[-Level] <Int32>] [-RestartMode]
 [-BackupMode] [-RestartAndBackupMode] [-ExcludeFileName <String[]>] [-ExcludeDirectory <String[]>]
 [-Unit <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Get information like directory size or number of directories in any give location with the help of Robocopy.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-RoboItem -Path "E:\Anno 1800\" -Recurse

Source              : E:\Anno 1800\
Destination         : C:\Users\simon\AppData\Local\Temp
Command             : Robocopy.exe "E:\Anno 1800" "C:\Users\simon\AppData\Local\Temp" *.* /r:3 /w:3 /e /l /bytes /TEE /np /njh /fp /ndl /ts
DirCount            : 18
FileCount           : 230
DirCopied           : 17
FileCopied          : 230
DirIgnored          : 1
FileIgnored         : 0
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 20
FileExtra           : 42
TotalTime           : 00:00:00
StartedTime         : 2021-08-20 16:30:07
EndedTime           : 2021-08-20 16:30:07
TotalSize           : 60 GB
TotalSizeCopied     : 60 GB
TotalSizeIgnored    : 0 B
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 3,2 MB
Speed               : 0 B/s
ExitCode            : 3
Success             : True
LastExitCodeMessage : [SUCCESS]Some files were copied. Additional files were present. No failure was encountered.
```

Get the number and size of files and subdirectories on location "E:\Anno 1800"

### Example 2: Multiple directories
```powershell
Get-RoboItem -Path "E:\Anno 1800\","D:\tmp\"

Source              : E:\Anno 1800\
Destination         : C:\Users\simon\AppData\Local\Temp
Command             : Robocopy.exe "E:\Anno 1800" "C:\Users\simon\AppData\Local\Temp" *.* /r:3 /w:3 /l /bytes /TEE /np /njh /fp /ndl /ts
DirCount            : 1
FileCount           : 2
DirCopied           : 0
FileCopied          : 2
DirIgnored          : 1
FileIgnored         : 0
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 22
FileExtra           : 45
TotalTime           : 00:00:00
StartedTime         : 2021-08-21 08:37:05
EndedTime           : 2021-08-21 08:37:05
TotalSize           : 1 MB
TotalSizeCopied     : 1 MB
TotalSizeIgnored    : 0 B
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 1,1 MB
Speed               : 0 B/s
ExitCode            : 3
Success             : True
LastExitCodeMessage : [SUCCESS]Some files were copied. Additional files were present. No failure was encountered.

Source              : D:\tmp\
Destination         : C:\Users\simon\AppData\Local\Temp
Command             : Robocopy.exe "D:\tmp" "C:\Users\simon\AppData\Local\Temp" *.* /r:3 /w:3 /l /bytes /TEE /np /njh /fp /ndl /ts
DirCount            : 1
FileCount           : 5
DirCopied           : 0
FileCopied          : 5
DirIgnored          : 1
FileIgnored         : 0
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 21
FileExtra           : 45
TotalTime           : 00:00:00
StartedTime         : 2021-08-21 08:37:05
EndedTime           : 2021-08-21 08:37:05
TotalSize           : 17 KB
TotalSizeCopied     : 17 KB
TotalSizeIgnored    : 0 B
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 1,1 MB
Speed               : 0 B/s
ExitCode            : 3
Success             : True
LastExitCodeMessage : [SUCCESS]Some files were copied. Additional files were present. No failure was encountered.
```

Get Robocopy information about multiple directories.

### Example 3: Pipe from Get-Childitem
```powershell
PS C:\> Get-ChildItem -Path 'E:\Anno 1800\' -Recurse -Directory -Depth 1 | Get-RoboItem -Unit MB -Recurse -RestartAndBackupMode | Out-GridView
```

Get information including directorys size of all subfolders for a folder in MB.

## PARAMETERS

### -BackupMode
Get files in Backup mode.

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

### -Files
Specifies the file or files. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Level
Get only the top N levels of the source directory tree.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: lev, Depth

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path to directory.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: FullPath

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Recurse
Includes subdirectories and files.

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

### -RestartAndBackupMode
Get files in restartable mode. If file access is denied, switches to backup mode.

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
Get files in restartable mode.

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

### -Unit
What unit the sizes are shown as

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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
