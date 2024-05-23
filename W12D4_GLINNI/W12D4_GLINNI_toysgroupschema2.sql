-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: toysgroup
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idproduct` int NOT NULL AUTO_INCREMENT,
  `productname` varchar(45) NOT NULL,
  `productcategory` varchar(45) NOT NULL,
  PRIMARY KEY (`idproduct`),
  KEY `idx_idproduct` (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'robot_xy','robot'),(2,'robot_bz','robot'),(3,'peluche_cane','peluche'),(4,'peluche_delfino','peluche'),(5,'soldatino_1','soldatini'),(6,'soldatino_2','soldatini'),(7,'soldatino_3','soldatini'),(8,'cellulare_peluche','peluche'),(9,'dinosauro_peluche','peluche'),(10,'pappagallo_peluche','peluche');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `idregion` int NOT NULL AUTO_INCREMENT,
  `idproduct` int NOT NULL,
  `regionname` varchar(45) NOT NULL,
  PRIMARY KEY (`idregion`),
  KEY `idx_idproduct` (`idproduct`),
  CONSTRAINT `region_product` FOREIGN KEY (`idproduct`) REFERENCES `product` (`idproduct`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (8,1,'Lazio'),(9,1,'EmiliaRomagna'),(10,2,'Liguria'),(11,2,'Campania'),(12,3,'Calabria'),(13,3,'Basilicata'),(14,4,'Abbruzzo'),(15,5,'Umbria'),(16,5,'Valdaosta'),(17,6,'Sicilia'),(18,7,'Sardegna');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `idsales` int NOT NULL AUTO_INCREMENT,
  `saledate` datetime NOT NULL,
  `saleamount` decimal(10,0) NOT NULL,
  `idproduct` int NOT NULL,
  PRIMARY KEY (`idsales`),
  KEY `sales_product_idx` (`idproduct`),
  CONSTRAINT `sales_product` FOREIGN KEY (`idproduct`) REFERENCES `product` (`idproduct`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2023-01-01 00:00:00',55,1),(2,'2024-01-01 00:00:00',100,1),(3,'2024-10-01 00:00:00',111,2),(4,'2024-10-01 00:00:00',99,2),(5,'2024-04-02 00:00:00',150,2),(6,'2023-04-02 00:00:00',1333,3),(7,'2024-04-02 00:00:00',12,2),(8,'2024-04-02 00:00:00',100,1),(9,'2023-04-02 00:00:00',55,4),(10,'2024-04-02 00:00:00',100,2),(11,'2024-04-03 00:00:00',99,5),(12,'2024-04-03 00:00:00',43,3),(13,'2024-04-13 00:00:00',321,6),(14,'2024-05-01 00:00:00',131,4),(15,'2024-05-01 00:00:00',12,1);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-23 20:45:30
