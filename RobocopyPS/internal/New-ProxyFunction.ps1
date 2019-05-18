Function New-ProxyFunction {
    <#
    .SYNOPSIS
        Proxy function dynamic parameter block
    .DESCRIPTION
        The dynamic parameter block of a proxy function. This block can be used to copy a proxy function target's parameters, regardless of changes from version to version.
    .LINK
        https://www.the-little-things.net/blog/2017/07/30/powershell-inheriting-parameters-proxy-functions/
        #>
    [CmdletBinding(SupportsShouldProcess = $true)]    
    [System.Diagnostics.DebuggerStepThrough()]
    param(
        # The name of the command being proxied.
        [System.String]
        $CommandName,

        # The type of the command being proxied. Valid values include 'Cmdlet' or 'Function'.
        [System.Management.Automation.CommandTypes]
        $CommandType,

        [String[]]
        $ignoredParams
    )

    Process {
        if ($pscmdlet.ShouldProcess('New-ProxyFunction', 'Invoke')) {
            try {
                # Look up the command being proxied.
                $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand($CommandName, $CommandType)

                #If the command was not found, throw an appropriate command not found exception.
                if (-not $wrappedCmd) {
                    $PSCmdlet.ThrowCommandNotFoundError($CommandName, $PSCmdlet.MyInvocation.MyCommand.Name)
                }

                # Lookup the command metadata.
                $metadata = New-Object -TypeName System.Management.Automation.CommandMetadata -ArgumentList $wrappedCmd

                # Create dynamic parameters, one for each parameter on the command being proxied.
                $dynamicDictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary
                foreach ($key in $metadata.Parameters.Keys) {
                    If ($ignoredParams -notcontains $Key) {
                        $parameter = $metadata.Parameters[$key]
                        $dynamicParameter = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList @(
                            $parameter.Name
                            $parameter.ParameterType
                            , $parameter.Attributes
                        )
                        $dynamicDictionary.Add($parameter.Name, $dynamicParameter)
                    }
                }
                $dynamicDictionary

            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
    }
}