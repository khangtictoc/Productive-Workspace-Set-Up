function oh-my-zsh--install {

    # =========================
    # SET YOUR THEME HERE
    # =========================
    $THEME = "kushal"   # <-- change this

    Write-Host "Installing Oh My Posh..." -ForegroundColor Cyan
    winget install JanDeDobbeleer.OhMyPosh --source winget

    # Profiles to update
    $Profiles = @(
        $PROFILE | Split-Path | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1"
        $PROFILE | Split-Path | Join-Path -ChildPath "Microsoft.VSCode_profile.ps1"
        $PROFILE | Split-Path | Join-Path -ChildPath "profiles.ps1"
    )

    # Create theme directory
    $ThemeDir = "$HOME\.poshthemes"
    if (!(Test-Path $ThemeDir)) {
        New-Item -ItemType Directory -Path $ThemeDir -Force | Out-Null
    }

    # Download theme
    $ThemeUrl  = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/$THEME.omp.json"
    $ThemePath = Join-Path $ThemeDir "$THEME.omp.json"

    Write-Host "Downloading theme $THEME..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $ThemeUrl -OutFile $ThemePath

    $InitLine = "oh-my-posh init pwsh --config `"$ThemePath`" | Invoke-Expression"

    foreach ($ProfilePath in $Profiles) {        
        # Ensure profile exists
        if (!(Test-Path $ProfilePath)) {
            New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
        }

        if (-not (Select-String -Path $ProfilePath -Pattern "oh-my-posh init pwsh" -Quiet)) {
            Add-Content -Path $ProfilePath -Value "`n# Oh My Posh Init"
            Add-Content -Path $ProfilePath -Value $InitLine
            Write-Host "Updated: $ProfilePath" -ForegroundColor Green
        }
        else {
            Write-Host "Already configured: $ProfilePath" -ForegroundColor Yellow
        }
    }

    Write-Host "Done - Install Oh My Posh. Restart terminals." -ForegroundColor Green
}

function aliases--install {
    # Download aliases file
    $AliasUrl  = "https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/windows/alias/system/common.ps1"
    $AliasPath = "$HOME\.custom_aliases.ps1"

    Write-Host "Downloading aliases..."
    Invoke-WebRequest -Uri $AliasUrl -OutFile $AliasPath

    # Add source line to profile
    $AliasInitLine = ". `"$AliasPath`""
    
    # Profiles to update
    $Profiles = @(
        $PROFILE | Split-Path | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1"
        $PROFILE | Split-Path | Join-Path -ChildPath "Microsoft.VSCode_profile.ps1"
        $PROFILE | Split-Path | Join-Path -ChildPath "profiles.ps1"
    )
    
    Write-Host "Configuring profiles to load aliases..." -ForegroundColor Cyan
    foreach ($ProfilePath in $Profiles) {

        # Ensure profile exists
        if (!(Test-Path $ProfilePath)) {
            New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
        }

        if (-not (Select-String -Path $ProfilePath -Pattern "\.custom_aliases.ps1" -Quiet)) {
            Add-Content -Path $ProfilePath -Value "`n# Load custom aliases"
            Add-Content -Path $ProfilePath -Value $AliasInitLine
        }
        else {
            Write-Host "Already configured: $ProfilePath" -ForegroundColor Yellow
        }
    }
    
    Write-Host "Done - Installing custom aliases. Restart terminals." -ForegroundColor Green
}


oh-my-zsh--install
aliases--install