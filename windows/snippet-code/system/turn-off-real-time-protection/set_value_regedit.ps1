# Define the registry path and key
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"
$newKeyName = "Real-Time Protection"
$dwordName = "DisableRealtimeMonitoring"
$dwordValue = 1

# Check if the key already exists
if (-not (Test-Path "$registryPath\$newKeyName")) {
    # Create the new key
    New-Item -Path $registryPath -Name $newKeyName -Force
    Write-Output "Created key: $newKeyName"
} else {
    Write-Output "Key already exists: $newKeyName"
}

# Set the DWORD value
Set-ItemProperty -Path "$registryPath\$newKeyName" -Name $dwordName -Value $dwordValue -Type DWord
Write-Output "Set DWORD value '$dwordName' to $dwordValue"
