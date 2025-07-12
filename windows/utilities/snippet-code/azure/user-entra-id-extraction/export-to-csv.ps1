# Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
# Connect-MgGraph -Scopes "User.Read.All Directory.Read.All"

# Get all users and select required fields
$users = Get-MgUser -All -Property DisplayName, Mail,
    JobTitle, CompanyName, Department, OfficeLocation, Manager,
    StreetAddress, City, State, Country, PostalCode, MobilePhone, BusinessPhones

# Convert to custom objects for easier manipulation
$userData = $users | Select-Object `
    @{Label="Name"; Expression={$_.DisplayName}},
    @{Label="Email"; Expression={$_.Mail}},
    @{Label="Job Title"; Expression={$_.JobTitle}},
    @{Label="Company"; Expression={$_.CompanyName}},
    @{Label="Department"; Expression={$_.Department}},
    @{Label="Office Location"; Expression={$_.OfficeLocation}},
    @{Label="Manager"; Expression={$_.Manager}},
    @{Label="Street Address"; Expression={$_.StreetAddress}},
    @{Label="City"; Expression={$_.City}},
    @{Label="State"; Expression={$_.State}},
    @{Label="Country"; Expression={$_.Country}},
    @{Label="Postal Code"; Expression={$_.PostalCode}},
    @{Label="Mobile Phone"; Expression={$_.MobilePhone}},
    @{Label="Business Phones"; Expression={$_.BusinessPhones -join ", "}}
    

# Export to CSV
$outputPath = "C:\Users\Public\AzureEntraUserData.csv"
$userData | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "User data exported to $outputPath"
