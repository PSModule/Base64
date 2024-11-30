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
    }
}
