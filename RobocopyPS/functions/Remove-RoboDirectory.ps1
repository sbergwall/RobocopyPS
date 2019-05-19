<#
.Synopsis
   Removes a directory using Robocopy.
.DESCRIPTION
   Removes a directory by creating an empty temp directory in $env:Temp and using Robocopy with /mir on your Target folder.
   Function will then remove the temp folder and the Target folder (Robocopy only removes the content).
.EXAMPLE
    Remove-RoboDirectory -Target G:\temp\ -WhatIf
    What if: Performing the operation "Remove" on target "G:\temp\".
.EXAMPLE
    Remove-RoboDirectory -Target G:\temp\

    Confirm
    Are you sure you want to perform this action?
    Performing the operation "Remove" on target "G:\temp\".
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): a


    Command     : Robocopy.exe "C:\Users\admin\AppData\Local\Temp\21bf9f45-f87b-44e5-b8c2-319c4c012fd1" "G:\temp" *.* /r:3 /w:3 /mir /bytes /TEE /np /njh /fp /v /ndl /ts
    TotalDir    : 357
    TotalFile   : 128
    TotalSize   : 5,6 GB
    TotalTime   : 00:00:00
    StartedTime : 2019-05-19 11:37:08
    EndedTime   : 2019-05-19 11:37:08.NOTES
.NOTES
   This function was created because using mirror over a folder you want to remove is fast and we dont need to worry about long path names. We also can use backup mode.
#>

function Remove-RoboDirectory {
    
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'High')]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('Destination', 'Path')]
        $Target,

        [switch]
        $BackupMode
    )

    Begin {}

    Process {
        if ($pscmdlet.ShouldProcess("$Target", 'Remove')) {
            try {
                Write-Verbose "Creating temporary folder"
                $TempDirectory = New-Item -Name ([System.Guid]::NewGuid()) -Path $env:TEMP -ItemType Directory -ErrorAction Stop

                $PSBoundParameters.Add("Source", "$TempDirectory")
                $PSBoundParameters.Add("Mirror", $true)
                
                Write-Verbose "Invoke Start-Robocopy"
                $Result = Start-Robocopy @PSBoundParameters

                If ($Result.Success -eq $true) { 
                    # Only run Remove-Item if Robocopy was successful
                    Remove-Item $Target -Force -Recurse
                } 

                If (Test-Path $TempDirectory) {
                    Write-Verbose "Remove Temporary Folder"
                    Remove-Item $TempDirectory
                }

                [PSCustomObject]@{
                    Command     = $Result.Command
                    TotalDir    = $Result.DirExtra
                    TotalFile   = $Result.FileExtra
                    TotalSize   = $Result.TotalSizeExtra
                    TotalTime   = $Result.TotalTime
                    StartedTime = $Result.StartedTime
                    EndedTime   = $Result.EndedTime
                }

            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End {}
}
