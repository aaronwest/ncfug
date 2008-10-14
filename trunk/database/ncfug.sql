SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;

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

insert into `address` values('E236DD4A-9D6D-A86B-E25841FDE2376A87','5543 Edmondson Pike','Suite 116','Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37211','US','','0','',null,null,null,'1'),
 ('E23CFE0B-AD65-370F-D4CC9800C4DB9AF6','404 BNA Drive',null,'Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37217','','','0','',null,null,null,'0'),
 ('E241A961-E669-DF8F-3A1CFCFA48404C03',' One Vantage Way',' Suite C-200','Nashville','C1F5D060-9683-C53A-0E5E81F501BF4796','37228 ','','','0','',null,'0',null,'0'),
 ('E2480A50-B22F-19EF-286009BC28F9B3AB','',null,'',null,null,'','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567084104','127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567199800','127.0.0.1','1');

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


CREATE TABLE `article_author` (
  `article_id` char(35) NOT NULL,
  `author_id` char(35) NOT NULL,
  PRIMARY KEY  (`article_id`,`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE `article_category` (
  `article_id` char(35) NOT NULL,
  `category_id` char(35) NOT NULL,
  PRIMARY KEY  (`article_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


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

insert into `board_position` values('9E5FB8D1-E317-6618-9C9C26B54AF87B90','Manager','UG Manager','1','993700D0-C25C-213F-C3F38E7A533AEB88','1170888177873','156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88','1170888269805','156.33.114.155','1'),
 ('9E69E14F-A2FE-570D-B09755CE1BB9EDF4','Meeting Content','Person responsible for speakers and meeting content','2','993700D0-C25C-213F-C3F38E7A533AEB88','1170888843596','156.33.114.155',null,null,null,'1'),
 ('9E6A79C3-900F-1F4D-F4AEE6A8102110DD','Publicity and Membership','Person responsible for publicizing the group and meetings, and recruiting and retaining members','3','993700D0-C25C-213F-C3F38E7A533AEB88','1170888882627','156.33.114.155',null,null,null,'1'),
 ('E24A27D8-ADD2-2A7D-D8855994AB43F6F3','Co-Manager',null,'2','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567222744','127.0.0.1',null,null,null,'1');

CREATE TABLE `board_position_person` (
  `board_position_id` char(35) NOT NULL,
  `person_id` char(35) NOT NULL,
  PRIMARY KEY  (`board_position_id`,`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `board_position_person` values('9E5FB8D1-E317-6618-9C9C26B54AF87B90','E2480A4A-B339-4494-3DBC5369447E443E'),
 ('E24A27D8-ADD2-2A7D-D8855994AB43F6F3','598F17EB-FB4C-FCFC-8525B1FDF43FA053');

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


CREATE TABLE `book_author` (
  `book_id` char(35) NOT NULL,
  `author_id` char(35) NOT NULL,
  PRIMARY KEY  (`book_id`,`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


CREATE TABLE `book_category` (
  `book_id` char(35) NOT NULL,
  `category_id` char(35) NOT NULL,
  PRIMARY KEY  (`book_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


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

insert into `category` values('26BFCADF-0A33-6FFF-1ADD6B5B98948EC2','New Category','993700D0-C25C-213F-C3F38E7A533AEB88','1181766109918','127.0.0.1',null,null,null,'1');

CREATE TABLE `country` (
  `country_id` char(35) NOT NULL,
  `country` varchar(500) default NULL,
  `country_abbr` char(2) NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


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

insert into `im_type` values('940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','Skype','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170714842070','156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170715920039','156.33.114.155','1'),
 ('940B01D1-FEEB-DC29-F2F26E44522032D0','Yahoo!','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170714853840','156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170715959105','156.33.114.155','1'),
 ('93F032CD-9872-2C0C-0776C3B2CD417D9E','AOL','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170713096909','156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88','1171490593866','156.33.114.155','1'),
 ('941B9C87-F160-F341-8FEA5A07E4AFB150','Google Talk','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170715942023','156.33.114.155',null,null,null,'1'),
 ('941BC4FC-DF44-CD14-B25D64FAA6E22129','MSN','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170715952378','156.33.114.155',null,null,null,'1');

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

insert into `location` values('E241A960-DC18-6E54-4BC289132E559B5E','Produce Alliance','http://maps.google.com/maps?q=One+Vantage+Way+Suite+C-200+Nashville,+TN+37228&ie=UTF8&oe=utf-8&client=firefox-a&ll=36.193135,-86.790726&spn=0.008174,0.01884&z=16&iwloc=addr','Come to the Door near the parking lot and follow the signs.','E241A961-E669-DF8F-3A1CFCFA48404C03','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223566666080','127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223566721179','127.0.0.1','1'),
 ('E23CFE09-072C-E111-8CF1CBB708BF319C','Dealerskins - First Floor Auditorium','http://maps.google.com/maps?q=404+BNA+Dr.+Nashville,+TN+37217&ie=UTF8&ll=36.13713,-86.697042&spn=0.008179,0.01884&z=16&iwloc=addr','Come in and take the elevator to the bottom floor and follow the signs.','E23CFE0B-AD65-370F-D4CC9800C4DB9AF6','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223566360072','127.0.0.1',null,null,null,'1');

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

insert into `meeting` values('E2471CC4-908C-DFB9-E4CA9EA53B0577A9','Introduction to jQuery for the ColdFusion Developer','<p>Been wanting to learn jQuery but didn\'t know where to start? We will cover the basics and give you an idea where to start.</p>\r\n<p>&nbsp;</p>\r\n<p>Great giveaways including 2 books worth $40 each:</p>\r\n<p>Learning jQuery by Karl Swedberg and jQuery reference guide by Karl Swedberg. Big thanks to Packt Publishing!</p>','1224802800000','E241A960-DC18-6E54-4BC289132E559B5E','','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567023299','127.0.0.1',null,null,null,'1');

CREATE TABLE `meeting_presentation` (
  `meeting_id` char(35) NOT NULL,
  `presentation_id` char(35) NOT NULL,
  PRIMARY KEY  (`meeting_id`,`presentation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `meeting_presentation` values('21686DFF-933A-2568-420CC50C07FE2492','216816A2-FFB5-05EF-C204DA18B2B2F2DC'),
 ('EA3F4A1F-AFF2-FAE5-3F82FE27EB4508F1','EA4AD032-B8E6-D9E2-E7B378CE1E5DC80E'),
 ('EB97E219-CEAD-DA48-A8EFB0AF8F35B9C6','EA4A7F9E-D040-F6BC-E18191D762036B79');

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

insert into `news` values('E2383E86-D20E-D0ED-5D2384CDB026B3C3','Welcome New Co-Manager!','<p><br />\r\nNearly two months ago I e-mailed the group announcing Adobe\'s decision to require 			assistant user group managers at every user group worldwide. I gave brief information 			about the how the role would be structured in our group and asked for volunteers. A 			few people contacted me and I met with each to discuss their ideas and the responsibility 			and commitment level associated with the role. 			<br />\r\n<br />\r\nThose meetings were very beneficial to me as each person had some fantastic ideas 			about how to grow our user group and reach people in the Web community. I made a 			decision based not only on those meetings but also my experience with each potential 			assistant manager for the past 4+ years. 			<br />\r\n<br />\r\nI\'m delighted to announce that J.J. Merrick is our first official (with Adobe anyway) 			assistant user group manager. J.J. has supported the Nashville CF User Group for 			as long as I\'ve been apart of it. He has helped the group in many ways over the years 			including: organizing meetings and events, gathering sponsors, offering ideas, attending 			most meetings, hosting a Subversion repository, and hosting our current e-mail lists to 			name a few. 			<br />\r\n<br />\r\nI\'m excited to increase J.J.\'s commitment to our group and I know he will do great things. 			He will work with me to arrange speakers and sponsors, run meetings, keep up with 			attendance and giveaways (some new processes coming in this regard), organize events, 			help in the creation of a new Web site and otherwise represent the Nashville CF community 			in an official capacity with Adobe. 			<br />\r\n<br />\r\nExciting times are ahead. Please join me in welcoming J.J. into his new role! 			<br />\r\n<br />\r\nposted by <strong>Aaron West</strong></p>','1223566020000','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223566048902','127.0.0.1',null,null,null,'1');

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

insert into `organization` values('E2372D78-C36E-F82B-26C8DAEF02E35E3A','Otis Technologies, LLC','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223565978999','127.0.0.1',null,null,null,'1'),
 ('E2374D22-CB6A-F1AD-2FA3359837D88546','DealerSkins','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223565987106','127.0.0.1',null,null,null,'1'),
 ('E23771A1-D68E-E62A-526243CA4C5AA677','Lampo (Dave Ramsey)','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223565996448','127.0.0.1',null,null,null,'1'),
 ('E2379078-DF0B-FD51-C6090073B75A5A6C','Kroll','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223566004344','127.0.0.1',null,null,null,'1');

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
  `bio` text,
  PRIMARY KEY  (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `person` values('598F17EB-FB4C-FCFC-8525B1FDF43FA053','J.J.','Merrick','Co-Manager',null,'615-414-4671','jay@cyber-jay.com','http://jeremiahx.com','jmerrick-128.jpg','brother6','1','98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053','2007','127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223565958446','127.0.0.1','1',null),
 ('E2480A4A-B339-4494-3DBC5369447E443E','Aaron','West','Manager','E2374D22-CB6A-F1AD-2FA3359837D88546',null,'a.west@me.com','http://aaronwest.net',null,'temp1234','1','98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567084104','127.0.0.1','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1223567199800','127.0.0.1','1',null);

CREATE TABLE `person_address` (
  `person_id` char(35) NOT NULL,
  `address_id` char(35) NOT NULL,
  PRIMARY KEY  (`person_id`,`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `person_address` values('598F17EB-FB4C-FCFC-8525B1FDF43FA053','E236DD4A-9D6D-A86B-E25841FDE2376A87'),
 ('E2480A4A-B339-4494-3DBC5369447E443E','E2480A50-B22F-19EF-286009BC28F9B3AB');

CREATE TABLE `person_im` (
  `person_id` char(35) NOT NULL,
  `im_type_id` char(35) NOT NULL,
  `im_handle` varchar(100) NOT NULL,
  PRIMARY KEY  (`person_id`,`im_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `person_im` values('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941B9C87-F160-F341-8FEA5A07E4AFB150','jj@themerrickhouse.com'),
 ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','jjmerrick'),
 ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940B01D1-FEEB-DC29-F2F26E44522032D0','cyber_jay2001'),
 ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','93F032CD-9872-2C0C-0776C3B2CD417D9E','jayrick99'),
 ('993700D0-C25C-213F-C3F38E7A533AEB88','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','mpwoodward'),
 ('993700D0-C25C-213F-C3F38E7A533AEB88','941B9C87-F160-F341-8FEA5A07E4AFB150','mpwoodward@gmail.com'),
 ('993700D0-C25C-213F-C3F38E7A533AEB88','940B01D1-FEEB-DC29-F2F26E44522032D0','mpwoodward2'),
 ('993700D0-C25C-213F-C3F38E7A533AEB88','941BC4FC-DF44-CD14-B25D64FAA6E22129','mpwoodward@hotmail.com'),
 ('993700D0-C25C-213F-C3F38E7A533AEB88','93F032CD-9872-2C0C-0776C3B2CD417D9E','CaptainJavac'),
 ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941BC4FC-DF44-CD14-B25D64FAA6E22129','jay@cyber-jay.com');

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


CREATE TABLE `photo_album_photo` (
  `photo_album_id` char(35) NOT NULL,
  `photo_id` char(35) NOT NULL,
  PRIMARY KEY  (`photo_album_id`,`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


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


CREATE TABLE `presentation_presenter` (
  `presentation_id` char(35) NOT NULL,
  `presenter_id` char(35) NOT NULL,
  PRIMARY KEY  (`presentation_id`,`presenter_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


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

insert into `role` values('98C49505-0610-4F47-B7E2535E5BC75934','Member','User Group Member','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170794124549','156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170794502025','156.33.114.155','1'),
 ('98CAA920-F976-92DA-1E46FB2C500556CC','Presenter','Non-Member Presenter','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170794522912','156.33.114.155',null,null,null,'1'),
 ('98CF6629-DF39-BD9D-8F95BE845916D0B5','Sponsor','Sponsor','598F17EB-FB4C-FCFC-8525B1FDF43FA053','1170794833449','156.33.114.155',null,null,null,'1');

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

insert into `rsvp` values('E2523EE2-CEEF-BA23-ED8BF040A22259AD','E2471CC4-908C-DFB9-E4CA9EA53B0577A9','598F17EB-FB4C-FCFC-8525B1FDF43FA053','J.J.','Merrick','jay@cyber-jay.com','Test','','0','',null,null,null,'1');

CREATE TABLE `state` (
  `state_id` char(35) NOT NULL,
  `state` varchar(50) NOT NULL,
  `state_abbr` char(2) NOT NULL,
  PRIMARY KEY  (`state_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

insert into `state` values('C1F5D036-FBA0-AC33-30DFD83ECBD754F7','Alabama','AL'),
 ('C1F5D037-E5D4-EBA7-BC0FA1191C1FA222','Alaska','AK'),
 ('C1F5D038-06B7-BA21-68CD4E18A0EDA5A7','Arizona','AZ'),
 ('C1F5D039-BB26-0CB7-6B60FC81C144FA8F','Arkansas','AR'),
 ('C1F5D03A-EA1F-F33E-64FBE4837506885F','California','CA'),
 ('C1F5D03B-D8E3-2B02-9C8496EF7ACEF62D','Colorado','CO'),
 ('C1F5D03C-EAA5-876B-45D91B7719C17BFE','Connecticut','CT'),
 ('C1F5D03D-036C-353C-FF37CE9DB95CC177','Delaware','DE'),
 ('C1F5D03E-CCC0-947D-9DC1CDA49819FD33','District of Columbia','DC'),
 ('C1F5D03F-F195-C3D9-6D4859EA559392CA','Florida','FL'),
 ('C1F5D040-DE7F-202D-30FA138DCC7A30CC','Georgia','GA'),
 ('C1F5D041-F012-A2FE-09F32A51F589C27B','Hawaii','HI'),
 ('C1F5D042-C8BC-522C-FC79B916F792EB42','Idaho','ID'),
 ('C1F5D043-9860-67FC-30B8B08BB24978C2','Illinois','IL'),
 ('C1F5D044-A344-3CCD-851DBFF07FEB4AD1','Indiana','IN'),
 ('C1F5D045-A9E0-B5A9-936AB7A3DF118BC0','Iowa','IA'),
 ('C1F5D046-CC23-8DE6-BBDEB5C8879B1995','Kansas','KS'),
 ('C1F5D047-FBDB-3E95-F149E8B586E29507','Kentucky','KY'),
 ('C1F5D048-B6C2-5C5B-F916BB063EC5CEE8','Louisiana','LA'),
 ('C1F5D049-D489-578A-04A9B5232E66D9BB','Maine','ME'),
 ('C1F5D04A-C342-4497-232D8D96F3AC7199','Maryland','MD'),
 ('C1F5D04B-BBB7-6329-8C21D3A4CD63E695','Massachusetts','MA'),
 ('C1F5D04C-01D0-B2CF-A6E38AE9C41DA312','Michigan','MI'),
 ('C1F5D04D-F882-E823-B2A3E08965BED7A1','Minnesota','MN'),
 ('C1F5D04E-B2DB-4A83-9CB9FC2850AE5799','Mississippi','MS'),
 ('C1F5D04F-CFD6-3DDD-621FBBE18F22974E','Missouri','MO'),
 ('C1F5D050-F757-B052-C963B6867A0304FF','Montana','MT'),
 ('C1F5D051-00F2-ABD4-6C6A587D2E110E97','Nebraska','NE'),
 ('C1F5D052-DA83-337E-A353B39A60E86B37','Nevada','NV'),
 ('C1F5D053-9460-2CA3-8B795D9FFB74706C','New Hampshire','NH'),
 ('C1F5D054-D727-EE6A-11FFF8C5F848CD53','New Jersey','NJ'),
 ('C1F5D055-FAF5-BBF6-AEEAC71DE6765D6C','New Mexico','NM'),
 ('C1F5D056-E36D-3E3D-01598825C287155B','New York','NY'),
 ('C1F5D057-CF98-85E5-35D1FF9326DFA858','North Carolina','NC'),
 ('C1F5D058-CBDE-E0DC-2B151CF2A0C18E48','North Dakota','ND'),
 ('C1F5D059-B689-A31B-14A54ECF18B506D2','Ohio','OH'),
 ('C1F5D05A-D565-6CDE-408208858E1D521E','Oklahoma','OK'),
 ('C1F5D05B-F33E-E956-6ABACD5303E941A2','Oregon','OR'),
 ('C1F5D05C-004E-3EA1-1F9F58147BC34A7D','Pennsylvania','PA'),
 ('C1F5D05D-09BB-5C15-4B01433D9245E98A','Rhode Island','RI'),
 ('C1F5D05E-A2DF-5A05-2FA25E4431C635ED','South Carolina','SC'),
 ('C1F5D05F-FA6D-E8CC-163FF44BCA49DB1A','South Dakota','SD'),
 ('C1F5D060-9683-C53A-0E5E81F501BF4796','Tennessee','TN'),
 ('C1F5D061-BF35-AA81-7776805AC236C0FF','Texas','TX'),
 ('C1F5D062-98F2-7B8A-C80E2EB0B5659334','Utah','UT'),
 ('C1F5D063-EA74-5D1F-097C875504EE01E5','Vermont','VT'),
 ('C1F5D064-CC73-7518-3F11E86931025847','Virginia','VA'),
 ('C1F5D065-A37F-0FD6-06EF9862797D4E44','Washington','WA'),
 ('C1F5D066-D062-9414-94E8EAD5E20E6B24','West Virginia','WV'),
 ('C1F5D067-DAE1-D63B-B0AE570AC815E554','Wisconsin','WI'),
 ('C1F5D068-040D-DE21-490A9C8C975574FE','Wyoming','WY');

SET FOREIGN_KEY_CHECKS = 1;
