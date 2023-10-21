# AnsibleWin
On Windows Server 2019
Make sure WinRM is running so do 
Get-Service WinRM and check the status

winrm quickconfig, then select y 

New-NetFirewallRule -Name winrm -DisplayName "Windows Remote Management" -Enabled True -Profile Any -Action Allow -Direction Inbound -Protocol TCP -LocalPort 5985 --> Sets up to open the ports 

New-LocalUser -Name "ansible_user" -Password (ConvertTo-SecureString "Password123!" -AsPlainText -Force) -FullName "Ansible User" --> Sets up the ansible account

Add-LocalGroupMember -Group "Administrators" -Member "ansible_user" --> adds the ansible user

Ansible CTRL Host:
Set in hosts.ini whatever you windows ip address is

As of Note you may need to promote the AD to domain controller there is a 50/50 chance of that being needed and not happening automatically. Also if the computer takes a super long time to restart you might need to rerun to have the groups added, I have not seen that issue yet but it is def possible



