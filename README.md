
# pf2-to-scribe

## Présentation

Ce simple module permet d'exporter les données issues du site https://pf2e.pathfinder-fr.org vers le format supporté par https://scribe.pf2.tools.


## Utilisation

Pour utiliser ce module il faut importer celui-ci via la commande Powershell :

```Import-Module  -Name .\pf2ToScribeModule.psm1```

Ensuite, les commandes disponibles pourront être utilisée sans réimporter celui-ci.

## Fonctionnalités
### Actions
Pour l'instant, seules les actions sont supportées via la commande :

```Get-Actions -OutputFile ./out.txt```

Par défaut, sans paramètres, toutes les actions sont exportées.
Les paramètres suivants sont supportés :

Ids
: Pemet de chaîner des identifiants d'actions pour exporter uniquement celles-ci.
: Exemple : `Get-Actions -OutputFile ./out.txt -Ids 46pkhUrd57gTd4th, PZGE4lLJ8DHbGIUI`

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