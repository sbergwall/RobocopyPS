function Sync-RoboItem {
    [CmdletBinding(SupportsShouldProcess = $True)]


    param (

    )

    DynamicParam {
        # Get available parameters from Invoke-RoboCopy and ignore parameters that is not for moving items
        New-ProxyFunction -CommandName 'Invoke-RoboCopy' -CommandType 'Function' -ignoredParams "Mirror", "MoveFiles", "MoveFilesAndDirectories","Files","IncludeSubDirectories","IncludeEmptySubDirectories","Purge"
    }

    begin {

    }

    process {
        $Destination = $PSBoundParameters['Destination']
        $Source = $PSBoundParameters['Source']

        If ($PSCmdlet.ShouldProcess("from $source to $destination" , 'Sync')) {
            Invoke-RoboCopy -Mirror @PSBoundParameters
        }
    }

    end {

    }
}