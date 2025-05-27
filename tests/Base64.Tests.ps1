Describe 'Base64' {
    Context 'Function: Test-Base64' {
        It "Test-Base64 -Base64String 'VGhpc0lzQU5pY2VTdHJpbmc=' -> true" {
            Test-Base64 -Base64String 'VGhpc0lzQU5pY2VTdHJpbmc=' | Should -Be $true
        }
        It "'SGVsbG8gV29ybGQ=' | Test-Base64 -> true" {
            'SGVsbG8gV29ybGQ=' | Test-Base64 | Should -Be $true
        }
    }
    Context 'Function: ConvertTo-Base64' {
        It "ConvertTo-Base64 -String 'ThisIsANiceString' -> VGhpc0lzQU5pY2VTdHJpbmc=" {
            ConvertTo-Base64 -String 'ThisIsANiceString' | Should -Be 'VGhpc0lzQU5pY2VTdHJpbmc='
        }

        It "'Hello World' | ConvertTo-Base64 -> SGVsbG8gV29ybGQ=" {
            'Hello World' | ConvertTo-Base64 | Should -Be 'SGVsbG8gV29ybGQ='
        }
        
        It "ConvertTo-Base64 -String @('Hello', 'World') -> @('SGVsbG8=', 'V29ybGQ=')" {
            $result = ConvertTo-Base64 -String @('Hello', 'World')
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8='
            $result[1] | Should -Be 'V29ybGQ='
        }

        It "@('Hello', 'World') | ConvertTo-Base64 -> @('SGVsbG8=', 'V29ybGQ=')" {
            $result = @('Hello', 'World') | ConvertTo-Base64
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8='
            $result[1] | Should -Be 'V29ybGQ='
        }
    }
    Context 'Function: ConvertFrom-Base64' {
        It "ConvertFrom-Base64 -Base64String 'VGhpc0lzQU5pY2VTdHJpbmc=' -> ThisIsANiceString" {
            ConvertFrom-Base64 -Base64String 'VGhpc0lzQU5pY2VTdHJpbmc=' | Should -Be 'ThisIsANiceString'
        }

        It "'SGVsbG8gV29ybGQ=' | ConvertFrom-Base64 -> Hello World" {
            'SGVsbG8gV29ybGQ=' | ConvertFrom-Base64 | Should -Be 'Hello World'
        }
        
        It "ConvertFrom-Base64 -Base64String @('SGVsbG8=', 'V29ybGQ=') -> @('Hello', 'World')" {
            $result = ConvertFrom-Base64 -Base64String @('SGVsbG8=', 'V29ybGQ=')
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }

        It "@('SGVsbG8=', 'V29ybGQ=') | ConvertFrom-Base64 -> @('Hello', 'World')" {
            $result = @('SGVsbG8=', 'V29ybGQ=') | ConvertFrom-Base64
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }
    }
}
