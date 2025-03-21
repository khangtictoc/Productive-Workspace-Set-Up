$MyObject = Get-MgUser

$MyObject.GetType().FullName

$MyObject | Get-Member

$MyObject | Get-Member | Where-Object { $_.MemberType -eq "Property" }
