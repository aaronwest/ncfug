USE `chug`

ALTER TABLE `chug`.`person` ADD COLUMN `bio` TEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL AFTER `is_active`;