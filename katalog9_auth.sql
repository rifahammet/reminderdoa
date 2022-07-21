-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 13, 2022 at 06:39 PM
-- Server version: 8.0.29
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `katalog9_auth`
--

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `access_token` varchar(40) NOT NULL COMMENT 'access_token',
  `client_id` varchar(80) NOT NULL COMMENT 'Appid',
  `user_id` varchar(255) DEFAULT NULL COMMENT 'id',
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date("Y-m-d H:i:s")',
  `scope` varchar(2000) DEFAULT NULL COMMENT 'scope'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`access_token`, `client_id`, `user_id`, `scope`) VALUES
('06df08792cd03bcd10745afe3c00a8638704f598', 'doa', 'user', 'userinfo file node cloud share');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_authorization_codes`
--

CREATE TABLE `oauth_authorization_codes` (
  `authorization_code` varchar(40) NOT NULL COMMENT 'Authorization code，access_token',
  `client_id` varchar(80) NOT NULL COMMENT 'Appid',
  `user_id` varchar(255) DEFAULT NULL COMMENT 'id',
  `redirect_uri` varchar(2000) DEFAULT NULL COMMENT 'url',
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date("Y-m-d H:i:s")',
  `scope` varchar(2000) DEFAULT NULL COMMENT 'scope'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `client_id` varchar(80) NOT NULL COMMENT 'AppId',
  `client_secret` varchar(80) NOT NULL COMMENT 'AppSecret',
  `redirect_uri` varchar(2000) NOT NULL COMMENT 'url',
  `grant_types` varchar(80) DEFAULT NULL COMMENT 'grant_type',
  `scope` varchar(100) DEFAULT NULL COMMENT 'scope',
  `user_id` varchar(80) DEFAULT NULL COMMENT 'user_id'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`client_id`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`) VALUES
('client2', 'pass2', 'http://satualgoritma.com', 'authorization_code', 'file node userinfo cloud', 'xiaocao'),
('doa', '00ffa05b007a7ff50ac547e82df3ab85', 'http://satualgoritma.com', 'client_credentials password authorization_code refresh_token', 'file node userinfo cloud', 'xiaocao'),
('System', 'db08ec016f88fae0ef46fe40f60fbb18', 'http://satualgoritma.com', 'client_credentials password authorization_code refresh_token', 'file node userinfo cloud', 'xiaocao');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_jwt`
--

CREATE TABLE `oauth_jwt` (
  `client_id` varchar(80) NOT NULL COMMENT 'id',
  `subject` varchar(80) DEFAULT NULL,
  `public_key` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `refresh_token` varchar(40) NOT NULL COMMENT 'refresh_token for access_token',
  `client_id` varchar(80) NOT NULL COMMENT 'AppId',
  `user_id` varchar(255) DEFAULT NULL COMMENT 'id',
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date("Y-m-d H:i:s")',
  `scope` varchar(2000) DEFAULT NULL COMMENT 'scope'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`refresh_token`, `client_id`, `user_id`, `scope`) VALUES
('07570480bde7faa3245f0600210383d07f03234f', 'arbitbot', 'user', 'userinfo'),
('252203d02b494c4b45711548dba839a441f1b1cd', 'arbitbot', 'user', 'userinfo'),
('2877df56a4c208f3100f3994cd34bd444c10eb28', 'arbitbot', 'user', 'userinfo file node cloud share'),
('5609b63ec7042821d6976cf75a2d3a461c5ab2c5', 'arbitbot', 'user', 'userinfo file node cloud share'),
('5c41069ad59a23971bb6692a4f168fd14bd54f2f', 'System', 'user', 'userinfo'),
('5d32bb216e84b29cdef6d0570de885eb8d5d109f', 'arbitbot', 'user', 'userinfo'),
('65f3f51a3e7a9b20b204a20bbcaac5bb0b975d72', 'arbitbot', 'user', 'userinfo'),
('6c81cb95f4e9d96fea562114014edeefcb046c60', 'arbitbot', 'user', 'userinfo file node cloud share'),
('70497fda4427a85fd81d6d9defb77ac607c8e25a', 'arbitbot', 'user', 'userinfo'),
('8924061f26c22fd5953a91700eb76d7503f84558', 'arbitbot', 'user', 'userinfo file node cloud share'),
('91a94200733edfe8a44f2e94fa165051274a8591', 'arbitbot', 'user', 'userinfo file node cloud share'),
('d11af2e776f143678b06410a0dd5c257693cdeef', 'System', 'user', 'userinfo'),
('f2304c0e0faba4f483fae14cdd464ad35eeeef72', 'System', 'user', 'userinfo');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_scopes`
--

CREATE TABLE `oauth_scopes` (
  `scope` text COMMENT 'scope',
  `is_default` tinyint(1) DEFAULT NULL COMMENT 'Default 1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oauth_scopes`
--

INSERT INTO `oauth_scopes` (`scope`, `is_default`) VALUES
('userinfo', 1),
('file', 1),
('node', 1),
('cloud', 1),
('share', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_users`
--

CREATE TABLE `oauth_users` (
  `username` varchar(255) NOT NULL COMMENT 'username',
  `password` varchar(2000) DEFAULT NULL COMMENT 'password',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'firstname',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'lastname'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oauth_users`
--

INSERT INTO `oauth_users` (`username`, `password`, `first_name`, `last_name`) VALUES
('user', 'pass', 'xiaocao', 'grasses');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`access_token`);

--
-- Indexes for table `oauth_authorization_codes`
--
ALTER TABLE `oauth_authorization_codes`
  ADD PRIMARY KEY (`authorization_code`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `oauth_jwt`
--
ALTER TABLE `oauth_jwt`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`refresh_token`);

--
-- Indexes for table `oauth_users`
--
ALTER TABLE `oauth_users`
  ADD PRIMARY KEY (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
