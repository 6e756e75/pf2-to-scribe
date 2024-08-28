Write-Progress -Activity "Chargement du module" -PercentComplete 0
Import-Module -Name .\pf2ToScribeModule.psm1
Write-Progress -Activity "Chargement du module" -PercentComplete 100
Write-Host "Module chargé"