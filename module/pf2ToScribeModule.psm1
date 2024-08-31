$DIR_DATAS = "./datas"
$FILE_ACTIONS = "actions.json"
$FILE_DONS = "dons.json"
$FILE_SORTS = "sorts.json"
$FILE_TRAITS = "traits.json"

<# PRIVATE FUNCTIONS #>
function DownloadActions {
    $filePath = "$DIR_DATAS/$FILE_ACTIONS"

    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).LastWriteTime -ge (Get-Date).AddHours(-1))){
        Write-Output (Get-Content -Path $filePath -Raw -Encoding UTF8)
    } else {
        $rawDatas = Invoke-WebRequest -UseBasicParsing -Uri "https://pf2e.pathfinder-fr.org/assets/data/actions.json" `
        -Headers @{
        "Accept" = "application/json, text/plain, */*"
          "Accept-Language" = "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3"
          "Accept-Encoding" = "gzip, deflate, br, zstd"
          "Referer" = "https://pf2e.pathfinder-fr.org/"
          "Sec-Fetch-Dest" = "empty"
          "Sec-Fetch-Mode" = "cors"
          "Sec-Fetch-Site" = "same-origin"
        }

        $datas = [Text.Encoding]::UTF8.GetString($rawDatas.RawContentStream.ToArray())
        Set-Content -Path $filePath -Value $datas -Encoding UTF8
        Write-Output $datas
    }
}

function DownloadDons {
    $filePath = "$DIR_DATAS/$FILE_DONS"

    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).LastWriteTime -ge (Get-Date).AddHours(-1))){
        Write-Output (Get-Content -Path $filePath -Raw -Encoding UTF8)
    } else {
        $rawDatas = Invoke-WebRequest -UseBasicParsing -Uri "https://pf2e.pathfinder-fr.org/assets/data/feats.json" `
        -Headers @{
        "Accept" = "application/json, text/plain, */*"
          "Accept-Language" = "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3"
          "Accept-Encoding" = "gzip, deflate, br, zstd"
          "Referer" = "https://pf2e.pathfinder-fr.org/all-feats"
          "Sec-Fetch-Dest" = "empty"
          "Sec-Fetch-Mode" = "cors"
          "Sec-Fetch-Site" = "same-origin"
        }

        $datas = [Text.Encoding]::UTF8.GetString($rawDatas.RawContentStream.ToArray())
        Set-Content -Path $filePath -Value $datas -Encoding UTF8
        Write-Output $datas
    }
}

function DownloadSpells {
    $filePath = "$DIR_DATAS/$FILE_SORTS"

    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).LastWriteTime -ge (Get-Date).AddHours(-1))){
        Write-Output (Get-Content -Path $filePath -Raw -Encoding UTF8)
    } else {
        $rawDatas = Invoke-WebRequest -UseBasicParsing -Uri "https://pf2e.pathfinder-fr.org/assets/data/spells.json" `
        -Headers @{
        "Accept" = "application/json, text/plain, */*"
          "Accept-Language" = "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3"
          "Accept-Encoding" = "gzip, deflate, br, zstd"
          "Referer" = "https://pf2e.pathfinder-fr.org/spells"
          "Sec-Fetch-Dest" = "empty"
          "Sec-Fetch-Mode" = "cors"
          "Sec-Fetch-Site" = "same-origin"
        }

        $datas = [Text.Encoding]::UTF8.GetString($rawDatas.RawContentStream.ToArray())
        Set-Content -Path $filePath -Value $datas -Encoding UTF8
        Write-Output $datas
    }
}

function DownloadTraits {
    $filePath = "$DIR_DATAS/$FILE_TRAITS"

    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).LastWriteTime -ge (Get-Date).AddHours(-1))){
        Write-Output (Get-Content -Path $filePath -Raw -Encoding UTF8)
    } else {
        $rawDatas = Invoke-WebRequest -UseBasicParsing -Uri "https://pf2e.pathfinder-fr.org/assets/data/traits.json" `
        -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:129.0) Gecko/20100101 Firefox/129.0" `
        -Headers @{
        "Accept" = "application/json, text/plain, */*"
          "Accept-Language" = "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3"
          "Accept-Encoding" = "gzip, deflate, br, zstd"
          "Referer" = "https://pf2e.pathfinder-fr.org/traits"
          "Sec-Fetch-Dest" = "empty"
          "Sec-Fetch-Mode" = "cors"
          "Sec-Fetch-Site" = "same-origin"
        }

        $datas = [Text.Encoding]::UTF8.GetString($rawDatas.RawContentStream.ToArray())
        Set-Content -Path $filePath -Value $datas -Encoding UTF8
        Write-Output $datas
    }
}

function GetActionIcon {
    param($NombreActions)

    switch ($NombreActions) {
        1 { return ":a:" }
        2 { return ":aa:" }
        3 { return ":aaa:" }
        Default { return "" }
    }
}

function ParseActionIcon{
    param($Action)

    switch ($Action.actionType) {
        "action" {
            Write-Output "$(GetActionIcon([int]$Action.actions))"
        }
        "reaction" { Write-Output ":r:" }
        "free" { Write-Output ":f:" }
        "passive" { Write-Output "" }
    }
}

function GetSpellIcon{
    param($Spell)

    switch ($Spell.time) {
        "1" { Write-Output ":a:" }
        "2" { Write-Output ":aa:" }
        "3" { Write-Output ":aaa:" }
        Default { Write-Output "" }
    }
}

function GetTraductionTraits{
    param(
        [string]
        $Trait
    )

    $traits = (DownloadTraits | ConvertFrom-Json)
    $item = $traits | Select-Object -ExpandProperty $Trait -ErrorAction SilentlyContinue

    if ($item){
        Write-Output $item.translations.fr.name
        return
    }

    Write-Output $Trait
}

function GetTraits {
    param($Traits)

    $outputTraits = @()
    switch ($Traits.rarity) {
        "uncommon" { $outputTraits += "Peu courant" }
        "rare" { $outputTraits += "Rare" }
        "unique" { $outputTraits += "Unique" }
    }

    foreach($t in $Traits.value) {
        $outputTraits += GetTraductionTraits($t)
    }

    if ($outputTraits.Length -eq 0){
        Write-Output ""
    } else {
        Write-Output ($outputTraits -join ", ")
    }
}

function ParseCheck{
    # $CheckAttribute == type:crafting|dc:36
    param(
        [string]
        $CheckAttribute
    )

    # Impossible de déterminer le type => on sort
    if ($CheckAttribute.Contains(":") -and -not ($CheckAttribute -match "(?<=type:)(\w+)")){
        return
    }

    $out = ""
    switch ($Matches[1]) {
        "acrobatics" { $out = "Acrobatie" }
        "arcana" { $out = "Arcanes" }
        "crafting" { $out = "Artisanat" }
        "athletics" { $out = "Athlétisme" }
        "diplomacy" { $out = "Diplomatie" }
        "discretion" { $out = "Discrétion" }
        "deception" { $out = "Duperie" }
        "intimidation" { $out = "Intimidation" }
        "nature" { $out = "Nature" }
        "occultism" { $out = "Occultisme" }
        "religion" { $out = "Religion" }
        "performance" { $out = "Représentation" }
        "society" { $out = "Société" }
        "survival" { $out = "Survie" }
        "stealth" { $out = "Vol" }
        "reflex" { $out = "Réflexe" }
        "will" { $out = "Volonté" }
        "fortitude" { $out = "Vigueur" }
        Default { $out = $Matches[1] }
    }

    if ($CheckAttribute -match "(?<=basic:)true"){
        $out += " basique"
    }

    if ($CheckAttribute -match "(?<=dc:)(\d+)"){
        $dc = [int]$Matches[1]
        if ($dc -gt 0){
            $out += " (DD $dc)"
        }
    }

    Write-Output $out
}

function GetDescription{
    param(
        [string]
        $Description
    )
    
    while ($Description -match "@Check\[([\w\d:|@\.()]+)]"){
        $Description = $Description.Replace($Matches[0], "$(ParseCheck($Matches[1]))")
    }

    while ($Description -match "@UUID\[[^\]]+\]{(.*?)}"){
        $Description = $Description.Replace($Matches[0], $Matches[1])
    }

    while ($Description -match "@Template\[[^\]]+\]{(.*?)}"){
        $Description = $Description.Replace($Matches[0], $Matches[1])
    }

    while ($Description -match "@Damage.*?{(.*?)}"){
        $Description = $Description.Replace($Matches[0], $Matches[1])
    }

    while ($Description -match "[\[]{2}.*?[\]]{2}{(.*?)}"){
        $Description = $Description.Replace($Matches[0], $Matches[1])
    }

    # Remplace les balises <h2> par ##
    while ($Description -match '<h2.*>(.*?)<\/h2>'){
        $Description = $Description.Replace($Matches[0], "`r`n### $($Matches[1])`r`n")
    }

    while ($Description -match '<span class="action-glyph">(\d)<\/span>'){
        $Description = $Description.Replace($Matches[0], "$(GetActionIcon([int]$Matches[1]))")
    }

    # Supprime les sections
    while ($Description -match '<section.*>|<\/section>'){
        $Description = $Description.Replace($Matches[0], "")
    }

    # Tout ce qui prend une forme textuelle est utilisé directement (@Damage[...]{Texte})
    # $Description = $Description -replace "@[^{]+{([^}]+)}", '$1'
    
    # Les tests de compétences sont traduits
    <#
    while ($Description -match "@Check\[([^\]]+)]"){
        $rawCheck = $Matches[0]
        $propCheck = $Matches[1]
    
        $str = ""
        # Isole le type du @Check
        if ($propCheck -match "type:([^|]+)") {
            switch ($Matches[1]) {
                "reflex" { $str = "Réflexes" }
            }
        }
    
        # Isole si le jet est basique
        if ($propCheck -match "basic:([^|]+)") {
            switch ($Matches[1]) {
                "true" { $str += " (basique)" }
            }
        }
    
        $Description = $Description.Replace($rawCheck, $str)
    }
    #>
    
    Write-Output $Description
}

function GetIncantationTime {
    param (
        $spell
    )

    $out = ""
    switch ($spell.translations.fr.time) {
        "1" { $out = ":a:" }
        "2" { $out = ":aa:" }
        "3" { $out = ":aaa:" }
        "reaction" { $out = ":r:" }
        Default { $out = $spell.translations.fr.time }
    }

    $out = $out -replace "to", "à"

    $components = @()
    if ($spell.components.somatic) {
        $components += "Somatique"
    }

    if ($spell.components.verbal){
        $components += "verbal"
    }

    if ($spell.components.material){
        $components += "matériel"
    }

    if ($components.Count -gt 0) {
        $out += " ($($components -join ", "))"
    }

    Write-Output $out
}

function GetTranslatedProperties {
    param($item)

    if (-not $item.translations.fr){
        Write-Output ""
        return
    }

    $str = ""
    $item.translations.fr | Get-Member -MemberType NoteProperty | ForEach-Object {
        switch ($_.Name) {
            "prerequisites" { $str += "**Prérequis** $(($item.translations.fr.prerequisites -join ", "))`r`n`r`n" }
            "time" { $str += "**Incantation** $(GetIncantationTime($item))`r`n`r`n" }
            "secondarycasters" { $str += "**Incantateurs secondaires** $($item.translations.fr.secondarycasters)`r`n`r`n" }
            "materials" { $str += "**Condition** $($item.translations.fr.materials)`r`n`r`n" }
            "primarycheck" {
                $str += "**Test principal** $($item.translations.fr.primarycheck)"

                if ($s.translations.fr.secondarycheck){
                    $str += " ; **Test secondaire** $($item.translations.fr.secondarycheck)`r`n`r`n"
                } else {
                    $str += "`r`n`r`n"
                }
            }
            "secondarycheck" {  }
            "range" { $str += "**Portée** $($item.translations.fr.range)`r`n`r`n" }
            "areadetails" { $str += "**Zone** $($item.translations.fr.areadetails)`r`n`r`n" }
            "cost" { $str += "**Coût** $($item.translations.fr.cost)`r`n`r`n" }
            "duration" { $str += "**Durée** $($item.translations.fr.duration)`r`n`r`n" }
            "target" { $str += "**Cible** $($item.translations.fr.target)`r`n`r`n" }
            "description" {  }
            "name" {  }
            Default {
                $str += "**$($_.Name)**`r`n`r`n"
            }
        }
    }

    Write-Output $str
}

function GetSpellTypeName {
    param($spell)

    if ($spell.traits.value -contains "cantrip"){
        Write-Output "Tour de magie"
        return
    }

    Write-Output "Sort"
}

function FormatActionsToScribe{
    param($actions)

    # Titre + header
    $str = "head (`r`n# Actions`r`n-`r`n)`r`n"

    foreach ($action in $actions){
    
        $str += "item(`r`n"
        $str += "# $($action.translations.fr.name) $((ParseActionIcon($action)))`r`n"
        $str += "-`r`n"

        $traits = GetTraits($action.traits)
        if ($traits){
            $str += "; $traits`r`n"
        }

        $str += "$(GetDescription($action.translations.fr.description))`r`n"
        $str += ")`r`n"
    }
    
    Write-Output $str
}

function FormatDonsToScribe {
    param($feats)

    $lvl = 0

    # Titre + header
    $str = "head (`r`n# Dons`r`n-`r`n)`r`n"

    foreach ($feat in $feats){
    
        if (-not $feat.translations.fr.name){
            continue
        }

        if ($lvl -lt $feat.level) {
            $lvl = $feat.level
            $str += "`r`n#### Niveau $($feat.level) `r`n`r`n"
        }
    
        $str += "item(`r`n"
        $str += "# $($feat.translations.fr.name) $(ParseActionIcon($feat))`r`n"
        $str += "## Don $($feat.level)`r`n"
        $str += "-`r`n"

        $traits = GetTraits($feat.traits)
        if ($traits){
            $str += "; $traits`r`n"
        }

        $str += GetTranslatedProperties($feat)
        $str += "-`r`n"
        $str += "$(GetDescription($feat.translations.fr.description))`r`n"
        $str += ")`r`n"
    }

    Write-Output $str
}

function FormatSpellsToScribe{
    param($spells)

    $lvl = 0

    # Titre + header
    $str = "head (`r`n# Sorts`r`n-`r`n)`r`n"

    foreach ($s in $spells){
    
        if ($lvl -lt $s.level) {
            $lvl = $s.level
            $str += "`r`n#### Niveau $($s.level) `r`n`r`n"
        }
    
        $str += "item(`r`n"
        $str += "# $($s.translations.fr.name) $(GetSpellIcon($s))`r`n"
        $str += "## $(GetSpellTypeName($s)) $($s.level)`r`n"
        $str += "-`r`n"

        $traits = GetTraits($s.traits)
        if ($traits){
            $str += "; $traits`r`n"
        }

        $str += GetTranslatedProperties($s)
        $str += "-`r`n"
        $str += "$(GetDescription($s.translations.fr.description))`r`n"
        $str += ")`r`n"
    }

    Write-Output $str
}

<# PUBLIC FUNCTION #>

<#
.SYNOPSIS
    Exporte une ou plusieurs actions.
.DESCRIPTION
    Cette commande exporte une ou plusieurs actions vers un fichier de sortie pour être utilisé sur https://scribe.pf2.tools/.
.PARAMETER OutputFile
    Il s'agit du fichier qui contiendra les données formatées pour pf2 scribe tools.
.PARAMETER Ids
    Permet de chaîner des identifiants d'actions pour exporter uniquement celles-ci.
.EXAMPLE
    C:\PS> Get-Actions -OutputFile ./out.txt -Ids 46pkhUrd57gTd4th, PZGE4lLJ8DHbGIUI
.NOTES
    https://github.com/6e756e75/pf2-to-scribe
#>
function Get-Actions{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Il s'agit du fichier qui contiendra les données formattés pour pf2 scribe tools.")]
        [string]
        $OutputFile,

        [string[]]
        $Ids
    )

    $actions = (DownloadActions | ConvertFrom-Json)

    # Filtre par ID
    if ($Ids.Length -gt 0){
        $actions = $actions | Where-Object { 
            $currentActionId = $_._id
            $null -ne ($Ids | Where-Object { $currentActionId -eq $_ })
        }
    }

    $actions = ($actions | Sort-Object -Property translations.fr.name)
    Set-Content -Path $OutputFile -Value (FormatActionsToScribe($actions)) -Encoding UTF8
}

<#
.SYNOPSIS
    Exporte une ou plusieurs dons.
.DESCRIPTION
    Cette commande exporte une ou plusieurs dons vers un fichier de sortie pour être utilisé sur https://scribe.pf2.tools/.
.PARAMETER OutputFile
    Il s'agit du fichier qui contiendra les données formatées pour pf2 scribe tools.
.PARAMETER Ids
    Permet de chaîner des identifiants de dons pour exporter uniquement ceux-ci.
.EXAMPLE
    C:\PS> Get-Dons -OutputFile ./out.txt -Ids CpjN7v1QN8TQFcvI
.NOTES
    https://github.com/6e756e75/pf2-to-scribe
#>
function Get-Dons {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true, HelpMessage = "Il s'agit du fichier qui contiendra les données formattés pour pf2 scribe tools.")]
        [string]
        $OutputFile,

        [string[]]
        $Ids
    )

    $dons = (DownloadDons | ConvertFrom-Json)

    # Filtre par ID
    if ($Ids.Length -gt 0){
        $dons = $dons | Where-Object { 
            $currentDonId = $_._id
            $null -ne ($Ids | Where-Object { $currentDonId -eq $_ })
        }
    }

    $dons = ($dons | Sort-Object -Property level, translations.fr.name)
    Set-Content -Path $OutputFile -Value (FormatDonsToScribe($dons)) -Encoding UTF8
}

function Get-Spells {
    param(
        [string]
        $OutputFile,

        [string[]]
        $Ids
    )

    $spells = (DownloadSpells | ConvertFrom-Json)

    # Filtre par ID
    if ($Ids.Length -gt 0){
        $spells = $spells | Where-Object { 
            $currentSpellId = $_._id
            $null -ne ($Ids | Where-Object { $currentSpellId -eq $_ })
        }
    }

    $spells = ($spells | Sort-Object -Property level, translations.fr.name)
    Set-Content -Path $OutputFile -Value (FormatSpellsToScribe($spells)) -Encoding UTF8
}

Export-ModuleMember -Function Get-Actions
Export-ModuleMember -Function Get-Dons
# Export-ModuleMember -Function Get-Spells