# Install Java 17
$javaUrl = "https://download.oracle.com/java/17/archive/jdk-17.0.12_windows-x64_bin.msi"
$javaInstaller = "$env:TEMP\jdk-17.0.12_windows-x64_bin.msi"
Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstaller
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $javaInstaller, "/quiet", "/norestart" -Wait

# Install Jenkins
$jenkinsUrl = "https://sg.mirror.servanamanaged.com/jenkins/windows-stable/2.492.2/jenkins.msi"
$jenkinsInstaller = "$env:TEMP\jenkins.msi"
Invoke-WebRequest -Uri $jenkinsUrl -OutFile $jenkinsInstaller
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $jenkinsInstaller, "/quiet", "/norestart" -Wait