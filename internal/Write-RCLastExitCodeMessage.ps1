<#
.Synopsis
   Translate lastexitcode to readable message
.DESCRIPTION
   Internal function to translate the lastexitcode used by Robopcopy to something readable. Depending on the InformationLevel, it either write to Output stream or correct stream depending on exitcide (example exitcode 8 write to error stream).
.EXAMPLE
    Write-RCLastExitCodeMessage -LASTEXITCODE 8
    Write-RCLastExitCodeMessage : Several files did not copy.(copy errors occurred and the retry limit was exceeded). Check these errors further.
.EXAMPLE
    Write-RCLastExitCodeMessage -LASTEXITCODE 6
    WARNING: Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory.
#>
function Write-RCLastExitCodeMessage {
    [CmdletBinding()]

    Param
    (
        # Param1 help description
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $LASTEXITCODE,

        [Parameter (Mandatory = $true)]
        [ValidateSet('Detailed', 'Normal')]
        $InformationLevel
    )

    Begin {
    }
    Process {
        $LastExitCodeMessage = switch ($LASTEXITCODE) {
            0 {'[SUCCESS]No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped.'}
            1 {'[SUCCESS]All files were copied successfully.'}
            2 {'[SUCCESS]There are some additional files in the destination directory that are not present in the source directory. No files were copied.'}
            3 {'[SUCCESS]Some files were copied. Additional files were present. No failure was encountered.'}
            4 {'[WARNING]Some Mismatched files or directories were detected. Examine the output log. Housekeeping might be required.'}
            5 {'[WARNING]Some files were copied. Some files were mismatched. No failure was encountered.'}
            6 {'[WARNING]Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory.'}
            7 {'[WARNING]Files were copied, a file mismatch was present, and additional files were present.'}
            8 {'[ERRROR]Several files did not copy.(copy errors occurred and the retry limit was exceeded). Check these errors further.'}
            9 {'[ERRROR]Some files did copy, but copy errors occurred and the retry limit was exceeded. Check these errors further.'}
            10 {'[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.'}
            11 {'[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Extra files or directories were detected.'}
            12 {'[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.'}
            13 {'[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected.'}
            14 {'[ERRROR]Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.'}
            15 {'[ERRROR]Some files were copied. Copy errors occurred and the retry limit was exceeded. Some Mismatched files or directories were detected. Some Extra files or directories were detected.'}
            16 {'[ERRROR]Robocopy did not copy any files. Either a usage error or an error due to insufficient access privileges on the source or destination directories.'}
            default {'[WARNING]No message associated with this exit code. ExitCode: {0}' -f $LASTEXITCODE}
        }

        If ($InformationLevel -eq 'Detailed') {
            If ($LASTEXITCODE -ge 4 -and $LASTEXITCODE -lt 17) {
                Write-Warning $LastExitCodeMessage
            }
            elseif ($LASTEXITCODE -ge 0 -and $LASTEXITCODE -lt 4) {
                Write-Verbose $LastExitCodeMessage
            }
            else {
                Write-Warning $LastExitCodeMessage
            }
        }
        else {
            Write-Output $LastExitCodeMessage
        }
    }

    End {
    }
}