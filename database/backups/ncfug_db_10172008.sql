-- MySQL dump 10.9
--
-- Host: localhost    Database: ncfug
-- ------------------------------------------------------
-- Server version	4.1.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` varchar(35) NOT NULL default '',
  `address_1` varchar(250) NOT NULL default '',
  `address_2` varchar(250) default NULL,
  `city` varchar(250) NOT NULL default '',
  `state_id` varchar(35) default NULL,
  `postal_code` varchar(100) default NULL,
  `country_id` varchar(35) NOT NULL default '',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES ('E236DD4A-9D6D-A86B-E25841FDE2376A87','5543 Edmondson Pike','Suite 116','Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37211','US','',0,'',NULL,NULL,NULL,1),('E23CFE0B-AD65-370F-D4CC9800C4DB9AF6','404 BNA Drive',NULL,'Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37217','','',0,'',NULL,NULL,NULL,0),('E241A961-E669-DF8F-3A1CFCFA48404C03',' One Vantage Way',' Suite C-200','Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37228','','',0,'',NULL,0,NULL,0),('E2480A50-B22F-19EF-286009BC28F9B3AB','',NULL,'','TN',NULL,'US','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223567084104,'127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223926294254,'69.138.62.82',1),('F16C60AD-B032-4734-B9660122D7E064C2','1918 West End Avenue',NULL,'Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37203','','',0,'',NULL,NULL,NULL,0),('F175D2D9-E27C-1BDB-36080C114F17B39E','1010 Demonbreun St',NULL,'Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37203','','',0,'',NULL,NULL,NULL,0),('06BB665A-06B4-724F-B7F444A92A3F6D11','Unknown',NULL,'Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796',NULL,'','',0,'',NULL,0,NULL,0);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `article_id` varchar(35) NOT NULL default '',
  `title` text NOT NULL,
  `content` longtext NOT NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `article_id` char(35) NOT NULL default '',
  `author_id` char(35) NOT NULL default '',
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
  `article_id` char(35) NOT NULL default '',
  `category_id` char(35) NOT NULL default '',
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
  `board_position_id` varchar(35) NOT NULL default '',
  `board_position` varchar(250) NOT NULL default '',
  `description` text,
  `sort_order` tinyint(3) unsigned NOT NULL default '0',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`board_position_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `board_position`
--

LOCK TABLES `board_position` WRITE;
/*!40000 ALTER TABLE `board_position` DISABLE KEYS */;
INSERT INTO `board_position` VALUES ('9E5FB8D1-E317-6618-9C9C26B54AF87B90','Manager','UG Manager',1,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888177873,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1170888269805,'156.33.114.155',1),('9E69E14F-A2FE-570D-B09755CE1BB9EDF4','Meeting Content','Person responsible for speakers and meeting content',2,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888843596,'156.33.114.155',NULL,NULL,NULL,1),('9E6A79C3-900F-1F4D-F4AEE6A8102110DD','Publicity and Membership','Person responsible for publicizing the group and meetings, and recruiting and retaining members',3,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888882627,'156.33.114.155',NULL,NULL,NULL,1),('E24A27D8-ADD2-2A7D-D8855994AB43F6F3','Assistant Manager','Assists the user group manager in all things.',2,'598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223567222744,'127.0.0.1','E2480A4A-B339-4494-3DBC5369447E443E',1224177923091,'209.194.99.146',1);
/*!40000 ALTER TABLE `board_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_position_person`
--

DROP TABLE IF EXISTS `board_position_person`;
CREATE TABLE `board_position_person` (
  `board_position_id` char(35) NOT NULL default '',
  `person_id` char(35) NOT NULL default '',
  PRIMARY KEY  (`board_position_id`,`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `board_position_person`
--

LOCK TABLES `board_position_person` WRITE;
/*!40000 ALTER TABLE `board_position_person` DISABLE KEYS */;
INSERT INTO `board_position_person` VALUES ('9E5FB8D1-E317-6618-9C9C26B54AF87B90','E2480A4A-B339-4494-3DBC5369447E443E'),('E24A27D8-ADD2-2A7D-D8855994AB43F6F3','598F17EB-FB4C-FCFC-8525B1FDF43FA053');
/*!40000 ALTER TABLE `board_position_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `book_id` varchar(35) NOT NULL default '',
  `title` text NOT NULL,
  `publisher_id` varchar(35) NOT NULL default '',
  `publication_year` smallint(5) unsigned NOT NULL default '0',
  `isbn` varchar(20) NOT NULL default '',
  `num_pages` smallint(5) unsigned default NULL,
  `price` smallint(5) unsigned default NULL,
  `url` varchar(255) default NULL,
  `cover_image_small` varchar(255) default NULL,
  `cover_image_large` varchar(255) default NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `book_id` char(35) NOT NULL default '',
  `author_id` char(35) NOT NULL default '',
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
  `book_id` char(35) NOT NULL default '',
  `category_id` char(35) NOT NULL default '',
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
  `book_review_id` varchar(35) NOT NULL default '',
  `book_id` varchar(35) NOT NULL default '',
  `review` longtext NOT NULL,
  `review_date` bigint(20) unsigned NOT NULL default '0',
  `reviewer_id` varchar(35) NOT NULL default '',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `category_id` varchar(35) NOT NULL default '',
  `category` text NOT NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `country_id` varchar(35) NOT NULL default '',
  `country` text,
  `country_abbr` char(2) NOT NULL default '',
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `file_type_id` varchar(35) NOT NULL default '',
  `file_type` varchar(100) NOT NULL default '',
  `file_extension` varchar(20) NOT NULL default '',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `im_type_id` varchar(35) NOT NULL default '',
  `im_type` varchar(100) NOT NULL default '',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `location_id` varchar(35) NOT NULL default '',
  `location` varchar(250) NOT NULL default '',
  `map_link` varchar(250) default NULL,
  `description` text,
  `address_id` varchar(35) default NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES ('E241A960-DC18-6E54-4BC289132E559B5E','Produce Alliance','http://maps.google.com/maps?q=One+Vantage+Way+Suite+C-200+Nashville,+TN+37228&ie=UTF8&oe=utf-8&client=firefox-a&ll=36.193135,-86.790726&spn=0.008174,0.01884&z=16&iwloc=addr','Come to the Door near the parking lot and follow the signs.','E241A961-E669-DF8F-3A1CFCFA48404C03','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223566666080,'127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223566721179,'127.0.0.1',1),('E23CFE09-072C-E111-8CF1CBB708BF319C','Dealerskins - First Floor Auditorium','http://maps.google.com/maps?q=404+BNA+Dr.+Nashville,+TN+37217&ie=UTF8&ll=36.13713,-86.697042&spn=0.008179,0.01884&z=16&iwloc=addr','Come in and take the elevator to the bottom floor and follow the signs.','E23CFE0B-AD65-370F-D4CC9800C4DB9AF6','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223566360072,'127.0.0.1',NULL,NULL,NULL,1),('F16C60AC-C6D8-D043-A1C639C6B1F2E61F','Blackstone Brewery','http://maps.google.com/maps?hl=en&ie=UTF8&q=Blackstone+Brewing+Co&fb=1&cid=0,0,4341223915388800721&near=Nashville,+TN&cd=1&z=16&iwloc=A',NULL,'F16C60AD-B032-4734-B9660122D7E064C2','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821123756,'69.138.62.82',NULL,NULL,NULL,1),('F175D2D7-0092-EA60-1D4E8D69942543EC','Flying Saucer','http://maps.google.com/maps?ie=UTF8&oe=utf-8&client=firefox-a&q=Flying+Saucer+Nashville&fb=1&cid=0,0,13169589004936134573&z=16&iwloc=A',NULL,'F175D2D9-E27C-1BDB-36080C114F17B39E','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821742806,'69.138.62.82',NULL,NULL,NULL,1),('06BB6659-E67B-2F87-7B9F5B706E9E498E','TBD',NULL,'An unknown location for use as a placeholder until we nail down the details.','06BB665A-06B4-724F-B7F444A92A3F6D11','E2480A4A-B339-4494-3DBC5369447E443E',1224178624089,'209.194.99.146','E2480A4A-B339-4494-3DBC5369447E443E',1224178843330,'209.194.99.146',1);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
CREATE TABLE `meeting` (
  `meeting_id` varchar(35) NOT NULL default '',
  `title` text NOT NULL,
  `description` text,
  `dt_meeting` bigint(20) unsigned NOT NULL default '0',
  `location_id` varchar(35) NOT NULL default '',
  `connect_url` varchar(255) default NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`meeting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES ('E2471CC4-908C-DFB9-E4CA9EA53B0577A9','Introduction to jQuery for the ColdFusion Developer','<p>Been wanting to learn jQuery but didn\'t know where to start? We will cover the basics and give you an idea where to start.</p>\r\n<p><em>Learning jQuery</em> by Karl Swedberg ($40 value)<br/>\r\n<em>jQuery reference guide</em> by Karl Swedberg ($40 value)<br/>\r\nBig thanks to Packt Publishing for these books!</p>\r\n<p><img src=\"http://www.ncfug.com/skins/ncfug/images/nin.jpg\" border=\"0\"/></p>\r\n<p><strong>This just in!</strong><br/>\r\nVaco Technology will be giving away 2 tickets (winner plus a guest) to the Nine Inch Nails concert on Halloween!! The winner and one guest will be in a luxury suite directly above the stage. The suite includes an open bar, food, flat screen TV, private restroom etc. This is quite an awesome giveaway so be sure and show up in person to be eligible to win!</p>\r\n<p><strong>PRESENTATION:</strong><br />\r\nIntroduction to jQuery for the ColdFusion developer</p>\r\n<p>J.J. Merrick will give an introduction to jQuery and show some code demonstrations.</p>\r\n<p><strong>SPEAKER BIO:</strong><br />\r\nJ.J. currently works as a ColdFusion developer with almost 10 years of development under his belt. He specializes in UI design and Customer experience. Past projects include managing a CMS/Web Builder for Churches, a loyalty shopping system for non-profits and Back office systems for Multi-Level Marketing companies. He currently works for Otis Technologies in Brentwood, TN where he is a product developer managing an Ordering system for a Big Box retailer and a &ldquo;Prosumer&rdquo; project management application called SpotOn! (http://www.spotonpm.com) He recently acquired eChurchOnline.com from a previous partner and is working on growing that company in his spare time. He resides in Nolensville, TN with his wife Elaine and 3 children; Hannah, River, and Evan.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>SPONSOR INFO:</strong><br />\r\nThis meeting is sponsored by Dealerskins (<a mce_href=\"http://www.dealerskins.com/\" href=\"http://www.dealerskins.com/\">http://www.dealerskins.com</a>) and Vaco Technology (<a mce_href=\"http://www.vacotechnology.com/\" href=\"http://www.vacotechnology.com/\">http://www.vacotechnology.com</a>). We thank them for their support. Food and drinks will be provided.</p>',1224802800000,'E241A960-DC18-6E54-4BC289132E559B5E','http://mmusergroup.adobe.acrobat.com/ncfug/','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223567023299,'127.0.0.1','E2480A4A-B339-4494-3DBC5369447E443E',1224258323279,'209.194.99.146',1),('F16E657F-D8AB-3E3A-B4324C465651B618','CF_LUNCH - October Edition','<p>Join us for a laid back lunch to talk about all things tech and current events. RSVP to let us know if you are going to be there so we can get a table ahead.</p>',1225299600000,'F16C60AC-C6D8-D043-A1C639C6B1F2E61F','','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821256063,'69.138.62.82','E2480A4A-B339-4494-3DBC5369447E443E',1224178516971,'209.194.99.146',1),('F170803F-A8E8-660C-3B798DAD76617A69','NCFUG Christmas Party','<p>Save the date! We haven\'t made a final decision on location but we\'re thinking of having this at Bosco\'s in downtown Nashville. If you have a different suggestion, please submit it in our Contact Us form.</p>',1229043600000,'06BB6659-E67B-2F87-7B9F5B706E9E498E','','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821393983,'69.138.62.82','E2480A4A-B339-4494-3DBC5369447E443E',1224282267215,'75.200.250.243',1),('F178CB46-AE47-D9C2-9359BFDA7651BA18','CF_BEER - January Edition','<p>Join us for a couple of beers at one of Nashville favorite draught emporium. With over 100 beers on tap you can surely find one you like!</p>',1231979400000,'F175D2D7-0092-EA60-1D4E8D69942543EC','','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821937477,'69.138.62.82',NULL,NULL,NULL,1),('F179A74F-A20D-C03A-1C47F32658BB4F06','CF_LUNCH - February Edition','<p>Join us for lunch to talk all things technology!</p>',1234375200000,'F16C60AC-C6D8-D043-A1C639C6B1F2E61F','','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223821993806,'69.138.62.82','E2480A4A-B339-4494-3DBC5369447E443E',1224178470101,'209.194.99.146',1);
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_presentation`
--

DROP TABLE IF EXISTS `meeting_presentation`;
CREATE TABLE `meeting_presentation` (
  `meeting_id` char(35) NOT NULL default '',
  `presentation_id` char(35) NOT NULL default '',
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
  `news_id` varchar(35) NOT NULL default '',
  `headline` text NOT NULL,
  `body` longtext NOT NULL,
  `dt_to_post` bigint(20) unsigned NOT NULL default '0',
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`news_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES ('E2383E86-D20E-D0ED-5D2384CDB026B3C3','Welcome Your New Assistant Manager!','<p><br />\r\nNearly two months ago I e-mailed the group announcing Adobe\'s decision to require assistant user group managers at every user group worldwide. I gave brief information about the how the role would be structured in our group and asked for volunteers. A few people contacted me and I met with each to discuss their ideas and the responsibility and commitment level associated with the role.\r\n<br /><br />\r\nThose meetings were very beneficial to me as each person had some fantastic ideas about how to grow our user group and reach people in the Web community. I made a decision based not only on those meetings but also my experience with each potential assistant manager for the past 4+ years. <br /><br />\r\n<img src=\"http://www.ncfug.com/skins/ncfug/images/jjmerrick.jpg\" border=\"0\"/><br/>J.J. Merrick\r\n<br/><br/>\r\nI\'m delighted to announce that J.J. Merrick is our first official (with Adobe anyway) assistant user group manager. J.J. has supported the Nashville CF User Group for as long as I\'ve been apart of it. He has helped the group in many ways over the years including: organizing meetings and events, gathering sponsors, offering ideas, attending most meetings, hosting a Subversion repository, and hosting our current e-mail lists to name a few.\r\n<br /><br />\r\nI\'m excited to increase J.J.\'s commitment to our group and I know he will do great things. He will work with me to arrange speakers and sponsors, run meetings, keep up with attendance and giveaways (some new processes coming in this regard), organize events, help in the creation of a new Web site and otherwise represent the Nashville CF community in an official capacity with Adobe. 			<br /><br />\r\nExciting times are ahead. Please join me in welcoming J.J. into his new role!\r\n<br /><br />\r\nposted by <strong>Aaron West</strong></p>',1222442820000,'598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223566048902,'127.0.0.1','E2480A4A-B339-4494-3DBC5369447E443E',1224186422357,'209.194.99.146',1),('07876921-9A0A-C748-B5F4C4D2771267BA','After Five Years We Have a New Site!!','I am completely, unbelievably, indubitably, fantastically excited to announce and SHOW you the brand-spanking new Nashville ColdFusion User Group Web site!!\r\n<br/><br/>\r\nLaunching a new Web site has been \"in the works\" in one way or another for over two years. Not long after I took over the group from Tony Bradshaw (January 2005) we all decided it was time for a new Web site and thus started a journey that took much longer than anyone anticipated.  In some ways it\'s embarrassing how we didn\'t buckle down and just get the job done. But when I think of all the things that have taken place over the last three years, from the babies, job changes, contract and consultant work many of us do etc., I\'m not too surprised. And after spending most of my waking hours over the last week working on the new site with J.J., I\'m even less surprised.\r\n<br/><br/>\r\nNevertheless, it\'s here and I\'m very pleased with the results. The look and feel of the site are quite nice (in my opinion) but so are the features. We\'re using the <a href=\"http://code.google.com/p/chug/\" target=\"_blank\">Captial Hill User Group (CHUG) application</a> originally built by Matt Woodward. The application is open source and built on top of ColdFusion, Mach-ii, and ColdSpring. What more could you ask for from a group of ColdFusion fanatics? The CHUG app is pretty good out of the box, but we\'ve made some strong enhancements to it\'s functionality and have built it on top of the latest Mach-ii version (1.6.x beta) and ColdFusion 8 Enterprise. What else has changed? We\'ve moved from <a href=\"http://www.cfdynamics.com\" target=\"_blank\">CFDynamics</a>, a hosting company that has served us very well for the last three years, to a Virtual Private Server hosted at <a href=\"http://www.viviotech.net/hosting_vps.cfm\" target=\"_blank\">Viviotech</a>. The site now runs on top of CentOS Linux, Apache 2, and of course ColdFusion 8 Enterprise. The flexibility, control, and management features we have through a VPS mean the sky is limit in how we progress the site.\r\n<br/><br/>\r\nToday, we\'re rolling the site out with a set of basic user group management features, many of which are built right into CHUG. Meetings are databased and tied to specific meeting locations we manage, and there\'s an RSVP system for members. Gone are the days of sending RSVP e-mails! There\'s a News section for posting things such as this site announcement, an Articles section for blog-like postings, a Board page for listing user group leaders, and a Contact Us page so folks can get in touch with us easily. There are a dozen or so other features built-in to CHUG that we almost have complete and ready for release too. If that weren\'t enough, we architecting our own features into CHUG such as blog aggregation, member bios/photos, sponsors page, and a ColdFusion resources page. All of these features have been started code-wise or are documented in a Google doc shared between user leaders.\r\n<br/><br/>\r\nWhat\'s next for us? In addition to a new Web site and all the content and features it contains, we\'ve created a few new events to help promote the user group and the Nashville Internet community, as well as create more opportunities for social interaction among members. We\'re kicking off the first of these events, a CF_LUNCH, this month at Blackstone. Next month, we\'re all meeting up for some CF_BEER at \"the saucer\" (Flying Saucer). Both events should be loads of fun and I encourage everyone to RSVP on the Meetings page. With these new events rotating every other month and the official monthly meeting, you have two opportunities to get involved each month. So get off your couch, put down the bon-bon\'s and remote, and come out to these events to meet other developers and further your own career!\r\n<br/><br/>\r\nI want to say what a privilege and and honor it has been to serve you and the ColdFusion/Internet community in Nashville for the last three years. I\'m so thankful for the familiar faces at each monthly event and the new faces that show up from time to time. We have a great user group and I\'m looking forward to the future!\r\n<br/><br/>\r\nLastly, huge kudos are due Tony Bradshaw and company for setting up our old site that served us well for such a long time. Thanks also to CFDynamics for hosting our site for the last three years and for Jim Rising for hosting it before that. To Andy and Cutter for smacking me around and motivating me to keep working on the site, thanks. To J.J., dude, you rock! You sparked the development flame when you downloaded the CHUG app and now it\'s a raging fire. Thanks for volunteering for the assistant manager role and for being so instrumental in the success of this group.\r\n<br/><br/>\r\nTo everyone else, I\'ll see you at the next event!\r\n<br/><br/>\r\nCheers!\r\n<br/><br/>\r\nposted by <strong>Aaron West</strong>',1224217260000,'E2480A4A-B339-4494-3DBC5369447E443E',1224191994145,'209.194.99.146','E2480A4A-B339-4494-3DBC5369447E443E',1224218288296,'69.243.202.7',1);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `organization_id` varchar(35) NOT NULL default '',
  `organization` text NOT NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(35) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`organization_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('E2372D78-C36E-F82B-26C8DAEF02E35E3A','Otis Technologies, LLC','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223565978999,'127.0.0.1',NULL,NULL,NULL,1),('E2374D22-CB6A-F1AD-2FA3359837D88546','DealerSkins','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223565987106,'127.0.0.1',NULL,NULL,NULL,1),('E23771A1-D68E-E62A-526243CA4C5AA677','Lampo (Dave Ramsey)','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223565996448,'127.0.0.1',NULL,NULL,NULL,1),('E2379078-DF0B-FD51-C6090073B75A5A6C','Kroll','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223566004344,'127.0.0.1',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `person_id` varchar(35) NOT NULL default '',
  `first_name` varchar(250) NOT NULL default '',
  `last_name` varchar(250) NOT NULL default '',
  `title` varchar(250) NOT NULL default '',
  `organization_id` varchar(35) default NULL,
  `phone` varchar(50) default NULL,
  `email` varchar(250) NOT NULL default '',
  `url` varchar(255) default NULL,
  `image` varchar(255) default NULL,
  `password` varchar(50) default NULL,
  `is_admin` tinyint(3) unsigned default NULL,
  `role_id` varchar(35) default NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  `bio` text,
  PRIMARY KEY  (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','J.J.','Merrick','Co-Manager',NULL,'615-414-4671','jay@cyber-jay.com','http://jeremiahx.com','jmerrick-128.jpg','brother6',1,'98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053',2007,'127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223565958446,'127.0.0.1',1,NULL),('E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','Manager','E2374D22-CB6A-F1AD-2FA3359837D88546','615.708.4552','a.west@me.com','http://www.aaronwest.net','AaronWest_03_05_08_150.jpg','abc123',1,'98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223567084104,'127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1223926294254,'69.138.62.82',1,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
CREATE TABLE `person_address` (
  `person_id` char(35) NOT NULL default '',
  `address_id` char(35) NOT NULL default '',
  PRIMARY KEY  (`person_id`,`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
INSERT INTO `person_address` VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','E236DD4A-9D6D-A86B-E25841FDE2376A87'),('E2480A4A-B339-4494-3DBC5369447E443E','E2480A50-B22F-19EF-286009BC28F9B3AB');
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_im`
--

DROP TABLE IF EXISTS `person_im`;
CREATE TABLE `person_im` (
  `person_id` varchar(35) NOT NULL default '',
  `im_type_id` varchar(35) NOT NULL default '',
  `im_handle` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`person_id`,`im_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person_im`
--

LOCK TABLES `person_im` WRITE;
/*!40000 ALTER TABLE `person_im` DISABLE KEYS */;
INSERT INTO `person_im` VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941B9C87-F160-F341-8FEA5A07E4AFB150','jj@themerrickhouse.com'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','jjmerrick'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940B01D1-FEEB-DC29-F2F26E44522032D0','cyber_jay2001'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','93F032CD-9872-2C0C-0776C3B2CD417D9E','jayrick99'),('993700D0-C25C-213F-C3F38E7A533AEB88','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','mpwoodward'),('993700D0-C25C-213F-C3F38E7A533AEB88','941B9C87-F160-F341-8FEA5A07E4AFB150','mpwoodward@gmail.com'),('993700D0-C25C-213F-C3F38E7A533AEB88','940B01D1-FEEB-DC29-F2F26E44522032D0','mpwoodward2'),('993700D0-C25C-213F-C3F38E7A533AEB88','941BC4FC-DF44-CD14-B25D64FAA6E22129','mpwoodward@hotmail.com'),('993700D0-C25C-213F-C3F38E7A533AEB88','93F032CD-9872-2C0C-0776C3B2CD417D9E','CaptainJavac'),('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941BC4FC-DF44-CD14-B25D64FAA6E22129','jay@cyber-jay.com');
/*!40000 ALTER TABLE `person_im` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photo_id` varchar(35) NOT NULL default '',
  `title` varchar(250) NOT NULL default '',
  `caption` text,
  `file_name` text NOT NULL,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `photo_album_id` varchar(35) NOT NULL default '',
  `title` varchar(250) NOT NULL default '',
  `description` text,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `photo_album_id` char(35) NOT NULL default '',
  `photo_id` char(35) NOT NULL default '',
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
  `presentation_id` varchar(35) NOT NULL default '',
  `title` text NOT NULL,
  `summary` text,
  `presentation_file` varchar(250) default NULL,
  `presentation_file_title` varchar(250) default NULL,
  `presentation_file_description` text,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presentation`
--

LOCK TABLES `presentation` WRITE;
/*!40000 ALTER TABLE `presentation` DISABLE KEYS */;
/*!40000 ALTER TABLE `presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentation_presenter`
--

DROP TABLE IF EXISTS `presentation_presenter`;
CREATE TABLE `presentation_presenter` (
  `presentation_id` char(35) NOT NULL default '',
  `presenter_id` char(35) NOT NULL default '',
  PRIMARY KEY  (`presentation_id`,`presenter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `presentation_presenter`
--

LOCK TABLES `presentation_presenter` WRITE;
/*!40000 ALTER TABLE `presentation_presenter` DISABLE KEYS */;
/*!40000 ALTER TABLE `presentation_presenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` varchar(35) NOT NULL default '',
  `role` varchar(100) NOT NULL default '',
  `description` text,
  `created_by_id` varchar(35) NOT NULL default '',
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
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
  `rsvp_id` varchar(35) NOT NULL default '',
  `meeting_id` varchar(35) NOT NULL default '',
  `person_id` varchar(35) default NULL,
  `first_name` varchar(100) NOT NULL default '',
  `last_name` varchar(100) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `comments` text,
  `created_by_id` varchar(35) default NULL,
  `dt_created` bigint(20) unsigned NOT NULL default '0',
  `ip_created` varchar(15) NOT NULL default '',
  `modified_by_id` varchar(35) default NULL,
  `dt_modified` bigint(20) unsigned default NULL,
  `ip_modified` varchar(15) default NULL,
  `is_active` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`rsvp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rsvp`
--

LOCK TABLES `rsvp` WRITE;
/*!40000 ALTER TABLE `rsvp` DISABLE KEYS */;
INSERT INTO `rsvp` VALUES ('E2523EE2-CEEF-BA23-ED8BF040A22259AD','E2471CC4-908C-DFB9-E4CA9EA53B0577A9','598F17EB-FB4C-FCFC-8525B1FDF43FA053','J.J.','Merrick','jay@cyber-jay.com','Test','',0,'',NULL,NULL,NULL,1),('F760A33C-D6ED-5BEF-B4FBCF967DC26941','E2471CC4-908C-DFB9-E4CA9EA53B0577A9',NULL,'Cutter','Blades','no.junk@cutterscrossing.com','I\'ll be there','',0,'',NULL,NULL,NULL,1),('F9AEF468-C890-6BCC-B2550D085B6111A7','','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','Man these form input boxes are tiny (height-wise).asdf','',0,'','',0,'',1),('F9B0D682-DE55-1B74-D4EABF41624DE7CC','F16E657F-D8AB-3E3A-B4324C465651B618','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','I\'m down.','',0,'',NULL,NULL,NULL,1),('F9B161C3-9653-0F1E-D8E29D4361FCA3AD','F170803F-A8E8-660C-3B798DAD76617A69','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','I\'m there. With bells on.','',0,'',NULL,NULL,NULL,1),('F9B1CD41-DA76-4059-8BB487BC7F72B208','F178CB46-AE47-D9C2-9359BFDA7651BA18','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','I love the saucer!','',0,'',NULL,NULL,NULL,1),('0256F384-DDFC-5D0D-F61425779FFF7CFA','index',NULL,'','','',NULL,'',0,'',NULL,NULL,NULL,1),('0459BCDF-FA1E-1117-003501000F6CAB79','','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','I\'m there.ert','',0,'','',0,'',1),('0A7046D1-B196-C398-36CBC45B07F99B14','F16E657F-D8AB-3E3A-B4324C465651B618','598F17EB-FB4C-FCFC-8525B1FDF43FA053','J.J.','Merrick','jay@cyber-jay.com','I\'ll be there!','',0,'',NULL,NULL,NULL,1),('0B052068-FC55-DA0E-6758F99EF5483C9B','E2471CC4-908C-DFB9-E4CA9EA53B0577A9',NULL,'Paul','stewart','paul.stew@gmail.com',NULL,'',0,'',NULL,NULL,NULL,1),('045FD197-04D6-DD95-56B5EF41D4824ABF','E2471CC4-908C-DFB9-E4CA9EA53B0577A9','E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','a.west@me.com','I\'m there.','',0,'',NULL,NULL,NULL,1),('0B2202CC-C5E6-B513-20FD9087F9F23860','F16E657F-D8AB-3E3A-B4324C465651B618',NULL,'Brett','Davis','dev@bsmuv.com','Can we discuss the features of the new <cfbeer> tag?','',0,'',NULL,NULL,NULL,1),('0B6EC4F1-FC88-9959-598E58B62541EB52','E2471CC4-908C-DFB9-E4CA9EA53B0577A9',NULL,'Scott','Gordon','sgordon@vaco.com',NULL,'',0,'',NULL,NULL,NULL,1),('0B7317DC-CBB6-AD01-8B49D466DBD75B6A','E2471CC4-908C-DFB9-E4CA9EA53B0577A9',NULL,'Shawn','Oden','shawnoden@gmail.com',NULL,'',0,'',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `rsvp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `state_id` varchar(35) NOT NULL default '',
  `state` varchar(50) NOT NULL default '',
  `state_abbr` char(2) NOT NULL default '',
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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

