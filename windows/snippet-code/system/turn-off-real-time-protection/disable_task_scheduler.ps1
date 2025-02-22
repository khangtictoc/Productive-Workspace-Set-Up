# Define a list of task names and their paths
$tasks = @(
    @{ Name = "Windows Defender Cache Maintenance"; Path = "\Microsoft\Windows\Windows Defender\" },
    @{ Name = "Windows Defender Cleanup"; Path = "\Microsoft\Windows\Windows Defender\" },
    @{ Name = "Windows Defender Verification"; Path = "\Microsoft\Windows\Windows Defender\" }
)

# Loop through each task in the list
foreach ($task in $tasks) {
    # Disable the task
    Disable-ScheduledTask -TaskName $task.Name -TaskPath $task.Path

    # Optionally, confirm that the task is disabled
    $status = Get-ScheduledTask -TaskName $task.Name -TaskPath $task.Path | Select-Object TaskName, State

    # Output the status
    Write-Output "Task: $($task.Name), Status: $($status.State)"
}

