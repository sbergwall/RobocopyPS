<#
.Synopsis
   Remove folder with help of Robocopy
.DESCRIPTION
   Creates a temporary folder in users TEMP directory, mirror the temp folder to the Path specificed.
   Removes the temp folder when done
.EXAMPLE
   Remove-RoboFolder -Path "C:\temp"
.NOTES
   General notes
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
        [Alias('Target', 'Destination')]
        $Path
    )

    Begin {
        Write-Verbose "Creating temporary folder"
        $TempDirectory = New-Item -Name ([System.Guid]::NewGuid()) -Path $env:TEMP -ItemType Directory -Force -ErrorAction Stop
    
    }
    Process {
        if ($pscmdlet.ShouldProcess('Target', 'Operation')) {
            try {
                Write-Verbose "Invoke Start-Robocopy"
                Start-Robocopy -Source $TempDirectory -Destination $Path -Mirror
                Remove-Item $Path -Force   
            
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }
    End {
        Write-Verbose "Remove Temporary Folder"
        Remove-Item $TempDirectory
    }
}