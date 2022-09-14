-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: funweb
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `archive`
--

DROP TABLE IF EXISTS `archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archive` (
  `num` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `type` varchar(10) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `original_file` varchar(50) NOT NULL,
  `real_file` varchar(50) NOT NULL,
  `readcount` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive`
--

LOCK TABLES `archive` WRITE;
/*!40000 ALTER TABLE `archive` DISABLE KEYS */;
INSERT INTO `archive` VALUES (1,'uncalmtomato','1234','digital','말랑귀염 찹쌀떡들','시고르 고양이','two_ricecake.jpg','two_ricecake.jpg',1,'2022-09-07 11:54:47'),(2,'uncalmtomato','12345678','digital','강릉가는 길','여행가고싶다.. ','onttheroad.jpg','onttheroad.jpg',6,'2022-09-07 11:55:45'),(3,'uncalmtomato','12345678','digital','소금빵금빵','이흥용 소금빵 너무맛있고...너무...너무고....','saltb.jpg','saltb.jpg',32,'2022-09-07 11:56:33'),(4,'filmneverdie','12345678','film','dusty cat','시작은 역시 고양이죠.','dustycat_tw.JPG','dustycat_tw.JPG',4,'2022-09-07 12:04:13'),(5,'filmneverdie','12345678','film','금붕어','어라','goldfish_hk.JPG','goldfish_hk.JPG',0,'2022-09-07 12:05:15'),(7,'filmneverdie','12345678','film','summer','여름 해바라기밭에서 찍었던 사진.사람도 별로없고 날이 많이덥지는 않아서 정말 좋았던 곳','sunflower.JPG','sunflower.JPG',5,'2022-09-07 12:13:24'),(8,'woo0woo0','12345678','digital','새끼범고래','새끼범고래가 심심해서 튀어오르는 장면입니다. 아주작고귀엽지만 새끼여도 1톤정도는 되기때문에 꽤나크다고 할수있습니다.','jumpppp.jpg','jumpppp.jpg',24,'2022-09-07 12:29:25'),(9,'woo0woo0','12345678','film','의뢰받았던 날','제주도는 참 날씨가좋고 아름다운 곳이 많습니다.','greenjj.JPG','greenjj.JPG',13,'2022-09-07 12:30:36'),(10,'o2170838','1234','digital','채소가게도둑','어어 지금 뭐하는?','theif.jpg','theif.jpg',8,'2022-09-08 08:31:01'),(11,'o2170838','1234','digital','seeea','바다는 봐도봐도 너무좋아요','panorama_gn.jpg','panorama_gn.jpg',1,'2022-09-08 08:31:46'),(12,'o2170838','1234','film','Best Friend','할아버지랑 꼬마고양이는 친구라고 했다. 고앵이...너무귀여워..할아버지완전 졸졸따라다닌다..ㅠㅠ','friend_osk.JPG','friend_osk.JPG',0,'2022-09-08 08:32:51'),(13,'o2170838','1234','digital','SignRoad','북적거렸지만 너무좋아서 기억에 많이 남았던 홍콩. 2층버스타고 꼬불길 따라서 스탠리비치가던게 아직도 생생하다','signroad_hk.JPG','signroad_hk.JPG',0,'2022-09-08 08:34:28'),(14,'dotory09','12345678','digital','경주에 가면','월정교는 꼭 야경으로 보고오셔야해요...ㅠㅠㅠ안보면겸상안하는곳','moonbridge.jpg','moonbridge.jpg',0,'2022-09-08 08:42:53'),(15,'dotory09','12345678','digital','piecesOfSun','윤슬 좋아하시는 분들 많을 것 같아서 올려봐요. :) ','knowwheretogo.jpg','knowwheretogo.jpg',7,'2022-09-08 08:45:15'),(16,'dotory09','1234','film','기다리는중','뭘그렇게 열심히 기다리는걸까','puppyb_jj.JPG','puppyb_jj.JPG',10,'2022-09-08 08:49:12'),(17,'mint813choco','12345678','digital','부엉부엉','강릉갔을때 절에있었던 엄청엄청 큰 부엉부엉이 너무 동그랗고 귀엽고 멀뚱해 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ','owl_of_thetemp.jpg','owl_of_thetemp.jpg',17,'2022-09-08 08:53:19'),(18,'mint813choco','12345678','digital','for Taiwan','대만가면 이거아마 다들 지나치면서 한번씩은 꼭 봤을테니까.','rainbowroad.jpg','rainbowroad.jpg',0,'2022-09-08 08:54:16'),(19,'mint813choco','12345678','film','palmtree','제주 어느 초등학교 앞','pppalmtree_jj.JPG','pppalmtree_jj.JPG',10,'2022-09-08 08:55:51'),(20,'mint813choco','12345678','film','skyscrapper!','NEWWWWWWWWYORKKKKKKKKKKKK','skyscrapper_ny.JPG','skyscrapper_ny.JPG',54,'2022-09-08 08:56:39'),(21,'mint813choco','12345678','film','Just NYC ','우연히 뉴욕의 상징 두개가 나란히 찍혀준 사진.','thisis_ny.JPG','thisis_ny.JPG',8,'2022-09-08 08:57:36'),(22,'mojiluvu','12345678','film','brothers','귀여운녀석덜','brothers_jdj.JPG','brothers_jdj.JPG',3,'2022-09-08 09:01:03'),(23,'mojiluvu','12345678','digital','Journey','방콕..그리워허..','alwaysyes.jpg','alwaysyes.jpg',1,'2022-09-08 09:02:43'),(24,'dododo22','12345678','film','sheeeep',':)','smileykid.jpg','smileykid1.jpg',0,'2022-09-08 11:16:34'),(25,'dododo22','12345678','digital','김첨지의 하루','너무기빨리고...배고프고.....','ㅜ.jpg','ㅜ.jpg',10,'2022-09-08 11:46:11'),(26,'mojiluvu','12345678','digital','SelfCamera','말랑콩떡 모지입니다?','cutieeeeemozi.jpg','cutieeeeemozi.jpg',8,'2022-09-08 17:32:24');
/*!40000 ALTER TABLE `archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `num` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `readcount` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'너구리','1234','제 솜사탕 어디갔나요?','솜사탕 씻어뒀는데 보신분 계신가요. ',153,'2022-08-17 15:34:43'),(3,'uncalmtomato','12345678','오프라인 샵에서 사진인화 가능한가요?','가격알고싶습니다!',17,'2022-09-07 11:57:43'),(4,'우영우','12345678','고래사진을 인화하고 싶습니다','고래이야기가 필요한 상황이라 고래사진을 보여주며 설명하고싶습니다. 가능할까요?',14,'2022-09-07 12:32:38'),(5,'톰과제리','0202','회원가입을 했는데 글이 써지지않아요ㅜㅜ','뭐때문인건가요ㅠㅠ',7,'2022-09-07 12:33:38'),(6,'똑똑강쥐','1234','포토북같이만드실분구합니다~','여러권제작하려고하는데 뭐 팬북이나 아니면 여행책 공구하실분 구해요!댓글 달아주세요!',36,'2022-09-08 08:40:05');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` varchar(16) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `name` varchar(20) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `email1` varchar(50) NOT NULL,
  `email2` varchar(50) NOT NULL,
  `emailw` varchar(50) NOT NULL,
  `camera` varchar(10) NOT NULL,
  `post_code` varchar(10) NOT NULL,
  `address1` varchar(100) NOT NULL,
  `address2` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `emailw` (`emailw`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('admin','1234','관리자','01011111111','admin','admin.com','admin@admin.com','both','','','','','2022-09-01'),('dododo22','12345678','도도','01000002154','dododo22','naver.com','dododo22@naver.com','digital','48755','부산 동구 범일로 3','123','','2022-09-08'),('dongrami00','12345678','동그라미','00000000000','circle00','naver.com','circle00@naver.com','both','','','','','2022-09-02'),('dotory09','12345678','도토리','01099990000','doto99','daum.net','doto99@daum.net','both','48755','부산 동구 범일로 11','1234','','2022-09-05'),('filmneverdie','12345678','김공공','01012345678','filmneverdie','naver.com','filmneverdie@naver.com','digital','47246','부산 부산진구 동천로 109','7층','','2022-09-05'),('mint813choco','12345678','박민트','01062625252','mintchoco','daum.net','mintchoco@daum.net','both','54081','전북 군산시 팔마로 122','레몬컴퓨터','','2022-09-08'),('mojiluvu','12345678','정모지','01045671234','hamzzimozi','naver.com','hamzzimozi@naver.com','film','51356','경남 창원시 마산회원구 3.15대로 750','시외버스터미널','','2022-09-08'),('uncalmtomato','12345678','토마토','01025255252','dancingtomato','naver.com','dancingtomato@naver.com','digital','23061','인천 강화군 화도면 해안남로 2506-15','토마토','','2022-09-07'),('woo0woo0','12345678','우영우','01000000000','woowhale','daum.net','woowhale@daum.net','both','05856','서울 송파구 법원로 101','서울동부지방법원','','2022-09-05');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply` (
  `num` int NOT NULL AUTO_INCREMENT,
  `boardType` varchar(10) NOT NULL,
  `refNum` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `content` varchar(100) NOT NULL,
  `date` timestamp NOT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (8,'archive',26,'dotory09','으아 너무 귀엽고 동그란거아닌가요 ㅠㅠㅠㅠㅠ','2022-09-13 00:00:13'),(9,'archive',25,'dotory09','ㅋㅋㅋㅋㅋ표정뭐예요 너무귀여운데 웃프다...','2022-09-13 00:00:31'),(10,'qnaBoard',6,'dotory09','팬북공구 끝났나요 ?? 참여하고싶어요 ㅠㅠ','2022-09-13 00:01:26'),(11,'qnaBoard',3,'dotory09','인화가능해요! 아마 1장단위아니고 여러장일걸요 ㅠㅠ 매장에 전화해서 문의하시는게 제일 빠를 것 같아요!!!','2022-09-13 00:01:55'),(12,'qnaBoard',1,'dotory09','무슨맛 솜사탕이었나요??','2022-09-13 00:02:28');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `num` int NOT NULL AUTO_INCREMENT,
  `boardType` varchar(15) NOT NULL,
  `refNum` int NOT NULL,
  `postName` varchar(20) NOT NULL,
  `postSubject` varchar(50) NOT NULL,
  `reportReason` varchar(100) NOT NULL,
  `reporter` varchar(20) NOT NULL,
  `reportDate` timestamp NOT NULL,
  `processing` varchar(20) NOT NULL DEFAULT '처리중',
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,'archive',25,'dododo22','김첨지의 하루','부적합한 사진입니다','dotory09','2022-09-13 00:00:55','처리완료'),(2,'qnaBoard',1,'너구리','제 솜사탕 어디갔나요?','게시판길잃으신거같은데요...','dotory09','2022-09-13 00:02:08','처리중'),(3,'archive',10,'o2170838','채소가게도둑','제목이 부적합합니다;;','dotory09','2022-09-13 00:02:58','처리중');
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-13 10:03:37
