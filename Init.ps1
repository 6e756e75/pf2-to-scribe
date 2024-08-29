<# Script d'initialisation du module Powershell #>

if (Test-Path -Path .\module) {
    Remove-Item -Path .\module -Recurse -Force
}

New-Item -Name module -ItemType Directory

if (-not (Test-Path -Path .\datas)){
    New-Item -Name .\datas -ItemType Directory
}

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/module/pf2ToScribeModule.psm1" -OutFile .\module\pf2ToScribeModule.psm1
Import-Module -Name .\module\pf2ToScribeModule.psm1