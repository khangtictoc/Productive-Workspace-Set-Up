$LongFolderPath = "$env:TEMP\" + ("A" * 200) + "\" + ("B" * 200) + "\" + ("C" * 200)
$LongFolderPath.Length
New-Item $LongFolderPath -ItemType Directory