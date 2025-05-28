function ConvertTo-Base64 {
    <#
        .SYNOPSIS
        Converts a string or array of strings to their base64 encoded representation.

        .DESCRIPTION
        This function takes a string or array of strings as input and converts them to base64 encoded strings using UTF-8 encoding.
        It accepts input from the pipeline and can process string values directly or as an array.
        
        By default, each string is encoded individually. Use the -AsOneString parameter to join all inputs with newlines and encode as a single string.

        .EXAMPLE
        "Hello World" | ConvertTo-Base64

        Output:
        ```powershell
        SGVsbG8gV29ybGQ=
        ```

        Converts the string "Hello World" to its base64 encoded equivalent.

        .EXAMPLE
        @("Hello", "World") | ConvertTo-Base64

        Output:
        ```powershell
        SGVsbG8=
        V29ybGQ=
        ```

        Converts each string in the array to its base64 encoded equivalent.

        .EXAMPLE
        @("Hello", "World") | ConvertTo-Base64 -AsOneString

        Output:
        ```powershell
        SGVsbG8KV29ybGQ=
        ```

        Joins all strings with newlines and encodes them as a single base64 string.

        .EXAMPLE
        Get-Content -Path "file.txt" | ConvertTo-Base64 -AsOneString

        Output:
        ```powershell
        VGhpcyBpcyB0aGUgY29udGVudCBvZiB0aGUgZmlsZQp3aXRoIG11bHRpcGxlIGxpbmVzLg==
        ```

        Reads the file content and encodes all lines as a single base64 string, similar to the Linux base64 utility.

        .OUTPUTS
        System.String

        .NOTES
        The base64 encoded representation of the input string(s).

        .LINK
        https://psmodule.io/Base64/Functions/ConvertTo-Base64/
    #>
    [Alias('ConvertTo-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The input string or array of strings to be converted to base64 encoding.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string[]] $String,

        # The encoding to use when converting the string to bytes.
        [Parameter()]
        [ValidateSet('UTF8', 'UTF7', 'UTF32', 'ASCII', 'Unicode', 'BigEndianUnicode', 'Latin1')]
        [string] $Encoding = 'UTF8',

        # Join all input strings with newlines and encode as a single string.
        [Parameter()]
        [switch] $AsOneString
    )

    begin {
        if ($AsOneString) {
            [System.Collections.Generic.List[string]]$allStrings = @()
        }
    }

    process {
        if ($AsOneString) {
            foreach ($item in $String) {
                $allStrings.Add($item)
            }
        } else {
            foreach ($item in $String) {
                [Convert]::ToBase64String([System.Text.Encoding]::$Encoding.GetBytes($item))
            }
        }
    }

    end {
        if ($AsOneString -and $allStrings.Count -gt 0) {
            $joinedString = $allStrings -join [Environment]::NewLine
            [Convert]::ToBase64String([System.Text.Encoding]::$Encoding.GetBytes($joinedString))
        }
    }
}
