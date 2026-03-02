DROP SCHEMA IF EXIST competitionEsport;
CREATE SCHEMA competitionEsport;

--table competitionEsport.personne
CREATE TABLE personne (
    idPers INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    age INT
);

--table competitionEsport.visiteur
CREATE TABLE visiteur (
    idVis INT PRIMARY KEY,
    FOREIGN KEY (idVis) REFERENCES personne(idPers)
);

--table competitionEsport.joueur
CREATE TABLE joueur (
    idJoueur INT PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL,
    idEquipe INT NOT NULL,
    classement INT NOT NULL,
    FOREIGN KEY (idJoueur) REFERENCES personne(idPers)
);

--table competitionEsport.equipe
CREATE TABLE equipe (
    idEquipe INT PRIMARY KEY,
    nom VARCHAR(50),
    directeur VARCHAR(50),
    nbrVictoires INT,
    nbrDefaites INT,
    etapeAtteinte VARCHAR(30)
);

--table competitionEsport.etape
CREATE TABLE etape (
    idEtape INT PRIMARY KEY,
    dateEtape DATE,
    heureEtape TIME,
    idMatch INT,
    phaseCompetition VARCHAR(30)
);

--table competitionEsport.match
CREATE TABLE `match` (
    idMatch INT PRIMARY KEY,
    equipeGagnante INT,
    equipePerdante INT,
    scoreGagnant INT,
    scorePerdant INT,
    idEtape INT,
    FOREIGN KEY (equipeGagnante) REFERENCES equipe(idEquipe),
    FOREIGN KEY (equipePerdante) REFERENCES equipe(idEquipe),
    FOREIGN KEY (idEtape) REFERENCES etape(idEtape)
);

--table competitionEsport.depenses
CREATE TABLE depenses (
    idDepenses INT PRIMARY KEY,
    prixLieu DECIMAL(10,2),
    prixPersonnel DECIMAL(10,2),
    prixMateriel DECIMAL(10,2)
);

--table competitionEsport.sponsor
CREATE TABLE sponsor (
    idSponsor INT PRIMARY KEY,
    codeSirene VARCHAR(20),
    nom VARCHAR(20),
    montantVerse DECIMAL(10,2),
    typePub VARCHAR(50)
);

--table competitionEsport.ticketing
CREATE TABLE ticketing (
    idTicket INT PRIMARY KEY,
    prix DECIMAL(7,2),
    dateDebut DATE,
    dateFin DATE
);

--table competitionEsport.budget
CREATE TABLE budget (
    idBudget INT PRIMARY KEY,
    idDepenses INT,
    idSponsor INT,
    idTicketing INT,
    FOREIGN KEY (idDepenses) REFERENCES depenses(idDepenses),
    FOREIGN KEY (idSponsor) REFERENCES sponsor(idSponsor),
    FOREIGN KEY (idTicketing) REFERENCES ticketing(idTicket)
);

--table competitionEsport.tournois
CREATE TABLE tournois (
    idTournois INT PRIMARY KEY,
    nom VARCHAR(100),
    dateDebut DATE,
    dateFin DATE,
    lieu VARCHAR(100),
    idBudget INT,
    FOREIGN KEY (idBudget) REFERENCES budget(idBudget)
);


INSERT INTO personne (idPers, nom, prenom, age) VALUES
(1,'Dupont','Alice',23),(2,'Martin','Bob',30),(3,'Bernard','Chloé',19),
(4,'Petit','David',28),(5,'Robert','Emma',22),(6,'Richard','Félix',35),
(7,'Durand','Gabriel',27),(8,'Moreau','Hélène',24),(9,'Simon','Isabelle',29),
(10,'Laurent','Julien',21),(11,'Lefevre','Kylian',31),(12,'Michel','Léa',26),
(13,'Garcia','Maxime',33),(14,'David','Nina',20),(15,'Bertrand','Oscar',25),
(16,'Roux','Paul',32),(17,'Vincent','Quentin',22),(18,'Fournier','Romain',28),
(19,'Morel','Sophie',24),(20,'Gautier','Thomas',27),(21,'Chevalier','Ulysse',30),
(22,'Blanc','Valentine',21),(23,'Guerin','William',34),(24,'Boyer','Xavier',29),
(25,'Garnier','Yasmine',23),(26,'Faure','Zoé',26),(27,'Henry','Alex',31),
(28,'Perrin','Bella',28),(29,'Rousseau','Cédric',25),(30,'Dupuis','Diane',22),
(31,'Lemoine','Éric',36),(32,'Brun','Fanny',19),(33,'Michel','Geoffrey',28),
(34,'Olivier','Hugo',24),(35,'Gautier','Inès',27),(36,'Adam','Jules',20),
(37,'Giraud','Karine',32),(38,'Collin','Lucas',29),(39,'Gillet','Marine',23),
(40,'Fabre','Nathan',26),(41,'Noel','Océane',21),(42,'Renaud','Pierre',33),
(43,'Marchand','Quentin',30),(44,'Barbier','Roxane',22),(45,'Benoit','Samuel',25),
(46,'Poulain','Théo',28),(47,'Henry','Ugo',34),(48,'Carre','Valentin',27),
(49,'Gros','Wendy',24),(50,'Blond','Xavier',31),(51,'Chevalier','Yann',29),
(52,'Lucas','Zoé',20),(53,'Rolland','Arthur',22),(54,'Caron','Bastien',35),
(55,'Lucas','Camille',26),(56,'Morel','Denis',23),(57,'Pires','Estelle',30),
(58,'Mathieu','Florian',28),(59,'Dufour','Gabin',21),(60,'Lemoine','Hana',27);

INSERT INTO visiteur (idVis) VALUES
(2),(5),(7),(8),(11),(12),(14),(16),(18),(20),
(21),(23),(24),(26),(27),(29),(30),(31),(33),(34),
(36),(37),(39),(40),(42),(44),(45),(47),(48),(50);

INSERT INTO joueur (idJoueur, pseudo, idEquipe, classement) VALUES
(1,'Shadow',1,1200),(3,'Blaze',1,1350),(4,'Nova',2,1400),
(6,'Razor',2,1250),(9,'Phantom',3,1500),(10,'Viper',3,1100),
(13,'Fury',4,1300),(15,'Ghost',4,1450),(17,'Falcon',5,1380),
(19,'Ace',5,1220),(22,'Tiger',6,1180),(25,'Eagle',6,1280),
(28,'Wolf',7,1350),(32,'Lion',7,1400),(35,'Dragon',8,1500),
(38,'Hawk',8,1200),(41,'Cobra',9,1250),(43,'Panther',9,1300),
(46,'Shark',10,1380),(49,'Jaguar',10,1100),(51,'Raven',1,1450),
(52,'Lynx',2,1320),(53,'Bear',3,1210),(54,'Tiger2',4,1190),
(55,'Phoenix',5,1370),(56,'Dragon2',6,1420),(57,'Falcon2',7,1330),
(59,'Vulture',9,1280),(60,'Panther2',10,1390);

INSERT INTO equipe (idEquipe, nom, directeur, nbrVictoires, nbrDefaites, etapeAtteinte) VALUES
(1,'Red Dragons','Alice Martin',12,3,'Finale'),
(2,'Blue Phoenix','Bob Dupont',9,6,'Demi-Finale'),
(3,'Green Tigers','Chloé Bernard',15,2,'Finale'),
(4,'Yellow Wolves','David Petit',7,8,'Quart de Finale'),
(5,'Black Panthers','Emma Robert',10,5,'Demi-Finale'),
(6,'White Eagles','Félix Richard',8,7,'Quart de Finale'),
(7,'Silver Foxes','Gabriel Durand',13,4,'Finale'),
(8,'Golden Lions','Hélène Moreau',6,9,'Huitième de Finale'),
(9,'Shadow Hawks','Isabelle Simon',11,4,'Demi-Finale'),
(10,'Crimson Cobras','Julien Laurent',5,10,'Huitième de Finale');

INSERT INTO etape (idEtape, dateEtape, heureEtape, idMatch, phaseCompetition) VALUES
(1,'2026-01-15','11:42',7,'Demi-Finale'),
(2,'2026-01-10','16:18',12,'Huitième de Finale'),
(3,'2026-01-18','09:50',5,'Quart de Finale'),
(4,'2026-01-12','14:33',19,'Finale'),
(5,'2026-01-14','13:15',2,'Huitième de Finale'),
(6,'2026-01-17','17:22',9,'Demi-Finale'),
(7,'2026-01-11','10:05',14,'Huitième de Finale'),
(8,'2026-01-21','18:40',3,'Quart de Finale'),
(9,'2026-01-16','12:50',11,'Demi-Finale'),
(10,'2026-01-13','15:30',1,'Quart de Finale'),
(11,'2026-01-24','13:10',6,'Demi-Finale'),
(12,'2026-01-19','09:55',16,'Quart de Finale'),
(13,'2026-01-22','16:05',4,'Finale'),
(14,'2026-01-10','12:42',20,'Huitième de Finale'),
(15,'2026-01-23','11:30',18,'Demi-Finale'),
(16,'2026-01-12','17:48',28,'Finale'),
(17,'2026-01-20','10:15',27,'Quart de Finale'),
(18,'2026-01-11','14:55',26,'Huitième de Finale'),
(19,'2026-01-13','18:05',25,'Quart de Finale'),
(20,'2026-01-16','09:40',22,'Demi-Finale'),
(21,'2026-01-15','16:20',23,'Huitième de Finale'),
(22,'2026-01-14','11:05',21,'Quart de Finale'),
(23,'2026-01-17','13:35',10,'Demi-Finale'),
(24,'2026-01-19','15:50',24,'Finale'),
(25,'2026-01-20','12:25',29,'Huitième de Finale'),
(26,'2026-01-18','17:15',30,'Quart de Finale'),
(27,'2026-01-21','09:40',8,'Demi-Finale'),
(28,'2026-01-22','14:10',15,'Quart de Finale'),
(29,'2026-01-23','16:55',13,'Huitième de Finale'),
(30,'2026-01-24','10:20',17,'Finale');

INSERT INTO `match` (idMatch, equipeGagnante, equipePerdante, scoreGagnant, scorePerdant, idEtape) VALUES
(1, 3, 7, 2, 1, 1),
(2, 2, 4, 2, 0, 2),
(3, 6, 1, 2, 1, 3),
(4, 5, 9, 2, 0, 4),
(5, 8, 3, 1, 2, 5),
(6, 7, 2, 2, 0, 6),
(7, 1, 10, 2, 1, 7),
(8, 9, 5, 2, 0, 8),
(9, 4, 6, 2, 1, 9),
(10, 10, 8, 2, 0, 10),
(11, 3, 2, 2, 1, 11),
(12, 6, 7, 1, 2, 12),
(13, 5, 9, 2, 1, 13),
(14, 1, 4, 2, 0, 14),
(15, 8, 3, 2, 1, 15),
(16, 2, 6, 1, 2, 16),
(17, 7, 1, 2, 0, 17),
(18, 9, 10, 2, 1, 18),
(19, 4, 8, 2, 1, 19),
(20, 3, 5, 2, 0, 20),
(21, 1, 7, 2, 1, 21),
(22, 2, 9, 1, 2, 22),
(23, 6, 3, 2, 1, 23),
(24, 8, 4, 2, 0, 24),
(25, 5, 10, 2, 1, 25),
(26, 9, 1, 2, 0, 26),
(27, 7, 6, 2, 1, 27),
(28, 3, 8, 1, 2, 28),
(29, 10, 2, 2, 0, 29),
(30, 4, 5, 2, 1, 30);

INSERT INTO depenses (idDepenses, prixLieu, prixPersonnel, prixMateriel) VALUES
(1,1200.50,3500.00,1500.75),
(2,800.00,2200.50,900.00),
(3,1500.00,4000.00,2000.00),
(4,600.00,1800.50,700.00),
(5,2000.00,5000.00,2500.00),
(6,1100.00,3300.00,1300.00),
(7,900.50,2700.75,1200.25),
(8,1700.00,4500.00,2100.00),
(9,500.00,1500.50,600.00),
(10,1300.00,3600.00,1600.00),
(11,1400.25,3800.00,1800.75),
(12,1000.00,3000.00,1200.50),
(13,800.00,2500.00,1000.00),
(14,1600.50,4200.00,2000.25),
(15,1200.00,3400.00,1500.00),
(16,1100.00,3200.50,1400.00),
(17,700.00,2000.00,900.00),
(18,1800.00,4700.00,2300.00),
(19,900.50,2800.00,1100.75),
(20,1500.00,4000.50,2100.00),
(21,1300.00,3500.00,1700.00),
(22,1000.00,3000.00,1200.00),
(23,800.50,2500.00,950.25),
(24,1700.00,4300.00,2200.00),
(25,600.00,1800.50,700.50),
(26,1400.00,3700.00,1600.00),
(27,1200.50,3400.00,1500.25),
(28,1000.00,2900.00,1300.00),
(29,1500.00,4100.00,2000.00),
(30,900.00,2600.50,1100.50);

INSERT INTO sponsor (idSponsor, codeSirene, nom, montantVerse, typePub) VALUES
(1,'123456789','Nvidia','5000.00','Banniere'),
(2,'987654321','Louis Vuitton','10000.00','Vidéo'),
(3,'456123789','Chanel','7500.00','Logo sur maillot'),
(4,'321654987','Hermès','3000.00','Annonce web'),
(5,'852963741','Gucci','15000.00','Sponsoring principal'),
(6,'147258369','Zara','4000.00','Banniere'),
(7,'963852741','Adidas','8500.00','Vidéo'),
(8,'258741369','Uniqlo','12000.00','Logo sur maillot'),
(9,'741852963','Dior','6000.00','Annonce web'),
(10,'369258147','Cartier','11000.00','Sponsoring principal'),
(11,'159753486','Rolex','5000.00','Banniere'),
(12,'753159486','H&M','9000.00','Vidéo'),
(13,'852456789','Prada','7000.00','Logo sur maillot'),
(14,'456789123','Coach','3500.00','Annonce web'),
(15,'321987654','Tiffany & Co','16000.00','Sponsoring principal'),
(16,'654321987','Notion','4500.00','Banniere'),
(17,'987123654','Back Market','8000.00','Vidéo'),
(18,'123987456','Figma','13000.00','Logo sur maillot'),
(19,'789456123','Blablacar','6500.00','Annonce web'),
(20,'147369258','Glossier','11500.00','Sponsoring principal'),
(21,'963147852','BigBuddy','5500.00','Banniere'),
(22,'258963147','Sunday','9200.00','Vidéo'),
(23,'741369852','Doctolib','7200.00','Logo sur maillot'),
(24,'369741258','Airbnb','3400.00','Annonce web'),
(25,'159486753','Deezer','15500.00','Sponsoring principal'),
(26,'753486159','Feed','4200.00','Banniere'),
(27,'852963147','Mailchimp','8700.00','Vidéo'),
(28,'456123852','Netflix','12500.00','Logo sur maillot'),
(29,'321654789','Stripe','6100.00','Annonce web'),
(30,'789123456','Slack','11800.00','Sponsoring principal');

INSERT INTO ticketing (idTicket, prix, dateDebut, dateFin) VALUES
(1,25.50,'2026-01-01','2026-01-15'),
(2,40.00,'2026-01-05','2026-01-18'),
(3,35.00,'2026-01-03','2026-01-17'),
(4,50.00,'2026-01-10','2026-01-20'),
(5,30.00,'2026-01-02','2026-01-14'),
(6,45.00,'2026-01-06','2026-01-19'),
(7,28.00,'2026-01-01','2026-01-12'),
(8,55.00,'2026-01-08','2026-01-22'),
(9,32.50,'2026-01-04','2026-01-16'),
(10,38.00,'2026-01-05','2026-01-18'),
(11,29.00,'2026-01-03','2026-01-15'),
(12,42.00,'2026-01-07','2026-01-20'),
(13,34.50,'2026-01-02','2026-01-14'),
(14,48.00,'2026-01-09','2026-01-21'),
(15,36.00,'2026-01-06','2026-01-19'),
(16,31.00,'2026-01-01','2026-01-13'),
(17,50.00,'2026-01-08','2026-01-22'),
(18,33.50,'2026-01-04','2026-01-16'),
(19,46.00,'2026-01-07','2026-01-20'),
(20,28.50,'2026-01-02','2026-01-15'),
(21,52.00,'2026-01-10','2026-01-23'),
(22,37.00,'2026-01-05','2026-01-18'),
(23,30.50,'2026-01-03','2026-01-15'),
(24,49.00,'2026-01-09','2026-01-21'),
(25,35.50,'2026-01-06','2026-01-19'),
(26,41.00,'2026-01-01','2026-01-13'),
(27,27.50,'2026-01-08','2026-01-22'),
(28,44.00,'2026-01-04','2026-01-16'),
(29,39.50,'2026-01-07','2026-01-20'),
(30,31.50,'2026-01-02','2026-01-15');

INSERT INTO budget (idBudget, idDepenses, idSponsor, idTicketing) VALUES
(1, 5, 2, 14),
(2, 12, 7, 3),
(3, 1, 10, 20),
(4, 8, 5, 6),
(5, 15, 1, 9),
(6, 3, 14, 2),
(7, 20, 8, 25),
(8, 7, 19, 11),
(9, 11, 3, 4),
(10, 4, 18, 7),
(11, 2, 15, 1),
(12, 9, 12, 17),
(13, 6, 20, 30),
(14, 13, 9, 5),
(15, 18, 13, 12),
(16, 16, 6, 8),
(17, 10, 4, 16),
(18, 14, 11, 21),
(19, 17, 17, 19),
(20, 19, 16, 22),
(21, 30, 30, 27),
(22, 21, 25, 28),
(23, 23, 1, 15),
(24, 22, 14, 18),
(25, 24, 7, 26),
(26, 26, 5, 23),
(27, 25, 2, 29),
(28, 28, 12, 24),
(29, 27, 8, 13),
(30, 29, 9, 10);

INSERT INTO tournois (idTournois, nom, dateDebut, dateFin, lieu, idBudget) VALUES
(1, 'Championnat National', '2026-02-12', '2026-02-15', 'Paris', 17),
(2, 'Coupe des Régions', '2026-03-05', '2026-03-08', 'Lyon', 3),
(3, 'Open Esport France', '2026-01-20', '2026-01-23', 'Marseille', 25),
(4, 'Grand Tournoi Pro', '2026-04-10', '2026-04-13', 'Lille', 9),
(5, 'Masters League', '2026-05-01', '2026-05-04', 'Toulouse', 12),
(6, 'Esport Challenge', '2026-02-22', '2026-02-25', 'Nice', 1),
(7, 'Ultimate Cup', '2026-03-15', '2026-03-18', 'Bordeaux', 28),
(8, 'Pro League Summer', '2026-06-10', '2026-06-13', 'Strasbourg', 5),
(9, 'Winter Clash', '2026-01-28', '2026-01-31', 'Nantes', 19),
(10, 'Spring Showdown', '2026-03-20', '2026-03-23', 'Montpellier', 30),
(11, 'Elite Tournament', '2026-04-05', '2026-04-08', 'Rennes', 11),
(12, 'Battle Royale', '2026-05-15', '2026-05-18', 'Grenoble', 7),
(13, 'Champions Cup', '2026-06-01', '2026-06-04', 'Dijon', 2),
(14, 'Pro Series', '2026-02-14', '2026-02-17', 'Angers', 20),
(15, 'Legends Arena', '2026-03-02', '2026-03-05', 'Clermont-Ferrand', 23),
(16, 'Elite Masters', '2026-04-22', '2026-04-25', 'Le Havre', 16),
(17, 'Summer Clash', '2026-06-15', '2026-06-18', 'Tours', 4),
(18, 'Autumn Arena', '2026-09-10', '2026-09-13', 'Nancy', 26),
(19, 'Winter Masters', '2026-12-01', '2026-12-04', 'Reims', 6),
(20, 'Pro Cup', '2026-07-05', '2026-07-08', 'Poitiers', 18),
(21, 'Championnat Régional', '2026-08-12', '2026-08-15', 'Orléans', 8),
(22, 'Open League', '2026-09-20', '2026-09-23', 'Metz', 27),
(23, 'Grand Arena', '2026-10-05', '2026-10-08', 'Besançon', 21),
(24, 'Ultimate Series', '2026-11-01', '2026-11-04', 'Saint-Étienne', 13),
(25, 'Masters Challenge', '2026-05-22', '2026-05-25', 'Rouen', 10),
(26, 'Esport Battle', '2026-06-18', '2026-06-21', 'Avignon', 22),
(27, 'Pro Arena', '2026-07-15', '2026-07-18', 'La Rochelle', 29),
(28, 'Champions League', '2026-08-05', '2026-08-08', 'Brest', 14),
(29, 'Spring Masters', '2026-03-28', '2026-03-31', 'Tours', 24),
(30, 'Legends Cup', '2026-04-12', '2026-04-15', 'Lille', 15);