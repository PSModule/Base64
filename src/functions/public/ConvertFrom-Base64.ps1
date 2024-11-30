function ConvertFrom-Base64 {
    <#
        .SYNOPSIS
        Convert to string from base64

        .DESCRIPTION
        Converts a Base64 encoded string to a string.

        .EXAMPLE
        'VGhpc0lzQU5pY2VTdHJpbmc=' | ConvertFrom-Base64
        ThisIsANiceString

        Converts the Base64 encoded string 'VGhpc0lzQU5pY2VTdHJpbmc=' to a string.

        .EXAMPLE
        ConvertFrom-Base64String -String 'SABlAGwAbABvACAAVwBvAHIAbABkAA=='
        Hello World

        Converts the string from base64 to a regular string.
    #>
    [Alias('ConvertFrom-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The Base64 encoded string to convert.
        [Parameter(Mandatory)]
        [string] $Base64String
    )

    if ([PSBase64]::IsValid($Base64String)) {
        return [PSBase64]::ConvertFromBase64($Base64String)
    } else {
        throw "Invalid Base64 string"
    }
}
