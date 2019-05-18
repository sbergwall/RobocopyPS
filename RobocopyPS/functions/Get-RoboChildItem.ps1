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

function Get-RoboChildItem {
    
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
                $PSBoundParameters.Add("IncludeEmptySubDirectories", $true)
                $PSBoundParameters.Add("List",$true)

                If ($PSBoundParameters.ContainsKey('ErrorAction')) {
                    Start-Robocopy @PSBoundParameters
                }
                else {
                    $Result = Start-Robocopy @PSBoundParameters -errorvariable err -ErrorAction SilentlyContinue

                    foreach ($errorRecord in $err) {
                        Write-Error $errorRecord
                    }

                    $Result
                }
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End {}
}