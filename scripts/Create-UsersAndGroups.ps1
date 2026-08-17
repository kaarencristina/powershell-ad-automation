Import-Module ActiveDirectory

# Employee information
$FirstName = "David"
$LastName = "Miller"
$Username = "david.miller"
$Department = "Operations"

# Domain information
$Domain = "DC=techsolutions,DC=local"
$OUPath = "OU=$Department,OU=Departments,$Domain"
$GroupName = "${Department}_Users"
$GroupsOU = "OU=Groups,$Domain"

# Check if the department OU exists
$OU = Get-ADOrganizationalUnit -Identity $OUPath -ErrorAction SilentlyContinue

if (-not $OU) {
    Write-Host "ERROR: Department OU '$Department' does not exist." -ForegroundColor Red
    exit
}

Write-Host "Department OU found: $OUPath" -ForegroundColor Green

# Check if the group exists
$Group = Get-ADGroup -Identity $GroupName -ErrorAction SilentlyContinue

if (-not $Group) {

    Write-Host "Group '$GroupName' does not exist. Creating it..." -ForegroundColor Yellow

    New-ADGroup `
        -Name $GroupName `
        -GroupScope Global `
        -GroupCategory Security `
        -Path $GroupsOU

    $Group = Get-ADGroup -Identity $GroupName

    Write-Host "Group created successfully." -ForegroundColor Green

}
else {

    Write-Host "Group '$GroupName' already exists. Using existing group." -ForegroundColor Cyan

}

# Check if the user exists
$User = Get-ADUser -Identity $Username -ErrorAction SilentlyContinue

if (-not $User) {

    Write-Host "User '$Username' does not exist. Creating user..." -ForegroundColor Yellow

    $Password = Read-Host "Enter temporary password" -AsSecureString

    New-ADUser `
        -Name "$FirstName $LastName" `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $Username `
        -UserPrincipalName "$Username@techsolutions.local" `
        -Path $OUPath `
        -AccountPassword $Password `
        -Enabled $true

    $User = Get-ADUser -Identity $Username

    Write-Host "User created successfully." -ForegroundColor Green

}
else {

    Write-Host "User '$Username' already exists. Using existing user." -ForegroundColor Cyan

}

# Check if the user is already a member of the group
$Membership = Get-ADGroupMember -Identity $GroupName |
    Where-Object { $_.SamAccountName -eq $Username }

if (-not $Membership) {

    Add-ADGroupMember `
        -Identity $GroupName `
        -Members $Username

    Write-Host "User '$Username' added to '$GroupName'." -ForegroundColor Green

}
else {

    Write-Host "User '$Username' is already a member of '$GroupName'." -ForegroundColor Cyan

}

Write-Host ""
Write-Host "===================================="
Write-Host "Provisioning completed successfully"
Write-Host "===================================="
Write-Host "User: $Username"
Write-Host "Department: $Department"
Write-Host "Group: $GroupName"