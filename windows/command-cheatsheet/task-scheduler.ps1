# List
Get-ScheduledTask | Select-Object TaskName, TaskPath, State

# Disable
Disable-ScheduledTask -TaskName "Window Defender" -TaskPath "\Microsoft\Windows\Windows Defender"

# Get status
Get-ScheduledTask -TaskName "Window Defender" -TaskPath "\Microsoft\Windows\Windows Defender" | Select-Object TaskName, State
