# Define the registry path and the name of the new DWORD entry
$regPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$regName = "JumpListItems_Maximum"
$maxItems = 7  # Set the desired number of items (e.g., 25)

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Add the new DWORD entry and set its value as a decimal
New-ItemProperty -Path $regPath -Name $regName -PropertyType DWORD -Value ([Convert]::ToInt32($maxItems)) -Force

# Output the result
Write-Output "The maximum number of items in jump lists has been set to $maxItems."