# Self-Contained Font Installation Script
# All font URLs and names are defined within the script

# Check admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Administrator privileges required"
    exit 1
}

# Define fonts to install (add/remove as needed)
$fontsToInstall = @(
    @{
        Name = "JetBrainsMono"
        Url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
    },
    @{
        Name = "CascadiaCode"
        Url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip"
    }
)

Write-Host "Font Installation Script" -ForegroundColor Yellow
Write-Host "Will install $($fontsToInstall.Count) fonts:" -ForegroundColor Cyan
foreach ($font in $fontsToInstall) {
    Write-Host "  - $($font.Name)" -ForegroundColor White
}
Write-Host ""

# Create temp directory
$tempDir = Join-Path $env:TEMP "FontInstall_$(Get-Random)"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

$allFontFiles = @()
$successCount = 0

# Download and extract each font
foreach ($font in $fontsToInstall) {
    Write-Host "Processing: $($font.Name)" -ForegroundColor Cyan
    
    try {
        # Download
        $zipPath = Join-Path $tempDir "$($font.Name).zip"
        Write-Host "  Downloading..." -ForegroundColor Gray
        Invoke-WebRequest -Uri $font.Url -OutFile $zipPath -UseBasicParsing
        
        # Extract
        $extractPath = Join-Path $tempDir $font.Name
        Write-Host "  Extracting..." -ForegroundColor Gray
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
        
        # Find font files
        $fontFiles = Get-ChildItem -Path $extractPath -Include "*.ttf", "*.otf" -Recurse
        $allFontFiles += $fontFiles
        
        Write-Host "  ✓ Found $($fontFiles.Count) font files" -ForegroundColor Green
        $successCount++
        
    } catch {
        Write-Warning "Failed to process $($font.Name): $($_.Exception.Message)"
    }
}

if ($allFontFiles.Count -eq 0) {
    Write-Error "No font files found"
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

Write-Host "`nInstalling $($allFontFiles.Count) font files..." -ForegroundColor Yellow

# Install fonts using the two essential steps
$fontsPath = "$env:SYSTEMROOT\Fonts"
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
$installedCount = 0

foreach ($fontFile in $allFontFiles) {
    Write-Host "Installing: $($fontFile.Name)" -ForegroundColor White
    
    try {
        # Step 1: Copy to Windows\Fonts
        $destinationPath = Join-Path $fontsPath $fontFile.Name
        Copy-Item -Path $fontFile.FullName -Destination $destinationPath -Force
        Write-Host "  ✓ Copied to fonts folder" -ForegroundColor Green
        
        # Step 2: Register in registry
        $fontDisplayName = $fontFile.BaseName
        $registryValue = if ($fontFile.Extension -eq ".ttf") { 
            "$fontDisplayName (TrueType)" 
        } else { 
            "$fontDisplayName (OpenType)" 
        }
        
        New-ItemProperty -Path $registryPath -Name $registryValue -Value $fontFile.Name -PropertyType String -Force | Out-Null
        Write-Host "  ✓ Registered in registry" -ForegroundColor Green
        
        $installedCount++
        
    } catch {
        Write-Warning "Failed to install $($fontFile.Name): $($_.Exception.Message)"
    }
}

# Cleanup
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue

# Summary
Write-Host "`n=== Installation Complete ===" -ForegroundColor Yellow
Write-Host "Fonts processed: $successCount/$($fontsToInstall.Count)"
Write-Host "Font files installed: $installedCount/$($allFontFiles.Count)" -ForegroundColor Green
Write-Host "`nNote: Some applications may need to be restarted to see new fonts" -ForegroundColor Cyan