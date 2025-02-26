filter Test-Base64 {
    <#
        .SYNOPSIS
        Determines whether a given string is a valid base64-encoded string.

        .DESCRIPTION
        This function checks whether the provided string is a valid base64-encoded string.
        It attempts to decode the input using `[Convert]::FromBase64String()`.
        If the decoding succeeds, it returns `$true`; otherwise, it returns `$false`.

        .EXAMPLE
        Test-Base64 -Base64String 'U29tZSBkYXRh'

        Output:
        ```powershell
        True
        ```

        Returns `$true` as the string is a valid base64-encoded string.

        .EXAMPLE
        'U29tZSBkYXRh' | Test-Base64

        Output:
        ```powershell
        True
        ```

        Returns `$true` as the string is a valid base64-encoded string.

        .OUTPUTS
        bool

        .NOTES
        Returns `$true` if the string is a valid base64-encoded string, otherwise `$false`.

        .LINK
        https://psmodule.io/Test/Functions/Test-Base64
    #>
    [OutputType([bool])]
    [CmdletBinding()]
    param (
        # The base64-encoded string to validate.
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [string] $Base64String
    )

    try {
        $null = [Convert]::FromBase64String($Base64String)
        $true
    } catch {
        $false
    }
}
