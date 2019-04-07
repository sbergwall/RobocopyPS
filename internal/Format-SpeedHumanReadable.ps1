    Function Format-SpeedHumanReadable {
        <#
    .SYNOPSIS
    Changes a file size in Bytes into a more readable format
#>
        Param (
            [String]$size
        )
        [System.Double]$absSize = $size.trimStart('-')
        if ($size -like '-*') {$Operator = '-'}
        else {$Operator = ''}
        switch ($absSize) {
            {$_ -ge 1PB} {"{1}{0:#.#' PB'}" -f ($absSize / 1PB), $Operator; break}
            {$_ -ge 1TB} {"{1}{0:#.#' TB'}" -f ($absSize / 1TB), $Operator; break}
            {$_ -ge 1GB} {"{1}{0:#.#' GB'}" -f ($absSize / 1GB), $Operator; break}
            {$_ -ge 1MB} {"{1}{0:#.#' MB'}" -f ($absSize / 1MB), $Operator; break}
            {$_ -ge 1KB} {"{1}{0:#' KB'}" -f ($absSize / 1KB), $Operator; break}
            default {"{1}{0}" -f ($absSize), $Operator + " B"}
        }
    }
