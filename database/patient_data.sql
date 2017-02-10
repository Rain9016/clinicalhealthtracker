-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Feb 10, 2017 at 02:09 PM
-- Server version: 5.5.42
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `patient_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `hk_data`
--

CREATE TABLE `hk_data` (
  `id` bigint(20) unsigned NOT NULL,
  `unique_id` varchar(50) NOT NULL,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `steps` int(11) NOT NULL,
  `distance` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hk_data`
--
ALTER TABLE `hk_data`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hk_data`
--
ALTER TABLE `hk_data`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
