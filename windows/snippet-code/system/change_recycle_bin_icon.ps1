# Define the paths to the custom icons
$emptyIconPath = "G:\My Drive\Image\Icon & Logo\Fresh install for Window\kanna-empty.ico"
$fullIconPath = "G:\My Drive\Image\Icon & Logo\Fresh install for Window\kanna-full.ico"

# Set the registry keys for the Recycle Bin icons
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon"

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the custom icon path for the empty Recycle Bin
Set-ItemProperty -Path $regPath -Name "empty" -Value $emptyIconPath

# Set the custom icon path for the full Recycle Bin
Set-ItemProperty -Path $regPath -Name "full" -Value $fullIconPath

# Refresh the icon cache
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "Recycle Bin icons have been changed globally."