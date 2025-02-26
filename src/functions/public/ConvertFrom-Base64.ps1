filter ConvertFrom-Base64 {
    <#
        .SYNOPSIS
        Decodes a base64-encoded string into a UTF-8 string.

        .DESCRIPTION
        Converts a base64-encoded string into a human-readable UTF-8 string. The function accepts input from the pipeline
        and validates the input using the `Test-Base64` function before decoding.

        .EXAMPLE
        "U29tZSBkYXRh" | ConvertFrom-Base64

        Output:
        ```powershell
        Some data
        ```

        Decodes the base64-encoded string "U29tZSBkYXRh" into its original UTF-8 representation.

        .OUTPUTS
        System.String

        .NOTES
        The decoded UTF-8 string.

        .LINK
        https://psmodule.io/Base64/Functions/ConvertFrom-Base64/
    #>
    [Alias('ConvertFrom-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The base64-encoded string to be decoded.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript({ Test-Base64 -Base64String $_ }, ErrorMessage = 'Invalid Base64 string')]
        [string] $Base64String,

        # The encoding to use when converting the string to bytes.
        [Parameter()]
        [ValidateSet('UTF8', 'UTF7', 'UTF32', 'ASCII', 'Unicode', 'BigEndianUnicode', 'Latin1')]
        [string] $Encoding = 'UTF8'
    )

    [System.Text.Encoding]::$Encoding.GetString([Convert]::FromBase64String($Base64String))
}
