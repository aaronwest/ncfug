-- table [dbo].[address]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[address]') AND type in (N'U')) DROP TABLE [dbo].[address];  

CREATE TABLE [dbo].[address] (
        address_id char(35) NOT NULL ,
        address_1 varchar(250) NOT NULL ,
        address_2 varchar(250) NULL DEFAULT (NULL),
        city varchar(250) NOT NULL ,
        state_id char(35) NULL DEFAULT (NULL),
        postal_code varchar(100) NULL DEFAULT (NULL),
        country_id char(35) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[address]
   ADD CONSTRAINT address_PK PRIMARY KEY ( address_id );
-- table [dbo].[article]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[article]') AND type in (N'U')) DROP TABLE [dbo].[article];  

CREATE TABLE [dbo].[article] (
        article_id char(35) NOT NULL ,
        title varchar(500) NOT NULL ,
        content text NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[article]
   ADD CONSTRAINT article_PK PRIMARY KEY ( article_id );
-- table [dbo].[article_author]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[article_author]') AND type in (N'U')) DROP TABLE [dbo].[article_author];  

CREATE TABLE [dbo].[article_author] (
        article_id char(35) NOT NULL ,
        author_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[article_author]
   ADD CONSTRAINT article_author_PK PRIMARY KEY ( article_id, author_id );
-- table [dbo].[article_category]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[article_category]') AND type in (N'U')) DROP TABLE [dbo].[article_category];  

CREATE TABLE [dbo].[article_category] (
        article_id char(35) NOT NULL ,
        category_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[article_category]
   ADD CONSTRAINT article_category_PK PRIMARY KEY ( article_id, category_id );
-- table [dbo].[board_position]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[board_position]') AND type in (N'U')) DROP TABLE [dbo].[board_position];  

CREATE TABLE [dbo].[board_position] (
        board_position_id char(35) NOT NULL ,
        board_position varchar(250) NOT NULL ,
        description varchar(500) NULL DEFAULT (NULL),
        sort_order tinyint NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[board_position]
   ADD CONSTRAINT board_position_PK PRIMARY KEY ( board_position_id );
-- table [dbo].[board_position_person]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[board_position_person]') AND type in (N'U')) DROP TABLE [dbo].[board_position_person];  

CREATE TABLE [dbo].[board_position_person] (
        board_position_id char(35) NOT NULL ,
        person_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[board_position_person]
   ADD CONSTRAINT board_position_person_PK PRIMARY KEY ( board_position_id, person_id );
-- table [dbo].[book]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book]') AND type in (N'U')) DROP TABLE [dbo].[book];  

CREATE TABLE [dbo].[book] (
        book_id char(35) NOT NULL ,
        title varchar(500) NOT NULL ,
        publisher_id char(35) NOT NULL ,
        publication_year smallint NOT NULL ,
        isbn varchar(20) NOT NULL ,
        num_pages smallint NULL DEFAULT (NULL),
        price smallint NULL DEFAULT (NULL),
        url varchar(255) NULL DEFAULT (NULL),
        cover_image_small varchar(255) NULL DEFAULT (NULL),
        cover_image_large varchar(255) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[book]
   ADD CONSTRAINT book_PK PRIMARY KEY ( book_id );
-- table [dbo].[book_author]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book_author]') AND type in (N'U')) DROP TABLE [dbo].[book_author];  

CREATE TABLE [dbo].[book_author] (
        book_id char(35) NOT NULL ,
        author_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[book_author]
   ADD CONSTRAINT book_author_PK PRIMARY KEY ( book_id, author_id );
-- table [dbo].[book_category]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book_category]') AND type in (N'U')) DROP TABLE [dbo].[book_category];  

CREATE TABLE [dbo].[book_category] (
        book_id char(35) NOT NULL ,
        category_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[book_category]
   ADD CONSTRAINT book_category_PK PRIMARY KEY ( book_id, category_id );
-- table [dbo].[book_review]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[book_review]') AND type in (N'U')) DROP TABLE [dbo].[book_review];  

CREATE TABLE [dbo].[book_review] (
        book_review_id char(35) NOT NULL ,
        book_id char(35) NOT NULL ,
        review text NOT NULL ,
        review_date bigint NOT NULL ,
        reviewer_id char(35) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[book_review]
   ADD CONSTRAINT book_review_PK PRIMARY KEY ( book_review_id );
-- table [dbo].[category]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[category]') AND type in (N'U')) DROP TABLE [dbo].[category];  

CREATE TABLE [dbo].[category] (
        category_id char(35) NOT NULL ,
        category varchar(500) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[category]
   ADD CONSTRAINT category_PK PRIMARY KEY ( category_id );
-- table [dbo].[country]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[country]') AND type in (N'U')) DROP TABLE [dbo].[country];  

CREATE TABLE [dbo].[country] (
        country_id char(35) NOT NULL ,
        country varchar(500) NULL DEFAULT (NULL),
        country_abbr char(2) NOT NULL ,
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[country]
   ADD CONSTRAINT country_PK PRIMARY KEY ( country_id );
-- table [dbo].[file_type]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[file_type]') AND type in (N'U')) DROP TABLE [dbo].[file_type];  

CREATE TABLE [dbo].[file_type] (
        file_type_id char(35) NOT NULL ,
        file_type varchar(100) NOT NULL ,
        file_extension varchar(20) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[file_type]
   ADD CONSTRAINT file_type_PK PRIMARY KEY ( file_type_id );
-- table [dbo].[im_type]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[im_type]') AND type in (N'U')) DROP TABLE [dbo].[im_type];  

CREATE TABLE [dbo].[im_type] (
        im_type_id char(35) NOT NULL ,
        im_type varchar(100) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[im_type]
   ADD CONSTRAINT im_type_PK PRIMARY KEY ( im_type_id );
-- table [dbo].[location]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[location]') AND type in (N'U')) DROP TABLE [dbo].[location];  

CREATE TABLE [dbo].[location] (
        location_id char(35) NOT NULL ,
        location varchar(250) NOT NULL ,
        map_link varchar(250) NULL DEFAULT (NULL),
        description varchar(500) NULL DEFAULT (NULL),
        address_id char(35) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[location]
   ADD CONSTRAINT location_PK PRIMARY KEY ( location_id );
-- table [dbo].[meeting]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[meeting]') AND type in (N'U')) DROP TABLE [dbo].[meeting];  

CREATE TABLE [dbo].[meeting] (
        meeting_id char(35) NOT NULL ,
        title varchar(500) NOT NULL ,
        description text,
        dt_meeting bigint NOT NULL ,
        location_id char(35) NOT NULL ,
        connect_url varchar(255) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[meeting]
   ADD CONSTRAINT meeting_PK PRIMARY KEY ( meeting_id );
-- table [dbo].[meeting_presentation]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[meeting_presentation]') AND type in (N'U')) DROP TABLE [dbo].[meeting_presentation];  

CREATE TABLE [dbo].[meeting_presentation] (
        meeting_id char(35) NOT NULL ,
        presentation_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[meeting_presentation]
   ADD CONSTRAINT meeting_presentation_PK PRIMARY KEY ( meeting_id, presentation_id );
-- table [dbo].[news]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[news]') AND type in (N'U')) DROP TABLE [dbo].[news];  

CREATE TABLE [dbo].[news] (
        news_id char(35) NOT NULL ,
        headline varchar(500) NOT NULL ,
        body text NOT NULL ,
        dt_to_post bigint NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[news]
   ADD CONSTRAINT news_PK PRIMARY KEY ( news_id );
-- table [dbo].[organization]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[organization]') AND type in (N'U')) DROP TABLE [dbo].[organization];  

CREATE TABLE [dbo].[organization] (
        organization_id char(35) NOT NULL ,
        organization varchar(500) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(35) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[organization]
   ADD CONSTRAINT organization_PK PRIMARY KEY ( organization_id );
-- table [dbo].[person]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[person]') AND type in (N'U')) DROP TABLE [dbo].[person];  

CREATE TABLE [dbo].[person] (
        person_id char(35) NOT NULL ,
        first_name varchar(250) NOT NULL ,
        last_name varchar(250) NOT NULL ,
        title varchar(250) NOT NULL ,
        organization_id char(35) NULL DEFAULT (NULL),
        phone varchar(50) NULL DEFAULT (NULL),
        email varchar(250) NOT NULL ,
        url varchar(255) NULL DEFAULT (NULL),
        image varchar(255) NULL DEFAULT (NULL),
        password varchar(50) NULL DEFAULT (NULL),
        is_admin tinyint NULL DEFAULT (NULL),
        role_id char(35) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL ,
	bio text NULL DEFAULT (NULL)
);
ALTER TABLE [dbo].[person]
   ADD CONSTRAINT person_PK PRIMARY KEY ( person_id );
-- table [dbo].[person_address]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[person_address]') AND type in (N'U')) DROP TABLE [dbo].[person_address];  

CREATE TABLE [dbo].[person_address] (
        person_id char(35) NOT NULL ,
        address_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[person_address]
   ADD CONSTRAINT person_address_PK PRIMARY KEY ( person_id, address_id );
-- table [dbo].[person_im]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[person_im]') AND type in (N'U')) DROP TABLE [dbo].[person_im];  

CREATE TABLE [dbo].[person_im] (
        person_id char(35) NOT NULL ,
        im_type_id char(35) NOT NULL ,
        im_handle varchar(100) NOT NULL 
);
ALTER TABLE [dbo].[person_im]
   ADD CONSTRAINT person_im_PK PRIMARY KEY ( person_id, im_type_id );
-- table [dbo].[photo]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[photo]') AND type in (N'U')) DROP TABLE [dbo].[photo];  

CREATE TABLE [dbo].[photo] (
        photo_id char(35) NOT NULL ,
        title varchar(250) NOT NULL ,
        caption varchar(500) NULL DEFAULT (NULL),
        file_name varchar(500) NOT NULL ,
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[photo]
   ADD CONSTRAINT photo_PK PRIMARY KEY ( photo_id );
-- table [dbo].[photo_album]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[photo_album]') AND type in (N'U')) DROP TABLE [dbo].[photo_album];  

CREATE TABLE [dbo].[photo_album] (
        photo_album_id char(35) NOT NULL ,
        title varchar(250) NOT NULL ,
        description varchar(500) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[photo_album]
   ADD CONSTRAINT photo_album_PK PRIMARY KEY ( photo_album_id );
-- table [dbo].[photo_album_photo]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[photo_album_photo]') AND type in (N'U')) DROP TABLE [dbo].[photo_album_photo];  

CREATE TABLE [dbo].[photo_album_photo] (
        photo_album_id char(35) NOT NULL ,
        photo_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[photo_album_photo]
   ADD CONSTRAINT photo_album_photo_PK PRIMARY KEY ( photo_album_id, photo_id );
-- table [dbo].[presentation]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[presentation]') AND type in (N'U')) DROP TABLE [dbo].[presentation];  

CREATE TABLE [dbo].[presentation] (
        presentation_id char(35) NOT NULL ,
        title varchar(500) NOT NULL ,
        summary text,
        presentation_file varchar(250) NULL DEFAULT (NULL),
        presentation_file_title varchar(250) NULL DEFAULT (NULL),
        presentation_file_description varchar(500) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[presentation]
   ADD CONSTRAINT presentation_PK PRIMARY KEY ( presentation_id );
-- table [dbo].[presentation_presenter]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[presentation_presenter]') AND type in (N'U')) DROP TABLE [dbo].[presentation_presenter];  

CREATE TABLE [dbo].[presentation_presenter] (
        presentation_id char(35) NOT NULL ,
        presenter_id char(35) NOT NULL 
);
ALTER TABLE [dbo].[presentation_presenter]
   ADD CONSTRAINT presentation_presenter_PK PRIMARY KEY ( presentation_id, presenter_id );
-- table [dbo].[role]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[role]') AND type in (N'U')) DROP TABLE [dbo].[role];  

CREATE TABLE [dbo].[role] (
        role_id char(35) NOT NULL ,
        role varchar(100) NOT NULL ,
        description varchar(500) NULL DEFAULT (NULL),
        created_by_id char(35) NOT NULL ,
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[role]
   ADD CONSTRAINT role_PK PRIMARY KEY ( role_id );
-- table [dbo].[rsvp]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rsvp]') AND type in (N'U')) DROP TABLE [dbo].[rsvp];  

CREATE TABLE [dbo].[rsvp] (
        rsvp_id char(35) NOT NULL ,
        meeting_id char(35) NOT NULL ,
        person_id char(35) NULL DEFAULT (NULL),
        first_name varchar(100) NOT NULL ,
        last_name varchar(100) NOT NULL ,
        email varchar(100) NOT NULL ,
        comments text,
        created_by_id char(35) NULL DEFAULT (NULL),
        dt_created bigint NOT NULL ,
        ip_created varchar(15) NOT NULL ,
        modified_by_id char(35) NULL DEFAULT (NULL),
        dt_modified bigint NULL DEFAULT (NULL),
        ip_modified varchar(15) NULL DEFAULT (NULL),
        is_active tinyint NOT NULL 
);
ALTER TABLE [dbo].[rsvp]
   ADD CONSTRAINT rsvp_PK PRIMARY KEY ( rsvp_id );
-- table [dbo].[state]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[state]') AND type in (N'U')) DROP TABLE [dbo].[state];  

CREATE TABLE [dbo].[state] (
        state_id char(35) NOT NULL ,
        state varchar(50) NOT NULL ,
        state_abbr char(2) NOT NULL 
);
ALTER TABLE [dbo].[state]
   ADD CONSTRAINT state_PK PRIMARY KEY ( state_id );
   
-- INSERTS
INSERT INTO [dbo].[board_position] VALUES ('9E5FB8D1-E317-6618-9C9C26B54AF87B90','Manager','UG Manager',1,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888177873,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1170888269805,'156.33.114.155',1);
INSERT INTO [dbo].[board_position] VALUES ('9E69E14F-A2FE-570D-B09755CE1BB9EDF4','Meeting Content','Person responsible for speakers and meeting content',2,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888843596,'156.33.114.155',NULL,NULL,NULL,1);
INSERT INTO [dbo].[board_position] VALUES ('9E6A79C3-900F-1F4D-F4AEE6A8102110DD','Publicity and Membership','Person responsible for publicizing the group and meetings, and recruiting and retaining members',3,'993700D0-C25C-213F-C3F38E7A533AEB88',1170888882627,'156.33.114.155',NULL,NULL,NULL,1);

--INSERT INTO [dbo].[board_position_person] VALUES ('9E5FB8D1-E317-6618-9C9C26B54AF87B90','993700D0-C25C-213F-C3F38E7A533AEB88');
--INSERT INTO [dbo].[board_position_person] VALUES ('9E69E14F-A2FE-570D-B09755CE1BB9EDF4','48DD38D3-D8E8-E152-054A8BA4B8B41C92');
--INSERT INTO [dbo].[board_position_person] VALUES ('9E6A79C3-900F-1F4D-F4AEE6A8102110DD','E5D7DDBE-C051-2835-72F654D715E20CD9');

INSERT INTO [dbo].[category] VALUES ('26BFCADF-0A33-6FFF-1ADD6B5B98948EC2','New Category','993700D0-C25C-213F-C3F38E7A533AEB88',1181766109918,'127.0.0.1',NULL,NULL,NULL,1);

INSERT INTO [dbo].[im_type] VALUES ('940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','Skype','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170714842070,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715920039,'156.33.114.155',1);
INSERT INTO [dbo].[im_type] VALUES ('940B01D1-FEEB-DC29-F2F26E44522032D0','Yahoo!','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170714853840,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715959105,'156.33.114.155',1);
INSERT INTO [dbo].[im_type] VALUES ('93F032CD-9872-2C0C-0776C3B2CD417D9E','AOL','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170713096909,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1171490593866,'156.33.114.155',1);
INSERT INTO [dbo].[im_type] VALUES ('941B9C87-F160-F341-8FEA5A07E4AFB150','Google Talk','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715942023,'156.33.114.155',NULL,NULL,NULL,1);
INSERT INTO [dbo].[im_type] VALUES ('941BC4FC-DF44-CD14-B25D64FAA6E22129','MSN','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170715952378,'156.33.114.155',NULL,NULL,NULL,1);

INSERT INTO [dbo].[location] VALUES ('C22F8EF6-FF60-02E0-5C74CEB0539AB0A4','Postal Square 6915',NULL,'Meeting area in PSQ 6915',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1171489001206,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1171551140070,'156.33.114.155',1);
INSERT INTO [dbo].[location] VALUES ('20309DC1-9D07-F40E-3BACB6FCF8ABFEE9','Hart Senate Office Building - Room 512','http://maps.google.com/maps?f=q&hl=en&q=Hart+Senate+Office+Building','The Hart Senate Office Building is located at Constitution & 2nd Street NE. The public entrance is on 2nd Street. Two blocks north is the nearest metro stop: Union Station on the Red Line. Please send an email to info@capitolhillusergroup.com if you get lost.',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1177361096128,'156.33.114.155',NULL,NULL,NULL,1);
INSERT INTO [dbo].[location] VALUES ('49FAAF2C-C438-867B-F7C6431E826E80CE','Senate Dirksen Office Building - Room 138','http://maps.google.com/maps?f=q&hl=en&q=Dirksen+Senate+Office+Building',NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1178062204716,'69.143.48.132',NULL,NULL,NULL,1);
INSERT INTO [dbo].[location] VALUES ('1CE73ADB-B371-7E25-1E61990745B94AD6','Senate Dirksen Office Building - Room 192','http://maps.google.com/maps?f=q&hl=en&q=Dirksen+Senate+Office+Building',NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181600922330,'69.3.89.146','993700D0-C25C-213F-C3F38E7A533AEB88',1181603531105,'127.0.0.1',1);

INSERT INTO [dbo].[meeting] VALUES ('1526DBD7-BEB0-7EA4-7A2167BF1C257DEB','Inaugural Meeting','Please come join us at our inaugural meeting! We have the distinct pleasure of welcoming Ben Forta, Tim Buntel, and Adam Wayne Lehman from Adobe at our first meeting to share everything they can about ColdFusion 8 ("Scorpio");, so you won''t want to miss it!\r\n\r\nWe''ll also socialize a bit and discuss what we want to do with the group, as well as get into meeting times, topics, and anything else to do with this fledgling group. See you there!',1179421200000,'49FAAF2C-C438-867B-F7C6431E826E80CE',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1177175907287,'69.143.48.132','993700D0-C25C-213F-C3F38E7A533AEB88',1178933567786,'69.143.48.132',1);
INSERT INTO [dbo].[meeting] VALUES ('1D05E843-F80E-257B-56B030A320DECE6D','adsads','adsads',1181602920000,'1CE73ADB-B371-7E25-1E61990745B94AD6',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181602932803,'127.0.0.1',NULL,NULL,NULL,1);
INSERT INTO [dbo].[meeting] VALUES ('21686DFF-933A-2568-420CC50C07FE2492','Test Meeting','This is a test meeting.',1181676480000,'C22F8EF6-FF60-02E0-5C74CEB0539AB0A4',NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181676498430,'127.0.0.1',NULL,NULL,NULL,1);
INSERT INTO [dbo].[meeting] VALUES ('25D0EB5D-E68C-5645-7CBA2E6A1EFC8978','Test of Connect URL','This is a test of the connect url field.',1181750400000,'20309DC1-9D07-F40E-3BACB6FCF8ABFEE9','http://connecturl/newone','993700D0-C25C-213F-C3F38E7A533AEB88',1181750455133,'127.0.0.1','993700D0-C25C-213F-C3F38E7A533AEB88',1181750894732,'127.0.0.1',1);

INSERT INTO [dbo].[meeting_presentation] VALUES ('21686DFF-933A-2568-420CC50C07FE2492','216816A2-FFB5-05EF-C204DA18B2B2F2DC');
INSERT INTO [dbo].[meeting_presentation] VALUES ('EA3F4A1F-AFF2-FAE5-3F82FE27EB4508F1','EA4AD032-B8E6-D9E2-E7B378CE1E5DC80E');
INSERT INTO [dbo].[meeting_presentation] VALUES ('EB97E219-CEAD-DA48-A8EFB0AF8F35B9C6','EA4A7F9E-D040-F6BC-E18191D762036B79');

INSERT INTO [dbo].[news] VALUES ('211CD7D5-D352-22CE-53B48DCFED1052FC','Headline','Body',1181671500000,'993700D0-C25C-213F-C3F38E7A533AEB88',1181671544789,'127.0.0.1',NULL,NULL,NULL,1);

INSERT INTO [dbo].[organization] VALUES ('9888ABD5-019C-E4BF-BC1566C59A9CD316','U.S. Senate - Sergeant at Arms','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170790198228,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170790956331,'156.33.114.155',1);

INSERT INTO [dbo].[person] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','Default','User','Default User','9888ABD5-019C-E4BF-BC1566C59A9CD316','phone','admin@admin.com',NULL,NULL,'admin',1,'98C49505-0610-4F47-B7E2535E5BC75934','598F17EB-FB4C-FCFC-8525B1FDF43FA053',2007,'127.0.0.1','993700D0-C25C-213F-C3F38E7A533AEB88',1170879468244,'156.33.114.155',1,NULL);

INSERT INTO [dbo].[person_im] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940B01D1-FEEB-DC29-F2F26E44522032D0','yahoo');
INSERT INTO [dbo].[person_im] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941B9C87-F160-F341-8FEA5A07E4AFB150','google');
INSERT INTO [dbo].[person_im] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','93F032CD-9872-2C0C-0776C3B2CD417D9E','aol');
INSERT INTO [dbo].[person_im] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','skype');
INSERT INTO [dbo].[person_im] VALUES ('598F17EB-FB4C-FCFC-8525B1FDF43FA053','941BC4FC-DF44-CD14-B25D64FAA6E22129','msn');
INSERT INTO [dbo].[person_im] VALUES ('993700D0-C25C-213F-C3F38E7A533AEB88','940AD3D6-A5ED-7BA9-FCA0E2F2DF057430','mpwoodward');
INSERT INTO [dbo].[person_im] VALUES ('993700D0-C25C-213F-C3F38E7A533AEB88','941B9C87-F160-F341-8FEA5A07E4AFB150','mpwoodward@gmail.com');
INSERT INTO [dbo].[person_im] VALUES ('993700D0-C25C-213F-C3F38E7A533AEB88','940B01D1-FEEB-DC29-F2F26E44522032D0','mpwoodward2');
INSERT INTO [dbo].[person_im] VALUES ('993700D0-C25C-213F-C3F38E7A533AEB88','941BC4FC-DF44-CD14-B25D64FAA6E22129','mpwoodward@hotmail.com');
INSERT INTO [dbo].[person_im] VALUES ('993700D0-C25C-213F-C3F38E7A533AEB88','93F032CD-9872-2C0C-0776C3B2CD417D9E','CaptainJavac');

INSERT INTO [dbo].[presentation] VALUES ('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','Test of File Upload','test',NULL,NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1172092936674,'156.33.114.155','993700D0-C25C-213F-C3F38E7A533AEB88',1172094034859,'156.33.114.155',1);
INSERT INTO [dbo].[presentation] VALUES ('216816A2-FFB5-05EF-C204DA18B2B2F2DC','Test Presentation','test',NULL,NULL,NULL,'993700D0-C25C-213F-C3F38E7A533AEB88',1181676476065,'127.0.0.1',NULL,NULL,NULL,1);

INSERT INTO [dbo].[presentation_presenter] VALUES ('216816A2-FFB5-05EF-C204DA18B2B2F2DC','993700D0-C25C-213F-C3F38E7A533AEB88');
INSERT INTO [dbo].[presentation_presenter] VALUES ('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','993700D0-C25C-213F-C3F38E7A533AEB88');
INSERT INTO [dbo].[presentation_presenter] VALUES ('E62EE1E2-D7D4-70C6-D227249EA3AB9C58','E5D7DDBE-C051-2835-72F654D715E20CD9');

INSERT INTO [dbo].[role] VALUES ('98C49505-0610-4F47-B7E2535E5BC75934','Member','User Group Member','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794124549,'156.33.114.155','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794502025,'156.33.114.155',1);
INSERT INTO [dbo].[role] VALUES ('98CAA920-F976-92DA-1E46FB2C500556CC','Presenter','Non-Member Presenter','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794522912,'156.33.114.155',NULL,NULL,NULL,1);
INSERT INTO [dbo].[role] VALUES ('98CF6629-DF39-BD9D-8F95BE845916D0B5','Sponsor','Sponsor','598F17EB-FB4C-FCFC-8525B1FDF43FA053',1170794833449,'156.33.114.155',NULL,NULL,NULL,1);

INSERT INTO [dbo].[state] VALUES ('C1F5D036-FBA0-AC33-30DFD83ECBD754F7','Alabama','AL');
INSERT INTO [dbo].[state] VALUES ('C1F5D037-E5D4-EBA7-BC0FA1191C1FA222','Alaska','AK');
INSERT INTO [dbo].[state] VALUES ('C1F5D038-06B7-BA21-68CD4E18A0EDA5A7','Arizona','AZ');
INSERT INTO [dbo].[state] VALUES ('C1F5D039-BB26-0CB7-6B60FC81C144FA8F','Arkansas','AR');
INSERT INTO [dbo].[state] VALUES ('C1F5D03A-EA1F-F33E-64FBE4837506885F','California','CA');
INSERT INTO [dbo].[state] VALUES ('C1F5D03B-D8E3-2B02-9C8496EF7ACEF62D','Colorado','CO');
INSERT INTO [dbo].[state] VALUES ('C1F5D03C-EAA5-876B-45D91B7719C17BFE','Connecticut','CT');
INSERT INTO [dbo].[state] VALUES ('C1F5D03D-036C-353C-FF37CE9DB95CC177','Delaware','DE');
INSERT INTO [dbo].[state] VALUES ('C1F5D03E-CCC0-947D-9DC1CDA49819FD33','District of Columbia','DC');
INSERT INTO [dbo].[state] VALUES ('C1F5D03F-F195-C3D9-6D4859EA559392CA','Florida','FL');
INSERT INTO [dbo].[state] VALUES ('C1F5D040-DE7F-202D-30FA138DCC7A30CC','Georgia','GA');
INSERT INTO [dbo].[state] VALUES ('C1F5D041-F012-A2FE-09F32A51F589C27B','Hawaii','HI');
INSERT INTO [dbo].[state] VALUES ('C1F5D042-C8BC-522C-FC79B916F792EB42','Idaho','ID');
INSERT INTO [dbo].[state] VALUES ('C1F5D043-9860-67FC-30B8B08BB24978C2','Illinois','IL');
INSERT INTO [dbo].[state] VALUES ('C1F5D044-A344-3CCD-851DBFF07FEB4AD1','Indiana','IN');
INSERT INTO [dbo].[state] VALUES ('C1F5D045-A9E0-B5A9-936AB7A3DF118BC0','Iowa','IA');
INSERT INTO [dbo].[state] VALUES ('C1F5D046-CC23-8DE6-BBDEB5C8879B1995','Kansas','KS');
INSERT INTO [dbo].[state] VALUES ('C1F5D047-FBDB-3E95-F149E8B586E29507','Kentucky','KY');
INSERT INTO [dbo].[state] VALUES ('C1F5D048-B6C2-5C5B-F916BB063EC5CEE8','Louisiana','LA');
INSERT INTO [dbo].[state] VALUES ('C1F5D049-D489-578A-04A9B5232E66D9BB','Maine','ME');
INSERT INTO [dbo].[state] VALUES ('C1F5D04A-C342-4497-232D8D96F3AC7199','Maryland','MD');
INSERT INTO [dbo].[state] VALUES ('C1F5D04B-BBB7-6329-8C21D3A4CD63E695','Massachusetts','MA');
INSERT INTO [dbo].[state] VALUES ('C1F5D04C-01D0-B2CF-A6E38AE9C41DA312','Michigan','MI');
INSERT INTO [dbo].[state] VALUES ('C1F5D04D-F882-E823-B2A3E08965BED7A1','Minnesota','MN');
INSERT INTO [dbo].[state] VALUES ('C1F5D04E-B2DB-4A83-9CB9FC2850AE5799','Mississippi','MS');
INSERT INTO [dbo].[state] VALUES ('C1F5D04F-CFD6-3DDD-621FBBE18F22974E','Missouri','MO');
INSERT INTO [dbo].[state] VALUES ('C1F5D050-F757-B052-C963B6867A0304FF','Montana','MT');
INSERT INTO [dbo].[state] VALUES ('C1F5D051-00F2-ABD4-6C6A587D2E110E97','Nebraska','NE');
INSERT INTO [dbo].[state] VALUES ('C1F5D052-DA83-337E-A353B39A60E86B37','Nevada','NV');
INSERT INTO [dbo].[state] VALUES ('C1F5D053-9460-2CA3-8B795D9FFB74706C','New Hampshire','NH');
INSERT INTO [dbo].[state] VALUES ('C1F5D054-D727-EE6A-11FFF8C5F848CD53','New Jersey','NJ');
INSERT INTO [dbo].[state] VALUES ('C1F5D055-FAF5-BBF6-AEEAC71DE6765D6C','New Mexico','NM');
INSERT INTO [dbo].[state] VALUES ('C1F5D056-E36D-3E3D-01598825C287155B','New York','NY');
INSERT INTO [dbo].[state] VALUES ('C1F5D057-CF98-85E5-35D1FF9326DFA858','North Carolina','NC');
INSERT INTO [dbo].[state] VALUES ('C1F5D058-CBDE-E0DC-2B151CF2A0C18E48','North Dakota','ND');
INSERT INTO [dbo].[state] VALUES ('C1F5D059-B689-A31B-14A54ECF18B506D2','Ohio','OH');
INSERT INTO [dbo].[state] VALUES ('C1F5D05A-D565-6CDE-408208858E1D521E','Oklahoma','OK');
INSERT INTO [dbo].[state] VALUES ('C1F5D05B-F33E-E956-6ABACD5303E941A2','Oregon','OR');
INSERT INTO [dbo].[state] VALUES ('C1F5D05C-004E-3EA1-1F9F58147BC34A7D','Pennsylvania','PA');
INSERT INTO [dbo].[state] VALUES ('C1F5D05D-09BB-5C15-4B01433D9245E98A','Rhode Island','RI');
INSERT INTO [dbo].[state] VALUES ('C1F5D05E-A2DF-5A05-2FA25E4431C635ED','South Carolina','SC');
INSERT INTO [dbo].[state] VALUES ('C1F5D05F-FA6D-E8CC-163FF44BCA49DB1A','South Dakota','SD');
INSERT INTO [dbo].[state] VALUES ('C1F5D060-9683-C53A-0E5E81F501BF4796','Tennessee','TN');
INSERT INTO [dbo].[state] VALUES ('C1F5D061-BF35-AA81-7776805AC236C0FF','Texas','TX');
INSERT INTO [dbo].[state] VALUES ('C1F5D062-98F2-7B8A-C80E2EB0B5659334','Utah','UT');
INSERT INTO [dbo].[state] VALUES ('C1F5D063-EA74-5D1F-097C875504EE01E5','Vermont','VT');
INSERT INTO [dbo].[state] VALUES ('C1F5D064-CC73-7518-3F11E86931025847','Virginia','VA');
INSERT INTO [dbo].[state] VALUES ('C1F5D065-A37F-0FD6-06EF9862797D4E44','Washington','WA');
INSERT INTO [dbo].[state] VALUES ('C1F5D066-D062-9414-94E8EAD5E20E6B24','West Virginia','WV');
INSERT INTO [dbo].[state] VALUES ('C1F5D067-DAE1-D63B-B0AE570AC815E554','Wisconsin','WI');
INSERT INTO [dbo].[state] VALUES ('C1F5D068-040D-DE21-490A9C8C975574FE','Wyoming','WY');
