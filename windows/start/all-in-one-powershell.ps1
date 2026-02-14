function oh-my-zsh--install {

    # =========================
    # SET YOUR THEME HERE
    # =========================
    $THEME = "kushal"   # <-- change this

    Write-Host "Installing Oh My Posh..." -ForegroundColor Cyan
    winget install JanDeDobbeleer.OhMyPosh --source winget

    # Profiles to update
    $Profiles = @(
        $PROFILE.CurrentUserAllHosts,
        $PROFILE.CurrentUserCurrentHost
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

    Write-Host "Done. Restart terminals." -ForegroundColor Green
}


oh-my-zsh--install