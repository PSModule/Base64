filter ConvertTo-Base64 {
    <#
        .SYNOPSIS
        Convert a string to base64

        .DESCRIPTION
        Converts a string to a Base64 encoded string.

        .EXAMPLE
        ConvertTo-Base64 -String 'ThisIsANiceString'
        VGhpc0lzQU5pY2VTdHJpbmc=

        Converts the string 'ThisIsANiceString' to a Base64 encoded string.

        .EXAMPLE
        'Hello World' | ConvertTo-Base64

        SABlAGwAbABvACAAVwBvAHIAbABkAA==

        Converts the string 'Hello World' to base64.
    #>
    [Alias('ConvertTo-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The string to convert to base64
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string] $String
    )
    return [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($String))
}
