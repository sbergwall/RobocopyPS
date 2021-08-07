# RobocopyPS

[![Build status](https://ci.appveyor.com/api/projects/status/2hpug3ow4yv1810a/branch/master?svg=true)](https://ci.appveyor.com/project/sbergwall/robocopyps/branch/master)


## Description

RobocopyPS is a PowerShell module with the intention to be a wrapper for Robocopy.exe and output Robocopys information to PowerShell streams (Verbose, Error etc).

RobocopyPS only works if the language is set to en-US. This is because we look at each line of output from Robocopy and make a decision on what stream to use. If the language is not english we are not sure what to do.

If we do not know what stream to output to we use the Information stream, so if you are missing output try and run with -InformationAction Continue

You can use all Robocopys native parameters like -e, -mir etc but we try and translate them to easier parameter names as -Recurse and -Mirror instead. Some parameters cannot be ran with eachother, example -Mirror and -Recurse.

## Getting started

The easiest way to get RobocopyPS is using the [PowerShell Gallery](https://powershellgallery.com/packages/RobocopyPS/)!

### Installing the module

``` PowerShell
PS> Install-Module -Name RobocopyPS
```

### Example: Copy with Recurse

```` PowerShell
PS > Invoke-RoboCopy -Source "E:\Google Drive\Script Library" -Destination G:\Temp\ -Recurse  -Unit Bytes

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

````

### Example: List

This will only list all your files to verbose and output information. No copy, delete or mirror will be done.

```` PowerShell
PS$ > Invoke-RoboCopy -Source "C:\Users\Simon\Downloads\" -Destination NULL -List -Recurse -Verbose
VERBOSE: Performing the operation "List" on target "NULL from C:\Users\Simon\Downloads\".
VERBOSE: "List File" on "Item C:\Users\Simon\Downloads\desktop.ini" to target "NULL" Status on Item "New File". Length on Item "282". TimeStamp on Item "6/22/2019 2:28:00 PM"
VERBOSE: "List File" on "Item C:\Users\Simon\Downloads\SteamSetup.exe" to target "NULL" Status on Item "New File". Length on Item "1573568". TimeStamp on Item "6/27/2019 9:20:02 AM"
VERBOSE: "List File" on "Item C:\Users\Simon\Downloads\VeeamBackup&Replication_9.5.4.2753.Update4a.iso" to target "NULL" Status on Item "New File". Length on Item "5208592384". TimeStamp on Item
"7/11/2019 8:54:34 PM"
VERBOSE: "List File" on "Item C:\Users\Simon\Downloads\Windows10Upgrade9252.exe" to target "NULL" Status on Item "New File". Length on Item "6254480". TimeStamp on Item "6/22/2019 11:15:55 AM"


Source              : C:\Users\Simon\Downloads\
Destination         : NULL
Command             : Robocopy.exe "C:\Users\Simon\Downloads" "NULL" *.* /r:3 /w:3 /e /l /bytes /TEE /np /njh /fp /v /ndl /ts
DirCount            : 1
FileCount           : 4
DirCopied           : 1
FileCopied          : 4
DirIgnored          : 0
FileIgnored         : 0
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 0
FileExtra           : 0
TotalTime           : 00:00:00
StartedTime         : 7/16/2019 10:16:39 PM
EndedTime           : 7/16/2019 10:16:39 PM
TotalSize           : 4.9 GB
TotalSizeCopied     : 4.9 GB
TotalSizeIgnored    : 0 B
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 0 B
Speed               : 0 B/s
ExitCode            : 1
Success             : True
LastExitCodeMessage : [SUCCESS]All files were copied successfully.
````

### Example: How RobocopyPS handle native Robocopy errors

In this example we try to use the -Backup parameter (/B) without having permission to do so. Invoke-Robocopy, at the moment, do not know if it should be a terminating or a non terminating error in PowerShell, so it will throw all errors it can find as non terminating and continue.

```` PowerShell
PS$ > Invoke-RoboCopy -Source "C:\Users\Simon\Downloads\" -Destination NULL -List -Recurse -Verbose -BackupMode                                                                                                                                                    VERBOSE: Performing the operation "List" on target "NULL from C:\Users\Simon\Downloads\".
Invoke-RoboCopy : ERROR : You do not have the Backup and Restore Files user rights.. *****  You need these to perform Backup copies (/B or /ZB).
At line:1 char:1
+ Invoke-RoboCopy -Source "C:\Users\Simon\Downloads\" -Destination NULL ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Invoke-RoboCopy], Exception
    + FullyQualifiedErrorId : Invoke-RoboCopy

Invoke-RoboCopy : ERROR : Robocopy ran out of memory, exiting.. ERROR : Invalid Parameter #%d : "%s"
At line:1 char:1
+ Invoke-RoboCopy -Source "C:\Users\Simon\Downloads\" -Destination NULL ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Invoke-RoboCopy], Exception
    + FullyQualifiedErrorId : Invoke-RoboCopy

Invoke-RoboCopy : ERROR : Invalid Job File, Line #%d :"%s". Started : %s %s
At line:1 char:1
+ Invoke-RoboCopy -Source "C:\Users\Simon\Downloads\" -Destination NULL ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Invoke-RoboCopy], Exception
    + FullyQualifiedErrorId : Invoke-RoboCopy


Source              : C:\Users\Simon\Downloads\
Destination         : NULL
Command             : Robocopy.exe "C:\Users\Simon\Downloads" "NULL" *.* /r:3 /w:3 /e /b /l /bytes /TEE /np /njh /fp /v /ndl /ts
DirCount            : 0
FileCount           : 0
DirCopied           : 0
FileCopied          : 0
DirIgnored          : 0
FileIgnored         : 0
DirMismatched       : 0
FileMismatched      : 0
DirFailed           : 0
FileFailed          : 0
DirExtra            : 0
FileExtra           : 0
TotalTime           : 00:00:00
StartedTime         : 7/16/2019 10:21:53 PM
EndedTime           : 7/16/2019 10:21:53 PM
TotalSize           : 0 B
TotalSizeCopied     : 0 B
TotalSizeIgnored    : 0 B
TotalSizeMismatched : 0 B
TotalSizeFailed     : 0 B
TotalSizeExtra      : 0 B
Speed               : 0 B/s
ExitCode            : 16
Success             : False
LastExitCodeMessage : [ERROR]Robocopy did not copy any files. Either a usage error or an error due to insufficient access privileges on the source or destination directories.
````


## Release History

A detailed release history is contained in the [Change Log](CHANGELOG.md).

## License

RobocopyPS is provided under the [MIT license](LICENSE.md).