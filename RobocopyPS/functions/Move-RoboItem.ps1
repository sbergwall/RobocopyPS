function Move-RoboItem {
    [CmdletBinding()]
    param (

    )

    DynamicParam {
        # Get available parameters from Invoke-RoboCopy and ignore parameters that is not for moving items
        New-ProxyFunction -CommandName 'Invoke-RoboCopy' -CommandType 'Function' -ignoredParams "Mirror","MoveFiles","MoveFilesAndDirectories"
    }


    begin {

    }

    process {

        $Souce
        $Destination
        #Invoke-RoboCopy -MoveFilesAndDirectories @PSBoundParameters

    }

    end {

    }
}