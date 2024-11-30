filter ConvertFrom-Base64 {
    <#
        .SYNOPSIS
        Convert to string from base64

        .DESCRIPTION
        Converts a base64 encoded string to a string.

        .EXAMPLE
        ConvertFrom-Base64 -Base64String 'VGhpc0lzQU5pY2VTdHJpbmc='
        ThisIsANiceString

        Converts the base64 encoded string 'VGhpc0lzQU5pY2VTdHJpbmc=' to a string.

        .EXAMPLE
        'SGVsbG8gV29ybGQ=' | ConvertFrom-Base64String
        Hello World

        Converts the string from base64 to a regular string.
    #>
    [Alias('ConvertFrom-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The base64 encoded string to convert.
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [ValidateScript({ Test-Base64 -Base64String $_ }, ErrorMessage = 'Invalid Base64 string')]
        [string] $Base64String
    )

    return [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($Base64String))
}
