function New-Base64 {
    <#
        .SYNOPSIS
        Create a new Base64 object

        .DESCRIPTION
        Create a new Base64 object

        .EXAMPLE
        New-Base64 -InputString 'ThisIsANiceString'
        VGhpc0lzQU5pY2VTdHJpbmc=

        Create a new Base64 object from the string 'ThisIsANiceString'
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string] $InputString
    )

    if ($PSCmdlet.ShouldProcess("PSBase64 class", "Create")) {
        return [PSBase64]::new($InputString)
    }
}
