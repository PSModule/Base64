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

# Run tests
Invoke-Pester -Path "$PSScriptRoot/Base64.Tests.ps1" -PassThru