-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `klienci`
--

DROP TABLE IF EXISTS `klienci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `klienci` (
  `ID_Klienta` int(11) NOT NULL AUTO_INCREMENT,
  `Imie` varchar(255) NOT NULL,
  `Nazwisko` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Telefon` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_Klienta`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klienci`
--

LOCK TABLES `klienci` WRITE;
/*!40000 ALTER TABLE `klienci` DISABLE KEYS */;
INSERT INTO `klienci` VALUES (1,'Tomasz','Lewandowski','tomasz.lewandowski5@example.com','123456789'),(2,'Agnieszka','Lewandowski','agnieszka.lewandowski53@example.com','123456789'),(3,'Krzysztof','Kowalski','krzysztof.kowalski46@example.com','123456789'),(4,'Krzysztof','Wójcik','krzysztof.wójcik24@example.com','123456789'),(5,'Michał','Szymański','michał.szymański20@example.com','123456789'),(6,'Barbara','Dąbrowski','barbara.dąbrowski33@example.com','123456789'),(7,'Katarzyna','Nowak','katarzyna.nowak18@example.com','123456789'),(8,'Barbara','Wiśniewski','barbara.wiśniewski57@example.com','123456789'),(9,'Paweł','Kamiński','paweł.kamiński87@example.com','123456789'),(10,'Michał','Kamiński','michał.kamiński92@example.com','123456789'),(245,'a',' AND 1=1','a@dzisJestSobota.pl','aa'),(246,'ww','22','a@a.pl','222'),(247,'aaa','222','a@aaa.pl','22222'),(248,'aaa','222','a@aaa.pl','22222'),(251,'A','A','a@a.pl','22222'),(252,'Dzisaj','niedziela','a@aa.pl','221321312'),(253,'A','poniedzialek','a@a.pl','212321'),(254,'Dzisaj','\' UNION SELECT ID_Klienta, Imie, Nazwisko, Email, Telefon FROM Klienci -- ','a@aa.pl','221321312');
/*!40000 ALTER TABLE `klienci` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-01 21:05:48
