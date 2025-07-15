# Install the Exchange Online Management module
Install-Module -Name ExchangeOnlineManagement

# Connect to Exchange Online with your account
Connect-ExchangeOnline -UserPrincipalName [YOUR_EMAIL] -ShowProgress $true

Get-Recipient -ResultSize Unlimited |
Select-Object DisplayName, PrimarySmtpAddress, City, Company, Phone, PostalCode, Title |
Export-Csv -Path "C:\GAL-Contacts-full.csv" -NoTypeInformation