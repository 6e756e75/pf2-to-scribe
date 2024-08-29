
# pf2-to-scribe

## Présentation
Ce module PowerShell permet d'exporter les données issues du site https://pf2e.pathfinder-fr.org vers le format supporté par https://scribe.pf2.tools. Il est né d'un besoin d'imprimer les éléments techniques des personnages de mes joueurs pour qu'ils puissent facilement s'y référer.

## Installation
1. Télécharger l'archive zip du projet depuis GitHub (Code > Download zip);
2. Extraire ensuite ce zip dans un répertoire dedié;
3. Entrer dans ce répertoire;
4. Exécuter le script `Run.ps1` (clic-droit puis "Exécuter avec Powershell").

Le module va alors se mettre à jour puis se charger.

> [!NOTE]
> Pour une utilisation ultérieure, il ne sera plus nécessaire de télécharger une nouvelle fois l'archive, le script `Run.ps1` se charge de récupérer le module à jour.

## Utilisation
Une fois le module chargé via le script `Run.ps1`, les commandes sont disponibles dans la console. À partir de là, il suffit de les saisirs (voir ci-dessous) et les exécuter (touche "Entrée").

## Fonctionnalités
### Généralités
Chaque commande expose le paramètre ci-dessous:

- **OutputFile** (`-OutputFile <string>`) : le chemin vers le fichier dans lequel sera inscrit l'export. Exemple : `Get-Actions -OutputFile C:\Users\simon\Bureau\export.txt`

### Actions
L'export des actions se fait via la commande suivante :

```posh
Get-Actions -OutputFile ./out.txt
```

Par défaut, toutes les actions sont exportées si aucun filtre n'est spécifié.
Les filtres possibles sont les suivants :

- **Ids** (`-Ids <string[]>`) : Permet de chaîner des identifiants d'actions pour exporter uniquement celles-ci. Exemple : `Get-Actions -OutputFile ./out.txt -Ids 46pkhUrd57gTd4th, PZGE4lLJ8DHbGIUI`

Ces identifiants se trouvent :
- soit dans l'url du détail de l'action : par exemple, pour l'url suivante "https://pf2e.pathfinder-fr.org/actions/EHa0owz6mccnmSBf" l'ID est `EHa0owz6mccnmSBf`;
- soit dans l'id source sur Foundry (onglet "Règles" > ID source) : par exemple "Compendium.pf2e.actionspf2e.Item.g8QrV39TmZfkbXgE", l'ID est `g8QrV39TmZfkbXgE`;

## Exemples
Exporter les actions [Chercher](https://pf2e.pathfinder-fr.org/actions/BlAOM2X92SI6HMtJ) et [Aider](https://pf2e.pathfinder-fr.org/actions/HCl3pzVefiv9ZKQW) vers un fichier PJ_1.txt :
```posh
Get-Actions -OutputFile C:\Users\utilisateur\Desktop\PJ_1.txt -Ids BlAOM2X92SI6HMtJ, HCl3pzVefiv9ZKQW
```

## Roadmap
Je ferai évoluer le module dans le temps, mais la liste des ajouts futurs (non exhaustif, non ordonnés) :
- [ ] Ajouter l'export des dons
- [ ] Ajouter l'export des sorts
- [ ] Ajouter l'export de l'équipement
- [ ] Ajouter différents filtres sur les exports (traits, nom, etc.)

## Bugs et suggestions
Si vous repérez une erreur ou si vous avez une suggestion, n'hésitez pas à me ping sur le [Discord](https://discord.gg/MYqudHH) (@Nunu) ou à ouvrir une *issue* directement sur GitHub.

## Remerciements
Je profite de cette "tribune" pour remercier tous ceux qui participent à faire vivre cette superbe communauté Pathfinder francophone, à la fois bienveillante, accueillante et dévouée : :heart: sur vous.