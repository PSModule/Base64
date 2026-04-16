function ConvertFrom-Base64Url {
    <#
        .SYNOPSIS
        Decodes a base64url-encoded string or array of strings into UTF-8 strings.

        .DESCRIPTION
        Converts a base64url-encoded string or array of strings into human-readable UTF-8 strings. Base64url encoding
        is a URL-safe variant of base64 that uses '-' instead of '+', '_' instead of '/', and omits padding '=' characters.
        The function accepts input from the pipeline and validates the input using the `Test-Base64Url` function before decoding.

        .EXAMPLE
        "U29tZSBkYXRh" | ConvertFrom-Base64Url

        Output:
        ```powershell
        Some data
        ```

        Decodes the base64url-encoded string "U29tZSBkYXRh" into its original UTF-8 representation.

        .EXAMPLE
        @("SGVsbG8", "V29ybGQ") | ConvertFrom-Base64Url

        Output:
        ```powershell
        Hello
        World
        ```

        Decodes each base64url-encoded string in the array into its original UTF-8 representation.

        .OUTPUTS
        System.String

        .NOTES
        The decoded UTF-8 string(s).

        .LINK
        https://psmodule.io/Base64/Functions/ConvertFrom-Base64Url/
    #>
    [Alias('ConvertFrom-Base64UrlString')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The base64url-encoded string or array of strings to be decoded.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript({ Test-Base64Url -Base64UrlString $_ }, ErrorMessage = 'Invalid Base64Url string')]
        [string[]] $Base64UrlString,

        # The encoding to use when converting the string to bytes.
        [Parameter()]
        [ValidateSet('UTF8', 'UTF7', 'UTF32', 'ASCII', 'Unicode', 'BigEndianUnicode', 'Latin1')]
        [string] $Encoding = 'UTF8'
    )

    process {
        foreach ($item in $Base64UrlString) {
            # Convert base64url to base64 by replacing '-' with '+', '_' with '/', and adding padding if needed
            $base64 = $item.Replace('-', '+').Replace('_', '/')
            
            # Add padding if needed (base64 length must be multiple of 4)
            $padding = $base64.Length % 4
            if ($padding -ne 0) {
                $base64 += '=' * (4 - $padding)
            }
            
            [System.Text.Encoding]::$Encoding.GetString([Convert]::FromBase64String($base64))
        }
    }
}