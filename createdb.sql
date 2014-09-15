CREATE DATABASE northcode;
USE northcode;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edited_time` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `users` (`name` ASC);


-- -----------------------------------------------------
-- Table `localization_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `localization_currency` ;

CREATE TABLE IF NOT EXISTS `localization_currency` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `format` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `localization_datetime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `localization_datetime` ;

CREATE TABLE IF NOT EXISTS `localization_datetime` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `format` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_settings` ;

CREATE TABLE IF NOT EXISTS `user_settings` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `loc_currency` BIGINT UNSIGNED NOT NULL,
  `loc_datetime` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_settings_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_settings_localization_currency1`
    FOREIGN KEY (`loc_currency`)
    REFERENCES `localization_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_settings_localization_datetime1`
    FOREIGN KEY (`loc_datetime`)
    REFERENCES `localization_datetime` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_settings_localization_currency1_idx` ON `user_settings` (`loc_currency` ASC);

CREATE INDEX `fk_user_settings_localization_datetime1_idx` ON `user_settings` (`loc_datetime` ASC);


-- -----------------------------------------------------
-- Table `user_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_info` ;

CREATE TABLE IF NOT EXISTS `user_info` (
  `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bio` TEXT NULL,
  `img` VARCHAR(255) NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_info_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_passwords`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_passwords` ;

CREATE TABLE IF NOT EXISTS `user_passwords` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '	',
  `user_id` BIGINT UNSIGNED NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `expired` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_passwords_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_passwords_users_idx` ON `user_passwords` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE TABLE IF NOT EXISTS `group` (
  `id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `users_has_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users_has_group` ;

CREATE TABLE IF NOT EXISTS `users_has_group` (
  `users_id` BIGINT UNSIGNED NOT NULL,
  `group_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`, `group_id`),
  CONSTRAINT `fk_users_has_group_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_group_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `group` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_users_has_group_group1_idx` ON `users_has_group` (`group_id` ASC);

CREATE INDEX `fk_users_has_group_users1_idx` ON `users_has_group` (`users_id` ASC);


-- -----------------------------------------------------
-- Table `user_titles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_titles` ;

CREATE TABLE IF NOT EXISTS `user_titles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `short` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `user_titles` (`name` ASC);

CREATE UNIQUE INDEX `short_UNIQUE` ON `user_titles` (`short` ASC);


-- -----------------------------------------------------
-- Table `user_titles_has_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_titles_has_users` ;

CREATE TABLE IF NOT EXISTS `user_titles_has_users` (
  `user_titles_id` BIGINT UNSIGNED NOT NULL,
  `users_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_titles_id`, `users_id`),
  CONSTRAINT `fk_user_titles_has_users_user_titles1`
    FOREIGN KEY (`user_titles_id`)
    REFERENCES `user_titles` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_titles_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_titles_has_users_users1_idx` ON `user_titles_has_users` (`users_id` ASC);

CREATE INDEX `fk_user_titles_has_users_user_titles1_idx` ON `user_titles_has_users` (`user_titles_id` ASC);


-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `session` ;

CREATE TABLE IF NOT EXISTS `session` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NULL,
  `ip` VARCHAR(18) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT NOT NULL DEFAULT 0,
  `ident` INT UNSIGNED NOT NULL,
  `expires` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_session_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_session_users1_idx` ON `session` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects` ;

CREATE TABLE IF NOT EXISTS `projects` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `shortname` VARCHAR(10) NOT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `shortname_UNIQUE` ON `projects` (`shortname` ASC);

CREATE INDEX `fk_projects_project_types1_idx` ON `projects` (`type_id` ASC);


-- -----------------------------------------------------
-- Table `project_tabs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_tabs` ;

CREATE TABLE IF NOT EXISTS `project_tabs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_project_tabs_projects1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_project_tabs_projects1_idx` ON `project_tabs` (`project_id` ASC);


-- -----------------------------------------------------
-- Table `project_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_users` ;

CREATE TABLE IF NOT EXISTS `project_users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `projects_id` BIGINT UNSIGNED NOT NULL,
  `users_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_projects_has_users_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_projects_has_users_users1_idx` ON `project_users` (`users_id` ASC);

CREATE INDEX `fk_projects_has_users_projects1_idx` ON `project_users` (`projects_id` ASC);


-- -----------------------------------------------------
-- Table `project_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_roles` ;

CREATE TABLE IF NOT EXISTS `project_roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `project_roles` (`name` ASC);


-- -----------------------------------------------------
-- Table `project_users_has_project_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_users_has_project_roles` ;

CREATE TABLE IF NOT EXISTS `project_users_has_project_roles` (
  `project_users_id` BIGINT UNSIGNED NOT NULL,
  `project_roles_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`project_users_id`, `project_roles_id`),
  CONSTRAINT `fk_project_users_has_project_roles_project_users1`
    FOREIGN KEY (`project_users_id`)
    REFERENCES `project_users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_users_has_project_roles_project_roles1`
    FOREIGN KEY (`project_roles_id`)
    REFERENCES `project_roles` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_project_users_has_project_roles_project_roles1_idx` ON `project_users_has_project_roles` (`project_roles_id` ASC);

CREATE INDEX `fk_project_users_has_project_roles_project_users1_idx` ON `project_users_has_project_roles` (`project_users_id` ASC);


-- -----------------------------------------------------
-- Table `project_links`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_links` ;

CREATE TABLE IF NOT EXISTS `project_links` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` BIGINT UNSIGNED NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_project_links_projects1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_project_links_projects1_idx` ON `project_links` (`project_id` ASC);


-- -----------------------------------------------------
-- Table `api_access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `api_access` ;

CREATE TABLE IF NOT EXISTS `api_access` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `api_access` (`name` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `api_access` (`code` ASC);


-- -----------------------------------------------------
-- Table `api_perms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `api_perms` ;

CREATE TABLE IF NOT EXISTS `api_perms` (
  `id` BIGINT NOT NULL,
  `name` BIGINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `api_access_has_api_perms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `api_access_has_api_perms` ;

CREATE TABLE IF NOT EXISTS `api_access_has_api_perms` (
  `api_access_id` BIGINT UNSIGNED NOT NULL,
  `api_perms_id` BIGINT NOT NULL,
  PRIMARY KEY (`api_access_id`, `api_perms_id`),
  CONSTRAINT `fk_api_access_has_api_perms_api_access1`
    FOREIGN KEY (`api_access_id`)
    REFERENCES `api_access` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_api_access_has_api_perms_api_perms1`
    FOREIGN KEY (`api_perms_id`)
    REFERENCES `api_perms` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_api_access_has_api_perms_api_perms1_idx` ON `api_access_has_api_perms` (`api_perms_id` ASC);

CREATE INDEX `fk_api_access_has_api_perms_api_access1_idx` ON `api_access_has_api_perms` (`api_access_id` ASC);


-- -----------------------------------------------------
-- Table `api_access_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `api_access_log` ;

CREATE TABLE IF NOT EXISTS `api_access_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_id` BIGINT UNSIGNED NOT NULL,
  `action` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_api_access_log_api_access1`
    FOREIGN KEY (`api_id`)
    REFERENCES `api_access` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_api_access_log_api_access1_idx` ON `api_access_log` (`api_id` ASC);


-- -----------------------------------------------------
-- Table `api_ips`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `api_ips` ;

CREATE TABLE IF NOT EXISTS `api_ips` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_id` BIGINT UNSIGNED NOT NULL,
  `ip` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_api_ips_api_access1`
    FOREIGN KEY (`api_id`)
    REFERENCES `api_access` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_api_ips_api_access1_idx` ON `api_ips` (`api_id` ASC);


-- -----------------------------------------------------
-- Table `project_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `project_comments` ;

CREATE TABLE IF NOT EXISTS `project_comments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `content` VARCHAR(512) NOT NULL,
  `create_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_project_comments_projects1`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_project_comments_projects1_idx` ON `project_comments` (`project_id` ASC);

CREATE INDEX `fk_project_comments_users1_idx` ON `project_comments` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `news_posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `news_posts` ;

CREATE TABLE IF NOT EXISTS `news_posts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `content` TEXT NOT NULL,
  `create_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_news_posts_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_news_posts_users1_idx` ON `news_posts` (`user_id` ASC);


-- -----------------------------------------------------
-- procedure log_api_ip
-- -----------------------------------------------------
DROP procedure IF EXISTS `log_api_ip`;

DELIMITER $$


create procedure `log_api_ip`(`api` bigint,`ip` varchar(18)) begin
insert into `api_ips`(`api_id`,`ip`) values (`api`,`ip`);
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_api_perms
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_api_perms`;

DELIMITER $$


create procedure `select_api_perms`(`api_id` bigint) begin
select `api_perms.name` from `api_access_has_api_perms`
left join `api_perms` on `api_perms.id` = `api_access_has_api_perms.api_perms_id`
where `api_access_id` = `api_id`;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_project
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_project`;

DELIMITER $$
create procedure `select_project`(`pid` bigint) begin
select
	`projects.name` as `name`,
	`projects.shortname` as `shortname`,
	`projects.created` as `created`,
	`projects_git.git_repo` as `git_repo`
from `projects`
left join `projects_git` on `projects_git.project_id` = `projects.id`
where `projects.id` = `pid`;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_project_comments
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_project_comments`;

DELIMITER $$


create procedure `select_project_comments`(`pid` bigint) begin
select `user.name` as `username`,`content`, `create_time` from `project_comments`
left join `users` on `users.id` = `project_comments.user_id`
where `project_id` = `pid`;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_project_links
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_project_links`;

DELIMITER $$


create procedure `select_project_links`(`pid` bigint) begin
select `url`,`title` from `project_links` where `project_id` = `pid`;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_project_tabs
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_project_tabs`;

DELIMITER $$


create procedure `select_project_tabs`(`pid` bigint) begin
select `title`,`content`,`updated` from `project_tabs` where `project_id` = `pid`;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_project_users
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_project_users`;

DELIMITER $$


create procedure `select_project_users`(`pid` bigint) begin
select `users.name` as `name`, GROUP_CONCAT(`project_roles.name`) as `roles` from `project_users`
left join `users` on `project_users.user_id` = `users.id`
left join `project_users_has_project_roles` on `project_users_has_project_roles.project_users_id` = `project_users.id`
left join `project_roles` on `project_roles.id` = `project_users_has_project_roles.project_roles_id`
where `project_users.projects_id` = `pid`;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure select_user
-- -----------------------------------------------------
DROP procedure IF EXISTS `select_user`;

DELIMITER $$
CREATE procedure `select_user`(id bigint) begin
SELECT
	`users.name` as `username`,
	`user_info.bio` as `bio`,
	`user_info.img` as `img`,
	`localization_currency.format` as `currency_format`,
	`localization_datetime.format` as `date_format`,
	GROUP_CONCAT(`user_titles.name`) as `titles`,
	GROUP_CONCAT(CONCAT(`group.id`,',',`group.name`)) as `groups`
FROM `users`
LEFT JOIN `user_info` ON `user_info.user_id` = `users.id`
LEFT JOIN `user_settings` ON `user_settings.user_id` = `users.id`
LEFT JOIN `localization_currency` ON `localization_currency.id` = `user_settings.localization_currency`
LEFT JOIN `localization_datetime` ON `localization_datetime.id` = `user_settings.localization_datetime`
LEFT JOIN `users_has_group` ON `users_has_group.users_id` = `users.id`
LEFT JOIN `group` ON `group.id` = `users_has_group.group_id`
LEFT JOIN `user_titles_has_users` ON `user_titles_has_users.users_id` = `users.id`
LEFT JOIN `user_titles` ON `user_titles.id` = `user_titles_has_users.user_titles_id`
WHERE `users.id` = id;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure user_login
-- -----------------------------------------------------
DROP procedure IF EXISTS `user_login`;

DELIMITER $$


create procedure `user_login`(
	`username` varchar(45),
	`password` varchar(255),
	`ip` varchar(18)
) begin
select count(`users.id`),`users.id` into @count,@uid from users
left join `user_passwords` on `user_passwords.user_id` = `users.id`
where
	`users.name` = `username` and
	`user_passwords.password` = `password` and
	`user_passwords.expired` = null
;
if @count > 0 then
	insert into `session` (
		`user_id`, `ip`, `active`)
	values (
		@uid,`ip`,1
	);
	select @uid,LAST_INSERT_ID();
else
	select null,null;
end if;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_access
-- -----------------------------------------------------
DROP procedure IF EXISTS `check_access`;

DELIMITER $$
create procedure `check_access`(`name` varchar(255),`code` varchar(255)) begin
select COUNT(`id`),`id` into @count,@id
from `api_access`
where `api_access.name` = `name` and `api_access.code` = `code`;
if @count > 0 then
insert into `api_access_log` (`api_id`,`action`) values (@id,concat("access granted for ",`name`," using code ",`code`));
else
insert into `api_access_log` (`api_id`,`action`) values (@id,concat("access denied for ",`name`," using code ",`code`));
end if;
select @count,@id;
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure create_user
-- -----------------------------------------------------
DROP procedure IF EXISTS `create_user`;

DELIMITER $$


create procedure `create_user`(username varchar(45),`passwordhash` varchar(255)) begin
insert into users (`name`) VALUES (username);
set @id = LAST_INSERT_ID();
insert into `users_has_group` (`users_id`,`group_id`) VALUES (@id,1);
insert into `user_passwords` (`user_id`,`password`,`expired`) VALUES (@id,`passwordhash`,null);
end;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure find_user
-- -----------------------------------------------------
DROP procedure IF EXISTS `find_user`;

DELIMITER $$


create procedure `find_user`(`username` varchar(255)) begin
select `id` from `users` where `name` = `username`;
end;$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `localization_currency`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `localization_currency` (`id`, `name`, `format`) VALUES (1, 'www', 'BITCH');
INSERT INTO `localization_currency` (`id`, `name`, `format`) VALUES (2, 'no', 'NOK');
INSERT INTO `localization_currency` (`id`, `name`, `format`) VALUES (3, 'en-us', 'USD');
INSERT INTO `localization_currency` (`id`, `name`, `format`) VALUES (4, 'ch', 'CHF');
INSERT INTO `localization_currency` (`id`, `name`, `format`) VALUES (5, 'en-gb', 'GBP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `localization_datetime`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `localization_datetime` (`id`, `name`, `format`) VALUES (1, 'www', '%Y-%m-%d %T');
INSERT INTO `localization_datetime` (`id`, `name`, `format`) VALUES (2, 'no', '%T %d.%m.%Y');
INSERT INTO `localization_datetime` (`id`, `name`, `format`) VALUES (3, 'en-us', '%h %p %m/%d/%Y');
INSERT INTO `localization_datetime` (`id`, `name`, `format`) VALUES (4, 'ch', '%T %d.%m.%Y');
INSERT INTO `localization_datetime` (`id`, `name`, `format`) VALUES (5, 'en-gb', '%h %p %d.%m.%Y');

COMMIT;


-- -----------------------------------------------------
-- Data for table `group`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `group` (`id`, `name`) VALUES (1, 'members');
INSERT INTO `group` (`id`, `name`) VALUES (2, 'vips');
INSERT INTO `group` (`id`, `name`) VALUES (3, 'moderators');
INSERT INTO `group` (`id`, `name`) VALUES (4, 'admins');
INSERT INTO `group` (`id`, `name`) VALUES (5, 'developers');
INSERT INTO `group` (`id`, `name`) VALUES (6, 'map makers');
INSERT INTO `group` (`id`, `name`) VALUES (7, 'mojang');
INSERT INTO `group` (`id`, `name`) VALUES (8, 'oxeye games');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_titles`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `user_titles` (`id`, `name`, `short`) VALUES (1, 'Admin', 'ADM');
INSERT INTO `user_titles` (`id`, `name`, `short`) VALUES (2, 'Moderator', 'MOD');
INSERT INTO `user_titles` (`id`, `name`, `short`) VALUES (3, 'VIP', 'VIP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `project_roles`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `project_roles` (`id`, `name`) VALUES (1, 'Contributor');
INSERT INTO `project_roles` (`id`, `name`) VALUES (2, 'Maintainer');
INSERT INTO `project_roles` (`id`, `name`) VALUES (3, 'Manager');
INSERT INTO `project_roles` (`id`, `name`) VALUES (4, 'Benefactor');

COMMIT;


DELIMITER $$

DROP TRIGGER IF EXISTS `users_BUPD` $$
CREATE TRIGGER `users_BUPD` BEFORE UPDATE ON `users` FOR EACH ROW
SET New.edited_time = now();$$


DROP TRIGGER IF EXISTS `user_passwords_expire` $$
CREATE TRIGGER `user_passwords_expire` BEFORE INSERT ON `user_passwords` FOR EACH ROW
begin
UPDATE `user_passwords`
SET `expired` = NOW()
WHERE `expired` = null and `user_id` = New.user_id;
end;$$


DROP TRIGGER IF EXISTS `session_BINS` $$
CREATE TRIGGER `session_BINS` BEFORE INSERT ON `session` FOR EACH ROW
begin
SET NEW.ident = FLOOR(rand() * 10000000);
SET New.expires = timestampadd(DAY,1,NOW());
end;$$


DELIMITER ;
