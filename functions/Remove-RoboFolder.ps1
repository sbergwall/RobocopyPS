<#
.Synopsis
   Remove folder with help of Robocopy
.DESCRIPTION
   Creates a temporary folder in users TEMP directory, mirror the temp folder to the Path specificed.
   Removes the temp folder when done
.EXAMPLE
   Remove-RoboFolder -Path "C:\temp"
.EXAMPLE
   Get-Item G:\Temp | Remove-RoboFolder -WhatIf
#>

function Remove-RoboFolder {
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
                Remove-Item $Target -Force   

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