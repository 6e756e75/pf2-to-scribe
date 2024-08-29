<# Script d'initialisation du module Powershell #>

# S'assure de la cohérence du répertoire module/
if (Test-Path -Path .\module) {
    Remove-Item -Path .\module -Recurse -Force
}
New-Item -Name module -ItemType Directory

# S'assure de l'existance du répertoire datas/
if (-not (Test-Path -Path .\datas)){
    New-Item -Name .\datas -ItemType Directory
}

# Télécharge le module à jour
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/module/pf2ToScribeModule.psm1" -OutFile .\module\pf2ToScribeModule.psm1

# Import du module
Import-Module -Name .\module\pf2ToScribeModule.psm1

# Prêt !
Write-Host "pf2-to-scribe prêt !"