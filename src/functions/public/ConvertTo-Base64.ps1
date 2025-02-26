filter ConvertTo-Base64 {
    <#
        .SYNOPSIS
        Converts a string to its Base64 encoded representation.

        .DESCRIPTION
        This function takes a string as input and converts it to a Base64 encoded string using UTF-8 encoding.
        It accepts input from the pipeline and can process string values directly.

        .EXAMPLE
        "Hello World" | ConvertTo-Base64

        Output:
        ```powershell
        SGVsbG8gV29ybGQ=
        ```

        Converts the string "Hello World" to its Base64 encoded equivalent.

        .OUTPUTS
        System.String

        .NOTES
        The Base64 encoded representation of the input string.

        .LINK
        https://psmodule.io/Base64/Functions/ConvertTo-Base64/
    #>
    [Alias('ConvertTo-Base64String')]
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The input string to be converted to Base64 encoding.
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string] $String
    )
    [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($String))
}
