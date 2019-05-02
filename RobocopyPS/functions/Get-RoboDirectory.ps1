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
                $PSBoundParameters.Add("IncludeEmptySubDirectories", $true)
                $PSBoundParameters.Add("List",$true)

                Start-Robocopy @PSBoundParameters 
                #$GetItemResult = Get-Item $Source

                #Merge-Object -InputObject $RoboResult,$GetItemResult
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End {}
}