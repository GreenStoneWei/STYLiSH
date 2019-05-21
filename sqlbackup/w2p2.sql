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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (3,39,'http://18.216.254.196/uploads/201807242222.jpg_1550744910731','test');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_gallery`
--

LOCK TABLES `img_gallery` WRITE;
/*!40000 ALTER TABLE `img_gallery` DISABLE KEYS */;
INSERT INTO `img_gallery` VALUES (10,37,'public/uploads/0.jpg_1550558037381,public/uploads/1.jpg_1550558037394'),(11,38,'public/uploads/0.jpg_1550558047252,public/uploads/1.jpg_1550558047253'),(12,39,'public/uploads/0.jpg_1550558056883,public/uploads/1.jpg_1550558056884'),(13,41,'public/uploads/0.jpg_1550735269391,public/uploads/1.jpg_1550735269392'),(14,42,'public/uploads/0.jpg_1550736706527,public/uploads/1.jpg_1550736706528');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (10,37,'深藍','L',5),(11,37,'深藍','M',3),(12,37,'玉米斯白色','M',5),(13,37,'玉米斯白色','S',8),(14,38,'深藍','L',10),(15,38,'深藍','M',8),(16,38,'深藍','S',5),(17,38,'綠松色','M',5),(18,38,'綠松色','S',0),(19,38,'白色','M',12),(20,39,'白色','L',6),(21,39,'紫羅蘭色','M',2),(22,37,'深藍','XS',3),(23,41,'深藍','XS',3),(24,42,'紫羅蘭色','XL',6);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (37,'厚實毛呢格子外套','women','高抗寒素材選用，保暖也時尚有型',2200,'棉、聚脂纖維','手洗（水溫40度','韓國','實品顏色以單品照為主','你絕對不能錯過的超值商品','public/uploads/main.jpg_1550557257419'),(38,'刺繡貼布厚刷毛衛衣上衣','men','簡單的字母印圖，打造舒適好感的自在穿搭',449,'50%棉+50%聚酯纖維，微彈性','低於60度水洗','臺灣','深色衣物建議單獨洗滌，以翻面手洗或放洗衣袋洗較佳','加倍呵護你的肌膚保暖度更提升','public/uploads/main.jpg_1550557327482'),(39,'質感字母印花圓領短袖上衣','men','圖案搭配、字母設計呈現上抓住視覺焦點',299,'100%棉','手洗或放洗衣袋洗最佳(勿用熱水)','泰國','純棉材質不可烘乾，以免衣物縮水','質感面料與美式街頭風結合，打造更加簡約舒適的穿著體驗','public/uploads/main.jpg_1550557385516'),(41,'test3','men','男裝時尚有型',1099,'100%棉','手洗或放洗衣袋洗最佳(勿用熱水)','韓國','實品顏色以單品照為主','just buy','public/uploads/main.jpg_1550735236942'),(42,'test5','accessories','des5',2200,'棉、聚脂纖維','手洗（水溫40度','韓國','實品顏色以單品照為主','買就對了','public/uploads/main.jpg_1550736681304');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,'newgreen','jetaudio56@gmail.com','newpsd',NULL,'8c6179cd1c3472ef042e44e4cd8968f033f9fe5d8919a181e0e6b792502b35e9',NULL,NULL),(2,'native','stoneneww','jetaudio56@gmail.com','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b',NULL,'5dcf98c286c7f254977a18ce395a4155a67aad93982d0d463a971c51aecd1908',NULL,NULL),(3,NULL,'stone','jetaudio56@gmail.com','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b',NULL,'70862de29b93ec67391e123141da68df552c123c811eb6836bfb418f2c43a24a',NULL,NULL),(4,NULL,'stone5','jetaudio56@gmail.com','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b',NULL,'ed5ce574382d7b9f2a978abf0aebe1d5d9bab434a47d0f95af272ba91ac3198e',NULL,NULL),(5,NULL,'stonewei','jetaudio56@gmail.com','a85b6a20813c31a8b1b3f3618da796271c9aa293b3f809873053b21aec501087',NULL,'508c8ed997c727f1baae263d2e8311cc51f49a62d619e4d9453fead5f42a5150',1550892810192,'Sat Feb 23 2019 11:33:30 GMT+0800 (GMT+08:00)'),(6,NULL,'stonewei','jetaudio56@gmail.com','a85b6a20813c31a8b1b3f3618da796271c9aa293b3f809873053b21aec501087',NULL,'67989414a1f8b7b886fa322d546a52fa128a302ad4e427f04f66778b53978772',1550893014282,'Sat Feb 23 2019 11:36:54 GMT+0800 (GMT+08:00)'),(7,NULL,'','','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',NULL,'3108bd650ee095e935a9f9404570fc8114626698d570d5e778a0603c1a2554e3',1551084028585,'Mon Feb 25 2019 16:40:28 GMT+0800 (GMT+08:00)'),(8,NULL,'stone','stone@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'430ea084da8c81ecea938444e00b0db45823bc07b4e5448da01f932a44c8bf55',1551059356121,'Mon Feb 25 2019 09:49:16 GMT+0800 (GMT+08:00)'),(9,NULL,'stone1','sonte1@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'b2bfd92d849d1c7aebe5d4b191f9f0c418995ab2406ea496811107819f403cc2',1551059414539,'Mon Feb 25 2019 09:50:14 GMT+0800 (GMT+08:00)'),(10,NULL,'stone2','sontsse1@gmail.coms','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'c71b44fc5ac1064b2969ab3520e67b921df18829092a743367198c465c0a0f56',1551059594588,'Mon Feb 25 2019 09:53:14 GMT+0800 (GMT+08:00)'),(11,NULL,'greenleaf','stone111@icloud.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'0a563fe865fde972c35b859aa9cd9eba37f3c532979504577f226a4640e9a3b4',1551059696610,'Mon Feb 25 2019 09:54:56 GMT+0800 (GMT+08:00)'),(12,NULL,'test123','test123@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'98cdde098f7028fb107108d2769c71b5b8bba1969d757e160653fdf0c6aeb4bd',1551061156393,'Mon Feb 25 2019 10:19:16 GMT+0800 (GMT+08:00)'),(13,NULL,'test456','test456@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'04d4e6cba7920aea43856230fb78629762899d9128da4aef98a4c9a2ab3aaaac',1551087544727,'Mon Feb 25 2019 17:39:04 GMT+0800 (GMT+08:00)'),(14,NULL,'test555','test555@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'78835a68fa5e52b4aebba88e80e4a9fa727d449a5576cefd0ea578dcd99021fa',1551072860251,'Mon Feb 25 2019 13:34:20 GMT+0800 (GMT+08:00)'),(15,NULL,'test456e','test45336@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'738d7b94be136707eeca49f087949b2f1ae79010b93eed4b7b87b0308b9b2913',1551072902500,'Mon Feb 25 2019 13:35:02 GMT+0800 (GMT+08:00)'),(16,NULL,'ftest','ftest@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'074205d797e99c1cb638e5dee4793ae013e9a9341797b8f866a4d45b86b458e6',1551087762038,'Mon Feb 25 2019 17:42:42 GMT+0800 (GMT+08:00)'),(17,NULL,'finaltest','finaltest@gmail.com','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',NULL,'a958de092250ed32d5a36034b6b99b3a2a59adfe0e36c137d718e18591619fa2',1551089879261,'Mon Feb 25 2019 18:17:59 GMT+0800 (GMT+08:00)');
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

-- Dump completed on 2019-02-25 18:21:17
