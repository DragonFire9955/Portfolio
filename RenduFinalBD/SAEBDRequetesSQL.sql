
--afficher tous les joueurs avec leur pseudo, prénom et nom
SELECT joueur.pseudo, personne.prenom, personne.nom
FROM joueur
INNER JOIN personne ON joueur.idJoueur = personne.idPers;

--lister toutes les équipes avec plus de 15 victoires
SELECT equipe.nom, equipe.directeur, equipe.nbrVictoires
FROM equipe
WHERE equipe.nbrVictoires > 15;


--tournois qui commencent après le 1er mars 2025
SELECT tournois.nom, tournois.lieu, tournois.dateDebut
FROM tournois
WHERE tournois.dateDebut > '2025-03-01'
ORDER BY tournois.dateDebut ASC;


--cherche les visiteurs ayant moins de 27 ans.
SELECT personne.nom, personne.prenom, personne.age
FROM visiteur
INNER JOIN personne ON visiteur.idVis = personne.idPers
WHERE personne.age < 27
ORDER BY personne.age ASC;

--affiche les équipes en fonction de leur nombre de victoires (descendant).
SELECT nom, directeur, nbrVictoires, nbrDefaites
FROM equipe
ORDER BY nbrVictoires DESC;

--afficher la moyenne d'age des joueurs par équipe.
SELECT joueur.idEquipe, AVG(personne.age)
FROM joueur
INNER JOIN personne ON joueur.idJoueur = personne.idPers
GROUP BY joueur.idEquipe
ORDER BY AVG(personne.age) DESC;

-- Liste des matchs avec l’équipe gagnante, perdante et leur score
SELECT match.idMatch, 
       equipeGagnante.nom AS equipeGagnante, 
       equipePerdante.nom AS equipePerdante, 
       match.scoreGagnant, 
       match.scorePerdant
FROM match
INNER JOIN equipe equipeGagnante ON match.equipeGagnante = equipeGagnante.idEquipe
INNER JOIN equipe equipePerdante ON match.equipePerdante = equipePerdante.idEquipe;


--matchs avec un score gagnant supérieur ou égal à 4 avc le nom de l'équipe gagnante.
SELECT match.idMatch,
       equipeGagnante.nom AS equipeGagnante,
       match.scoreGagnant
FROM match
INNER JOIN equipe equipeGagnante ON match.equipeGagnante = equipeGagnante.idEquipe
WHERE match.scoreGagnant >= 4;

--affiche l'id du sponsor et le budget dépensé
SELECT budget.idSponsor, SUM(depenses.prixLieu + depenses.prixPersonnel + depenses.prixMateriel + sponsor.montantVerse + ticketing.prix) AS budget_total
FROM budget
INNER JOIN depenses using(idDepenses)
INNER JOIN sponsor ON budget.idSponsor = sponsor.idSponsor
INNER JOIN ticketing ON budget.idTicketing = ticketing.idTicket
GROUP BY budget.idSponsor
ORDER BY budget_total DESC;

--afficher le budget total (dépenses + sponsor + ticket) par événement trié du plus cher au moins cher
SELECT tournois.nom,
       tournois.lieu,
       (depenses.prixLieu + depenses.prixPersonnel + depenses.prixMateriel 
        + sponsor.montantVerse + ticketing.prix) AS budget_total
FROM tournois
JOIN budget ON tournois.idBudget = budget.idBudget
JOIN depenses ON budget.idDepenses = depenses.idDepenses
JOIN sponsor ON budget.idSponsor = sponsor.idSponsor
JOIN ticketing ON budget.idTicketing = ticketing.idTicket
ORDER BY budget_total DESC;