-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 14, 2014 at 09:23 AM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tvpub`
--

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE IF NOT EXISTS `actor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`id`, `name`) VALUES
(1, 'Amy Poehler'),
(2, 'Nick Offerman'),
(3, 'Rashida Jones'),
(4, 'Jim Parsons'),
(5, 'Johnny Galecki'),
(6, 'Kaley Cuoco-Sweeting'),
(7, 'Simon Helbert'),
(8, 'Kunal Nayyar'),
(9, 'Mayim Bialik');

-- --------------------------------------------------------

--
-- Table structure for table `episode`
--

CREATE TABLE IF NOT EXISTS `episode` (
  `id` int(11) NOT NULL,
  `director` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `episode_number` int(11) DEFAULT NULL,
  `air_date` date DEFAULT NULL,
  `overview` text,
  `rating_tvdb` decimal(8,0) DEFAULT NULL,
  `season_number` int(11) DEFAULT NULL,
  `combined_episode_number` int(11) DEFAULT NULL,
  `guest_stars` text,
  `writers` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `episode`
--

INSERT INTO `episode` (`id`, `director`, `name`, `episode_number`, `air_date`, `overview`, `rating_tvdb`, `season_number`, `combined_episode_number`, `guest_stars`, `writers`) VALUES
(1, NULL, 'Make My Pit a Park', 1, NULL, 'Indiana government worker Leslie Knope is given the assignment to convert an abandoned quarry pit into a community park. A documentary film crew follows Leslie through her mishaps and gaffes as she tries to make her assignment a reality.', NULL, 1, NULL, NULL, NULL),
(2, NULL, 'Canvassing', 2, NULL, 'Leslie decides that she and her committee need to go door-to-door to gain support for the park project as well as support for an upcoming town hall meeting, but their mission does not go as planned. Meanwhile, Tom wanders away from the canvassing group and uses his own creative recruitment tactics.', NULL, 1, NULL, NULL, NULL),
(3, NULL, 'The Reporter', 3, NULL, 'Leslie arranges for a reporter to do a story about her park project, but she and her committee have the worst time staying on topic. She then calls Mark to help her save the story, but it ends up hurting more than helping. Meanwhile, Tom does all he can to suck up to his boss.', NULL, 1, NULL, NULL, NULL),
(4, NULL, 'Pawnee Zoo', 1, NULL, 'When Leslie decides to marry two penguins to promote the local zoo, she inadvertently causes an uproar when both penguins turn out to be male. Meanwhile, Mark puts Ann in an awkward situation when he asks her to go see a movie.', NULL, 2, NULL, NULL, NULL),
(5, NULL, 'The Stakeout', 2, NULL, 'While pruning the new community garden, Leslie and Tom find that someone has been growing marijuana. To find those responsible, they decide to have an all-night stakeout of the garden. Meanwhile, Ann asks Leslie''s permission to go on a date with Mark. ', NULL, 2, NULL, NULL, NULL),
(6, NULL, 'Pilot', 1, NULL, 'Brilliant physicist roommates Leonard and Sheldon meet their new neighbor Penny, who begins showing them that as much as they know about science, they know little about actual living.', NULL, 1, NULL, NULL, NULL),
(7, NULL, 'The Big Bran Hypothesis', 2, NULL, 'Leonard volunteers to sign for a package in an attempt to make a good impression on Penny, but when he enlists Sheldon for help, his attempt at chivalry goes terribly awry.', NULL, 1, NULL, NULL, NULL),
(8, NULL, 'The Fuzzy Boots Corollary', 3, NULL, 'Leonard asks a woman out after he finds out that Penny is seeing someone.', NULL, 1, NULL, NULL, NULL),
(9, NULL, 'The Luminous Fish Effect', 4, NULL, 'Sheldon''s getting fired forces him to explore what life has to offer outside physics, leaving Leonard to take drastic action to snap his friend out of his funk.', NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE IF NOT EXISTS `genre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `genre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `genre`) VALUES
(1, 'Comedy');

-- --------------------------------------------------------

--
-- Table structure for table `genre_to_series`
--

CREATE TABLE IF NOT EXISTS `genre_to_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `genre_id_idx` (`genre_id`),
  KEY `series_id_idx` (`series_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `genre_to_series`
--

INSERT INTO `genre_to_series` (`id`, `genre_id`, `series_id`) VALUES
(1, 1, 2),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` varchar(255) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `group_id` varchar(255) DEFAULT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `group_id_UNIQUE` (`group_id`),
  KEY `sender1_id_idx` (`sender_id`),
  KEY `receiver_id_idx` (`receiver_id`),
  KEY `message_id_idx` (`message_id`),
  KEY `episode_id_idx` (`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message`
--


-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--


-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE IF NOT EXISTS `series` (
  `id` int(11) NOT NULL,
  `air_day` date DEFAULT NULL,
  `air_time` time DEFAULT NULL,
  `IMDB_ID` int(11) DEFAULT NULL,
  `network` varchar(45) DEFAULT NULL,
  `overview` text,
  `rating_tvdb` decimal(8,0) DEFAULT NULL,
  `runtime` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `banner` varchar(255) DEFAULT NULL,
  `fanart` varchar(255) DEFAULT NULL,
  `poster` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`id`, `air_day`, `air_time`, `IMDB_ID`, `network`, `overview`, `rating_tvdb`, `runtime`, `name`, `status`, `banner`, `fanart`, `poster`) VALUES
(1, NULL, NULL, NULL, NULL, 'The series follows Leslie Knope, the deputy head of the Parks and Recreation department in the fictional town of Pawnee, Indiana. Knope takes on a project with a nurse named Ann to turn a construction pit into a park, while trying to mentor a bored college-aged intern. However, Leslie must fight through the bureaucrats, problem neighbors, and developers in order to make her dream a reality, all while with a camera crew recording her every gaff and mishap.', NULL, NULL, 'Parks and Recreation', NULL, NULL, NULL, NULL),
(2, NULL, NULL, NULL, NULL, 'What happens when hyperintelligent roommates Sheldon and Leonard meet Penny, a free-spirited beauty moving in next door, and realize they know next to nothing about life outside of the lab. Rounding out the crew are the smarmy Wolowitz, who thinks he''s as sexy as he is brainy, and Koothrappali, who suffers from an inability to speak in the presence of a woman.', NULL, NULL, 'The Big Bang Theory', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `series_to_actor`
--

CREATE TABLE IF NOT EXISTS `series_to_actor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actor_id_idx` (`actor_id`),
  KEY `series_id_idx` (`series_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `series_to_actor`
--

INSERT INTO `series_to_actor` (`id`, `actor_id`, `series_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 2),
(8, 8, 2),
(9, 9, 2);

-- --------------------------------------------------------

--
-- Table structure for table `series_to_episode`
--

CREATE TABLE IF NOT EXISTS `series_to_episode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `series_id` int(11) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `series_id_idx` (`series_id`),
  KEY `episode_id_idx` (`episode_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `series_to_episode`
--

INSERT INTO `series_to_episode` (`id`, `series_id`, `episode_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 2, 6),
(7, 2, 7),
(8, 2, 8),
(9, 2, 9);

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE IF NOT EXISTS `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `suspended` tinyint(4) NOT NULL DEFAULT '0',
  `banned` tinyint(4) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `throttle`
--


-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `hash` text NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `salt` text NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `user`
--


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `activated` tinyint(4) NOT NULL DEFAULT '0',
  `activation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persist_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_activation_code_index` (`activation_code`),
  KEY `users_reset_password_code_index` (`reset_password_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `users`
--


-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `users_groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_to_series`
--

CREATE TABLE IF NOT EXISTS `user_to_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` decimal(8,0) DEFAULT NULL,
  `comment` text,
  `user_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `series_id_idx` (`series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `user_to_series`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_to_user`
--

CREATE TABLE IF NOT EXISTS `user_to_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL,
  `circle` varchar(255) DEFAULT NULL,
  `user1_id` int(11) DEFAULT NULL,
  `user2_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user1_id_idx` (`user1_id`),
  KEY `user_id_idx` (`user2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `user_to_user`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `genre_to_series`
--
ALTER TABLE `genre_to_series`
  ADD CONSTRAINT `genre_to_series_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `series_to_genre_id` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
