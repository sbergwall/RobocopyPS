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

function Get-RoboDirectoryInfo {

    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Low')]

    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String]$Source,

        [switch]
        $BackupMode,

        $Unit
    )

    Begin { }

    Process {
        if ($pscmdlet.ShouldProcess('$Source', 'Get info')) {
            try {
                $PSBoundParameters.Add("Destination", "NULL")
                $PSBoundParameters.Add("IncludeEmptySubDirectories", $true)

                $Result = Start-Robocopy @PSBoundParameters -ErrorVariable err
                foreach ($e in $Err) {
                    $pscmdlet.WriteError($e)
                }
                $Result

            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End { }
}