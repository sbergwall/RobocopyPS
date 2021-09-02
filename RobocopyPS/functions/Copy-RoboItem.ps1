function Copy-RoboItem {
    [CmdletBinding(SupportsShouldProcess = $True)]
    param (
        # Specifies the path to the source directory. Must be a folder.
        [Parameter( Mandatory = $True,
            ValueFromPipelineByPropertyName,
            ValueFromPipeline)]
        [Alias('Path', 'FullPath')]
        [String[]]$Source
    )

    DynamicParam {
        # Get available parameters from Invoke-RoboCopy and ignore parameters that is not for moving items
        New-ProxyFunction -CommandName 'Invoke-RoboCopy' -CommandType 'Function' -ignoredParams "Source", "Purge", "Mirror", "MoveFiles", "MoveFilesAndDirectories"
    }


    begin {

    }

    process {
        foreach ($Dir in $Source) {
            $Destination = $PSBoundParameters['Destination']

            If ($PSCmdlet.ShouldProcess("$Destination from $Dir" , "Copy")) {

                try {
                    Invoke-RoboCopy -Source $dir @PSBoundParameters -ErrorAction Stop
                }
                catch {
                    $PSCmdlet.WriteError($PSitem)
                }
            }
        }
    }

    end {

    }
}