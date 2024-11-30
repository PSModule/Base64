class PSBase64 {
    [string] $Base64

    PSBase64([string] $Value) {
        $this.Base64 = [PSBase64]::ConvertToBase64($Value)
    }

    [string] ToString() {
        return [PSBase64]::ConvertFromBase64($this.Base64)
    }

    static [string] ConvertFromBase64([string] $Base64String) {
        return [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($Base64String))
    }

    static [string] ConvertToBase64([string] $String) {
        return [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($String))
    }

    static [bool] IsValid([string] $Base64String) {
        try {
            $null = [Convert]::FromBase64String($Base64String)
            return $true
        } catch {
            return $false
        }
    }
}
