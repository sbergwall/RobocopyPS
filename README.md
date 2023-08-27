# RobocopyPS

| Powershell Gallery | Dev branch | Main branch |
|------------|-----|------|
| ![](https://img.shields.io/powershellgallery/dt/robocopyPS) | ![Dev Branch](https://github.com/sbergwall/RobocopyPS/actions/workflows/tests.yml/badge.svg?branch=dev) | ![Main Branch](https://github.com/sbergwall/RobocopyPS/actions/workflows/tests.yml/badge.svg?branch=master) |


## Description

RobocopyPS is a PowerShell module with the intention to be a wrapper for [Robocopy.exe](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy) and output Robocopys information to PowerShell streams (Verbose, Error etc).

RobocopyPS only works if the language is set to en-US. This is because we look at each line of output from Robocopy and make a decision on what stream to use. If the language is not english we are not sure what to do.

If we do not know what stream to output to we use the Information stream, so if you are missing output try and run with -InformationAction Continue

You can use all Robocopys native parameters like -e, -mir etc but we try and translate them to easier parameter names as -Recurse and -Mirror instead.

# Installation

The easiest way to get RobocopyPS is using the [PowerShell Gallery](https://powershellgallery.com/packages/RobocopyPS/)!

``` PowerShell
Install-Module -Name RobocopyPS
```

# Usage

## Invoke-Robocopy

Invoke-RoboCopy is the core function used by RobocopyPS and will contain all parameters that can be used with Robocopy.exe. Most, if not all, other functions will call Invoke-RoboCopy.

Copy all items from C:\tmp\from\ to C:\tmp\to\\. Include subdirectories that is empty and create a log file at C:\tmp\log.log
```` PowerShell
Invoke-RoboCopy -Source C:\tmp\from\ -Destination C:\tmp\to\ -IncludeEmptySubDirectories -LogFile C:\tmp\log.log
````

Move all items from C:\tmp\from\ to C:\tmp\to\\. Note that this will remove C:\tmp\from\ when Robocopy is done
```` PowerShell
Invoke-RoboCopy -Source C:\tmp\from\ -Destination C:\tmp\to\ -MoveFilesAndDirectories
````

# Other functions

Other functions are usually using Invoke-Robocopy under the hood but exist for convenience for the user to easier understand what the specific function does.

## Copy-RoboItem

Copy items from one directory to another, including empty subdirectories. Using -Force will create the destination folder if it does not exist.

```` PowerShell
Copy-RoboItem -Source C:\tmp\from\ -Destination C:\tmp\to\ -IncludeEmptySubDirectories -Force
````

## Get-RoboItem

List information about a directory, including file count and total folder size, and using -Unit will show the size in bytes.

```` PowerShell
Get-RoboItem -Path C:\tmp\from\ -Unit Bytes
````

## Move-RoboItem

Move D:\tmp\from to destination D:\tmp\to.

```` PowerShell
Move-RoboItem -Source D:\tmp\from\ -Destination D:\tmp\to
````

## Remove-RoboItem

Remove multiple directories.

```` PowerShell
Remove-RoboItem -Path "D:\dir1","D:\dir2"
````

# Release History

A detailed release history is contained in the [Change Log](CHANGELOG.md).

# License

RobocopyPS is provided under the [MIT license](LICENSE.md).