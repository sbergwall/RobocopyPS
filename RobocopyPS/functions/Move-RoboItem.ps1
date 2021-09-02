function Move-RoboItem {
    [CmdletBinding(SupportsShouldProcess = $True)]
    param (

    )

    DynamicParam {
        # Get available parameters from Invoke-RoboCopy and ignore parameters that is not for moving items
        New-ProxyFunction -CommandName 'Invoke-RoboCopy' -CommandType 'Function' -ignoredParams "Mirror", "MoveFiles", "MoveFilesAndDirectories"
    }


    begin {

    }

    process {
        $Destination = $PSBoundParameters['Destination']
        $Source = $PSBoundParameters['Source']

        If ($PSCmdlet.ShouldProcess("$Destination from $Source" , "Move")) {
            try {
                Invoke-RoboCopy -MoveFilesAndDirectories @PSBoundParameters -ErrorAction Stop
            }
            catch {
                $PSCmdlet.WriteError($psitem)
            }
        }
    }

    end {

    }
}