---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Remove-RoboDirectory

## SYNOPSIS
Removes a directory using Robocopy.

## SYNTAX

```
Remove-RoboDirectory [-Target] <Object> [-BackupMode] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a directory by creating an empty temp directory in $env:Temp and using Robocopy with /mir on your Target folder.
Function will then remove the temp folder and the Target folder (Robocopy only removes the content).

## EXAMPLES

### EXAMPLE 1
```
Remove-RoboDirectory -Target G:\temp\ -WhatIf
```

What if: Performing the operation "Remove" on target "G:\temp\".

### EXAMPLE 2
```
Remove-RoboDirectory -Target G:\temp\
```

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove" on target "G:\temp\".
\[Y\] Yes  \[A\] Yes to All  \[N\] No  \[L\] No to All  \[S\] Suspend  \[?\] Help (default is "Y"): a


Command     : Robocopy.exe "C:\Users\admin\AppData\Local\Temp\21bf9f45-f87b-44e5-b8c2-319c4c012fd1" "G:\temp" *.* /r:3 /w:3 /mir /bytes /TEE /np /njh /fp /v /ndl /ts
TotalDir    : 357
TotalFile   : 128
TotalSize   : 5,6 GB
TotalTime   : 00:00:00
StartedTime : 2019-05-19 11:37:08
EndedTime   : 2019-05-19 11:37:08.NOTES

## PARAMETERS

### -Target
Param1 help description

```yaml
Type: Object
Parameter Sets: (All)
Aliases: Destination, Path

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -BackupMode
{{ Fill BackupMode Description }}

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
This function was created because using mirror over a folder you want to remove is fast and we dont need to worry about long path names.
We also can use backup mode.

## RELATED LINKS
