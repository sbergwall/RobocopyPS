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
function Copy-RoboItem {
    
    [CmdletBinding(SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium',
        DefaultParameterSetName = 'Level')]

    Param
    (        
        # Specifies the path to the source directory. Must be a folder.
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('Path')]
        [String]$Source,

        # Specifies the path to the destination directory. Must be a folder.
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('Target')]
        [String]$Destination,

        # Specifies the file or files to be copied. You can use wildcard characters (* or ?), if you want. If the File parameter is not specified, *.* is used as the default value.
        [Parameter(Mandatory = $False)]
        [String[]] $Files = '*.*',

        [Parameter(ParameterSetName = 'Level')]
        [Alias('lev', 'Depth')]
        [Int]$Level = 1,

        [Parameter(ParameterSetName = 'Recurse')]
        [switch]$Recurse
    )

    DynamicParam {
        # Create dictionary
        $ArrayIgnoreParams = 'Source', 'Destination', 'Purge', 'Mirror', 'Create', 'IncludeSubDirectories', 'IncludeEmptySubDirectories', 'MoveFilesAndDirectories', 'MoveFiles', 'Level', 'Files', 'Recurse'
        New-ProxyFunction -CommandName 'Start-RoboCopy' -CommandType 'Function' -ignoredParams $ArrayIgnoreParams
    }

    Begin { }

    Process {
        if ($pscmdlet.ShouldProcess("$Destination from $Source", 'Copy')) {
            try {

                $Item = Get-Item -Path $Source -ErrorAction Stop
                If (($Item).PSIsContainer -eq $false -and !$PSBoundParameters.ContainsKey('Files')) {
                    # If source is a file and -Files parameter isnt specified we do some magic because RoboCopy doesnt like pointing to files without -Files parameter
                    $PSBoundParameters.Add('Files', $Item.Name)
                    $PSBoundParameters.Remove('Source') | Out-Null # Out-null so we supress True or false statement remove the remove method

                    # Add Source back with the directory name and now the file is specified in -Files parameter
                    $PSBoundParameters.Add('Source', $Item.Directory)
                    
                    # If level is specified but poiting to a file we ignore it
                    $PSBoundParameters.Remove('Level') | Out-Null
                    $PSBoundParameters.Add('Level', [int]1)
                    $PSBoundParameters.Remove('Recurse') | Out-Null

                }
                elseif (($Item).PSIsContainer -eq $false -and $PSBoundParameters.ContainsKey('Files')) {

                    Write-Warning "Both -Files Parameter and a specific file was pointed to, we will override -Files parameter and only copy file"
                    $PSBoundParameters.Remove('Files') | Out-Null 
                    $PSBoundParameters.Add('Files', $Item.Name)
                    $PSBoundParameters.Remove('Source') | Out-Null # Out-null so we supress True or false statement remove the remove method

                    # Add Source back with the directory name and now the file is specified in -Files parameter
                    $PSBoundParameters.Add('Source', $Item.Directory)
                    
                    # If level is specified but poiting to a file we ignore it
                    $PSBoundParameters.Remove('Level') | Out-Null
                    $PSBoundParameters.Add('Level', [int]1)
                    $PSBoundParameters.Remove('Recurse') | Out-Null
                }
                else {
                }

                If ($PSBoundParameters.ContainsKey('Recurse')) {
                    $PSBoundParameters.Remove('Recurse') | Out-Null
                    $PSBoundParameters.Remove('Level') | Out-Null
                    $PSBoundParameters.Add('Level', 0)
                }

                If (!$PSBoundParameters.ContainsKey('Recurse') -and !$PSBoundParameters.ContainsKey('Level')) {
                    $PSBoundParameters.Add('Level', $Level) | Out-Null
                }
                
                $PSBoundParameters.Add('IncludeEmptySubDirectories', [bool]$true)
                Start-RoboCopy @PSBoundParameters
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($PSitem)
            }
        }
    }

    End { }
}