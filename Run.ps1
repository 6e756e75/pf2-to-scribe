Invoke-WebRequest -Uri "https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/Init.ps1" -OutFile .\Init.ps1
powershell.exe -NoExit -Command "./Init.ps1"