# PowerShell script to enable RDP and give specific users access

# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Allow RDP through the firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Local users previously specified
$localUsers = @("NSA", "SecretService", "Navy", "Marines", "spaceforce")

# Domain users to be granted access
$domainUsers = @("cia", "fbi", "irs", "airforce", "military", "HacksawRidge", "ForestGump")

# Add local users to the "Remote Desktop Users" group
foreach ($user in $localUsers) {
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member $user
}

# Add domain users to the "Remote Desktop Users" group
foreach ($user in $domainUsers) {
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "us.gov\$user"
}

Write-Host "RDP is enabled and users have been granted access!"
