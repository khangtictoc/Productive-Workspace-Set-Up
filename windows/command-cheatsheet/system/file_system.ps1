# Filter BY FOLDER NAME in current path.
Get-ChildItem -Directory -Recurse -Filter "<FOLDER_NAME>" | Where-Object { $_.Name -ceq "<FOLDER_NAME>" }