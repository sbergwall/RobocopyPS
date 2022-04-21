---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Remove-RoboItem

## SYNOPSIS
Remove directory.

## SYNTAX

```
Remove-RoboItem [-Path] <String[]> [-RestartMode] [-BackupMode] [-RestartAndBackupMode] [-Threads <Int32>]
 [[-Retry] <Int32>] [[-Wait] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove one or more directories with the help of Robocopy by creating a temporary directory and mirror the empty content to the specified directories.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-RoboItem -Path "D:\dir1","D:\dir2"
```

Remove multiple directories.

## PARAMETERS

### -BackupMode
Remove directories in Backup mode.

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

### -Path
Specify which directory or directories you want to remove.

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

### -RestartAndBackupMode
Remove directories in restartable mode. If file access is denied, switches to backup mode.

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
Remove directories in restartable mode.

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
Specifies the number of retries. Default is 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: r

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Specifies the wait time between retries, in seconds. The default value of N is 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: w

Required: False
Position: 2
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

### -Threads
Creates multi-threaded copies with N threads. N must be an integer between 1 and 128.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: MT, MultiThread

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
