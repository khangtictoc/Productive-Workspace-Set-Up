$MyObject = Get-MgUser

# Get the type of the object
$MyObject.GetType().FullName

# Get all available properties and methods of the object
$MyObject | Get-Member

# Get all available properties and methods of the object with FILTER
$MyObject | Get-Member | Where-Object { $_.MemberType -eq "Property" }
