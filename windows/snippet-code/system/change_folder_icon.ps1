# Define the path to the custom icon
$iconPath = "G:\My Drive\Image\Icon & Logo\Fresh install for Window\folder_icon.ico"

# Set the registry key for the default folder icon
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"
$regName3 = "3"
$regName4 = "4"

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the custom icon path in the registry for key "3"
Set-ItemProperty -Path $regPath -Name $regName3 -Value $iconPath

# Set the custom icon path in the registry for key "4"
Set-ItemProperty -Path $regPath -Name $regName4 -Value $iconPath

# Refresh the icon cache
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "Folder icon has been changed globally."