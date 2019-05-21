-- MySQL dump 10.13  Distrib 8.0.14, for macos10.14 (x86_64)
--
-- Host: localhost    Database: stylish
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `stylish`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `stylish` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `stylish`;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `campaign` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `story` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (4,41,'201807242228.jpg_1551339771040','這樣還有快取嗎'),(5,45,'main.jpg_1551700891125','廣告測試'),(6,47,'main.jpg_1551702154941','應該 rewrite cache'),(7,50,'main.jpg_1551756607314','coding style test');
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `color` (
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES ('深藍','334455'),('玉米斯白色','FFF8DC'),('白色','FFFFFF'),('紫羅蘭色','EE82EE'),('綠松色','40E0D0');
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(50) DEFAULT NULL,
  `product_purchased` text COLLATE utf8mb4_general_ci,
  `subtotal` int(20) DEFAULT NULL,
  `freight` int(20) DEFAULT NULL,
  `total` int(20) DEFAULT NULL,
  `pay_method` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `recipient` text COLLATE utf8mb4_general_ci,
  `prime` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time_stamp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` VALUES (1,NULL,'[object Object]',980,150,1130,'credit_card','unpaid','[object Object]',NULL,NULL,NULL),(2,NULL,'[object Object]',980,150,1130,'credit_card','unpaid','[object Object]',NULL,NULL,NULL),(3,NULL,'[object Object]',980,150,1130,'credit_card','paid','[object Object]','5b7379be4f79052702c0e5fa16fc890b8bbb1c3c96b116b1a723005dbb10894e','Wed Feb 27 2019 11:26:54 GMT+0800 (GMT+08:00)',NULL),(4,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','[object Object]','8943c144ccaa7d9e016bfe2d48c417152f86c91e64823d890b54a288092570c0','Wed Feb 27 2019 11:28:18 GMT+0800 (GMT+08:00)',NULL),(5,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"[name]\",\"phone\":\"[phone]\",\"email\":\"[Email]\",\"address\":\"[Address]\",\"time\":\"anytime\"}','b45669fc15e21a26854a766404933b9408236e47a0864f8f24ca1aa01b6eb8fc','Wed Feb 27 2019 11:30:47 GMT+0800 (GMT+08:00)',NULL),(6,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"[name]\",\"phone\":\"[phone]\",\"email\":\"[Email]\",\"address\":\"[Address]\",\"time\":\"anytime\"}','bd051e7f563a6ae03bb3510fbd0f950bc78d5ebc293524072ba228bf4f8f2830','Wed Feb 27 2019 11:32:16 GMT+0800 (GMT+08:00)',NULL),(7,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','unpaid','{\"name\":\"[name]\",\"phone\":\"[phone]\",\"email\":\"[Email]\",\"address\":\"[Address]\",\"time\":\"anytime\"}','794121e54063323105b120d806bc6ca7943319053ec7878670b88f54b30e6ce8','Wed Feb 27 2019 11:32:58 GMT+0800 (GMT+08:00)',NULL),(8,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','failed','{\"name\":\"[name]\",\"phone\":\"[phone]\",\"email\":\"[Email]\",\"address\":\"[Address]\",\"time\":\"anytime\"}','aed659c1d576b38dc92956a715c7001d038840348f5478a0f8bd6fcf39575bd0','Wed Feb 27 2019 11:34:52 GMT+0800 (GMT+08:00)',NULL),(9,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','e2a9117a1188184bcf0aed29fc4c43ab21151e7c3730be606b824fad7f701ac6','Wed Feb 27 2019 13:47:09 GMT+0800 (GMT+08:00)','20190227'),(10,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','c409da2a96a7d7134b9db5b0dddfb73d8931f98c07507b4f8fd6140ff741125d','Wed Feb 27 2019 13:49:40 GMT+0800 (GMT+08:00)','20190227'),(11,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','06bb7058774e94deb781664322ccc067da912f315d64acc1a47dae035d3a9c40','Wed Feb 27 2019 13:50:56 GMT+0800 (GMT+08:00)','20190227'),(12,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','7e439661ba8dc0bf4f16412863ad7113f10c3ba916b83c6c37b8f2609e02d943','Wed Feb 27 2019 15:05:33 GMT+0800 (GMT+08:00)','20190227'),(13,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','ed6b2589fbe516d316b636ceb215caf2a7172a1b9f9b4c6d22bd5c904ad58402','Fri Mar 01 2019 15:11:44 GMT+0800 (GMT+08:00)','20190301'),(14,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','b73c97727a3597aacefec8bffcca7888de464f79d83abd0b58d51c6e9672926e','Fri Mar 01 2019 16:23:29 GMT+0800 (GMT+08:00)','20190301'),(15,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1797,150,1947,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','7d9aa5dcb3b386f605cbaa90170ea656c677d896f67fa210073ddc713993dc6a','Fri Mar 01 2019 17:16:23 GMT+0800 (GMT+08:00)','20190301'),(16,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','404f06fb7e1b240ce9b08233297dfb2fa0b7640e3f95215a76026aa98b171eb0','Sat Mar 02 2019 13:02:55 GMT+0800 (GMT+08:00)','20190302'),(17,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','f8d6ec46390b8ebd383c38d780701e41dd58d82773ff3a98ac397c6b0a37b640','Sat Mar 02 2019 13:10:13 GMT+0800 (GMT+08:00)','20190302'),(18,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','f6da9f3e5a1a7e5f850a8732d7d78a226fc47b1f4c805c7f19d7ba92e090b8d3','Sat Mar 02 2019 13:10:23 GMT+0800 (GMT+08:00)','20190302'),(19,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','bc933e01fb84bd300ddfd9fa158936b744151d963f0aeba2889ea4b13017f337','Sat Mar 02 2019 13:10:38 GMT+0800 (GMT+08:00)','20190302'),(20,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','b41df5e04aaa248da109140b2148af2171268070d54838c9c6105bf4beaeb12e','Sat Mar 02 2019 13:11:50 GMT+0800 (GMT+08:00)','20190302'),(21,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','b012bee63384a5d41e5161d12807fb9586e9b677ccef70bed44594350ec04a2f','Sat Mar 02 2019 13:18:28 GMT+0800 (GMT+08:00)','20190302'),(22,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','c38e96f8cd7b02de3e06215a12600d157fe33a666551827bdb788046221e5d39','Sat Mar 02 2019 13:19:28 GMT+0800 (GMT+08:00)','20190302'),(23,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','ba0ca432ce111f274190a7f59693d459881987295a456c251b3e341829a42b40','Sat Mar 02 2019 13:57:05 GMT+0800 (GMT+08:00)','20190302'),(24,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','32df758f78eba1662db312092e1127572ec42625f4f822429c4cc17c3f0e8180','Sat Mar 02 2019 13:57:21 GMT+0800 (GMT+08:00)','20190302'),(25,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','b68d3f44a516273d0a40f5f4337073f766110c1600facb4ee9b8e9346b32f6b1','Sat Mar 02 2019 14:05:45 GMT+0800 (GMT+08:00)',NULL),(26,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','e0360c97fade6195de17522cf73b6d53b8610848213d4694d8b0992c01ec1472','Sat Mar 02 2019 14:07:09 GMT+0800 (GMT+08:00)',NULL),(27,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','d424d3d400831550774fa094674240cd2caa3b7eab1608134ddcf73806e2d7f9','Sat Mar 02 2019 14:07:20 GMT+0800 (GMT+08:00)',NULL),(28,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','f0147ceacf4a88d75281210f4d2a38d5fedc2743e94c58c7e4c4145be57e3f7e','Sat Mar 02 2019 14:10:23 GMT+0800 (GMT+08:00)',NULL),(29,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','c5deed0615f09c0832abf6add7831077ccb32fe845b03cd12cb3c8d19d62670f','Sat Mar 02 2019 14:10:53 GMT+0800 (GMT+08:00)',NULL),(30,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','failed','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','b9a4f92117408d4332a24eff000512077eb392863959c021a8f57b07045a3448','Sat Mar 02 2019 14:11:26 GMT+0800 (GMT+08:00)',NULL),(31,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','8ff69b553330a21625f0b2ef26d2805f4fb1dbf6f4238d695783d1838a90a138','Sat Mar 02 2019 14:11:56 GMT+0800 (GMT+08:00)','20190302'),(32,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',980,150,1130,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','1eb5301af8a3c9061a147374809d9817e715a425c98f173dcaff7e5351f1acc1','Sat Mar 02 2019 16:37:05 GMT+0800 (GMT+08:00)','20190302'),(33,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',1299,150,1449,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','2cf18cd8694f8314586fd2b5584df003059a8af59194d66c68de4690640df2ba','Sat Mar 02 2019 21:50:09 GMT+0800 (GMT+08:00)','20190302'),(34,NULL,'[{\"id\":\"[Product ID]\",\"name\":\"[Product Name]\",\"price\":\"[Product Unit Price]\",\"color\":{\"name\":\"[Product Variant Color Name]\",\"code\":\"[Product Variant Color HexCode]\"},\"size\":\"[Product Variant Size]\",\"qty\":\"[Quantity]\"}]',3999,150,4149,'credit_card','paid','{\"name\":\"Stone Wei\",\"phone\":\"+886923456789\",\"email\":\"stone@test.com\",\"address\":\"123 1st Avenue, City, Country\",\"time\":\"anytime\"}','3629c67623320402819a04436944375975d3def2aab5adba496d1d445f2f2de3','Tue Mar 05 2019 15:56:56 GMT+0800 (GMT+08:00)','20190305');
/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img_gallery`
--

DROP TABLE IF EXISTS `img_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `img_gallery` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `gallery` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `img_gallery_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_gallery`
--

LOCK TABLES `img_gallery` WRITE;
/*!40000 ALTER TABLE `img_gallery` DISABLE KEYS */;
INSERT INTO `img_gallery` VALUES (11,38,'0.jpg_1550558047252,1.jpg_1550558047253'),(12,39,'0.jpg_1550558056883,1.jpg_1550558056884'),(13,41,'0.jpg_1550735269391,1.jpg_1550735269392'),(14,42,'0.jpg_1550736706527,1.jpg_1550736706528'),(16,43,'0.jpg_1551340522413,1.jpg_1551340522414'),(17,44,'0.jpg_1551541160135,1.jpg_1551541160136'),(24,37,'1552543277604_8240.jpg,1552543277606_8241.jpg');
/*!40000 ALTER TABLE `img_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `inventory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  `color_name` varchar(20) NOT NULL,
  `size` varchar(5) NOT NULL,
  `qty` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `color_name` (`color_name`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`color_name`) REFERENCES `color` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (10,37,'深藍','L',5),(11,37,'深藍','M',3),(12,37,'玉米斯白色','M',5),(13,37,'玉米斯白色','S',8),(14,38,'深藍','L',10),(15,38,'深藍','M',8),(16,38,'深藍','S',5),(17,38,'綠松色','M',5),(18,38,'綠松色','S',0),(19,38,'白色','M',12),(20,39,'白色','L',6),(21,39,'紫羅蘭色','M',2),(22,37,'深藍','XS',3),(23,41,'深藍','XS',3),(24,42,'紫羅蘭色','XL',6),(25,43,'深藍','M',5),(26,43,'綠松色','L',9),(27,44,'紫羅蘭色','S',4),(28,44,'玉米斯白色','S',6);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` double unsigned NOT NULL,
  `texture` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wash` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `place` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `story` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `main_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (37,'厚實毛呢格子外套','women','高抗寒素材選用，保暖也時尚有型',2200,'棉、聚脂纖維','手洗（水溫40度','韓國','實品顏色以單品照為主','你絕對不能錯過的超值商品','main.jpg_1550557257419'),(38,'刺繡貼布厚刷毛衛衣上衣','men','簡單的字母印圖，打造舒適好感的自在穿搭',449,'50%棉+50%聚酯纖維，微彈性','低於60度水洗','臺灣','深色衣物建議單獨洗滌，以翻面手洗或放洗衣袋洗較佳','加倍呵護你的肌膚保暖度更提升','main.jpg_1550557327482'),(39,'質感字母印花圓領短袖上衣','men','圖案搭配、字母設計呈現上抓住視覺焦點',299,'100%棉','手洗或放洗衣袋洗最佳(勿用熱水)','泰國','純棉材質不可烘乾，以免衣物縮水','質感面料與美式街頭風結合，打造更加簡約舒適的穿著體驗','main.jpg_1550557385516'),(41,'test3','men','男裝時尚有型',1099,'100%棉','手洗或放洗衣袋洗最佳(勿用熱水)','韓國','實品顏色以單品照為主','just buy','main.jpg_1550735236942'),(42,'test5','accessories','des5',2200,'棉、聚脂纖維','手洗（水溫40度','韓國','實品顏色以單品照為主','買就對了','main.jpg_1550736681304'),(43,'經典商務西裝','men','厚薄：薄 彈性：無',3999,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.','main.jpg_1551340461257'),(44,'最後一件','women','最後一件女裝',1088,'羊毛','乾洗','台灣','無','測試資料庫用的啦～','main.jpg_1551541125806');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `provider` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_expired` bigint(50) DEFAULT NULL,
  `time_stamp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (7,NULL,'','','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',NULL,'893a64d8c2a8a3068b7e212553ef4da2c59062aa255a1d4a89eac0537c824489',1551532756175,'Sat Mar 02 2019 21:19:16 GMT+0800 (GMT+08:00)'),(8,NULL,'stone','stone@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'430ea084da8c81ecea938444e00b0db45823bc07b4e5448da01f932a44c8bf55',1551059356121,'Mon Feb 25 2019 09:49:16 GMT+0800 (GMT+08:00)'),(9,NULL,'stone1','sonte1@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'b2bfd92d849d1c7aebe5d4b191f9f0c418995ab2406ea496811107819f403cc2',1551059414539,'Mon Feb 25 2019 09:50:14 GMT+0800 (GMT+08:00)'),(10,NULL,'stone2','sontsse1@gmail.coms','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'c71b44fc5ac1064b2969ab3520e67b921df18829092a743367198c465c0a0f56',1551059594588,'Mon Feb 25 2019 09:53:14 GMT+0800 (GMT+08:00)'),(11,NULL,'greenleaf','stone111@icloud.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'0a563fe865fde972c35b859aa9cd9eba37f3c532979504577f226a4640e9a3b4',1551059696610,'Mon Feb 25 2019 09:54:56 GMT+0800 (GMT+08:00)'),(12,NULL,'test123','test123@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'98cdde098f7028fb107108d2769c71b5b8bba1969d757e160653fdf0c6aeb4bd',1551061156393,'Mon Feb 25 2019 10:19:16 GMT+0800 (GMT+08:00)'),(13,NULL,'test456','test456@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'46b1187418ca72e1c65be64a58712197016d5c12bb8aedefd879637c9f540a39',1551760265704,'Tue Mar 05 2019 12:31:05 GMT+0800 (GMT+08:00)'),(14,NULL,'test555','test555@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'78835a68fa5e52b4aebba88e80e4a9fa727d449a5576cefd0ea578dcd99021fa',1551072860251,'Mon Feb 25 2019 13:34:20 GMT+0800 (GMT+08:00)'),(15,NULL,'test456e','test45336@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'738d7b94be136707eeca49f087949b2f1ae79010b93eed4b7b87b0308b9b2913',1551072902500,'Mon Feb 25 2019 13:35:02 GMT+0800 (GMT+08:00)'),(16,NULL,'ftest','ftest@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'074205d797e99c1cb638e5dee4793ae013e9a9341797b8f866a4d45b86b458e6',1551087762038,'Mon Feb 25 2019 17:42:42 GMT+0800 (GMT+08:00)'),(17,NULL,'finaltest','finaltest@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'008d2692233a1788d63e41b15ca988aa3fca0edf6b1f23bac46f7c356c104a5d',1551107170550,'Mon Feb 25 2019 23:06:10 GMT+0800 (GMT+08:00)'),(18,NULL,'second','second@gmail.com','16367aacb67a4a017c8da8ab95682ccb390863780f7114dda0a0e0c55644c7c4',NULL,'0ddea351f83a19170f2a40e0fa03480a33306be93eb069c37f8abf177b2c560e',1551094315286,'Mon Feb 25 2019 19:31:55 GMT+0800 (GMT+08:00)'),(19,NULL,'urltest','urltest@gmail.com','c31455a28ed41784b191eb1a78727879f9ec066bbeb27849a0291842f601a6a8',NULL,'2a7d3e0340f778f90622ca2135a6fd90c89d3582591f807ed2c6213e666794c0',1551109948747,'Mon Feb 25 2019 23:52:28 GMT+0800 (GMT+08:00)'),(20,NULL,'api','api1@gmail.com','14c2529eb4498c5d1ffd6915d05bf58a91bdda796af59f41d480d11c099d0479',NULL,'a76627a4087aa7cbe3ac3724b5258578e5c11e9888e8e59c933a38dc6c5e3573',1551114455307,'Tue Feb 26 2019 01:07:35 GMT+0800 (GMT+08:00)'),(45,NULL,'jctest','jctest@test.com','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',NULL,'f1592e7c09767068f276c53a422975760b1533b4c37a1c455f70ef72b1061d74',1551262141821,'Wed Feb 27 2019 18:09:01 GMT+0800 (GMT+08:00)'),(46,NULL,'test4567','test4567@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'fd87123b39deceaea07c3465595d110a84560d7197cc8ad9115e037db060f927',1551262402315,'Wed Feb 27 2019 18:13:22 GMT+0800 (GMT+08:00)'),(47,NULL,'test45','test45@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'8ee9881b32ecb70f593e3fb08c81a2b9f08f3878fed13e5bd3150f7a1120286d',1551262428043,'Wed Feb 27 2019 18:13:48 GMT+0800 (GMT+08:00)'),(48,NULL,'123','123@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'122157ca078a3fc51b9acd5780e9805aacab576c31b28094bf43eb7ff5463706',1551262462018,'Wed Feb 27 2019 18:14:22 GMT+0800 (GMT+08:00)'),(49,NULL,'20190302','20190302@test.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'415c0aa9a431f9ecd38810ae5de02d519b944d4539b9d127ce8040181086e2c4',1551516416368,'Sat Mar 02 2019 16:46:56 GMT+0800 (GMT+08:00)'),(50,NULL,'2019030201','2019030201@test.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'839e6d12b855b56b4484d65c65b412087816014825ec96b44f7268a27d8fef2b',1551517086234,'Sat Mar 02 2019 16:58:06 GMT+0800 (GMT+08:00)'),(51,NULL,'5566333','5566333@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'e2a380c044a5b62ba63cd7f34dea1f386e1c16132235dbfa6fb31deebafd309c',1551517200021,'Sat Mar 02 2019 17:00:00 GMT+0800 (GMT+08:00)'),(52,NULL,'20190302new','20190302new@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'00111019108fd5c0239afd6bf2518adaac1a4486d0f1acc9babb1a3ab0f0bc47',1551519149213,'Sat Mar 02 2019 17:32:29 GMT+0800 (GMT+08:00)'),(53,NULL,'20180101','20180101@test.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'929b489081fd89a13e6a4144c35cff0b1f15a2462f274b57a740752ac6c1e0de',1551520068677,'Sat Mar 02 2019 17:47:48 GMT+0800 (GMT+08:00)'),(54,NULL,'0302test','0302test@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'11fb440e79e44b4d8e9b5488a10f926946af4f9d8d030795cffe4b0e5db52a5d',1551529164230,'Sat Mar 02 2019 20:19:24 GMT+0800 (GMT+08:00)'),(55,NULL,'0302test2','0302test2@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'a54b7cae1728f8808b8a8955bf0769115f49ea56e8a5806e7f08fd605a7e9d89',1551529268582,'Sat Mar 02 2019 20:21:08 GMT+0800 (GMT+08:00)'),(57,NULL,'0302test3','0302test3@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'fbfc1515cd73733293d0f63dfd75a0d116b16d87f0d820e77c2bc8ae38362ef7',1551534308651,'Sat Mar 02 2019 21:45:08 GMT+0800 (GMT+08:00)'),(58,'facebook','魏綠葉','jetaudio56@gmail.com','Null','https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10211594542894231&height=50&width=50&ext=1554351962&hash=AeRmB04SmGAWs2F2','EAAIVi6fpQ3YBABZCroX4JW11eSDCeoekY53hlKxYRPKrOkalksb2T0dhOPYmDx74kswdtXxZAkS2kgXbB3FkikhEgnePVhKIU4GmS3I8hCdVDtyYnOUM1ZBFZCBiNQU82qyXw3ZA73xHjQnfLcBQ5MTVZAbiDKVyRpNmaTZAAMvasItZCx1IYtK45OXZBLx3sWNjemZB8Yl9L5TAZDZD',1551759962244,'Tue Mar 05 2019 12:26:02 GMT+0800 (GMT+08:00)');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-25 20:39:18
