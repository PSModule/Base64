Describe 'Module' {
    Context 'Base64' {
        It 'Creates a base64 object' {
            $base64 = New-Base64 -InputString 'ThisIsANiceString'
            $base64.Base64 | Should -Be 'VGhpc0lzQU5pY2VTdHJpbmc='
        }

        It 'Encodes and decodes a string' {
            $string = 'Hello, World!'
            $encoded = $string | ConvertTo-Base64
            $decoded = $encoded | ConvertFrom-Base64
            $decoded | Should -Be $string
        }

        It 'Can test if a string is base64 encoded' {
            $string = 'Hello, World!'
            $encoded = $string | ConvertTo-Base64
            $decoded = $encoded | ConvertFrom-Base64
            $string | Test-Base64 | Should -Be $false
            $encoded | Test-Base64 | Should -Be $true
            $decoded | Test-Base64 | Should -Be $false
        }
    }
}
