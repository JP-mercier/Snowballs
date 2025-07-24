# Ensure script runs as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Path to the loginusers.vdf file
$loginUsersPath = "$env:ProgramFiles (x86)\Steam\config\loginusers.vdf"

# Backup the original file
$backupPath = "$env:ProgramFiles (x86)\Steam\config\loginusers_backup.vdf"
Copy-Item -Path $loginUsersPath -Destination $backupPath -Force

# Function to modify WantsOfflineMode
function Set-WantsOfflineMode {
    param (
        [string]$filePath,
        [int]$value
    )
    (Get-Content -Path $filePath) -replace '"WantsOfflineMode"\s+"0"', "`"WantsOfflineMode`"		`"$value`"" | Set-Content -Path $filePath
}

# Step 1: Set WantsOfflineMode to 1
Write-Host "Setting WantsOfflineMode to 1..."
Set-WantsOfflineMode -filePath $loginUsersPath -value 1

# Step 2: Restart Steam
Write-Host "Restarting Steam..."
Get-Process -Name "steam" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Process "$env:ProgramFiles (x86)\Steam\steam.exe"

# Step 3: Change System Date
Write-Host "Changing system date to 2025-01-01..."
Set-Date -Date "2025-01-01"

# Step 4: Launch Payday 2
Write-Host "Launching Payday 2..."
Start-Process "steam://rungameid/218620"

Write-Host "`nSteam is set to offline mode, the system date is changed, and Payday 2 is running."
Read-Host "Press Enter to restore internet and time settings"

# Step 5: Revert WantsOfflineMode to 0
Write-Host "Reverting WantsOfflineMode to 0..."
Set-WantsOfflineMode -filePath $loginUsersPath -value 0

# Step 6: Clean up backup file
Remove-Item -Path $backupPath -Force

# Step 7: Restore Internet and Time Settings
Write-Host "Restoring internet connection and time sync..."
Set-Service -Name w32time -StartupType Automatic
Start-Service w32time
w32tm /resync

Write-Host "System settings restored. Steam's offline mode has been reverted."
