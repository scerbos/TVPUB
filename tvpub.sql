-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 14, 2014 at 10:31 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tvpub`
--
CREATE DATABASE IF NOT EXISTS `tvpub` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `tvpub`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE IF NOT EXISTS `actor` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `writers` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE IF NOT EXISTS `genre` (
`id` int(11) NOT NULL,
  `genre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `genre_to_series`
--

CREATE TABLE IF NOT EXISTS `genre_to_series` (
`id` int(11) NOT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `poster` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `series_to_actor`
--

CREATE TABLE IF NOT EXISTS `series_to_actor` (
`id` int(11) NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `series_to_episode`
--

CREATE TABLE IF NOT EXISTS `series_to_episode` (
`id` int(11) NOT NULL,
  `series_id` int(11) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE IF NOT EXISTS `throttle` (
`id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `suspended` tinyint(4) NOT NULL DEFAULT '0',
  `banned` tinyint(4) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `hash` text NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `salt` text NOT NULL,
  `role` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_to_series`
--

CREATE TABLE IF NOT EXISTS `user_to_series` (
`id` int(11) NOT NULL,
  `rating` decimal(8,0) DEFAULT NULL,
  `comment` text,
  `user_id` int(11) DEFAULT NULL,
  `series_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_to_user`
--

CREATE TABLE IF NOT EXISTS `user_to_user` (
`id` int(11) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `circle` varchar(255) DEFAULT NULL,
  `user1_id` int(11) DEFAULT NULL,
  `user2_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(10) unsigned NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
`id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `episode`
--
ALTER TABLE `episode`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre_to_series`
--
ALTER TABLE `genre_to_series`
 ADD PRIMARY KEY (`id`), ADD KEY `genre_id_idx` (`genre_id`), ADD KEY `series_id_idx` (`series_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `groups_name_unique` (`name`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `group_id_UNIQUE` (`group_id`), ADD KEY `sender1_id_idx` (`sender_id`), ADD KEY `receiver_id_idx` (`receiver_id`), ADD KEY `message_id_idx` (`message_id`), ADD KEY `episode_id_idx` (`episode_id`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `series_to_actor`
--
ALTER TABLE `series_to_actor`
 ADD PRIMARY KEY (`id`), ADD KEY `actor_id_idx` (`actor_id`), ADD KEY `series_id_idx` (`series_id`);

--
-- Indexes for table `series_to_episode`
--
ALTER TABLE `series_to_episode`
 ADD PRIMARY KEY (`id`), ADD KEY `series_id_idx` (`series_id`), ADD KEY `episode_id_idx` (`episode_id`);

--
-- Indexes for table `throttle`
--
ALTER TABLE `throttle`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `email_UNIQUE` (`email`), ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- Indexes for table `user_to_series`
--
ALTER TABLE `user_to_series`
 ADD PRIMARY KEY (`id`), ADD KEY `user_id_idx` (`user_id`), ADD KEY `series_id_idx` (`series_id`);

--
-- Indexes for table `user_to_user`
--
ALTER TABLE `user_to_user`
 ADD PRIMARY KEY (`id`), ADD KEY `user1_id_idx` (`user1_id`), ADD KEY `user_id_idx` (`user2_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `users_email_unique` (`email`), ADD KEY `users_activation_code_index` (`activation_code`), ADD KEY `users_reset_password_code_index` (`reset_password_code`);

--
-- Indexes for table `users_groups`
--
ALTER TABLE `users_groups`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actor`
--
ALTER TABLE `actor`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `genre_to_series`
--
ALTER TABLE `genre_to_series`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `series_to_actor`
--
ALTER TABLE `series_to_actor`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `series_to_episode`
--
ALTER TABLE `series_to_episode`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_to_series`
--
ALTER TABLE `user_to_series`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_to_user`
--
ALTER TABLE `user_to_user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users_groups`
--
ALTER TABLE `users_groups`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `genre_to_series`
--
ALTER TABLE `genre_to_series`
ADD CONSTRAINT `genre_to_series_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `series_to_genre_id` FOREIGN KEY (`series_id`) REFERENCES `series` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
