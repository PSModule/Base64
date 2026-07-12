# Base64

Base64 is a lightweight, cross-platform PowerShell module for Base64 conversion and validation. It provides pipeline-friendly commands to
encode text with `ConvertTo-Base64`, decode it back with `ConvertFrom-Base64`, and verify that a string is valid Base64 with `Test-Base64` —
so it drops cleanly into automation workflows.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name Base64
Import-Module -Name Base64
```

## Usage

### Example: Encode a string to Base64

Encode a plain text string into its Base64 representation:

```powershell
'Hello World' | ConvertTo-Base64
```

Expected output:

```text
SGVsbG8gV29ybGQ=
```

### Example: Decode a Base64 string

Convert a Base64 encoded string back to its original human-readable text:

```powershell
'SGVsbG8gV29ybGQ=' | ConvertFrom-Base64
```

Expected output:

```text
Hello World
```

### Example: Validate a Base64 string

Check whether a string is a properly formatted Base64 value:

```powershell
'SGVsbG8gV29ybGQ=' | Test-Base64
```

Expected output:

```text
True
```

## Documentation

Documentation is published at [psmodule.io/Base64](https://psmodule.io/Base64/).

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module Base64
Get-Help -Name ConvertTo-Base64 -Examples
```
