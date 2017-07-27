-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 27, 2017 at 04:00 PM
-- Server version: 5.6.35
-- PHP Version: 7.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `patient_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `height_weight_data`
--

CREATE TABLE `height_weight_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `height` varchar(10) NOT NULL,
  `weight` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hk_data`
--

CREATE TABLE `hk_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `steps` int(11) NOT NULL,
  `distance` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `location_data`
--

CREATE TABLE `location_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latitude` decimal(8,6) NOT NULL,
  `longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `survey_data`
--

CREATE TABLE `survey_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `question` varchar(100) NOT NULL,
  `answer` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `walk_test_data`
--

CREATE TABLE `walk_test_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `steps` int(11) NOT NULL,
  `distance` int(11) NOT NULL,
  `laps` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `height_weight_data`
--
ALTER TABLE `height_weight_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hk_data`
--
ALTER TABLE `hk_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location_data`
--
ALTER TABLE `location_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_data`
--
ALTER TABLE `survey_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `walk_test_data`
--
ALTER TABLE `walk_test_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `height_weight_data`
--
ALTER TABLE `height_weight_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hk_data`
--
ALTER TABLE `hk_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `location_data`
--
ALTER TABLE `location_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `survey_data`
--
ALTER TABLE `survey_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `walk_test_data`
--
ALTER TABLE `walk_test_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;