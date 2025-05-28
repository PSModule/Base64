function ConvertFrom-Base64 {
    <#
        .SYNOPSIS
        Decodes a base64-encoded string or array of strings into UTF-8 strings.

        .DESCRIPTION
        Converts a base64-encoded string or array of strings into human-readable UTF-8 strings. The function accepts input from the pipeline
        and validates the input using the `Test-Base64` function before decoding.

        .EXAMPLE
        "U29tZSBkYXRh" | ConvertFrom-Base64

        Output:
        ```powershell
        Some data
        ```

        Decodes the base64-encoded string "U29tZSBkYXRh" into its original UTF-8 representation.

        .EXAMPLE
        @("SGVsbG8=", "V29ybGQ=") | ConvertFrom-Base64

        Output:
        ```powershell
        Hello
        World
        ```

        Decodes each base64-encoded string in the array into its original UTF-8 representation.

        .OUTPUTS
        System.String

        .NOTES
        The decoded UTF-8 string(s).

        .LINK
        https://psmodule.io/Base64/Functions/ConvertFrom-Base64/
    #>
    [Alias('ConvertFrom-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The base64-encoded string or array of strings to be decoded.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript({ Test-Base64 -Base64String $_ }, ErrorMessage = 'Invalid Base64 string')]
        [string[]] $Base64String,

        # The encoding to use when converting the string to bytes.
        [Parameter()]
        [ValidateSet('UTF8', 'UTF7', 'UTF32', 'ASCII', 'Unicode', 'BigEndianUnicode', 'Latin1')]
        [string] $Encoding = 'UTF8'
    )

    process {
        foreach ($item in $Base64String) {
            [System.Text.Encoding]::$Encoding.GetString([Convert]::FromBase64String($item))
        }
    }
}
