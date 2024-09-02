<# Script d'initialisation du module Powershell #>
$ProgressPreference = 'SilentlyContinue'

Write-Host "Chargement du module... " -NoNewline
# S'assure de la cohérence du répertoire module/
if (Test-Path -Path .\module) {
    Remove-Item -Path .\module -Recurse -Force
}
New-Item -Name module -ItemType Directory | Out-Null

# Télécharge le module à jour
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/module/pf2ToScribeModule.psm1" -OutFile .\module\pf2ToScribeModule.psm1

# Import du module
Import-Module -Name .\module\pf2ToScribeModule.psm1
Write-Host "OK" -ForegroundColor Green

Write-Host "Installation du répertoire des données... " -NoNewline
# S'assure de l'existance du répertoire datas/
if (-not (Test-Path -Path .\datas)){
    New-Item -Name .\datas -ItemType Directory | Out-Null
}
Write-Host "OK" -ForegroundColor Green

$ProgressPreference = 'Continue'

# Prêt !
Write-Host `
"  _____  ______ ___    _           _____           _ _          
 |  __ \|  ____|__ \  | |         / ____|         (_) |         
 | |__) | |__     ) | | |_ ___   | (___   ___ _ __ _| |__   ___ 
 |  ___/|  __|   / /  | __/ _ \   \___ \ / __| '__| | '_ \ / _ \
 | |    | |     / /_  | || (_) |  ____) | (__| |  | | |_) |  __/
 |_|    |_|    |____|  \__\___/  |_____/ \___|_|  |_|_.__/ \___|
----------------------------------------------------------------                                                                
                                                      v2024.09.1

cf. https://github.com/6e756e75/pf2-to-scribe pour l'aide.
"