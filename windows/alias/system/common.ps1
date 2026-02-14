function osarch {
    (Get-CimInstance Win32_OperatingSystem).OSArchitecture
}

function osversion {
    Get-ComputerInfo | Select-Object OsName, OsVersion
}

function ospatch {
    Get-HotFix | Select-Object HotFixID, Description, InstalledOn
}
