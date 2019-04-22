<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.NOTES
   General notes
#>
function Get-RoboDirectory
{
    [CmdletBinding(SupportsShouldProcess=$true,
                  ConfirmImpact='Low')]

    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String]$Source,
        
        [switch]
        $BackupMode,

        $Unit
    )

    Begin {}

    Process
    {
        if ($pscmdlet.ShouldProcess('$Source', 'Get info'))
        {
            try {
                $PSBoundParameters.Add("Destination", "NULL")
                $PSBoundParameters.Add("Mirror", $true)
                $PSBoundParameters.Add("List",$true)

                $RoboResult = Start-Robocopy @PSBoundParameters -ErrorAction Stop | Select-Object -Property Source,Command,DirCount,FileCount,DirFailed,FileFailed,
                    TotalTime, StartedTime, EndedTime, TotalSize,ExitCode,Success,LastExitCodeMessage
                $GetItemResult = Get-Item $Source -ErrorAction Stop

                Merge-Object -InputObject $RoboResult,$GetItemResult
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End {}
}