function New-Base64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $InputString
    )

    return [PSBase64]::new($InputString)
}

New-Base64 -InputString 'ThisIsANiceString'
