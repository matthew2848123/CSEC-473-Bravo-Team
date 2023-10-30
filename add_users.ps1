# Powershell script to add users as Local Admins or normal users

# Password to set for all users
$securePassword = ConvertTo-SecureString "SecuristGovtNA1773" -AsPlainText -Force

# Users to be added as administrators
$adminUsers = @("NSA", "SecretService")

# Users to be added as normal users
$normalUsers = @("Navy", "Marines", "spaceforce")

# Add the admin users
foreach ($user in $adminUsers) {
    # Check if user already exists
    $userExists = Get-LocalUser -Name $user -ErrorAction SilentlyContinue
    if (-not $userExists) {
        # Create the user
        New-LocalUser -Name $user -Password $securePassword -FullName $user -Description "Administrator User"
        
        # Add the user to the Administrators group
        Add-LocalGroupMember -Group "Administrators" -Member $user
    }
}

# Add the normal users
foreach ($user in $normalUsers) {
    # Check if user already exists
    $userExists = Get-LocalUser -Name $user -ErrorAction SilentlyContinue
    if (-not $userExists) {
        # Create the user
        New-LocalUser -Name $user -Password $securePassword -FullName $user -Description "Normal User"
    }
}

Write-Host "All users have been added successfully!"
