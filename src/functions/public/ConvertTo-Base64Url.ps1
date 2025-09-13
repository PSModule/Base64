function ConvertTo-Base64Url {
    <#
        .SYNOPSIS
        Converts a string or array of strings to their base64url encoded representation.

        .DESCRIPTION
        This function takes a string or array of strings as input and converts them to base64url encoded strings using UTF-8 encoding.
        Base64url encoding is a URL-safe variant of base64 that replaces '+' with '-', '/' with '_', and removes padding '=' characters.
        It accepts input from the pipeline and can process string values directly or as an array.

        .EXAMPLE
        "Hello World" | ConvertTo-Base64Url

        Output:
        ```powershell
        SGVsbG8gV29ybGQ
        ```

        Converts the string "Hello World" to its base64url encoded equivalent.

        .EXAMPLE
        @("Hello", "World") | ConvertTo-Base64Url

        Output:
        ```powershell
        SGVsbG8
        V29ybGQ
        ```

        Converts each string in the array to its base64url encoded equivalent.

        .OUTPUTS
        System.String

        .NOTES
        The base64url encoded representation of the input string(s).

        .LINK
        https://psmodule.io/Base64/Functions/ConvertTo-Base64Url/
    #>
    [Alias('ConvertTo-Base64UrlString')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The input string or array of strings to be converted to base64url encoding.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]] $String,

        # The encoding to use when converting the string to bytes.
        [Parameter()]
        [ValidateSet('UTF8', 'UTF7', 'UTF32', 'ASCII', 'Unicode', 'BigEndianUnicode', 'Latin1')]
        [string] $Encoding = 'UTF8'
    )

    process {
        foreach ($item in $String) {
            $base64 = [Convert]::ToBase64String([System.Text.Encoding]::$Encoding.GetBytes($item))
            # Convert to base64url by replacing '+' with '-', '/' with '_', and removing padding '='
            $base64url = $base64.Replace('+', '-').Replace('/', '_').TrimEnd('=')
            $base64url
        }
    }
}