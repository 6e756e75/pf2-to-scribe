
# pf2-to-scribe

## Présentation

Ce simple module PowerShell permet d'exporter les données issues du site https://pf2e.pathfinder-fr.org vers le format supporté par https://scribe.pf2.tools. Il est né d'un besoin d'imprimer les éléments techniques des personnages de mes joueurs pour qu'ils puissent facilement s'y référer.

## Utilisation

Pour utiliser les commandes d'export, il faut simplement exécuter le fichier `Launch.bat`. Celui-ci va alors ouvrir un terminal PowerShell et charger le module nécessaire.
À partir de là, il suffira d'entrer les commandes (voir ci-dessous) et exécuter celles-ci directement.

## Fonctionnalités
### Actions
L'export des actions se fait via la commande suivante :

```Get-Actions -OutputFile ./out.txt```

Par défaut, toutes les actions sont exportées si aucun filtre n'est spécifié.
Les filtres sont les suivants :

Ids (`-Ids <string[]>`)
: Permet de chaîner des identifiants d'actions pour exporter uniquement celles-ci.
: Exemple : `Get-Actions -OutputFile ./out.txt -Ids 46pkhUrd57gTd4th, PZGE4lLJ8DHbGIUI`

Ces identifiants se trouvent :
- soit dans l'url du détail de l'action : par exemple, pour l'url suivante "https://pf2e.pathfinder-fr.org/actions/EHa0owz6mccnmSBf" l'ID est `EHa0owz6mccnmSBf`;
- soit dans l'id source sur Foundry (onglet "Règles" > ID source) : par exemple "Compendium.pf2e.actionspf2e.Item.g8QrV39TmZfkbXgE", l'ID est `g8QrV39TmZfkbXgE`;

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