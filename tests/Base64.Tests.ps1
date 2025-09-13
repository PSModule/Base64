BeforeAll {
    # Import functions directly
    . "$PSScriptRoot/../src/functions/public/Test-Base64.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertTo-Base64.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertFrom-Base64.ps1"
    . "$PSScriptRoot/../src/functions/public/Test-Base64Url.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertTo-Base64Url.ps1"
    . "$PSScriptRoot/../src/functions/public/ConvertFrom-Base64Url.ps1"

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
    Context 'Function: Test-Base64Url' {
        It "Test-Base64Url -Base64UrlString 'VGhpc0lzQU5pY2VTdHJpbmc' -> true" {
            Test-Base64Url -Base64UrlString 'VGhpc0lzQU5pY2VTdHJpbmc' | Should -Be $true
        }
        It "'SGVsbG8gV29ybGQ' | Test-Base64Url -> true" {
            'SGVsbG8gV29ybGQ' | Test-Base64Url | Should -Be $true
        }
        It "Test-Base64Url with invalid characters should return false" {
            'Invalid+String/With=Padding' | Test-Base64Url | Should -Be $false
        }
        It "Test-Base64Url with URL-safe characters should return true" {
            'VGhpcyB3aWxsIGhhdmUgKyBhbmQgLyBjaGFyYWN0ZXJzIHdoZW4gZW5jb2RlZA' | Test-Base64Url | Should -Be $true
        }
    }
    Context 'Function: ConvertTo-Base64Url' {
        It "ConvertTo-Base64Url -String 'ThisIsANiceString' -> VGhpc0lzQU5pY2VTdHJpbmc" {
            ConvertTo-Base64Url -String 'ThisIsANiceString' | Should -Be 'VGhpc0lzQU5pY2VTdHJpbmc'
        }

        It "'Hello World' | ConvertTo-Base64Url -> SGVsbG8gV29ybGQ" {
            'Hello World' | ConvertTo-Base64Url | Should -Be 'SGVsbG8gV29ybGQ'
        }
        It "ConvertTo-Base64Url -String @('Hello', 'World') -> @('SGVsbG8', 'V29ybGQ')" {
            $result = ConvertTo-Base64Url -String @('Hello', 'World')
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8'
            $result[1] | Should -Be 'V29ybGQ'
        }

        It "@('Hello', 'World') | ConvertTo-Base64Url -> @('SGVsbG8', 'V29ybGQ')" {
            $result = @('Hello', 'World') | ConvertTo-Base64Url
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8'
            $result[1] | Should -Be 'V29ybGQ'
        }

        It "Variable containing multiple strings piped to ConvertTo-Base64Url" {
            $strings = @('Hello', 'World')
            $result = $strings | ConvertTo-Base64Url
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'SGVsbG8'
            $result[1] | Should -Be 'V29ybGQ'
        }

        It "File content piped to ConvertTo-Base64Url" {
            $testFilePath = '/tmp/base64_test/test_content.txt'
            $result = Get-Content -Path $testFilePath | ConvertTo-Base64Url
            $result.Count | Should -Be 3
            $result[0] | Should -Be 'TGluZSAx'
            $result[1] | Should -Be 'TGluZSAy'
            $result[2] | Should -Be 'TGluZSAz'
        }

        It "ConvertTo-Base64Url removes padding characters" {
            # Test string that would normally have padding
            'sure.' | ConvertTo-Base64Url | Should -Be 'c3VyZS4'
        }

        It "ConvertTo-Base64Url replaces + and / with URL-safe characters" {
            # Test string that contains characters that would result in + and / in base64
            'subject?' | ConvertTo-Base64Url | Should -Be 'c3ViamVjdD8'
        }
    }
    Context 'Function: ConvertFrom-Base64Url' {
        It "ConvertFrom-Base64Url -Base64UrlString 'VGhpc0lzQU5pY2VTdHJpbmc' -> ThisIsANiceString" {
            ConvertFrom-Base64Url -Base64UrlString 'VGhpc0lzQU5pY2VTdHJpbmc' | Should -Be 'ThisIsANiceString'
        }

        It "'SGVsbG8gV29ybGQ' | ConvertFrom-Base64Url -> Hello World" {
            'SGVsbG8gV29ybGQ' | ConvertFrom-Base64Url | Should -Be 'Hello World'
        }
        It "ConvertFrom-Base64Url -Base64UrlString @('SGVsbG8', 'V29ybGQ') -> @('Hello', 'World')" {
            $result = ConvertFrom-Base64Url -Base64UrlString @('SGVsbG8', 'V29ybGQ')
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }

        It "@('SGVsbG8', 'V29ybGQ') | ConvertFrom-Base64Url -> @('Hello', 'World')" {
            $result = @('SGVsbG8', 'V29ybGQ') | ConvertFrom-Base64Url
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }

        It "Variable containing multiple Base64Url strings piped to ConvertFrom-Base64Url" {
            $base64UrlStrings = @('SGVsbG8', 'V29ybGQ')
            $result = $base64UrlStrings | ConvertFrom-Base64Url
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'Hello'
            $result[1] | Should -Be 'World'
        }

        It "File content with Base64Url strings piped to ConvertFrom-Base64Url" {
            $testBase64UrlFilePath = '/tmp/base64_test/test_base64url_content.txt'
            @('TGluZSAx', 'TGluZSAy', 'TGluZSAz') | Out-File -FilePath $testBase64UrlFilePath
            $result = Get-Content -Path $testBase64UrlFilePath | ConvertFrom-Base64Url
            $result.Count | Should -Be 3
            $result[0] | Should -Be 'Line 1'
            $result[1] | Should -Be 'Line 2'
            $result[2] | Should -Be 'Line 3'
        }

        It "ConvertFrom-Base64Url handles missing padding correctly" {
            # Test string without padding
            'c3VyZS4' | ConvertFrom-Base64Url | Should -Be 'sure.'
        }

        It "ConvertFrom-Base64Url handles URL-safe characters correctly" {
            # Test string with URL-safe characters
            'c3ViamVjdD8' | ConvertFrom-Base64Url | Should -Be 'subject?'
        }

        It "Round-trip conversion maintains data integrity" {
            $original = 'Test string with special chars: +/?='
            $encoded = $original | ConvertTo-Base64Url
            $decoded = $encoded | ConvertFrom-Base64Url
            $decoded | Should -Be $original
        }
    }
}
