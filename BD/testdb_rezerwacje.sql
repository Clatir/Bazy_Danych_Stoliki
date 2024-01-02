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
-- Table structure for table `rezerwacje`
--

DROP TABLE IF EXISTS `rezerwacje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rezerwacje` (
  `ID_Rezerwacji` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Klienta` int(11) DEFAULT NULL,
  `ID_Stolika` int(11) DEFAULT NULL,
  `Data` date NOT NULL,
  `Czas poczatek` time DEFAULT NULL,
  `Czas koniec` time DEFAULT NULL,
  `Uwagi` text DEFAULT NULL,
  PRIMARY KEY (`ID_Rezerwacji`),
  KEY `ID_Klienta` (`ID_Klienta`),
  KEY `ID_Stolika` (`ID_Stolika`),
  CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`ID_Klienta`) REFERENCES `klienci` (`ID_Klienta`),
  CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`ID_Stolika`) REFERENCES `stoliki` (`ID_Stolika`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezerwacje`
--

LOCK TABLES `rezerwacje` WRITE;
/*!40000 ALTER TABLE `rezerwacje` DISABLE KEYS */;
INSERT INTO `rezerwacje` VALUES (1,1,1,'2023-12-09','19:42:08','22:14:43','Uwaga 1'),(2,2,2,'2023-12-01','20:15:16','23:04:44','Uwaga 2'),(3,3,3,'2023-11-26','16:25:53','18:25:29','Uwaga 3'),(4,4,4,'2023-12-12','17:40:39','20:40:16','Uwaga 4'),(5,5,5,'2023-11-27','14:21:37','17:20:55','Uwaga 5'),(6,6,6,'2023-12-08','20:36:09','23:33:46','Uwaga 6'),(7,7,7,'2023-11-23','17:39:55','20:30:10','Uwaga 7'),(8,8,8,'2023-12-12','15:06:07','17:24:29','Uwaga 8'),(9,9,9,'2023-12-14','17:36:50','19:07:57','Uwaga 9'),(10,10,10,'2023-12-17','18:25:49','20:36:19','Uwaga 10'),(130,245,18,'2023-12-05','22:27:00','00:27:00','212321'),(131,246,16,'2023-12-07','14:30:00','00:00:00',''),(132,247,18,'2023-11-30','15:45:00','17:45:00','1'),(133,248,10,'2023-11-30','15:45:00','17:45:00','1'),(134,251,16,'2024-01-04','19:17:00','21:17:00','a'),(135,252,17,'2024-01-04','19:18:00','21:18:00','22'),(136,253,2,'2024-01-04','19:24:00','21:24:00','22'),(137,254,1,'2024-01-04','19:18:00','19:18:02','\' UNION SELECT ID_Klienta, Imie, Nazwisko, Email, Telefon FROM Klienci -- ');
/*!40000 ALTER TABLE `rezerwacje` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-01 21:05:49
