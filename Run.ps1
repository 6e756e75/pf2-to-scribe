$ProgressPreference = 'SilentlyContinue'

# Télécharge le script d'initialisation à jour
if (-not (Test-Path -Path .\Init.ps1) -or ((Get-Item -Path .\Init.ps1).LastWriteTime -lt (Get-Date).AddMinutes(-1))){
    Write-Host "Mise à jour du script d'initialisation..." -NoNewline
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/Init.ps1" -OutFile .\Init.ps1 -ErrorAction Stop
    Write-Host "OK" -ForegroundColor Green
}

# Lancement de la fenêtre d'exécution
powershell.exe -NoExit -Command "./Init.ps1"