<#
.Synopsis
   Gets files and folders, similar to Get-ChildItem but with Robocopy.
.DESCRIPTION
   Gets files and folders, similar to Get-ChildItem but with Robocopy.
.EXAMPLE
    Get-RoboChildItem -Source 'C:\temp\'

    Extension : html
    Name      : GPReport.html
    FullName  : C:\tmp 2\GPReport.html
    Length    : 200050
    TimeStamp : 2019-01-06 15:01:19

    Extension : txt
    Name      : log.txt
    FullName  : C:\tmp 2\log.txt
    Length    : 1220
    TimeStamp : 2018-08-12 18:13:15
.EXAMPLE
   Get-RoboChildItem -Source 'C:\Windows' -BackupMode
.NOTES
    Function need the full name to a path for it to work at this point in time. Example C:\Temp will work as Source but .\temp wont.
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
        $BackupMode
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
            }
            catch {
                $PSCmdlet.WriteError($PSitem)
            }
        }
    }

    End {}
}