$OUPath = "OU=Departments,DC=techsolutions,DC=local"

$Departments = @(
    "HR",
    "IT",
    "Finance",
    "Marketing"
)

foreach ($Department in $Departments) {

    $OU = Get-ADOrganizationalUnit -Filter "Name -eq '$Department'"

    if ($OU -eq $null) {


        Write-Host "Creating $Department..."
        New-ADOrganizationalUnit -Name $Department -Path $OUPath

    }

}