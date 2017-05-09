-- MySQL dump 10.16  Distrib 10.1.21-MariaDB, for Win32 (AMD64)
--
-- Host: gmgcjwawatv599gq.cbetxkdyhwsb.us-east-1.rds.amazonaws.com    Database: gmgcjwawatv599gq.cbetxkdyhwsb.us-east-1.rds.amazonaws.com
-- ------------------------------------------------------
-- Server version	10.0.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chats` (
  `chatid` int(11) NOT NULL,
  `chatname` varchar(50) NOT NULL,
  `participant` varchar(100) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isgroup` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`chatid`,`participant`),
  KEY `participant` (`participant`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`participant`) REFERENCES `users` (`fbid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (7,'Davide Belli','103761610178679','2017-05-06 11:58:29',0),(7,'Mario Rossi','1541035525916637','2017-05-06 11:58:29',0),(10,'Mario Rossi','100876167144539','2017-04-20 13:48:45',0),(10,'Giulia De Franceschi','103761610178679','2017-04-20 13:48:45',0),(11,'Davide Belli','100876167144539','2017-05-06 15:27:16',0),(11,'Giulia De Franceschi','1541035525916637','2017-05-06 15:27:16',0),(12,'Davide Belli','1383270178419309','2017-05-05 19:55:45',0),(12,'Marco Belli','1541035525916637','2017-05-05 19:55:45',0);
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `id` varchar(100) NOT NULL,
  `friendid` varchar(100) NOT NULL,
  `installed` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`friendid`),
  KEY `friendid` (`friendid`),
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`fbid`),
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friendid`) REFERENCES `users` (`fbid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES ('100876167144539','103761610178679',1),('100876167144539','1541035525916637',1),('103761610178679','100876167144539',1),('103761610178679','1541035525916637',1),('1383270178419309','1541035525916637',1),('1541035525916637','100876167144539',1),('1541035525916637','103761610178679',1),('1541035525916637','1383270178419309',1);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `chatid` int(11) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `ismedia` tinyint(1) DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`chatid`,`sender`,`time`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`chatid`, `sender`) REFERENCES `chats` (`chatid`, `participant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (7,'103761610178679','Hey Davide!',0,'2017-04-27 16:01:57'),(7,'103761610178679','I\'d rather go for a movie..',0,'2017-04-27 16:04:30'),(7,'1541035525916637','Hi Mario',0,'2017-04-27 16:02:18'),(7,'1541035525916637','wanna go out for dinner tonight?',0,'2017-04-27 16:03:34'),(7,'1541035525916637','hungry',0,'2017-05-06 09:54:13'),(11,'100876167144539','hey bro :)',0,'2017-05-06 15:26:44'),(11,'1541035525916637','Sup! wanna hang out for a movie sometimes?',0,'2017-05-06 15:27:16'),(12,'1383270178419309','Dici che traduce anche l\'italiano?',0,'2017-05-05 19:53:24'),(12,'1383270178419309','are you go to the fast food?',0,'2017-05-05 19:54:37'),(12,'1383270178419309','A tomorrow',0,'2017-05-05 19:55:45'),(12,'1541035525916637','ahah non credo, ma penso che lo aggiungerò',0,'2017-05-05 19:54:00'),(12,'1541035525916637','proprio cosí si scrive ahah',0,'2017-05-05 19:55:06'),(12,'1541035525916637','il server a quanto pare è a due ore in meno di fuso orario.. dovrò aggiustarlo',0,'2017-05-05 19:55:43');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `NOME` varchar(100) DEFAULT NULL,
  `DESCRIZIONE` varchar(500) DEFAULT NULL,
  `ENGLISH_DESCRIPTION` varchar(500) DEFAULT NULL,
  `CATEGORIA` varchar(50) DEFAULT NULL,
  `LATITUDINE` varchar(20) DEFAULT NULL,
  `LONGITUDINE` varchar(20) DEFAULT NULL,
  `VIA` varchar(50) DEFAULT NULL,
  `NUMBER` varchar(10) DEFAULT NULL,
  `CAP` varchar(10) DEFAULT NULL,
  `CITTA` varchar(20) DEFAULT NULL,
  `CONTATTO_NOME` varchar(100) DEFAULT '',
  `CONTATTO_TELEFONO` varchar(100) DEFAULT '',
  `CONTATTO_EMAIL` varchar(100) DEFAULT '',
  `CONTATTO_FAX` varchar(100) DEFAULT '',
  `CONTATTO_URL` varchar(100) DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES ('A LE DUE SPADE','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all wines are made in the area ','Ristorante','46.067225','11.120036','Via Don A. Rizzi',' 11 ','38122','Trento','','(+39) 0461 234343','info@leduespade.com ','(+39) 0461 920202 ','www.leduespade.com\r',1),('AL VO','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.070791','11.123888','Vicolo del Vo',' 11','38122','Trento','','(+39) 0461 985374','info@ristorantealvo.it','(+39) 0461 232131','www.ristorantealvo.it\r',2),('AL VOLT','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area;','Ristorante','46.142050','11.155242','Via Santa Croce ','16 ','38122','Trento','','(+39) 0461 983776','trattoria_al_volt@yahoo.it ','(+39) 0461 091011 \r','',3),('DUE MORI ','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.064622','11.123308','Via S. Marco',' 11','38122','Trento','','(+39) 0461 984251','info@ristoranteduemori.com','(+39) 0461 231201 ','www.ristoranteduemori.com\r',4),('GREEN TOWER','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.069691','11.121088','Piazza S. Pellico',' 12 ','38122','Trento','','(+39) 0461 231545','info@ristorantegreentower.it','(+39) 0461 231545','www.ristorantegreentower.it\r',5),('HOTEL RELAIS VILLA MADRUZZO','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.074016','11.146816','Via Ponte Alto',' 26','38121','Cognola','','(+39) 0461 986220','info@villamadruzzo.it','(+39) 0461 986361','www.villamadruzzo.it\r',6),('IL LIBERTINO','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.070125','11.124925','Piazza Piedicastello',' 4-6 ','38122','Trento','','(+39) 0461 260085','libertinotn@gmail.com','','www.ristoranteillibertino.com\r',7),('LA CANTINOTA','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area;','Ristorante','46.069691','11.121088','Via S. Marco',' 22-24','38122','Trento','','(+39) 0461 238527','cantinota@hotmail.it','(+39) 0461 238527','www.cantinota.editarea.com\r',8),('SCRIGNO DEL DUOMO','Marchi Strada del Vino e dei Sapori e Osteria tipica Trentina che certifica la qualità dell’offerta e dei prodotti enogastronomici. I prodotti sono di origine rigorosamente trentina e i vini serviti in tavola sono solo vini locali. ','Trentinos wine and flavour route and the Osteria Tipica Trentina brands which certifie the quality of the service food and wine products served in these restaurants. All of the products are strictly local and all the wines are made in the area; ','Ristorante','46.067352','11.120883','Piazza Duomo',' 29','38122','Trento','','(+39) 0461 220030','info@scrignodelduomo.com','(+39) 0461 235289 ','www.scrignodelduomo.com\r',9),('AI TRE GAROFANI','Marchio Strada del Vino e dei Sapori che certifica la qualità dell’offerta e dei prodotti enogastronomici.','Trentinos wine and flavour route brand which certifies the quality of the service food and wine products served in these restaurants.','Ristorante','46.065700','11.123022','Via Giuseppe Mazzini',' 33 ','38122','Trento','','(+39) 0461 237543','prenotazioni@aitregarofani.com','(+39) 349 6358908','www.aitregarofani.com\n',10),('AI VICOLI ','Ristorante e Winebar','Restaurant and Winebar','Ristorante','46.069691','11.121088','Piazza Santa Teresa Verzieri ','','38122','Trento','','(+39) 0461 260673','info@aivicoli.it','','www.aivicoli.it\n',11),('ALLA MOSTRA','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.071188','11.125855','Piazza della Mostra',' 13 ','38122','Trento','','(+39) 0461 230787','','(+39) 0461 230787','www.allamostra.it/\n',12),('AL MARINAIO ','Ristorante con prodotti tipici bar e pasticceria','Restaurant with tipical products cafe patisserie','Ristorante','46.033955','11.129333','Via dei Marinai dItalia ','','38123','Trento','','(+39) 0461 1734471/933053','info@almarinaio.eu ','(+39) 0461 933053','www.almarinaio.eu\r',13),('AMERICA EL MERICAN','Ristorante e bar','Restaurant and cafe','Ristorante','46.070986','11.123430','Via Torre Verde',' 50','38122','Trento','','(+39) 0461 983010','info@hotelamerica.it','(+39) 0461 230603','www.hotelamerica.it\r',14),('CHISTE','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.068883','11.121255','Via delle Orne',' 4','38122','Trento','','(+39) 0461 262979\r','','','',15),('CLESIO GRAND HOTEL TRENTO','Ristorante con cucina tipica','Typical restaurant','Ristorante','46.070544','11.121636','Via Vittorio Alfieri',' 1/3','38122','Trento','','(+39) 0461271000','reservation@grandhoteltrento.com','','www.grandhoteltrento.com\r',16),('DOC','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.061719','11.129111','Via Milano',' 148','38122','Trento','','(+39) 0461 262022','info@doctrento.it','(+39) 0461 223120','www.doctrento.it\r',17),('DUO','Ristorante & tapas bar; marchio Strada del Vino e dei Sapori che certifica la qualità dell’offerta e dei prodotti enogastronomici.','Restaurant and Tapas cafe Trentinos wine and flavour route brand which certifies the quality of the service food and wine products served in these restaurants.','Ristorante','46.070127','11.119711','Via Torre Vanga',' 14','38122','Trento','','(+39) 0461 1594461/1594462','contact@duoristorante.it','','www.duoristorante.it\r',18),('EVEREST','Marchio Strada del Vino e dei Sapori che certifica la qualità dell’offerta e dei prodotti enogastronomici.','Trentinos wine and flavour route brand which certifies the quality of the service food and wine products served in these restaurants.','Ristorante','46.078808','11.118280','Corso Alpini',' 14','38121','Trento','','(+39) 0461 825300','info@hoteleverest.it','(+39) 0461 824527','www.hoteleverest.it\r',19),('FORST','Ristorante birreria','Restaurant and brewery','Ristorante','46.068916','11.122541','Via Oss Mazzurana',' 38','38122','Trento','','(+39) 0461 235590','incentro.group@gmail.com','','www.nikys.it\r',20),('IL CAPPELLO','Ristorante Osteria','Restaurant with tipical products.','Ristorante','46.069691','11.121088','Piazzetta B. Lunelli',' 5','38122','Trento','','(+39) 0461 235850','info@osteriailcappello.it','(+39) 0461 235850','www.osteriailcappello.it\r',21),('IL SIMPOSIO','Ristorante e Winebar','Restaurant and Winebar','Ristorante','46.067966','11.118869','Via Rosmini',' 19','38122','Trento','','(+39) 0461 261848','ilsimposiotrento@gmail.com','(+39) 0461 261848','www.ilsimposio.net\r',22),('LOCANDA MARGON','Marchio Strada del Vino e dei Sapori che certifica la qualità dell’offerta e dei prodotti enogastronomici.','Trentinos wine and flavour route brand which certifies the quality of the service food and wine products served in these restaurants.','Ristorante','46.069691','11.121088','Via Margone',' 15','38123','Ravina - Trento','','(+39) 0461 349401','contact@locandamargon.it','(+39) 0461 349080','www.locandamargon.it\r',23),('MOVER','Ristorante e bar','Restaurant and cafe','Ristorante','46.101533','11.101316','Via Innsbruck',' 13','38122','Trento','','(+39) 0461 966899','info@quidhoteltrento.com','','www.quidhoteltrento.com\r',24),('NIKYS','Marchio Strada del Vino e dei Sapori che certifica la qualità dell’offerta e dei prodotti enogastronomici.','Trentinos wine and flavour route brand which certifies the quality of the service food and wine products served in these restaurants.','Ristorante','46.055005','11.120361','Via San Pio X',' 29','38122','Trento','','(+39) 0461 390828','info@nikys.it','','www.nikys.it\r',25),('OLYMPIC','Ristorante all\'interno dell\'Hotel Sporting Trento','Restaurant in Hotel Sporting Trento','Ristorante','46.057736','11.112491','Via R. da Sanseverino',' 125','38123','Trento','','(+39) 0461 391215','info@hotelsportingtrento.com','(+39) 0461 392052','www.hotelsportingtrento.com\r',26),('ORSO GRIGIO','Ristorante e Antica trattoria','Typical restaurant','Ristorante','46.065583','11.122052','Via degli Orti',' 19','38122','Trento','','(+39) 0461 984400','info@orsogrigiotrento.com','(+39) 0461 980953','www.orsogrigiotrento.com;\r',27),('OSTERIA DA GUIDO','Ristorante tipico','Typical restaurant','Ristorante','46.069413','11.126516','Parco San Marco; Via livio marchetti ','9','38122','Trento','','(+39) 0461 262418','info@osteriadaguido.com','','www.osteriadaguido.com\r',28),('4 STAGIONI','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.075252','11.137725','Via San Vito',' 36','38122','Trento','','(+39) 0461 987031','quttrostagioni@virgilio.it ','','www.quattrostagionisrl.it\r',29),('TORREFRANCA','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.006250','11.136672','Via Pomeranos',' 43','38122','Trento','','(+39) 0461 944511','torrefranca@interfree.it','','www.ristorantetorrefranca.com\r',30),('ROSA DORO','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.069691','11.121088','Piazza S. Maria Maggiore',' 21','38122','Trento','','(+39) 0461 261792','','(+39) 0461 264177\r','',31),('SAPORI MEDITERRANEI','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.065072','11.113966','Via Roberto da Sanseverino',' 39/4','38122','Trento','','(+39) 0461 984360','sapori.mediterranei@hotmail.it\r','','',32),('TEXMEX RESTAURANT CUEVA MAYA','Ristorante messicano','Mexican restaurant','Ristorante','46.067450','11.120880','Piaza Duomo',' 22','38122','Trento','','(+39) 0461 984507','trento@cuevamaya.it','','www.cuevamaya.it/trento\r',33),('UVA E MENTA','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.065422','11.123858','Via Dietro le Mura A',' 35','38122','Trento','','(+39) 0461 1903162','uvaementa@yahoo.it','(+39) 0461 1903162\r','',34),('CHALET LO SCIATORE','Ristorante e bar','Restaurant and cafe','Ristorante','46.040137','11.058590','Strada di Vason',' 84','38123','Trento','','(+39) 340 7124107\r','','','',35),('MALGA BRIGOLINA','Malga e ristorante con cucina tipica','Alpine hut with typical restaurant','Ristorante','46.057136','11.060485','Via della Brigolina',' 6','38123','Monte Bondone','','(+39) 0461 947474\r','','','',36),('RIFUGIO VIOTE','Rifugio e ristorante con cucina tipica','mountain dew with typical restaurant','Ristorante','46.023250','11.038169','Localita Viote',' 6','38123','Monte Bondone','','(+39) 0461 948033','','','',37),('MALGA CANDRIAI','Malga e ristorante con cucina tipica','Alpine hut with typical restaurant','Ristorante','46.046327','11.065047','Strada di Candriai',' 4','38123','Trento','','(+39) 0461 947526','','','www.malgacandriai.it\r',38),('NEVADA','Ristorante con pizzeria e bar','Restaurant pizzeria and cafe','Ristorante','46.039756','11.058479','Strada di Vason',' 61','38123','Trento','','(+39) 0461 948117','','','www.lorenzihotels.com\r',39),('IL GIARDINO DELLE SPEZIE','Ristorante con pizzeria e bar','Restaurant pizzeria and cafe','Ristorante','46.058436','10.980900','Via Nazionale',' 109','38070','Padergnone','','(+39) 0461 340122','','','www.ilgiardinodellespezie.it\r',40),('LILLA','Ristorante pizzeria','Restaurant and pizzeria','Ristorante','46.097411','11.058247','Localita Maso Travolt',' 12','38070','Terlago','','(+39) 0461 866159','','','www.ristorantepizzerialilla.com',41),('EQUATORE','Vicino all\'equatore','African restaurant at coordinates 0,0','Ristorante','0','0','Via Pascoli','30','12013','Capetown','Nome','+39 0123 454592','davide95belli@libero.it','fax','http://latemar.science.unitn.it/segue/index.php?&site=2017Mobile&section=380&action=site',64);
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `fbid` varchar(100) NOT NULL,
  `token` text NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`fbid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('100876167144539','cPJO4mbzOIc:APA91bEa68YUmN1TQTDU7FW3vi9FbsPp2Ze0V4v6XDFiRy2dW7xTgdhds0T5yEUAUSCZ3-WR8X5fTRfE_0IcdbqGBmR0MaAFvvjArt_UHQNYxAkVMjGT6mcRt6S8AZarIOX_OwTFmFTw','Giulia De Franceschi'),('103761610178679','e71I5LyG3wQ:APA91bHu_Xgw4DlzLUpa_3eu8Cdn_D-0eLmhjG5xZ1TEuPL6WDzVP_NMbwOpfBHxAM9a6aw_TiyE1uB7gKc6fIElZOeF5YtoqIGNQeCsJgtUEJFruaoSuzYmmwtuZ1nm4oAWloRJ_tqh','Mario Rossi'),('1383270178419309','null','Marco Belli'),('1541035525916637','fHpEU85T5KA:APA91bEXBgbhbjsVGWp6m6WMv5CSYIzieQxfVz2GkuDwDwZBqFMoTmDoX0ouRdY4xh7pi1GakDy0O21tvvDVoB_a0l85GZswiKmcCJd7ZeUVhjMXLCm7dI5T52W73njKpjbFM11hX6L0','Davide Belli');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-07 19:52:03
