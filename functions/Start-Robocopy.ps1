
    
[regex] $HeaderRegex = '\s+Total\s*Copied\s+Skipped\s+Mismatch\s+FAILED\s+Extras'
[regex] $DirLineRegex = 'Dirs\s*:\s*(?<DirCount>\d+)(?:\s+\d+){3}\s+(?<DirFailed>\d+)\s+\d+'
[regex] $FileLineRegex = 'Files\s*:\s*(?<FileCount>\d+)(?:\s+\d+){3}\s+(?<FileFailed>\d+)\s+\d+'
[regex] $BytesLineRegex = 'Bytes\s*:\s*(?<ByteCount>\d+)(?:\s+\d+){3}\s+(?<BytesFailed>\d+)\s+\d+'
[regex] $TimeLineRegex = 'Times\s*:\s*(?<TimeElapsed>\d+).*'
[regex] $EndedLineRegex = 'Ended\s*:\s*(?<EndedTime>.+)'
[regex] $SpeedLineRegex = 'Speed\s:\s+(\d+)\sBytes\/sec'
[regex] $JobSummaryEndLineRegex = '[-]{78}'
[regex] $SpeedInMinutesRegex = 'Speed\s:\s+(\d+).(\d+)\sMegaBytes\/min'

$StartTime = $(Get-Date)    
filter isRc { if ($_ -ne "") { $_ } }
$Source = "E:\DLs"
$Destination = "E:\DL2"
$RoboArgs = " /bytes /mir /tee /np /ns /njh /nc /fp /r:1 /w:1" -split " " # Space before /bytes so output object look correct
Robocopy.exe $Source $Destination $RoboArgs | isRc | ForEach-Object {

    If ($_ -match 'ERROR \d \(0x\d{1,11}\)') {
        # First rule is if we catch an error we will write a warning with the path and error text from Robocopy
        Write-Warning $_
    }

    elseif ($_ -like "*$Source*") {
        # If no error is found we will output the file name. We are using split because when we use /bytes in the Robocopy args we also output each files size.
        Write-Verbose -Message ("Processing {1}" -f $PSitem.Trim().Split("`t"))
    }

    elseif ($_ -match "$HeaderRegex|$DirLineRegex|$FileLineRegex|$BytesLineRegex|$TimeLineRegex|$EndedLineRegex|$SpeedLineRegex|$JobSummaryEndLineRegex|$SpeedInMinutesRegex") {

        # Catch all the summary lines and transform it if no error was found and the passed text didnt contain text from the source.
        # Some we will just assign to variables or dont do anything with
        Switch -Regex ($_) {
            $JobSummaryEndLine { }
            $HeaderRegex { }
            $DirLineRegex { $TotalDirs, $TotalDirCopied, $TotalDirIgnored, $TotalDirMismatched, $TotalDirFailed, $TotalDirExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
            $FileLineRegex { $TotalFiles, $TotalFileCopied, $TotalFileIgnored, $TotalFileMismatched, $TotalFileFailed, $TotalFileExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
            $BytesLineRegex { $TotalBytes, $TotalBytesCopied, $TotalBytesIgnored, $TotalBytesMismatched, $TotalBytesFailed, $TotalBytesExtra = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
            $TimeLineRegex { [TimeSpan]$TotalDuration, [TimeSpan]$CopyDuration, [TimeSpan]$FailedDuration, [TimeSpan]$ExtraDuration = $PSitem | Select-String -Pattern '\d?\d\:\d{2}\:\d{2}' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
            $EndedLineRegex { }
            $SpeedLineRegex { $TotalSpeedBytes = $PSitem | Select-String -Pattern '\d+' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } }
            $SpeedInMinutesRegex { }
        } # end Switch 
    }

    else {
        # Output all lines we dont have rules for
        $PSitem
    }
}


$endtime = $(Get-Date) 
    

[PSCustomObject][ordered]@{
    'Source'               = $Source
    'Destination'          = $Destination
    'Command'              = 'Robocopy.exe' + $RoboArgs -join " "
    'DirCount'             = $TotalDirs
    'FileCount'            = $TotalFiles
    #'Duration'     = $TotalDuration
    'DirCopied'            = $TotalDirCopied
    'FileCopied'           = $TotalFileCopied
    #'CopyDuration' = $CopyDuration
    'DirIgnored'           = $TotalDirIgnored
    'FileIgnored'          = $TotalFileIgnored
    'DirMismatched'        = $TotalDirMismatched
    'FileMismatched'       = $TotalFileMismatched
    'DirFailed'            = $TotalDirFailed
    'FileFailed'           = $TotalFileFailed
    #'FailedDuration'   = $FailedDuration
    'DirExtra'             = $TotalDirExtra
    'FileExtra'            = $TotalFileExtra
    #'ExtraDuration'    = $ExtraDuration
    'TotalTime'            = "{0:HH:mm:ss}" -f ([datetime]$($endtime - $StartTime).Ticks)
    'StartedTime'          = $StartTime
    'EndedTime'            = $endTime
    'TotalBytes'           = $TotalBytes
    'TotalBytesCopied'     = $TotalBytesCopied
    'TotalBytesIgnored'    = $TotalBytesIgnored
    'TotalBytesMismatched' = $TotalBytesMismatched
    'TotalBytesFailed'     = $TotalBytesFailed
    'TotalBytesExtra'      = $TotalBytesExtra
    'Speed'                = (Format-SpeedHumanReadable $TotalSpeedBytes) + '/s'
    'ExitCode'             = $LASTEXITCODE
    'Success'              = If ($RoboRun.ExitCode -lt 8) { $true } else { $false }
}
