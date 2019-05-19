---
external help file: RobocopyPS-help.xml
Module Name: RobocopyPS
online version:
schema: 2.0.0
---

# Get-RoboChildItem

## SYNOPSIS
Gets files and folders, similar to Get-ChildItem but with Robocopy.

## SYNTAX

```
Get-RoboChildItem [-Source] <String> [-BackupMode] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Gets files and folders, similar to Get-ChildItem but with Robocopy.

## EXAMPLES

### EXAMPLE 1
```
Get-RoboChildItem -Source 'C:\temp\'
```

Extension : html
Name      : GPReport.html
FullName  : C:\tmp 2\GPReport.html
Length    : 200050
TimeStamp : 2019-01-06 15:01:19

Extension : txt
Name      : log.txt
FullName  : C:\tmp 2\log.txt
Length    : 1220
TimeStamp : 2018-08-12 18:13:15

### EXAMPLE 2
```
Get-RoboChildItem -Source 'C:\Windows' -BackupMode
```

## PARAMETERS

### -Source
Param1 help description

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
Function need the full name to a path for it to work at this point in time.
Example C:\Temp will work as Source but .\temp wont.

## RELATED LINKS
