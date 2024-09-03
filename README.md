
# pf2-to-scribe

## Présentation
Ce module PowerShell permet d'exporter les données issues du site https://pf2e.pathfinder-fr.org vers le format supporté par https://scribe.pf2.tools. Il est né d'un besoin d'imprimer les éléments techniques des personnages (dons, sorts, actions, etc.) de mes joueurs pour qu'ils puissent facilement s'y référer.

## Installation

### Automatique
Exécuter la commande suivante dans un terminal PowerShell :
``` posh
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/6e756e75/pf2-to-scribe/main/Init.ps1'))
```

### Manuelle

1. Télécharger l'archive zip du projet depuis GitHub (Code > Download zip);
2. Extraire ensuite ce zip dans un répertoire dedié;
3. Entrer dans ce répertoire;
4. Exécuter le script `Run.ps1` (clic-droit puis "Exécuter avec Powershell").

Le module va alors se mettre à jour puis se charger.

> [!NOTE]
> Pour une utilisation ultérieure, il ne sera plus nécessaire de télécharger une nouvelle fois l'archive, le script `Run.ps1` se charge de récupérer le module à jour.

## Utilisation
Une fois le module chargé via le script `Run.ps1`, les commandes sont disponibles dans la console. À partir de là, il suffit de les saisir (voir ci-dessous) et les exécuter (touche "Entrée").

## Fonctionnalités
### Généralités
Chaque commande expose les paramètres ci-dessous:

- **OutputFile** (`-OutputFile <string>`) : le chemin vers le fichier dans lequel sera inscrit l'export. Exemple : `Get-Actions -OutputFile C:\Users\simon\Bureau\export.txt`

- **Ids** (`-Ids <string[]>`) : Permet de chaîner des identifiants (dons, sorts, etc.) pour exporter uniquement ceux-ci. Exemple : `Get-Dons -OutputFile ./out.txt -Ids B0T6p3kcrOfSvLqQ, oTTddwzF9TPNkMyd`

Ces identifiants se trouvent :
- soit dans l'url du détail du don : par exemple, pour l'url suivante "https://pf2e.pathfinder-fr.org/feats/pekKtubQTkG9m1xK" l'ID est `pekKtubQTkG9m1xK`;
- soit dans l'id source sur Foundry (onglet "Règles" > ID source) : par exemple "Compendium.pf2e.feats-srd.Item.uW0VSyy75YrsvtWz", l'ID est `uW0VSyy75YrsvtWz`;

### Actions
L'export des actions se fait via la commande suivante :

```posh
Get-Actions -OutputFile ./out.txt
```

Par défaut, toutes les actions sont exportées si aucun filtre n'est spécifié.

### Dons
L'export des dons se fait via la commande suivante :

```posh
Get-Dons -OutputFile ./out.txt
```

Par défaut, tous les dons sont exportés si aucun filtre n'est spécifié.

### Sorts
L'export des sorts se fait via la commande suivante :

```posh
Get-Sorts -OutputFile ./out.txt
```

Par défaut, tous les sorts sont exportés si aucun filtre n'est spécifié.

## Exemples
Exporter les actions [Chercher](https://pf2e.pathfinder-fr.org/actions/BlAOM2X92SI6HMtJ) et [Aider](https://pf2e.pathfinder-fr.org/actions/HCl3pzVefiv9ZKQW) vers un fichier PJ_1.txt :
```posh
Get-Actions -OutputFile C:\Users\utilisateur\Desktop\PJ_1.txt -Ids BlAOM2X92SI6HMtJ, HCl3pzVefiv9ZKQW
```

Exporter les dons [Assaut à deux mains](https://pf2e.pathfinder-fr.org/feats/HHAGiBYVv8nyUEsd) et [Contresort astucieux](https://pf2e.pathfinder-fr.org/feats/IMPP5pa8AmvCby4W) vers un fichier PJ_1.txt :
```posh
Get-Dons -OutputFile C:\Users\utilisateur\Desktop\PJ_1.txt -Ids IMPP5pa8AmvCby4W, HHAGiBYVv8nyUEsd
```

Exporter le sort [Abrutir](https://pf2e.pathfinder-fr.org/spells/CQb8HtQ1BPeZmu9h) vers un fichier PJ_1.txt : 
```posh
Get-Sorts -OutputFile C:\Users\utilisateur\Desktop\PJ_1.txt -Ids CQb8HtQ1BPeZmu9h
```

## Roadmap
Je ferai évoluer le module dans le temps, mais la liste des ajouts futurs (non exhaustif, non ordonnés) :
- [ ] Ajouter l'export de l'équipement
- [ ] Ajouter différents filtres sur les exports (traits, nom, etc.)

## Bugs et suggestions
Si vous repérez une erreur ou si vous avez une suggestion, n'hésitez pas à me ping sur le [Discord](https://discord.gg/MYqudHH) (@Nunu) ou ouvrir une *issue* directement sur GitHub.

## Remerciements
Je profite de cette "tribune" pour remercier tous ceux qui participent à faire vivre cette superbe communauté Pathfinder francophone, à la fois bienveillante, accueillante et dévouée : :heart: sur vous.