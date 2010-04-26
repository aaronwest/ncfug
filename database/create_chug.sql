DROP DATABASE IF EXISTS `chug`;
CREATE DATABASE `chug` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL ON chug.* to chugadmin@'%' IDENTIFIED BY 'chugadmin';
GRANT ALL ON chug.* to chugadmin@'localhost' IDENTIFIED BY 'chugadmin';
GRANT SELECT, INSERT, UPDATE, DELETE, LOCK TABLES, EXECUTE ON chug.* to chuguser@'%' IDENTIFIED BY 'chuguser';
GRANT SELECT, INSERT, UPDATE, DELETE, LOCK TABLES, EXECUTE ON chug.* to chuguser@'localhost' IDENTIFIED BY 'chuguser';
GRANT SELECT ON chug.* to chugrouser@'%' IDENTIFIED BY 'readonly';
GRANT SELECT ON chug.* to chugrouser@'localhost' IDENTIFIED BY 'readonly';
FLUSH PRIVILEGES;
