Describe 'Base64' {
    Context 'Function: Test-Base64' {
        It "Test-Base64 -Base64String 'U29tZSBkYXRh' -> true" {
            Test-Base64 -Base64String 'U29tZSBkYXRh' | Should -Be $true
        }
        It "'U29tZSBkYXRh' | Test-Base64 -> true" {
            'U29tZSBkYXRh' | Test-Base64 | Should -Be $true
        }
    }
    Context 'Function: ConvertTo-Base64' {
        It "ConvertTo-Base64 -String 'ThisIsANiceString' -> VGhpc0lzQU5pY2VTdHJpbmc=" {
            ConvertTo-Base64 -String 'ThisIsANiceString' | Should -Be 'VGhpc0lzQU5pY2VTdHJpbmc='
        }

        It "'Hello World' | ConvertTo-Base64 -> SABlAGwAbABvACAAVwBvAHIAbABkAA==" {
            'Hello World' | ConvertTo-Base64 | Should -Be 'SABlAGwAbABvACAAVwBvAHIAbABkAA=='
        }
    }
    Context 'Function: ConvertFrom-Base64' {
        It "'VGhpc0lzQU5pY2VTdHJpbmc=' | ConvertFrom-Base64 -> ThisIsANiceString" {
            'VGhpc0lzQU5pY2VTdHJpbmc=' | ConvertFrom-Base64 | Should -Be 'ThisIsANiceString'
        }

        It "ConvertFrom-Base64 -Base64String 'SABlAGwAbABvACAAVwBvAHIAbABkAA==' -> Hello World" {
            ConvertFrom-Base64 -Base64String 'SABlAGwAbABvACAAVwBvAHIAbABkAA==' | Should -Be 'Hello World'
        }
    }
}
