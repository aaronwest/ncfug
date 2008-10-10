-- MySQL dump 10.10
--
-- Host: localhost    Database: chug
-- ------------------------------------------------------
-- Server version    5.0.27-standard

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` char(35) NOT NULL,
  `address_1` varchar(250) NOT NULL,
  `address_2` varchar(250) default NULL,
  `city` varchar(250) NOT NULL,
  `state_id` char(35) default NULL,
  `postal_code` varchar(100) default NULL,
  `country_id` char(35) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` char(35) NOT NULL,
  `title` varchar(500) NOT NULL,
  `content` longtext NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_author`
--

DROP TABLE IF EXISTS `article_author`;
CREATE TABLE `article_author` (
  `article_id` char(35) NOT NULL,
  `author_id` char(35) NOT NULL,
  PRIMARY KEY  (`article_id`,`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `article_author`
--

LOCK TABLES `article_author` WRITE;
/*!40000 ALTER TABLE `article_author` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_category`
--

DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `article_id` char(35) NOT NULL,
  `category_id` char(35) NOT NULL,
  PRIMARY KEY  (`article_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `article_category`
--

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_position`
--

DROP TABLE IF EXISTS `board_position`;
CREATE TABLE `board_position` (
  `board_position_id` char(35) NOT NULL,
  `board_position` varchar(250) NOT NULL,
  `description` varchar(500) default NULL,
  `sort_order` tinyint(3) unsigned NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`board_position_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `board_position`
--

LOCK TABLES `board_position` WRITE;
/*!40000 ALTER TABLE `board_position` DISABLE KEYS */;
INSERT INTO `board_position` VALUES ('9E5FB8D1-E317-6618-9C9C26B54AF87B90','Manager','UG Manager',1,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888177873,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1170888269805,'156.33.114.155',1),('9E69E14F-A2FE-570D-B09755CE1BB9EDF4','Meeting Content','Person responsible for speakers and meeting content',2,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888843596,'156.33.114.155',NULL,NULL,NULL,1),('9E6A79C3-900F-1F4D-F4AEE6A8102110DD','Publicity and Membership','Person responsible for publicizing the group and meetings, and recruiting and retaining members',3,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888882627,'156.33.114.155',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `board_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_position_person`
--

DROP TABLE IF EXISTS `board_position_person`;
CREATE TABLE `board_position_person` (
  `board_position_id` char(35) NOT NULL,
  `person_id` char(35) NOT NULL,
  PRIMARY KEY  (`board_position_id`,`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `board_position_person`
--

LOCK TABLES `board_position_person` WRITE;
/*!40000 ALTER TABLE `board_position_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_position_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `book_id` char(35) NOT NULL,
  `title` varchar(500) NOT NULL,
  `publisher_id` char(35) NOT NULL,
  `publication_year` smallint(5) unsigned NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `num_pages` smallint(5) unsigned default NULL,
  `price` smallint(5) unsigned default NULL,
  `url` varchar(255) default NULL,
  `cover_image_small` varchar(255) default NULL,
  `cover_image_large` varchar(255) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`book_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
CREATE TABLE `book_author` (
  `book_id` char(35) NOT NULL,
  `author_id` char(35) NOT NULL,
  PRIMARY KEY  (`book_id`,`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_category`
--

DROP TABLE IF EXISTS `book_category`;
CREATE TABLE `book_category` (
  `book_id` char(35) NOT NULL,
  `category_id` char(35) NOT NULL,
  PRIMARY KEY  (`book_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_category`
--

LOCK TABLES `book_category` WRITE;
/*!40000 ALTER TABLE `book_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_review`
--

DROP TABLE IF EXISTS `book_review`;
CREATE TABLE `book_review` (
  `book_review_id` char(35) NOT NULL,
  `book_id` char(35) NOT NULL,
  `review` longtext NOT NULL,
  `review_date` bigint(20) unsigned NOT NULL,
  `reviewer_id` char(35) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`book_review_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book_review`
--

LOCK TABLES `book_review` WRITE;
/*!40000 ALTER TABLE `book_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` char(35) NOT NULL,
  `category` varchar(500) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('26BFCADF-0A33-6FFF-1ADD6B5B98948EC2','New Category','993700D0-C25C-213F-C3F38E7A533AEB88',1181766109918,'127.0.0.1',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` char(35) NOT NULL,
  `country` varchar(500) default NULL,
  `country_abbr` char(2) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_type`
--

DROP TABLE IF EXISTS `file_type`;
CREATE TABLE `file_type` (
  `file_type_id` char(35) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `file_extension` varchar(20) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`file_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `file_type`
--

LOCK TABLES `file_type` WRITE;
/*!40000 ALTER TABLE `file_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_type`
--

DROP TABLE IF EXISTS `im_type`;
CREATE TABLE `im_type` (
  `im_type_id` char(35) NOT NULL,
  `im_type` varchar(100) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`im_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `im_type`
--

LOCK TABLES `im_type` WRITE;
/*!40000 ALTER TABLE `im_type` DISABLE KEYS */;
INSERT INTO `im_type` VALUES ('940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','Skype','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170714842070,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715920039,'156.33.114.155',1),('940B01D1-FEEB-DC29-F2F26E44522032D0','Yahoo!','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170714853840,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715959105,'156.33.114.155',1),('93F032CD-9872-2C0C-0776C3B2CD417D9E','AOL','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170713096909,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1171490593866,'156.33.114.155',1),('941B9C87-F160-F341-8FEA5A07E4AFB150','Google Talk','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715942023,'156.33.114.155',NULL,NULL,NULL,1),('941BC4FC-DF44-CD14-B25D64FAA6E22129','MSN','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715952378,'156.33.114.155',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `im_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `location_id` char(35) NOT NULL,
  `location` varchar(250) NOT NULL,
  `map_link` varchar(250) default NULL,
  `description` varchar(500) default NULL,
  `address_id` char(35) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES ('C22F8EF6-FF60-02E0-5C74CEB0539AB0A4','Postal Square 6915',NULL,'Meeting area in PSQ 6915',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1171489001206,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1171551140070,'156.33.114.155',1),('20309DC1-9D07-F40E-3BACB6FCF8ABFEE9','Hart Senate Office Building - Room 512','http://maps.google.com/maps?f=q&hl=en&q=Hart+Senate+Office+Building','The Hart Senate Office Building is located at Constitution & 2nd Street NE. The public entrance is on 2nd Street. Two blocks north is the nearest metro stop: Union Station on the Red Line. Please send an email to info@capitolhillusergroup.com if you get lost.',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1177361096128,'156.33.114.155',NULL,NULL,NULL,1),('49FAAF2C-C438-867B-F7C6431E826E80CE','Senate Dirksen Office Building - Room 138','http://maps.google.com/maps?f=q&hl=en&q=Dirksen+Senate+Office+Building',NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1178062204716,'69.143.48.132',NULL,NULL,NULL,1),('1CE73ADB-B371-7E25-1E61990745B94AD6','Senate Dirksen Office Building - Room 192','http://maps.google.com/maps?f=q&hl=en&q=Dirksen+Senate+Office+Building',NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181600922330,'69.3.89.146','993700D0-C25C-213F-C3F38E7A533AEB88',1181603531105,'127.0.0.1',1);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
CREATE TABLE `meeting` (
  `meeting_id` char(35) NOT NULL,
  `title` varchar(500) NOT NULL,
  `description` text,
  `dt_meeting` bigint(20) unsigned NOT NULL,
  `location_id` char(35) NOT NULL,
  `connect_url` varchar(255) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`meeting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES ('1526DBD7-BEB0-7EA4-7A2167BF1C257DEB','Inaugural Meeting','Please come join us at our inaugural meeting! We have the distinct pleasure of welcoming Ben Forta, Tim Buntel, and Adam Wayne Lehman from Adobe at our first meeting to share everything they can about ColdFusion 8 (\"Scorpio\"), so you won\'t want to miss it!\r\n\r\nWe\'ll also socialize a bit and discuss what we want to do with the group, as well as get into meeting times, topics, and anything else to do with this fledgling group. See you there!',1179421200000,'49FAAF2C-C438-867B-F7C6431E826E80CE',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1177175907287,'69.143.48.132','993700D0-C25C-213F-C3F38E7A533AEB88',1178933567786,'69.143.48.132',1),('1D05E843-F80E-257B-56B030A320DECE6D','adsads','adsads',1181602920000,'1CE73ADB-B371-7E25-1E61990745B94AD6',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181602932803,'127.0.0.1',NULL,NULL,NULL,1),('21686DFF-933A-2568-420CC50C07FE2492','Test Meeting','This is a test meeting.',1181676480000,'C22F8EF6-FF60-02E0-5C74CEB0539AB0A4',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181676498430,'127.0.0.1',NULL,NULL,NULL,1),('25D0EB5D-E68C-5645-7CBA2E6A1EFC8978','Test of Connect URL','This is a test of the connect url field.',1181750400000,'20309DC1-9D07-F40E-3BACB6FCF8ABFEE9','http://connecturl/newone','993700D0-C25C-213F-C3F38E7A533AEB88',1181750455133,'127.0.0.1','993700D0-C25C-213F-C3F38E7A533AEB88',1181750894732,'127.0.0.1',1);
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_presentation`
--

DROP TABLE IF EXISTS `meeting_presentation`;
CREATE TABLE `meeting_presentation` (
  `meeting_id` char(35) NOT NULL,
  `presentation_id` char(35) NOT NULL,
  PRIMARY KEY  (`meeting_id`,`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meeting_presentation`
--

LOCK TABLES `meeting_presentation` WRITE;
/*!40000 ALTER TABLE `meeting_presentation` DISABLE KEYS */;
INSERT INTO `meeting_presentation` VALUES ('21686DFF-933A-2568-420CC50C07FE2492','216816A2-FFB5-05EF-C204DA18B2B2F2DC'),('EA3F4A1F-AFF2-FAE5-3F82FE27EB4508F1','EA4AD032-B8E6-D9E2-E7B378CE1E5DC80E'),('EB97E219-CEAD-DA48-A8EFB0AF8F35B9C6','EA4A7F9E-D040-F6BC-E18191D762036B79');
/*!40000 ALTER TABLE `meeting_presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `news_id` char(35) NOT NULL,
  `headline` varchar(500) NOT NULL,
  `body` longtext NOT NULL,
  `dt_to_post` bigint(20) unsigned NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`news_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES ('211CD7D5-D352-22CE-53B48DCFED1052FC','Headline','Body',1181671500000,'993700D0-C25C-213F-C3F38E7A533AEB88',1181671544789,'127.0.0.1',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `organization_id` char(35) NOT NULL,
  `organization` varchar(500) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(35) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`organization_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('9888ABD5-019C-E4BF-BC1566C59A9CD316','U.S. Senate - Sergeant at Arms','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170790198228,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170790956331,'156.33.114.155',1);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `person_id` char(35) NOT NULL,
  `first_name` varchar(250) NOT NULL,
  `last_name` varchar(250) NOT NULL,
  `title` varchar(250) NOT NULL,
  `organization_id` char(35) default NULL,
  `phone` varchar(50) default NULL,
  `email` varchar(250) NOT NULL,
  `url` varchar(255) default NULL,
  `image` varchar(255) default NULL,
  `password` varchar(50) default NULL,
  `is_admin` tinyint(3) unsigned default NULL,
  `role_id` char(35) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  `bio` text default NULL,
  PRIMARY KEY  (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','Default','User','Default User','9888ABD5-019C-E4BF-BC1566C59A9CD316','phone','admin@admin.com',NULL,NULL,'admin',1,'98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053',2007,'127.0.0.1','993700D0-C25C-213F-C3F38E7A533AEB88',1170879468244,'156.33.114.155',1,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
CREATE TABLE `person_address` (
  `person_id` char(35) NOT NULL,
  `address_id` char(35) NOT NULL,
  PRIMARY KEY  (`person_id`,`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_im`
--

DROP TABLE IF EXISTS `person_im`;
CREATE TABLE `person_im` (
  `person_id` char(35) NOT NULL,
  `im_type_id` char(35) NOT NULL,
  `im_handle` varchar(100) NOT NULL,
  PRIMARY KEY  (`person_id`,`im_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person_im`
--

LOCK TABLES `person_im` WRITE;
/*!40000 ALTER TABLE `person_im` DISABLE KEYS */;
INSERT INTO `person_im` VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940B01D1-FEEB-DC29-F2F26E44522032D0','yahoo'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941B9C87-F160-F341-8FEA5A07E4AFB150','google'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','93F032CD-9872-2C0C-0776C3B2CD417D9E','aol'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','skype'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941BC4FC-DF44-CD14-B25D64FAA6E22129','msn'),('993700D0-C25C-213F-C3F38E7A533AEB88','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','mpwoodward'),('993700D0-C25C-213F-C3F38E7A533AEB88','941B9C87-F160-F341-8FEA5A07E4AFB150','mpwoodward@gmail.com'),('993700D0-C25C-213F-C3F38E7A533AEB88','940B01D1-FEEB-DC29-F2F26E44522032D0','mpwoodward2'),('993700D0-C25C-213F-C3F38E7A533AEB88','941BC4FC-DF44-CD14-B25D64FAA6E22129','mpwoodward@hotmail.com'),('993700D0-C25C-213F-C3F38E7A533AEB88','93F032CD-9872-2C0C-0776C3B2CD417D9E','CaptainJavac');
/*!40000 ALTER TABLE `person_im` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photo_id` char(35) NOT NULL,
  `title` varchar(250) NOT NULL,
  `caption` varchar(500) default NULL,
  `file_name` varchar(500) NOT NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_album`
--

DROP TABLE IF EXISTS `photo_album`;
CREATE TABLE `photo_album` (
  `photo_album_id` char(35) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` varchar(500) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`photo_album_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `photo_album`
--

LOCK TABLES `photo_album` WRITE;
/*!40000 ALTER TABLE `photo_album` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_album_photo`
--

DROP TABLE IF EXISTS `photo_album_photo`;
CREATE TABLE `photo_album_photo` (
  `photo_album_id` char(35) NOT NULL,
  `photo_id` char(35) NOT NULL,
  PRIMARY KEY  (`photo_album_id`,`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `photo_album_photo`
--

LOCK TABLES `photo_album_photo` WRITE;
/*!40000 ALTER TABLE `photo_album_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo_album_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentation`
--

DROP TABLE IF EXISTS `presentation`;
CREATE TABLE `presentation` (
  `presentation_id` char(35) NOT NULL,
  `title` varchar(500) NOT NULL,
  `summary` text,
  `presentation_file` varchar(250) default NULL,
  `presentation_file_title` varchar(250) default NULL,
  `presentation_file_description` varchar(500) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presentation`
--

LOCK TABLES `presentation` WRITE;
/*!40000 ALTER TABLE `presentation` DISABLE KEYS */;
INSERT INTO `presentation` VALUES ('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','Test of File Upload','test',NULL,NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1172092936674,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1172094034859,'156.33.114.155',1),('216816A2-FFB5-05EF-C204DA18B2B2F2DC','Test Presentation','test',NULL,NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181676476065,'127.0.0.1',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentation_presenter`
--

DROP TABLE IF EXISTS `presentation_presenter`;
CREATE TABLE `presentation_presenter` (
  `presentation_id` char(35) NOT NULL,
  `presenter_id` char(35) NOT NULL,
  PRIMARY KEY  (`presentation_id`,`presenter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presentation_presenter`
--

LOCK TABLES `presentation_presenter` WRITE;
/*!40000 ALTER TABLE `presentation_presenter` DISABLE KEYS */;
INSERT INTO `presentation_presenter` VALUES ('216816A2-FFB5-05EF-C204DA18B2B2F2DC','993700D0-C25C-213F-C3F38E7A533AEB88'),('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','993700D0-C25C-213F-C3F38E7A533AEB88'),('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','E5D7DDBE-C051-2835-72F654D715E20CD9');
/*!40000 ALTER TABLE `presentation_presenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` char(35) NOT NULL,
  `role` varchar(100) NOT NULL,
  `description` varchar(500) default NULL,
  `created_by_id` char(35) NOT NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('98C49505-0610-4F47-B7E2535E5BC75934','Member','User Group Member','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794124549,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794502025,'156.33.114.155',1),('98CAA920-F976-92DA-1E46FB2C500556CC','Presenter','Non-Member Presenter','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794522912,'156.33.114.155',NULL,NULL,NULL,1),('98CF6629-DF39-BD9D-8F95BE845916D0B5','Sponsor','Sponsor','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794833449,'156.33.114.155',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rsvp`
--

DROP TABLE IF EXISTS `rsvp`;
CREATE TABLE `rsvp` (
  `rsvp_id` char(35) NOT NULL,
  `meeting_id` char(35) NOT NULL,
  `person_id` char(35) default NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `comments` text,
  `created_by_id` char(35) default NULL,
  `dt_created` bigint(20) unsigned NOT NULL,
  `ip_created` varchar(15) NOT NULL,
  `modified_by_id` char(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`rsvp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rsvp`
--

LOCK TABLES `rsvp` WRITE;
/*!40000 ALTER TABLE `rsvp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rsvp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `state_id` char(35) NOT NULL,
  `state` varchar(50) NOT NULL,
  `state_abbr` char(2) NOT NULL,
  PRIMARY KEY  (`state_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES ('C1F5D036-FBA0-AC33-30DFD83ECBD754F7','Alabama','AL'),('C1F5D037-E5D4-EBA7-BC0FA1191C1FA222','Alaska','AK'),('C1F5D038-06B7-BA21-68CD4E18A0EDA5A7','Arizona','AZ'),('C1F5D039-BB26-0CB7-6B60FC81C144FA8F','Arkansas','AR'),('C1F5D03A-EA1F-F33E-64FBE4837506885F','California','CA'),('C1F5D03B-D8E3-2B02-9C8496EF7ACEF62D','Colorado','CO'),('C1F5D03C-EAA5-876B-45D91B7719C17BFE','Connecticut','CT'),('C1F5D03D-036C-353C-FF37CE9DB95CC177','Delaware','DE'),('C1F5D03E-CCC0-947D-9DC1CDA49819FD33','District of Columbia','DC'),('C1F5D03F-F195-C3D9-6D4859EA559392CA','Florida','FL'),('C1F5D040-DE7F-202D-30FA138DCC7A30CC','Georgia','GA'),('C1F5D041-F012-A2FE-09F32A51F589C27B','Hawaii','HI'),('C1F5D042-C8BC-522C-FC79B916F792EB42','Idaho','ID'),('C1F5D043-9860-67FC-30B8B08BB24978C2','Illinois','IL'),('C1F5D044-A344-3CCD-851DBFF07FEB4AD1','Indiana','IN'),('C1F5D045-A9E0-B5A9-936AB7A3DF118BC0','Iowa','IA'),('C1F5D046-CC23-8DE6-BBDEB5C8879B1995','Kansas','KS'),('C1F5D047-FBDB-3E95-F149E8B586E29507','Kentucky','KY'),('C1F5D048-B6C2-5C5B-F916BB063EC5CEE8','Louisiana','LA'),('C1F5D049-D489-578A-04A9B5232E66D9BB','Maine','ME'),('C1F5D04A-C342-4497-232D8D96F3AC7199','Maryland','MD'),('C1F5D04B-BBB7-6329-8C21D3A4CD63E695','Massachusetts','MA'),('C1F5D04C-01D0-B2CF-A6E38AE9C41DA312','Michigan','MI'),('C1F5D04D-F882-E823-B2A3E08965BED7A1','Minnesota','MN'),('C1F5D04E-B2DB-4A83-9CB9FC2850AE5799','Mississippi','MS'),('C1F5D04F-CFD6-3DDD-621FBBE18F22974E','Missouri','MO'),('C1F5D050-F757-B052-C963B6867A0304FF','Montana','MT'),('C1F5D051-00F2-ABD4-6C6A587D2E110E97','Nebraska','NE'),('C1F5D052-DA83-337E-A353B39A60E86B37','Nevada','NV'),('C1F5D053-9460-2CA3-8B795D9FFB74706C','New Hampshire','NH'),('C1F5D054-D727-EE6A-11FFF8C5F848CD53','New Jersey','NJ'),('C1F5D055-FAF5-BBF6-AEEAC71DE6765D6C','New Mexico','NM'),('C1F5D056-E36D-3E3D-01598825C287155B','New York','NY'),('C1F5D057-CF98-85E5-35D1FF9326DFA858','North Carolina','NC'),('C1F5D058-CBDE-E0DC-2B151CF2A0C18E48','North Dakota','ND'),('C1F5D059-B689-A31B-14A54ECF18B506D2','Ohio','OH'),('C1F5D05A-D565-6CDE-408208858E1D521E','Oklahoma','OK'),('C1F5D05B-F33E-E956-6ABACD5303E941A2','Oregon','OR'),('C1F5D05C-004E-3EA1-1F9F58147BC34A7D','Pennsylvania','PA'),('C1F5D05D-09BB-5C15-4B01433D9245E98A','Rhode Island','RI'),('C1F5D05E-A2DF-5A05-2FA25E4431C635ED','South Carolina','SC'),('C1F5D05F-FA6D-E8CC-163FF44BCA49DB1A','South Dakota','SD'),('C1F5D060-9683-C53A-0E5E81F501BF4796','Tennessee','TN'),('C1F5D061-BF35-AA81-7776805AC236C0FF','Texas','TX'),('C1F5D062-98F2-7B8A-C80E2EB0B5659334','Utah','UT'),('C1F5D063-EA74-5D1F-097C875504EE01E5','Vermont','VT'),('C1F5D064-CC73-7518-3F11E86931025847','Virginia','VA'),('C1F5D065-A37F-0FD6-06EF9862797D4E44','Washington','WA'),('C1F5D066-D062-9414-94E8EAD5E20E6B24','West Virginia','WV'),('C1F5D067-DAE1-D63B-B0AE570AC815E554','Wisconsin','WI'),('C1F5D068-040D-DE21-490A9C8C975574FE','Wyoming','WY');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-06-13 23:14:36
