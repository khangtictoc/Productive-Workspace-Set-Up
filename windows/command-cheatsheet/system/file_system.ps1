# Filter BY FOLDER NAME in current path.
Get-ChildItem -Directory -Recurse -Filter "<FOLDER_NAME>" | Where-Object { $_.Name -ceq "<FOLDER_NAME>" }

# Check if a folder path is too long
$LongFolderPath = "$env:TEMP\" + ("A" * 200) + "\" + ("B" * 200) + "\" + ("C" * 200)
$LongFolderPath.Length
New-Item $LongFolderPath -ItemType Directory