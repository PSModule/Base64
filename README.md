# Base64

base64 is a lightweight PowerShell module that provides a set of functions for encoding and decoding strings using base64 encoding. Designed to be
simple, efficient, and cross-platform, this module leverages pipeline-friendly commands to integrate seamlessly into your automation workflows.

## Module Features

- `ConvertTo-Base64`: Transforms a plain text string into its base64 encoded equivalent.
- `ConvertFrom-Base64`: Decodes a base64 encoded string back into a human-readable UTF-8 string.
- `Test-Base64`: Validates whether a string is a properly formatted base64 encoded string.

Ever questioned whether your base64 data is truly valid? With `Test-Base64`, you can be skeptical and verify it for yourself.

## Prerequisites

This module utilizes the [PSModule framework](https://github.com/PSModule) for building, testing, and publishing. It is compatible with PowerShell
Core as well as Windows PowerShell—so whether you're on Windows, Linux, or macOS, you're covered.

## Installation

To install the module from the PowerShell Gallery, run the following commands:

```powershell
Install-PSResource -Name Base64
Import-Module -Name Base64
```

## Usage

Here are some example use cases to get you started with the module:

### Convert a String to base64

Encode a plain text string into its base64 representation:

```powershell
"Hello World" | ConvertTo-Base64
```

**Expected Output:**

```powershell
SGVsbG8gV29ybGQ=
```

### Decode a base64 String

Convert a base64 encoded string back to its original human-readable format:

```powershell
"SGVsbG8gV29ybGQ=" | ConvertFrom-Base64
```

**Expected Output:**

```powershell
Hello World
```

### Validate a base64 String

Check if a string is a valid base64 encoded string:

```powershell
"SGVsbG8gV29ybGQ=" | Test-Base64
```

**Expected Output:**

```powershell
True
```

Because in automation, a skeptical mind is the best safety net—if it passes the tests, you can trust it (at least until the next edge case shows up).

## Contributing

Whether you’re a coder or a user with invaluable feedback, your contributions can make this module even better.

### For Users

If you encounter unexpected behavior or think something is missing, please open an issue on [GitHub Issues](https://github.com/yourusername/Base64/issues).
Your skepticism is welcome—it only makes the project stronger.

### For Developers

Developers, feel free to contribute code improvements or new features. Please read the [Contribution Guidelines](CONTRIBUTING.md) to learn how to get started.
