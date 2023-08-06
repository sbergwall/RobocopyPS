Function Invoke-RobocopyParser {
    <#
    .SYNOPSIS
    Parse Robocopy.exe output

    .DESCRIPTION
    This function will try and parse the output from when you run Robocopy.exe and give you information about what PowerShell stream should be used.

    .EXAMPLE
    PS$ >
    #>


    [CmdletBinding()]

    PARAM (
        # Robocopy text
        [Parameter(ValueFromPipeline = $true)]
        [String]
        $InputObject,

        # What unit the sizes are shown as
        [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
        [String]$Unit = 'Auto',

        [ValidateRange(1,28)]
        [System.Int64]$Precision = 4
    )

    begin {
        # We have a corresponding $endtime to measure how long the code ran for
        $StartTime = $(Get-Date)

        # Regex for catching all text that will be sent to Error Stream
        $ErrorFilter = @(
            "The filename, directory name, or volume label syntax is incorrect.",
            "\*\*\*\*\*  You need these to perform Backup copies \(\/B or \/ZB\).",
            "ERROR \d{1,3} \(0x\d{1,11}\)",
            "ERROR : ",
            "ERROR: RETRY LIMIT EXCEEDED.",
            "ERROR 123"
        ) -join '|'

        # Regex for catching all text that will be sent to Warning Stream
        $WarningFilter = @(
            "Waiting $Wait seconds... Retrying..."
            "Pausing to wait for free space"
        ) -join '|'

        # Regex filter used for finding strings we want to handle in Robocopy output. This is also used when we find specific strings in the output
        [regex] $HeaderRegex = '\s+Total\s*Copied\s+Skipped\s+Mismatch\s+FAILED\s+Extras'
        [regex] $DirLineRegex = 'Dirs\s*:\s*(?<DirCount>\d+)(?:\s+\d+){3}\s+(?<DirFailed>\d+)\s+\d+'
        [regex] $FileLineRegex = 'Files\s*:\s*(?<FileCount>\d+)(?:\s+\d+){3}\s+(?<FileFailed>\d+)\s+\d+'
        [regex] $BytesLineRegex = 'Bytes\s*:\s*(?<ByteCount>\d+)(?:\s+\d+){3}\s+(?<BytesFailed>\d+)\s+\d+'
        [regex] $TimeLineRegex = 'Times\s*:\s*(?<TimeElapsed>\d+).*'
        [regex] $EndedLineRegex = 'Ended\s*:\s*(?<EndedTime>.+)'
        [regex] $SpeedLineRegex = 'Speed\s:\s+(\d+)\sBytes\/sec|Speed\s*:\s*([\d\s,]+)\s*Bytes\/sec\.'
        [regex] $JobSummaryEndLineRegex = '[-]{78}'
        [regex] $SpeedInMinutesRegex = 'Speed\s:\s+(\d+).(\d+)\sMegaBytes\/min'
        [regex] $FileInfoRegex = "\s*(?<status>[\*A-Za-z]+|([\*A-Za-z]+\s+[A-Za-z]+)|)\s+(?<size>[0-9]+)\s+(?<timestamp>([0-9]{4}\/[01][0-9]\/[0-3][0-9])\s+([0-2][0-9]:[0-5][0-9]:[0-5][0-9]))\s+(?<path>.+)\s*$"
    }

    Process {
        try {

            If ($InputObject -match $ErrorFilter -or $ForceNextLineIntoError -eq $true) {
                # If any error happened we set $errorOccured to $true.
                # This is used in the output Property Success. If $errorOccured is $true we set Success to $false
                $errorOccured = $true

                If ($null -eq $Message) {
                    $Message = $inputobject
                    $ForceNextLineIntoError = $true
                }
                else {
                    $LastMessage = ("{0}. {1}" -f $Message, $inputobject.trim())
                    $ForceNextLineIntoError = $false
                    $Message = $null
                    $SplitMessage = $LastMessage -split '(ERROR \d \(0x\d{1,11}\) )'
                    [PSCustomObject]@{
                        Value     = $LastMessage
                        Stream    = "Error"
                        Exception = $SplitMessage[2]
                        ErrorID   = $SplitMessage[1]
                    }
                }
            }

            ElseIf ($InputObject -match $FileInfoRegex) {
                $timestamp = [DateTime]::Parse($Matches.timestamp)
                $Extension = [System.IO.Path]::GetExtension($Matches.Path)
                $FileName = [System.IO.Path]::GetFileName($Matches.Path)

                [PSCustomObject]@{
                    Extension = $Extension
                    Name      = $FileName
                    FullName  = $Matches.Path
                    Length    = $Matches.Size
                    TimeStamp = $TimeStamp
                    Status    = $Matches.Status
                    Stream    = "Verbose"
                }
            }

            ElseIf ($InputObject -match "$HeaderRegex|$DirLineRegex|$FileLineRegex|$BytesLineRegex|$TimeLineRegex|$EndedLineRegex|$SpeedLineRegex|$JobSummaryEndLineRegex|$SpeedInMinutesRegex") {
                # Some we will just assign to variables and dont use or dont do anything with
                Switch -Regex ($inputobject) {
                    $JobSummaryEndLine { }
                    $HeaderRegex { }
                    $DirLineRegex { $TotalDirs, $TotalDirCopied, $TotalDirIgnored, $TotalDirMismatched, $TotalDirFailed, $TotalDirExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                    $FileLineRegex { $TotalFiles, $TotalFileCopied, $TotalFileIgnored, $TotalFileMismatched, $TotalFileFailed, $TotalFileExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                    $BytesLineRegex { $TotalBytes, $TotalBytesCopied, $TotalBytesIgnored, $TotalBytesMismatched, $TotalBytesFailed, $TotalBytesExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                    #$TimeLineRegex { [TimeSpan]$TotalDuration, [TimeSpan]$CopyDuration, [TimeSpan]$FailedDuration, [TimeSpan]$ExtraDuration = $PSitem | Select-String -Pattern '\d?\d\:\d{2}\:\d{2}' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value } }
                    $EndedLineRegex { }
                    $SpeedLineRegex { $TotalSpeedBytes, $null = ($PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $PSitem.Matches } | ForEach-Object { $PSitem.Value }) -join "" } # fix for issue 18
                    $SpeedInMinutesRegex { }
                }
            }

            elseif ($InputObject -match $WarningFilter) {
                [PSCustomObject]@{
                    Value  = $InputObject
                    Stream = "Warning"
                }
            }

            ElseIf ($InputObject) {
                # Write all strings to Information stream that we dont have rules for
                [PSCustomObject]@{
                    Value  = $InputObject
                    Stream = "Information"
                }
            }
        }
        catch {
            Write-Warning "cannot parse output line: ${InputObject}: $($PSItem.Exception.Message)"
            [PSCustomObject]@{
                Value  = $InputObject
                Stream = "Information"
            }
        }
    }

    end {

        # Exit Code lookup "table"
        $LastExitCodeMessage = switch ($LASTEXITCODE) {
            0 { 'No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped.' }
            1 { 'All files were copied successfully.' }
            2 { 'There are some additional files in the destination directory that are not present in the source directory. No files were copied.' }
            3 { 'Some files were copied. Additional files were present. No failure was encountered.' }
            4 { 'Some Mismatched files or directories were detected. Examine the output log. Housekeeping might be required.' }
            5 { 'Some files were copied. Some files were mismatched. No failure was encountered.' }
            6 { 'Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory.' }
            7 { 'Files were copied, a file mismatch was present, and additional files were present.' }
            8 { 'Several files did not copy.(copy errors occurred and the retry limit was exceeded). Check these errors further.' }
            9 { 'Some files did copy, but copy errors occurred and the retry limit was exceeded. Check these errors further.' }
            10 { 'Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.' }
            11 { 'Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.' }
            12 { 'Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.' }
            13 { 'Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.' }
            14 { 'Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.' }
            15 { 'Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.' }
            16 { 'Robocopy did not copy any files. Either a usage error or an error due to insufficient access privileges on the source or destination directories.' }
            default { '[WARNING]No message associated with this exit code. ExitCode: {0}' -f $LASTEXITCODE }
        }

        # We have a corresponding $starttime to measure how long the code ran for
        $endtime = $(Get-Date)

        $FormatSpeedSplatting = @{
            Unit = $Unit
            Precision = $Precision
        }

        [PSCustomObject]@{
            'Source'                = [System.IO.DirectoryInfo]$Source
            'Destination'           = [System.IO.DirectoryInfo]$Destination
            'Command'               = 'Robocopy.exe ' + ($RoboArgs | ForEach-Object {[string]$_}) -join " "
            'DirCount'              = [int]$TotalDirs
            'FileCount'             = [int]$TotalFiles
            #'Duration'     = $TotalDuration
            'DirCopied'             = [int]$TotalDirCopied
            'FileCopied'            = [int]$TotalFileCopied
            #'CopyDuration' = $CopyDuration
            'DirIgnored'            = [int]$TotalDirIgnored
            'FileIgnored'           = [int]$TotalFileIgnored
            'DirMismatched'         = [int]$TotalDirMismatched
            'FileMismatched'        = [int]$TotalFileMismatched
            'DirFailed'             = [int]$TotalDirFailed
            'FileFailed'            = [int]$TotalFileFailed
            #'FailedDuration'   = $FailedDuration
            'DirExtra'              = [int]$TotalDirExtra
            'FileExtra'             = [int]$TotalFileExtra
            #'ExtraDuration'    = $ExtraDuration
            'TotalTime'             = "{0:g}" -f ($endtime - $StartTime)
            'StartedTime'           = [datetime]$StartTime
            'EndedTime'             = [datetime]$endTime
            'TotalSize'             = (Format-SpeedHumanReadable $Totalbytes @FormatSpeedSplatting)
            'TotalSizeCopied'       = (Format-SpeedHumanReadable $TotalBytesCopied @FormatSpeedSplatting)
            'TotalSizeIgnored'      = (Format-SpeedHumanReadable $TotalBytesIgnored @FormatSpeedSplatting)
            'TotalSizeMismatched'   = (Format-SpeedHumanReadable $TotalBytesMismatched @FormatSpeedSplatting)
            'TotalSizeFailed'       = (Format-SpeedHumanReadable $TotalBytesFailed @FormatSpeedSplatting)
            'TotalSizeExtra'        = (Format-SpeedHumanReadable $TotalBytesExtra @FormatSpeedSplatting)
            'TotalSizeBytes'        = [int64]$Totalbytes
            'Speed'                 = (Format-SpeedHumanReadable $TotalSpeedBytes @FormatSpeedSplatting) + '/s'
            'ExitCode'              = $LASTEXITCODE
            'Success'               = If ($LASTEXITCODE -lt 8 -and $errorOccured -ne $true) { $true } else { $false }
            'LastExitCodeMessage'   = [string]$LastExitCodeMessage
        }
    }
}