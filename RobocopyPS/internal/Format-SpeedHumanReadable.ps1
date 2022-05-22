Function Format-SpeedHumanReadable {
    Param (
        [String]$Size,

        [ValidateSet('Auto', 'PB', 'TB', 'GB', 'MB', 'KB', 'Bytes')]
        [String]$Unit = 'Auto',

        [System.Int64]$Precision
    )

    [System.String]$absSize = $size.trimStart('-')
    if ($size -like '-*') {
        $Operator = '-'
    }
    else {
        $Operator = ''
    }

    If ($Unit -eq 'Auto') {
        switch ($absSize) {
            { $_ -ge 1PB } {
                "{1}{0:#.#' PB'}" -f ($absSize / 1PB), $Operator; break
            }
            { $_ -ge 1TB } {
                "{1}{0:#.#' TB'}" -f ($absSize / 1TB), $Operator; break
            }
            { $_ -ge 1GB } {
                #"{1}{0:#.#' GB'}" -f ($absSize / 1GB), $Operator; break
                $Output = [Math]::Round(([Decimal] $absSize / 1GB), $Precision)
                [System.String]$Output + " GB" ; break
            }
            { $_ -ge 1MB } {
                "{1}{0:#.#' MB'}" -f ($absSize / 1MB), $Operator; break
            }
            { $_ -ge 1KB } {
                "{1}{0:#' KB'}" -f ($absSize / 1KB), $Operator; break
            }
            default {
                "{1}{0}" -f ($absSize), $Operator + " B"
            }
        }
    }
    else {
        switch ($Unit) {
            'PB' {
                "{1}{0:#.#' PB'}" -f ($absSize / 1PB), $Operator; break
            }
            'TB' {
                "{1}{0:#.#' TB'}" -f ($absSize / 1TB), $Operator; break
            }
            'GB' {
                #"{1}{0:#.#' GB'}" -f ($absSize / 1GB), $Operator; break
                $Output = [Math]::Round(([decimal] $absSize / 1GB), $Precision)
                [System.String]$Output + " GB" ; break
            }
            'MB' {
                "{1}{0:#.#' MB'}" -f ($absSize / 1MB), $Operator; break
            }
            'KB' {
                "{1}{0:#' KB'}" -f ($absSize / 1KB), $Operator; break
            }
            default {
                "{1}{0}" -f ($absSize), $Operator + " B"
            }
        }
    }
}