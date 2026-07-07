#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '6.0.0'; MaximumVersion = '6.*'; GUID = 'a699dea5-2c73-4616-a270-1f7abb777e71' }

BeforeAll {
    # Import functions directly
    . "$PSScriptRoot/../src/functions/public/Test-Base64.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertTo-Base64.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertFrom-Base64.ps1"

    # Create test files
    $testContentPath = '/tmp/base64_test/test_content.txt'
    if (-not (Test-Path $testContentPath)) {
        New-Item -ItemType Directory -Path '/tmp/base64_test' -Force | Out-Null
        @"
Line 1
Line 2
Line 3
"@ | Out-File -FilePath $testContentPath -Encoding UTF8
    }

    $testBase64Path = '/tmp/base64_test/test_base64_content.txt'
    @"
TGluZSAx
TGluZSAy
TGluZSAz
"@ | Out-File -FilePath $testBase64Path -Encoding UTF8
}

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

        It "Variable containing multiple strings piped to ConvertTo-Base64" {
            $strings = @('Hello', 'World')
            $result = $strings | ConvertTo-Base64
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8='
            $result[1] | Should -Be 'V29ybGQ='
        }

        It "File content piped to ConvertTo-Base64" {
            $testFilePath = '/tmp/base64_test/test_content.txt'
            $result = Get-Content -Path $testFilePath | ConvertTo-Base64
            $result.Count | Should -Be 3
            $result[0] | Should -Be 'TGluZSAx'
            $result[1] | Should -Be 'TGluZSAy'
            $result[2] | Should -Be 'TGluZSAz'
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

        It "Variable containing multiple Base64 strings piped to ConvertFrom-Base64" {
            $base64Strings = @('SGVsbG8=', 'V29ybGQ=')
            $result = $base64Strings | ConvertFrom-Base64
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }

        It "File content with Base64 strings piped to ConvertFrom-Base64" {
            $testBase64FilePath = '/tmp/base64_test/test_base64_content.txt'
            @('TGluZSAx', 'TGluZSAy', 'TGluZSAz') | Out-File -FilePath $testBase64FilePath
            $result = Get-Content -Path $testBase64FilePath | ConvertFrom-Base64
            $result.Count | Should -Be 3
            $result[0] | Should -Be 'Line 1'
            $result[1] | Should -Be 'Line 2'
            $result[2] | Should -Be 'Line 3'
        }
    }
}
