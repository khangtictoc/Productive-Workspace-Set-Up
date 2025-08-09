# Install Java 21
$javaUrl = "https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.msi"
$javaInstaller = "$env:TEMP\jdk-21_windows-x64_bin.msi"
Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstaller
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $javaInstaller, "/quiet", "/norestart" -Wait

# Install Jenkins
$jenkinsUrl = "https://sg.mirror.servanamanaged.com/jenkins/windows-stable/2.492.2/jenkins.msi"
$jenkinsInstaller = "$env:TEMP\jenkins.msi"
Invoke-WebRequest -Uri $jenkinsUrl -OutFile $jenkinsInstaller
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $jenkinsInstaller, "/quiet", "/norestart" -Wait

# Install Calibre
$calibreUrl = "https://calibre-ebook.com/dist/win64"
Invoke-WebRequest -Uri $calibreUrl -MaximumRedirection 10 -OutFile "$env:TEMP\calibre-installer.msi"
$calibreInstaller = "$env:TEMP\calibre-installer.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $calibreInstaller, "/quiet", "/norestart" -Wait

# Install Cloudflare Warp
$cloudflareWarpUrl = "https://downloads.cloudflareclient.com/v1/download/windows/version/2025.5.893.0"
Invoke-WebRequest -Uri $cloudflareWarpUrl -MaximumRedirection 10 -OutFile "$env:TEMP\cloudflare-warp.msi"
$cloudflareWarpInstaller = "$env:TEMP\cloudflare-warp.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $cloudflareWarpInstaller, "/quiet", "/norestart" -Wait

$fontInstallUrl = "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/windows/utilities/snippet-code/system/install_fonts/download_and_install.ps1"
$fontInstaller = "$env:TEMP\download_and_install.ps1"
Invoke-WebRequest -Uri $fontInstallUrl -OutFile $fontInstaller
Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File", $fontInstaller -Wait

