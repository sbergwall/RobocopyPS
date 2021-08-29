function Move-RoboItem {
    [CmdletBinding()]
    param (

    )

    DynamicParam {
        # Get available parameters from Invoke-RoboCopy and ignore parameters that is not for moving items
        New-ProxyFunction -CommandName 'Invoke-RoboCopy' -CommandType 'Function' -ignoredParams "Mirror", "MoveFiles", "MoveFilesAndDirectories"
    }


    begin {

    }

    process {
        try {
            #region Verify that both Source and Destination exists and are a directory
            foreach ($Location in $PSBoundParameters['Source'], $PSBoundParameters['Destination']) {
                If (!(Test-Path -path $Location -PathType Container)) {
                    throw "Cannot find path $location because it does not exist."
                }
            }
            #endregion

            Invoke-RoboCopy -MoveFilesAndDirectories @PSBoundParameters
        }
        catch {
            $PSCmdlet.WriteError($psitem)
        }

    }

    end {

    }
}