filter Test-Base64Url {
    <#
        .SYNOPSIS
        Determines whether a given string is a valid base64url-encoded string.

        .DESCRIPTION
        This function checks whether the provided string is a valid base64url-encoded string.
        Base64url encoding is a URL-safe variant of base64 that uses '-' instead of '+', '_' instead of '/', 
        and omits padding '=' characters. It attempts to decode the input by converting it to standard base64
        and using `[Convert]::FromBase64String()`. If the decoding succeeds, it returns `$true`; otherwise, it returns `$false`.

        .EXAMPLE
        Test-Base64Url -Base64UrlString 'U29tZSBkYXRh'

        Output:
        ```powershell
        True
        ```

        Returns `$true` as the string is a valid base64url-encoded string.

        .EXAMPLE
        'U29tZSBkYXRh' | Test-Base64Url

        Output:
        ```powershell
        True
        ```

        Returns `$true` as the string is a valid base64url-encoded string.

        .OUTPUTS
        bool

        .NOTES
        Returns `$true` if the string is a valid base64url-encoded string, otherwise `$false`.

        .LINK
        https://psmodule.io/Test/Functions/Test-Base64Url
    #>
    [OutputType([bool])]
    [CmdletBinding()]
    param (
        # The base64url-encoded string to validate.
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [string] $Base64UrlString
    )

    try {
        # Check for invalid characters (base64url should only contain A-Z, a-z, 0-9, -, _)
        if ($Base64UrlString -match '[^A-Za-z0-9\-_]') {
            return $false
        }
        
        # Convert base64url to base64 by replacing '-' with '+', '_' with '/'
        $base64 = $Base64UrlString.Replace('-', '+').Replace('_', '/')
        
        # Add padding if needed (base64 length must be multiple of 4)
        $padding = $base64.Length % 4
        if ($padding -ne 0) {
            $base64 += '=' * (4 - $padding)
        }
        
        # Try to decode
        $null = [Convert]::FromBase64String($base64)
        $true
    } catch {
        $false
    }
}