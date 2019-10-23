-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Aug 16, 2019 at 09:02 PM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_phungb`
--
CREATE DATABASE IF NOT EXISTS `cs340_phungb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cs340_phungb`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`cs340_phungb`@`%` PROCEDURE `UpdateSeriesResult` (IN `URL` VARCHAR(100), IN `Team1` VARCHAR(3), IN `Team2` VARCHAR(3))  NO SQL
BEGIN

	declare Team1_Won boolean;
    set Team1_Won = (select Team1_HasWon from Matches M where URL = M.YT_URL and M.Team1 = Team1 and M.Team2 = Team2);
    
    #declare lul varchar(3);
    #set lul = (select T.League from Teams T where T.TeamID = Team1);
   	
    if((select T.League from Teams T where T.TeamID = Team1) = 'LCS' or (select T.League from Teams T where T.TeamID = Team1) = 'LEC') then
        if(Team1_Won = 1) then 
            update Teams 
            set Wins = Wins+1
            where Teams.TeamID = Team1;

            update Teams 
            set Losses = Losses+1
            where Teams.TeamID = Team2;

         ELSE
            update Teams
            set Wins = Wins+1
            where Teams.TeamID = Team2;

            update Teams 
            set Losses = Losses+1
            where Teams.TeamID = Team1;
         end if;
    end if;
END$$

--
-- Functions
--
CREATE DEFINER=`cs340_phungb`@`%` FUNCTION `isStarterStatus` (`start` BOOLEAN) RETURNS VARCHAR(3) CHARSET utf8 NO SQL
BEGIN
	if (start = 1) then 
    	return "Yes"; 
    else  
    	return "No";
    end if;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE `Account` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Account`
--

INSERT INTO `Account` (`Username`, `Password`) VALUES
('Nindoge', '7bba04a420a2a53177e5a4054207e4aa');

-- --------------------------------------------------------

--
-- Table structure for table `Champion`
--

CREATE TABLE `Champion` (
  `ChampionName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Champion`
--

INSERT INTO `Champion` (`ChampionName`) VALUES
('Aatrox'),
('Ahri'),
('Akali'),
('Alistar'),
('Amumu'),
('Anivia'),
('Annie'),
('Ashe'),
('Aurelion Sol'),
('Azir'),
('Bard'),
('Blitzcrank'),
('Brand'),
('Braum'),
('Caitlyn'),
('Camille'),
('Cassiopeia'),
('Chogath'),
('Corki'),
('Darius'),
('Diana'),
('Dr. Mundo'),
('Draven'),
('Ekko'),
('Elise'),
('Evelynn'),
('Ezreal'),
('Fiddlesticks'),
('Fiora'),
('Fizz'),
('Galio'),
('Gangplank'),
('Garen'),
('Gnar'),
('Gragas'),
('Graves'),
('Hecarim'),
('Heimerdinger'),
('Illaoi'),
('Irelia'),
('Ivern'),
('Janna'),
('Jarvan IV'),
('Jax'),
('Jayce'),
('Jhin'),
('Jinx'),
('Kaisa'),
('Kalista'),
('Karma'),
('Karthus'),
('Kassadin'),
('Katarina'),
('Kayle'),
('Kayn'),
('Kennen'),
('Khazix'),
('Kindred'),
('Kled'),
('Kogmaw'),
('LeBlanc'),
('Lee Sin'),
('Leona'),
('Lissandra'),
('Lucian'),
('Lulu'),
('Lux'),
('Malphite'),
('Malzahar'),
('Maokai'),
('Master Yi'),
('Miss Fortune'),
('Mordekaiser'),
('Morgana'),
('Nami'),
('Nasus'),
('Nautilus'),
('Neeko'),
('Nidalee'),
('Nocturne'),
('Nunu and Willump'),
('Olaf'),
('Orianna'),
('Ornn'),
('Pantheon'),
('Poppy'),
('Pyke'),
('Qiyana'),
('Quinn'),
('Rakan'),
('Rammus'),
('Reksai'),
('Renekton'),
('Rengar'),
('Riven'),
('Rumble'),
('Ryze'),
('Sejuani'),
('Shaco'),
('Shen'),
('Shyvana'),
('Singed'),
('Sion'),
('Sivir'),
('Skarner'),
('Sona'),
('Soraka'),
('Swain'),
('Sylas'),
('Syndra'),
('Tahm Kench'),
('Taliyah'),
('Talon'),
('Taric'),
('Teemo'),
('Thresh'),
('Tristana'),
('Trundle'),
('Tryndamere'),
('Twisted Fate'),
('Twitch'),
('Udyr'),
('Urgot'),
('Varus'),
('Vayne'),
('Veigar'),
('Velkoz'),
('Vi'),
('Viktor'),
('Vladimir'),
('Volibear'),
('Warwick'),
('Wukong'),
('Xayah'),
('Xerath'),
('Xin Zhao'),
('Yasuo'),
('Yorick'),
('Yuumi'),
('Zac'),
('Zed'),
('Ziggs'),
('Zilean'),
('Zoe'),
('Zyra');

-- --------------------------------------------------------

--
-- Table structure for table `Matches`
--

CREATE TABLE `Matches` (
  `YT_URL` varchar(100) NOT NULL,
  `Team1` varchar(50) NOT NULL,
  `Team1_HasWon` tinyint(1) DEFAULT NULL,
  `Team2` varchar(50) NOT NULL,
  `Team2_HasWon` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Matches`
--

INSERT INTO `Matches` (`YT_URL`, `Team1`, `Team1_HasWon`, `Team2`, `Team2_HasWon`) VALUES
('https://youtu.be/-57MlWIysRM', 'HLE', 1, 'KT', 0),
('https://youtu.be/0D1-cCUX7fk', 'GEN', 1, 'DWG', 0),
('https://youtu.be/0u0OpQQh0jQ', 'FLY', 0, 'GGS', 1),
('https://youtu.be/3_OQdTOv7aI', 'CG', 0, 'C9', 1),
('https://youtu.be/45LStnxX6xM', 'C9', 1, 'FLY', 0),
('https://youtu.be/4pnzElf7hpo', '100', 0, 'OPT', 1),
('https://youtu.be/5maIwMPmq28', 'FOX', 1, 'TL', 0),
('https://youtu.be/8Y3Qey8LU8I', 'OG', 1, 'VIT', 0),
('https://youtu.be/9fPR1wwK6U4', 'JAG', 0, 'KT', 1),
('https://youtu.be/9xZXbSbjTLg', 'TL', 1, '100', 0),
('https://youtu.be/Amc6-LE_nBo', 'GEN', 0, 'DWG', 1),
('https://youtu.be/aqH2LbBOnbc', 'SKT', 1, 'JAG', 0),
('https://youtu.be/ByiOIrEF3uI', 'AF', 1, 'GRF', 0),
('https://youtu.be/CFIjgsZhWis', 'KT', 1, 'JAG', 0),
('https://youtu.be/cXjF6a_qD4E', '100', 0, 'CG', 1),
('https://youtu.be/dl1DV8SWkt4', 'KZ', 1, 'GEN', 0),
('https://youtu.be/e45oIpJeewU', 'OPT', 1, 'CG', 0),
('https://youtu.be/fasfsdafsda', 'FNC', 0, 'G2', 1),
('https://youtu.be/g-Cf2-vBp0M', 'IG', 0, 'RNG', 1),
('https://youtu.be/G2D3SzLD00k', 'JAG', 1, 'SKT', 0),
('https://youtu.be/gvFx-7oeDZw', 'G2', 1, 'SPY', 0),
('https://youtu.be/HDht1NF6Esg', 'DWG', 0, 'GEN', 1),
('https://youtu.be/HK_4MxQ7hlE', 'FLY', 0, 'OPT', 1),
('https://youtu.be/HVPscnD5rLM', 'TSM', 1, 'CLG', 0),
('https://youtu.be/i-8mjyhNZes', 'CLG', 1, '100', 0),
('https://youtu.be/ibBYp-MTRfA', 'S04', 1, 'XL', 0),
('https://youtu.be/jEg2DNYtrHA', 'CG', 1, 'GGS', 0),
('https://youtu.be/lUASu7hRWRw', 'TSM', 0, 'TL', 1),
('https://youtu.be/M6cD4EcGG54', 'GGS', 1, 'FOX', 0),
('https://youtu.be/nntQ5aw88II', 'GRF', 1, 'AF', 0),
('https://youtu.be/oJnukphHk5g', 'FOX', 0, 'TSM', 1),
('https://youtu.be/pdmri1Q8hX4', 'OG', 0, 'G2', 1),
('https://youtu.be/ppGij_x2Utk', 'RGE', 0, 'MSF', 1),
('https://youtu.be/ptZC8Fcrpls', 'OPT', 1, 'CLG', 0),
('https://youtu.be/q0UU1x82rEI', 'GGS', 1, 'C9', 0),
('https://youtu.be/q8iYY9ai0B0', 'KT', 0, 'HLE', 1),
('https://youtu.be/qxX878WinCU', 'SB', 1, 'HLE', 0),
('https://youtu.be/r1dKJapbyO8', 'HLE', 0, 'SB', 1),
('https://youtu.be/R6YninVwLBc', 'CLG', 1, 'TL', 0),
('https://youtu.be/tiHM5-H9vcg', 'SKT', 1, 'JAG', 0),
('https://youtu.be/TKvWJkro2Lg', 'FNC', 1, 'SK', 0),
('https://youtu.be/umqoyqrbAJE', 'GRF', 1, 'AF', 0),
('https://youtu.be/waWxbDKVflE', 'GEN', 0, 'KZ', 1),
('https://youtu.be/XRQHj-WHZ30', 'TSM', 0, 'FLY', 1),
('https://youtu.be/Y3Ob8Fa3Au0', 'C9', 1, 'FOX', 0);

--
-- Triggers `Matches`
--
DELIMITER $$
CREATE TRIGGER `CheckValidMatch` BEFORE INSERT ON `Matches` FOR EACH ROW BEGIN
	#check if the teams exist
    if new.Team1 not in (select T.TeamID from Teams T) THEN
    	SIGNAL SQLSTATE '45000'
        set MESSAGE_TEXT = 'This team does not exist';
    end if;
    if new.Team2 not in (select T.TeamID from Teams T) THEN
    	signal sqlstate '45000'
        set MESSAGE_TEXT = 'This team does not exist';
    end if;
    
    #check if the teams are different
	if new.Team1 = new.Team2 THEN
    	signal sqlstate '45000'
        set MESSAGE_TEXT = 'Must have 2 different teams';
    end if;
    
    #check if the teams are in the same league
    if (select distinct T.League from Teams T, Player P where P.TeamID = T.TeamID and P.TeamID = new.Team1) <> (select distinct T.League from Teams T, Player P where P.TeamID = T.TeamID and P.TeamID = new.Team2) THEN
    	signal sqlstate '45000'
        set MESSAGE_TEXT = 'These teams are not in the same league';
    end if;



END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `MatchInfo`
--

CREATE TABLE `MatchInfo` (
  `MatchID` varchar(100) NOT NULL,
  `Team1_ID` varchar(3) NOT NULL,
  `PickT1_1` varchar(50) DEFAULT NULL,
  `PickT1_2` varchar(50) DEFAULT NULL,
  `PickT1_3` varchar(50) DEFAULT NULL,
  `PickT1_4` varchar(50) DEFAULT NULL,
  `PickT1_5` varchar(50) DEFAULT NULL,
  `BanT1_1` varchar(50) DEFAULT NULL,
  `BanT1_2` varchar(50) DEFAULT NULL,
  `BanT1_3` varchar(50) DEFAULT NULL,
  `BanT1_4` varchar(50) DEFAULT NULL,
  `BanT1_5` varchar(50) DEFAULT NULL,
  `Team2_ID` varchar(3) NOT NULL,
  `PickT2_1` varchar(50) DEFAULT NULL,
  `PickT2_2` varchar(50) DEFAULT NULL,
  `PickT2_3` varchar(50) DEFAULT NULL,
  `PickT2_4` varchar(50) DEFAULT NULL,
  `PickT2_5` varchar(50) DEFAULT NULL,
  `BanT2_1` varchar(50) DEFAULT NULL,
  `BanT2_2` varchar(50) DEFAULT NULL,
  `BanT2_3` varchar(50) DEFAULT NULL,
  `BanT2_4` varchar(50) DEFAULT NULL,
  `BanT2_5` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `MatchInfo`
--

INSERT INTO `MatchInfo` (`MatchID`, `Team1_ID`, `PickT1_1`, `PickT1_2`, `PickT1_3`, `PickT1_4`, `PickT1_5`, `BanT1_1`, `BanT1_2`, `BanT1_3`, `BanT1_4`, `BanT1_5`, `Team2_ID`, `PickT2_1`, `PickT2_2`, `PickT2_3`, `PickT2_4`, `PickT2_5`, `BanT2_1`, `BanT2_2`, `BanT2_3`, `BanT2_4`, `BanT2_5`) VALUES
('https://youtu.be/-57MlWIysRM', 'HLE', 'Irelia', 'Jarvan IV', 'LeBlanc', 'Kalista', 'Lux', 'Pyke', 'Neeko', 'Lee Sin', 'Fiora', 'Sylas', 'KT', 'Jax', 'Skarner', 'Akali', 'Ezreal', 'Yuumi', 'Aatrox', 'Sejuani', 'Olaf', 'Ryze', 'Gragas'),
('https://youtu.be/0D1-cCUX7fk', 'GEN', 'Kennen', 'Sejuani', 'Lissandra', 'Xayah', 'Rakan', 'Sona', 'Ryze', 'Tahm Kench', 'Yasuo', 'Sivir', 'DWG', 'Vladimir', 'Gragas', 'Aatrox', 'Kaisa', 'Lux', 'Sylas', 'Yuumi', 'Ezreal', 'LeBlanc', 'Irelia'),
('https://youtu.be/0u0OpQQh0jQ', 'FLY', 'Pyke', 'Jarvan IV', 'Ryze', 'Xayah', 'Rakan', 'Varus', 'Aatrox', 'Sylas', 'Akali', 'Velkoz', 'GGS', 'Jayce', 'Reksai', 'Anivia', 'Ezreal', 'Tahm Kench', 'Irelia', 'Taric', 'Yuumi', 'Skarner', 'Vi'),
('https://youtu.be/3_OQdTOv7aI', 'CG', 'Pyke', 'Lee Sin', 'Sylas', 'Xayah', 'Rakan', 'Irelia', 'Yuumi', 'Aatrox', 'Hecarim', 'Kindred', 'C9', 'Camille', 'Reksai', 'Akali', 'Sona', 'Taric', 'Jayce', 'Rumble', 'Ryze', 'Neeko', 'Kennen'),
('https://youtu.be/45LStnxX6xM', 'C9', 'Aatrox', 'Hecarim', 'Sylas', 'Varus', 'Galio', 'Draven', 'Rakan', 'Reksai', 'Ezreal', 'Sejuani', 'FLY', 'Irelia', 'Vi', 'Ryze', 'Xayah', 'Braum', 'Jayce', 'Yuumi', 'Sona', 'Sivir', 'Kaisa'),
('https://youtu.be/4pnzElf7hpo', '100', 'Ornn', 'Sejuani', 'Akali', 'Sivir', 'Morgana', 'Ryze', 'Yuumi', 'Taric', 'Rakan', 'LeBlanc', 'OPT', 'Jayce', 'Jarvan IV', 'Vladimir', 'Xayah', 'Nautilus', 'Aatrox', 'Sylas', 'Irelia', 'Braum', 'Thresh'),
('https://youtu.be/5maIwMPmq28', 'FOX', 'Gangplank', 'Skarner', 'Sylas', 'Kaisa', 'Galio', 'Ryze', 'Irelia', 'Aatrox', 'Rumble', 'Olaf', 'TL', 'Vladimir', 'Reksai', 'Akali', 'Xayah', 'Rakan', 'Yuumi', 'Jayce', 'Taric', 'Jarvan IV', 'Camille'),
('https://youtu.be/8Y3Qey8LU8I', 'OG', 'Jarvan IV', 'Sejuani', 'Camille', 'Sona', 'Tahm Kench', 'Ryze', 'Draven', 'Sylas', 'Renekton', 'Gangplank', 'VIT', 'Jayce', 'Olaf', 'Azir', 'Sivir', 'Taric', 'Aatrox', 'Irelia', 'Yuumi', 'Neeko', 'LeBlanc'),
('https://youtu.be/9fPR1wwK6U4', 'JAG', 'Ryze', 'Olaf', 'Taliyah', 'Ezreal', 'Tahm Kench', 'Irelia', 'Sejuani', 'Sylas', 'LeBlanc', 'Kaisa', 'KT', 'Pyke', 'Lee Sin', 'Akali', 'Kalista', 'Nautilus', 'Reksai', 'Yuumi', 'Aatrox', 'Ashe', 'Varus'),
('https://youtu.be/9xZXbSbjTLg', 'TL', 'Jayce', 'Trundle', 'Azir', 'Xayah', 'Rakan', 'Irelia', 'Yuumi', 'Sona', 'Neeko', 'Yorick', '100', 'Jarvan IV', 'Olaf', 'Orianna', 'Sivir', 'Nautilus', 'Aatrox', 'Sylas', 'Ryze', 'Reksai', 'Sejuani'),
('https://youtu.be/Amc6-LE_nBo', 'GEN', 'Aatrox', 'Lee Sin', 'Lissandra', 'Ezreal', 'Braum', 'Irelia', 'Taliyah', 'Ryze', 'Viktor', 'Yasuo', 'DWG', 'Fiora', 'Sejuani', 'Camille', 'Sona', 'Tahm Kench', 'Neeko', 'Sylas', 'Yuumi', 'Akali', 'LeBlanc'),
('https://youtu.be/aqH2LbBOnbc', 'SKT', 'Kennen', 'Skarner', 'Sylas', 'Ezreal', 'Rakan', 'Irelia', 'Lux', 'Yuumi', 'Neeko', 'Olaf', 'JAG', 'Aatrox', 'Reksai', 'Cassiopeia', 'Xayah', 'Nautilus', 'Ryze', 'Sejuani', 'Lee Sin', 'Jayce', 'Jarvan IV'),
('https://youtu.be/ByiOIrEF3uI', 'AF', 'Yorick', 'Sejuani', 'Ryze', 'Sivir', 'Galio', 'Rakan', 'Kindred', 'Aatrox', 'Lucian', 'Kalista', 'GRF', 'Jayce', 'Lee Sin', 'Sylas', 'Vayne', 'Nautilus', 'Olaf', 'Vladimir', 'Yuumi', 'Lux', 'Irelia'),
('https://youtu.be/CFIjgsZhWis', 'KT', 'Neeko', 'Olaf', 'Syndra', 'Sivir', 'Lux', 'Aatrox', 'Yuumi', 'Ryze', 'Yasuo', 'Kindred', 'JAG', 'Sylas', 'Lee Sin', 'Zoe', 'Xayah', 'Rakan', 'Irelia', 'Jayce', 'Sejuani', 'Ezreal', 'LeBlanc'),
('https://youtu.be/cXjF6a_qD4E', '100', 'Neeko', 'Jarvan IV', 'Azir', 'Sona', 'Taric', 'Ryze', 'Jayce', 'Irelia', 'Lee Sin', 'LeBlanc', 'CG', 'Rumble', 'Skarner', 'Lux', 'Xayah', 'Rakan', 'Aatrox', 'Yuumi', 'Sylas', 'Hecarim', 'Camille'),
('https://youtu.be/dl1DV8SWkt4', 'KZ', 'Sylas', 'Karthus', 'Jayce', 'Sivir', 'Lux', 'Yuumi', 'Skarner', 'Aatrox', 'Lissandra', 'LeBlanc', 'GEN', 'Neeko', 'Lee Sin', 'Zoe', 'Ezreal', 'Tahm Kench', 'Reksai', 'Sejuani', 'Ryze', 'Gragas', 'Lulu'),
('https://youtu.be/e45oIpJeewU', 'OPT', 'Poppy', 'Sejuani', 'Twisted Fate', 'Xayah', 'Nautilus', 'Aatrox', 'Taric', 'Sylas', 'Sivir', 'Kaisa', 'CG', 'Rumble', 'Lee Sin', 'Jayce', 'Varus', 'Braum', 'Irelia', 'Yuumi', 'Ryze', 'Leblanc', 'Rakan'),
('https://youtu.be/fasfsdafsda', 'FNC', 'Kled', 'Sejuani', 'Azir', 'Xayah', 'Pyke', 'Rakan', 'Yuumi', 'Corki', 'Elise', 'Lee Sin', 'G2', 'Aatrox', 'Gragas', 'Twisted Fate', 'Karma', 'Tahm Kench', 'Qiyana', 'Yasuo', 'Lucian', 'Irelia', 'Sylas'),
('https://youtu.be/g-Cf2-vBp0M', 'IG', 'Karma', 'Sejuani', 'Qiyana', 'Xayah', 'Rakan', 'Tahm Kench', 'Gragas', 'Olaf', 'Kennen', 'Rumble', 'RNG', 'Aatrox', 'Jarvan IV', 'Neeko', 'Kaisa', 'Nautilus', 'Zoe', 'LeBlanc', 'Yuumi', 'Sylas', 'Jayce'),
('https://youtu.be/G2D3SzLD00k', 'JAG', 'Akali', 'Reksai', 'Corki', 'Lucian', 'Nautilus', 'Neeko', 'Sylas', 'Yuumi', 'Ezreal', 'Sivir', 'SKT', 'Aatrox', 'Skarner', 'Lissandra', 'Xayah', 'Lux', 'Lee Sin', 'Sejuani', 'Ryze', 'Kalista', 'Fiora'),
('https://youtu.be/gvFx-7oeDZw', 'G2', 'Neeko', 'Jarvan IV', 'Sylas', 'Lucian', 'Braum', 'Yuumi', 'Aatrox', 'Xayah', 'Thresh', 'Jayce', 'SPY', 'Rumble', 'Reksai', 'Ryze', 'Sivir', 'Rakan', 'Draven', 'Irelia', 'Elise', 'Alistar', 'Kalista'),
('https://youtu.be/HDht1NF6Esg', 'DWG', 'Gangplank', 'Skarner', 'Sylas', 'Ezreal', 'Braum', 'Irelia', 'Sejuani', 'Tahm Kench', 'Rakan', 'Lux', 'GEN', 'Aatrox', 'Reksai', 'LeBlanc', 'Sivir', 'Shen', 'Neeko', 'Ryze', 'Yuumi', 'Kennen', 'Lissandra'),
('https://youtu.be/HK_4MxQ7hlE', 'FLY', 'Kennen', 'Lee Sin', 'Jayce', 'Xayah', 'Lux', 'Yuumi', 'Ryze', 'Sejuani', 'Leblanc', 'Syndra', 'OPT', 'Poppy', 'Olaf', 'Twisted Fate', 'Sivir', 'Nautilus', 'Aatrox', 'Sylas', 'Irelia', 'Vladimir', 'Morgana'),
('https://youtu.be/HVPscnD5rLM', 'TSM', 'Jayce', 'Hecarim', 'Zilean', 'Sona', 'Taric', 'Ryze', 'Yuumi', 'Sylas', 'Neeko', 'Leblanc', 'CLG', 'Rumble', 'Reksai', 'Orianna', 'Varus', 'Zyra', 'Aatrox', 'Sejuani', 'Irelia', 'Akali', 'Yasuo'),
('https://youtu.be/i-8mjyhNZes', 'CLG', 'Kennen', 'Sejuani', 'Orianna', 'Sivir', 'Yuumi', 'Irelia', 'Akali', 'Morgana', 'Jayce', 'Vladimir', '100', 'Rumble', 'Jarvan IV', 'Azir', 'Xayah', 'Rakan', 'Sylas', 'Ryze', 'Aatrox', 'LeBlanc', 'Neeko'),
('https://youtu.be/ibBYp-MTRfA', 'S04', 'Rumble', 'Elise', 'Aatrox', 'Vayne', 'Braum', 'Heimerdinger', 'Irelia', 'Yuumi', 'Sona', 'Sivir', 'XL', 'Renekton', 'Sejuani', 'Jayce', 'Jinx', 'Tahm Kench', 'Sylas', 'Xayah', 'Ryze', 'Nautilus', 'Kaisa'),
('https://youtu.be/jEg2DNYtrHA', 'CG', 'Rumble', 'Jarvan IV', 'Sylas', 'Jinx', 'Nautilus', 'Olaf', 'Yuumi', 'Draven', 'Braum', 'Tahm Kench', 'GGS', 'Neeko', 'Sejuani', 'Corki', 'Ezreal', 'Thresh', 'Aatrox', 'Irelia', 'Ryze', 'Sivir', 'Xayah'),
('https://youtu.be/lUASu7hRWRw', 'TSM', 'Irelia', 'Sejuani', 'Azir', 'Ezreal', 'Galio', 'Jayce', 'Taric', 'Akali', 'Jarvan IV', 'Reksai', 'TL', 'Kennen', 'Olaf', 'Sylas', 'Xayah', 'Rakan', 'Ryze', 'Yuumi', 'Aatrox', 'Draven', 'Sivir'),
('https://youtu.be/M6cD4EcGG54', 'GGS', 'Sylas', 'Skarner', 'Irelia', 'Ezreal', 'Tahm Kench', 'Yuumi', 'Taric', 'Aatrox', 'Kalista', 'Xayah', 'FOX', 'Akali', 'Reksai', 'Ryze', 'Sivir', 'Nautilus', 'Varus', 'Galio', 'Jayce', 'Sejuani', 'Braum'),
('https://youtu.be/nntQ5aw88II', 'GRF', 'Jayce', 'Sejuani', 'Camille', 'Ezreal', 'Lux', 'Kindred', 'Azir', 'Ryze', 'Lissandra', 'Akali', 'AF', 'Vladimir', 'Lee Sin', 'Irelia', 'Yasuo', 'Nautilus', 'Sylas', 'Yuumi', 'Aatrox', 'Yorick', 'Sivir'),
('https://youtu.be/oJnukphHk5g', 'FOX', 'Rumble', 'Nocturne', 'Aatrox', 'Sivir', 'Nautilus', 'Olaf', 'Irelia', 'Ryze', 'LeBlanc', 'Jarvan IV', 'TSM', 'Kennen', 'Hecarim', 'Zilean', 'Lucian', 'Yuumi', 'Sona', 'Camille', 'Sylas', 'Sejuani', 'Skarner'),
('https://youtu.be/pdmri1Q8hX4', 'OG', 'Vladimir', 'Jarvan IV', 'Syndra', 'Xayah', 'Morgana', 'Yuumi', 'Sona', 'Sylas', 'Renekton', 'Camille', 'G2', 'Kennen', 'Sejuani', 'Jayce', 'Ezreal', 'Rakan', 'Ryze', 'Irelia', 'Aatrox', 'Neeko', 'LeBlanc'),
('https://youtu.be/ppGij_x2Utk', 'RGE', 'Rumble', 'Reksai', 'Sylas', 'Kaisa', 'Rakan', 'Draven', 'Yuumi', 'Xayah', 'Cassiopeia', 'Azir', 'MSF', 'Jarvan IV', 'Elise', 'Jayce', 'Lucian', 'Nautilus', 'Ryze', 'Aatrox', 'Irelia', 'Sona', 'Sivir'),
('https://youtu.be/ptZC8Fcrpls', 'OPT', 'Poppy', 'Sejuani', 'Sylas', 'Sivir', 'Thresh', 'Sona', 'Yuumi', 'Ryze', 'Rakan', 'Orianna', 'CLG', 'Vladimir', 'Jarvan IV', 'Irelia', 'Xayah', 'Lux', 'Aatrox', 'Akali', 'Neeko', 'Jayce', 'Leona'),
('https://youtu.be/q0UU1x82rEI', 'GGS', 'Kennen', 'Olaf', 'Anivia', 'Varus', 'Tahm Kench', 'Yuumi', 'Sona', 'Sylas', 'Hecarim', 'Jarvan IV', 'C9', 'Neeko', 'Reksai', 'Azir', 'Xayah', 'Lux', 'Irelia', 'Ryze', 'Aatrox', 'Rumble', 'Jayce'),
('https://youtu.be/q8iYY9ai0B0', 'KT', 'Ryze', 'Reksai', 'Fizz', 'Varus', 'Tahm Kench', 'Sejuani', 'Lee Sin', 'Yuumi', 'Zoe', 'Ezreal', 'HLE', 'Aatrox', 'Skarner', 'Taliyah', 'Xayah', 'Pyke', 'Olaf', 'Irelia', 'Sylas', 'LeBlanc', 'Ashe'),
('https://youtu.be/qxX878WinCU', 'SB', 'Sylas', 'Lee Sin', 'Zoe', 'Varus', 'Tahm Kench', 'Irelia', 'Olaf', 'Sejuani', 'Braum', 'Xayah', 'HLE', 'Vladimir', 'Jarvan IV', 'Ryze', 'Ashe', 'Thresh', 'Yuumi', 'Neeko', 'Aatrox', 'Jayce', 'Kennen'),
('https://youtu.be/r1dKJapbyO8', 'HLE', 'Sylas', 'Reksai', 'Akali', 'Varus', 'Tahm Kench', 'Olaf', 'Yuumi', 'Aatrox', 'Skarner', 'Kindred', 'SB', 'Ryze', 'Gragas', 'Yasuo', 'Xayah', 'Rakan', 'Jayce', 'Irelia', 'Sejuani', 'Ezreal', 'Zoe'),
('https://youtu.be/R6YninVwLBc', 'CLG', 'Aatrox', 'Sejuani', 'Viktor', 'Caitlyn', 'Lux', 'Irelia', 'Sona', 'Xayah', 'LeBlanc', 'Akali', 'TL', 'Kennen', 'Olaf', 'Sylas', 'Sivir', 'Karma', 'Yuumi', 'Ryze', 'Rumble', 'Lucian', 'Kaisa'),
('https://youtu.be/tiHM5-H9vcg', 'SKT', 'Akali', 'Jarvan IV', 'Ryze', 'Ezreal', 'Braum', 'Irelia', 'Olaf', 'Yuumi', 'Zoe', 'Kalista', 'JAG', 'Neeko', 'Reksai', 'Sylas', 'Xayah', 'Nautilus', 'Aatrox', 'Sejuani', 'Lee Sin', 'Galio', 'Morgana'),
('https://youtu.be/TKvWJkro2Lg', 'FNC', 'Gnar', 'Elise', 'Irelia', 'Sivir', 'Thresh', 'Sylas', 'Rakan', 'Reksai', 'Olaf', 'Lee Sin', 'SK', 'Neeko', 'Jarvan IV', 'Azir', 'Xayah', 'Nautilus', 'Aatrox', 'Yuumi', 'Sejuani', 'Braum', 'Jayce'),
('https://youtu.be/umqoyqrbAJE', 'GRF', 'Jayce', 'Sejuani', 'Camille', 'Kaisa', 'Lux', 'Irelia', 'Kindred', 'Ryze', 'Kalista', 'Lucian', 'AF', 'Neeko', 'Lee Sin', 'Azir', 'Xayah', 'Nautilus', 'Sylas', 'Yuumi', 'Aatrox', 'Ezreal', 'Zoe'),
('https://youtu.be/waWxbDKVflE', 'GEN', 'Irelia', 'Sejuani', 'Neeko', 'Viktor', 'Pyke', 'Sylas', 'Ezreal', 'Rakan', 'Trundle', 'Olaf', 'KZ', 'Aatrox', 'Skarner', 'Lissandra', 'Vayne', 'Yuumi', 'Karthus', 'Lux', 'Ryze', 'Sona', 'Morgana'),
('https://youtu.be/XRQHj-WHZ30', 'TSM', 'Pyke', 'Hecarim', 'Ryze', 'Sona', 'Taric', 'Irelia', 'Yuumi', 'Olaf', 'Ezreal', 'Sivir', 'FLY', 'Riven', 'Elise', 'Jayce', 'Caitlyn', 'Lux', 'Aatrox', 'Sylas', 'Sejuani', 'Zilean', 'Camille'),
('https://youtu.be/Y3Ob8Fa3Au0', 'C9', 'Neeko', 'Jarvan IV', 'Azir', 'Sona', 'Taric', 'Irelia', 'Sylas', 'Yuumi', 'Rakan', 'Lux', 'FOX', 'Jayce', 'Gragas', 'Akali', 'Xayah', 'Veigar', 'Olaf', 'Ryze', 'Aatrox', 'Hecarim', 'Camille');

--
-- Triggers `MatchInfo`
--
DELIMITER $$
CREATE TRIGGER `CheckMatchExists` BEFORE INSERT ON `MatchInfo` FOR EACH ROW BEGIN
	#check if both teams exist in the DB
	if new.Team1_ID not in (select T.TeamID from Teams T) or new.Team2_ID not in (select T.TeamID from Teams T) then 
    	signal sqlstate '45000'
        set message_text = 'Please input an existing team';
    end if;
    
    #check if the teams are different
    if new.Team1_ID = new.Team2_ID then 
    	signal sqlstate '45000'
        set message_text = 'Please input two different teams';
    end if;
    
    #check if the teams belong in the same league
    if (select distinct T.League from Teams T, Player P where P.TeamID = T.TeamID and P.TeamID = new.Team1_ID) <> (select distinct T.League from Teams T, Player P where P.TeamID = T.TeamID and P.TeamID = new.Team2_ID) then
    	signal sqlstate '45000'
        set message_text = 'Please input two teams that are in the same league';
    end if;
  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `CheckUniqueChampions` BEFORE INSERT ON `MatchInfo` FOR EACH ROW BEGIN
	#annoyingly, check every single tuple for even a single duplicate
    
	if (new.PickT1_1 <> new.PickT1_2 and new.PickT1_1 <> new.PickT1_3 and new.PickT1_1 <> new.PickT1_4 and new.PickT1_1 <>  new.PickT1_5 and new.PickT1_1 <> new.BanT1_1 and new.PickT1_1 <>  new.BanT1_2 and new.PickT1_1 <> new.BanT1_3 and new.PickT1_1 <> new.BanT1_4 and new.PickT1_1 <> new.BanT1_5 and new.PickT1_1  <>  new.PickT2_1 and new.PickT1_1 <> new.PickT2_2 and new.PickT1_1 <> new.PickT2_3 and new.PickT1_1 <> new.PickT2_4  and new.PickT1_1 <> new.PickT2_5 and new.PickT1_1 <> new.BanT2_1 and new.PickT1_1 <> new.BanT2_2 and new.PickT1_1 <> new.BanT2_3 and new.PickT1_1 <> new.BanT2_4 and new.PickT1_1<> new.BanT2_5)  = false then
       	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
        end if;
	
    if (new.PickT1_2 <> new.PickT1_3 and new.PickT1_2 <> new.PickT1_4 and new.PickT1_2 <>  new.PickT1_5 and new.PickT1_2 <> new.BanT1_1 and new.PickT1_2 <>  new.BanT1_2 and new.PickT1_2 <> new.BanT1_3 and new.PickT1_2 <> new.BanT1_4 and new.PickT1_2 <> new.BanT1_5 and new.PickT1_2  <>  new.PickT2_1 and new.PickT1_2 <> new.PickT2_2 and new.PickT1_2 <> new.PickT2_3 and new.PickT1_2 <> new.PickT2_4  and new.PickT1_2 <> new.PickT2_5 and new.PickT1_2 <> new.BanT2_1 and new.PickT1_2 <> new.BanT2_2 and new.PickT1_2 <> new.BanT2_3 and new.PickT1_2 <> new.BanT2_4 and new.PickT1_2 <> new.BanT2_5)  = false then 	
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT1_3 <> new.PickT1_4 and new.PickT1_3 <>  new.PickT1_5 and new.PickT1_3 <> new.BanT1_1 and new.PickT1_3 <>  new.BanT1_2 and new.PickT1_3 <> new.BanT1_3 and new.PickT1_3 <> new.BanT1_4 and new.PickT1_3 <> new.BanT1_5 and new.PickT1_3  <>  new.PickT2_1 and new.PickT1_3 <> new.PickT2_2 and new.PickT1_3 <> new.PickT2_3 and new.PickT1_3 <> new.PickT2_4  and new.PickT1_3 <> new.PickT2_5 and new.PickT1_3 <> new.BanT2_1 and new.PickT1_3 <> new.BanT2_2 and new.PickT1_3 <> new.BanT2_3 and new.PickT1_3 <> new.BanT2_4 and new.PickT1_3 <> new.BanT2_5)  = false then 	
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;

	if (new.PickT1_4 <>  new.PickT1_5 and new.PickT1_4 <> new.BanT1_1 and new.PickT1_4 <>  new.BanT1_2 and new.PickT1_4 <> new.BanT1_3 and new.PickT1_4 <> new.BanT1_4 and new.PickT1_4 <> new.BanT1_5 and new.PickT1_4 <>  new.PickT2_1 and new.PickT1_4 <> new.PickT2_2 and new.PickT1_4 <> new.PickT2_3 and new.PickT1_4 <> new.PickT2_4  and new.PickT1_4 <> new.PickT2_5 and new.PickT1_4 <> new.BanT2_1 and new.PickT1_4 <> new.BanT2_2 and new.PickT1_4 <> new.BanT2_3 and new.PickT1_4 <> new.BanT2_4 and new.PickT1_4 <> new.BanT2_5)  = false then 	
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT1_5 <> new.BanT1_1 and new.PickT1_5 <>  new.BanT1_2 and new.PickT1_5 <> new.BanT1_3 and new.PickT1_5 <> new.BanT1_4 and new.PickT1_5 <> new.BanT1_5 and new.PickT1_5 <>  new.PickT2_1 and new.PickT1_5 <> new.PickT2_2 and new.PickT1_5 <> new.PickT2_3 and new.PickT1_5 <> new.PickT2_4  and new.PickT1_5 <> new.PickT2_5 and new.PickT1_5 <> new.BanT2_1 and new.PickT1_5 <> new.BanT2_2 and new.PickT1_5 <> new.BanT2_3 and new.PickT1_5 <> new.BanT2_4 and new.PickT1_5 <> new.BanT2_5)  = false then 	
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT1_1 <>  new.BanT1_2 and new.BanT1_1 <> new.BanT1_3 and new.BanT1_1 <> new.BanT1_4 and new.BanT1_1 <> new.BanT1_5 and new.BanT1_1 <>  new.PickT2_1 and new.BanT1_1 <> new.PickT2_2 and new.BanT1_1 <> new.PickT2_3 and new.BanT1_1 <> new.PickT2_4  and new.BanT1_1 <> new.PickT2_5 and new.BanT1_1 <> new.BanT2_1 and new.BanT1_1 <> new.BanT2_2 and new.BanT1_1 <> new.BanT2_3 and new.BanT1_1 <> new.BanT2_4 and new.BanT1_1 <> new.BanT2_5)  = false then 	
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT1_2 <> new.BanT1_3 and new.BanT1_2 <> new.BanT1_4 and new.BanT1_2 <> new.BanT1_5 and new.BanT1_2 <>  new.PickT2_1 and new.BanT1_2 <> new.PickT2_2 and new.BanT1_2 <> new.PickT2_3 and new.BanT1_2 <> new.PickT2_4  and new.BanT1_2 <> new.PickT2_5 and new.BanT1_2 <> new.BanT2_1 and new.BanT1_2 <> new.BanT2_2 and new.BanT1_2 <> new.BanT2_3 and new.BanT1_2 <> new.BanT2_4 and new.BanT1_2 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT1_3 <> new.BanT1_4 and new.BanT1_3 <> new.BanT1_5 and new.BanT1_3 <>  new.PickT2_1 and new.BanT1_3 <> new.PickT2_2 and new.BanT1_3 <> new.PickT2_3 and new.BanT1_3 <> new.PickT2_4  and new.BanT1_3 <> new.PickT2_5 and new.BanT1_3 <> new.BanT2_1 and new.BanT1_3 <> new.BanT2_2 and new.BanT1_3 <> new.BanT2_3 and new.BanT1_3 <> new.BanT2_4 and new.BanT1_3 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT1_4 <> new.BanT1_5 and new.BanT1_4 <>  new.PickT2_1 and new.BanT1_4 <> new.PickT2_2 and new.BanT1_4 <> new.PickT2_3 and new.BanT1_4 <> new.PickT2_4  and new.BanT1_4 <> new.PickT2_5 and new.BanT1_4 <> new.BanT2_1 and new.BanT1_4 <> new.BanT2_2 and new.BanT1_4 <> new.BanT2_3 and new.BanT1_4 <> new.BanT2_4 and new.BanT1_4 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT1_5 <> new.PickT2_1 and new.BanT1_5 <> new.PickT2_2 and new.BanT1_5 <> new.PickT2_3 and new.BanT1_5 <> new.PickT2_4  and new.BanT1_5 <> new.PickT2_5 and new.BanT1_5 <> new.BanT2_1 and new.BanT1_5 <> new.BanT2_2 and new.BanT1_5 <> new.BanT2_3 and new.BanT1_5 <> new.BanT2_4 and new.BanT1_5 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT2_1 <> new.PickT2_2 and new.PickT2_1 <> new.PickT2_3 and new.PickT2_1 <> new.PickT2_4  and new.PickT2_1 <> new.PickT2_5 and new.PickT2_1 <> new.BanT2_1 and new.PickT2_1 <> new.BanT2_2 and new.PickT2_1 <> new.BanT2_3 and new.PickT2_1 <> new.BanT2_4 and new.PickT2_1 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT2_2 <> new.PickT2_3 and new.PickT2_2 <> new.PickT2_4  and new.PickT2_2 <> new.PickT2_5 and new.PickT2_2 <> new.BanT2_1 and new.PickT2_2 <> new.BanT2_2 and new.PickT2_2 <> new.BanT2_3 and new.PickT2_2 <> new.BanT2_4 and new.PickT2_2 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT2_3 <> new.PickT2_4 and new.PickT2_3 <> new.PickT2_5 and new.PickT2_3 <> new.BanT2_1 and new.PickT2_3 <> new.BanT2_2 and new.PickT2_3 <> new.BanT2_3 and new.PickT2_3 <> new.BanT2_4 and new.PickT2_3 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT2_4 <> new.PickT2_5 and new.PickT2_4 <> new.BanT2_1 and new.PickT2_4 <> new.BanT2_2 and new.PickT2_4 <> new.BanT2_3 and new.PickT2_4 <> new.BanT2_4 and new.PickT2_4 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.PickT2_5 <> new.BanT2_1 and new.PickT2_5 <> new.BanT2_2 and new.PickT2_5 <> new.BanT2_3 and new.PickT2_5 <> new.BanT2_4 and new.PickT2_5 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT2_1 <> new.BanT2_2 and new.BanT2_1 <> new.BanT2_3 and new.BanT2_1 <> new.BanT2_4 and new.BanT2_1 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT2_2 <> new.BanT2_3 and new.BanT2_2 <> new.BanT2_4 and new.BanT2_2 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT2_3 <> new.BanT2_4 and new.BanT2_3 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;
    
    if (new.BanT2_4 <> new.BanT2_5)  = false then 
    	signal sqlstate '45000'
        set message_text = 'Please make all of the champions picked/banned be unique';
    end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Player`
--

CREATE TABLE `Player` (
  `FirstName` varchar(50) NOT NULL,
  `IGN` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Role` varchar(50) NOT NULL,
  `Origin` varchar(50) NOT NULL,
  `isStarter` tinyint(1) NOT NULL,
  `TeamID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Player`
--

INSERT INTO `Player` (`FirstName`, `IGN`, `LastName`, `Role`, `Origin`, `isStarter`, `TeamID`) VALUES
('Aaron', 'FakeGod', 'Lee', 'Top Lane', 'USA', 1, '100'),
('Adam', 'LIDER', 'Ilyasov', 'Mid Lane', 'Norway', 1, 'MSF'),
('Aleksi', 'H1IVA', 'Kaikkonen', 'Bot Lane Support', 'Finland', 1, 'MSF'),
('Alfonso', 'Mithy', 'Aguirre Rodriguez', 'Bot Lane Support', 'Spain', 1, 'OG'),
('Amadeu', 'Attila', 'Carvalho', 'Bot Lane Carry', 'Portugal', 1, 'VIT'),
('An', 'Ian', 'Jun-hyeong', 'Mid Lane', 'Korea', 0, 'VG'),
('Andrei', 'Odoamne', 'Pascu', 'Top Lane', 'Romania', 1, 'S04'),
('Andrei', 'Orome', 'Popa', 'Top Lane', 'Romania', 0, 'SPY'),
('Andrei', 'Xerxe', 'Dragomir', 'Jungle', 'Romania', 1, 'SPY'),
('Andy', 'Smoothie', 'Ta', 'Bot Lane Support', 'USA', 1, 'TSM'),
('Appolo', 'Appolo', 'Price', 'Bot Lane Carry', 'USA', 1, 'FOX'),
('Ashkan', 'TF Blade', 'Homayouni', 'Top Lane', 'USA', 0, 'TL'),
('Austin', 'Gate', 'Yu', 'Bot Lane Support', 'China', 0, 'OPT'),
('Bae', 'Bang', 'Jun-sik', 'Bot Lane Carry', 'Korea', 1, '100'),
('Bae', 'Holder', 'Jae-cheol', 'Top Lane', 'Korea', 1, 'RW'),
('Bae', 'Plex', 'Ho-young', 'Mid Lane', 'Korea', 1, 'LNG'),
('Bai', '369', 'Jia-Hao', 'Top Lane', 'China', 1, 'TES'),
('Barney', 'Alphari', 'Morris', 'Top Lane', 'United Kingdom', 1, 'OG'),
('Byun', 'Gango', 'Se-hoon', 'Bot Lane Carry', 'Korea', 0, 'KT'),
('Chen', 'Curse', 'Chen', 'Top Lane', 'China', 1, 'OMG'),
('Chen', 'GALA', 'Wei', 'Bot Lane Carry', 'China', 1, 'DMO'),
('Chen', 'Haro', 'Wen-Lin', 'Jungle', 'China', 1, 'RW'),
('Chen', 'Jay', 'Bo', 'Mid Lane', 'China', 1, 'VG'),
('Chen', 'Kane', 'Hao', 'Bot Lane Carry', 'China', 1, 'OMG'),
('Chen', 'Pyl', 'Bo', 'Bot Lane Support', 'China', 1, 'LGD'),
('Chen', 'World6', 'Yu-Tian', 'Jungle', 'China', 1, 'OMG'),
('Cho', 'BeryL', 'Geon-hee', 'Bot Lane Support', 'Korea', 1, 'DWG'),
('Cho', 'Joker', 'Jae-eup', 'Bot Lane Support', 'Korea', 1, 'SB'),
('Cho', 'Mata', 'Se-hyeong', 'Bot Lane Support', 'Korea', 0, 'SKT'),
('Choi', 'CheonGo', 'Hyeon-woo', 'Mid Lane', 'Korea', 0, 'JAG'),
('Choi', 'Doran', 'Hyeon-joon', 'Top Lane', 'Korea', 1, 'GRF'),
('Choi', 'Huhi', 'Jae-hyun', 'Bot Lane Support', 'USA', 1, 'GGS'),
('Choi', 'Pirean', 'Jun-sik', 'Mid Lane', 'Korea', 0, 'SK'),
('Choi', 'Sword', 'Sung-won', 'Top Lane', 'Korea', 0, 'GRF'),
('Christian', 'Taxer', 'Vendelbo', 'Jungle', 'Denmark', 0, 'XL'),
('Cody', 'Cody Sun', 'Sun', 'Bot Lane Carry', 'China', 1, 'CG'),
('Colin', 'Solo', 'Earnest', 'Top Lane', 'USA', 1, 'FOX'),
('Dai', 'Cube', 'Yi', 'Top Lane', 'China', 1, 'VG'),
('Daniele', 'Jiizuke', 'di Mauro', 'Mid Lane', 'Italy', 1, 'VIT'),
('Danny', 'Dan Dan', 'Le Comte', 'Top Lane', 'Spain', 1, 'MSF'),
('Dennis', 'Svenskeren', 'Johnsen', 'Jungle', 'Denmark', 1, 'C9'),
('Ding', 'Kui', 'Zi-Hao', 'Jungle', 'China', 0, 'LGD'),
('Ding', 'Puff', 'Wang', 'Bot Lane Carry', 'China', 1, 'VG'),
('Duan', 'Duan', 'De-Liang', 'Bot Lane Support', 'China', 1, 'LNG'),
('Elias', 'Upset', 'Lipp', 'Bot Lane Carry', 'Germany', 1, 'S04'),
('Emil', 'Larssen', 'Larsson', 'Mid Lane', 'Sweden', 1, 'RGE'),
('Eom', 'UmTi', 'Seong-hyeon', 'Jungle', 'Korea', 0, 'KT'),
('Eric', 'Licorice', 'Ritchie', 'Top Lane', 'Canada', 1, 'C9'),
('Erlend', 'Nukeduck', 'Vatevik Holm', 'Mid Lane', 'Norway', 1, 'OG'),
('Eugene', 'Pobelter', 'Park', 'Mid Lane', 'USA', 1, 'FLY'),
('Fabian', 'Exile', 'Schubert', 'Mid Lane', 'Germnay', 0, 'XL'),
('Fabian', 'Febiven', 'Diepstraten', 'Mid Lane', 'Netherlands', 0, 'MSF'),
('Fang', 'Garvey', 'Jia-Wei', 'Top Lane', 'China', 1, 'LGD'),
('Felix', 'Abbedagge', 'Braun', 'Mid Lane', 'Germany', 1, 'S04'),
('Felix', 'MagiFelix', 'Bostrom', 'Mid Lane', 'Sweden', 0, 'FNC'),
('Finn', 'Finn', 'Wiestal', 'Top Lane', 'Sweden', 1, 'RGE'),
('Gabriel', 'Bwipo', 'Rau', 'Top Lane', 'Romania', 1, 'FNC'),
('Galen', 'Moon', 'Holgate', 'Jungle', 'USA', 0, 'CLG'),
('Gao', 'Ning', 'Zhen-Ning', 'Jungle', 'China', 1, 'IG'),
('Gao', 'Tian', 'Tian-Liang', 'Jungle', 'China', 1, 'FPX'),
('Go', 'Score', 'Dong-bin', 'Jungle', 'Korea', 1, 'KT'),
('Gu', 'Imp', 'Seung-bin', 'Bot Lane Carry', 'Korea', 1, 'JDG'),
('Guo', 'Lies', 'Hao-Tian', 'Top Lane', 'China', 0, 'LGD'),
('Gwak', 'BDD', 'Bo-seong', 'Mid Lane', 'Korea', 1, 'KT'),
('Gwon', 'Sangyoon', 'Sang-yun', 'Bot Lane Carry', 'Korea', 1, 'HLE'),
('Ha', 'Kramer', 'Jong-hun', 'Bot Lane Carry', 'Korea', 1, 'LGD'),
('Han', 'Dreams', 'Min-hook', 'Bot Lane Support', 'Korea', 1, 'SK'),
('Han', 'Leo', 'Gyeo-re', 'Bot Lane Carry', 'Korea', 0, 'SKT'),
('Han', 'Peanut', 'Wang-ho', 'Jungle', 'Korea', 1, 'GEN'),
('Han', 'Smlz', 'Jin', 'Bot Lane Carry', 'China', 1, 'SN'),
('Henrik', 'Froggen', 'Hansen', 'Mid Lane', 'Denmark', 1, 'GGS'),
('Heo', 'Huni', 'Seung-hoon', 'Top Lane', 'Korea', 1, 'CG'),
('Heo', 'Lindarang', 'Man-heung', 'Top Lane', 'Korea', 1, 'JAG'),
('Heo', 'PawN', 'Won-seok', 'Mid Lane', 'Korea', 0, 'KZ'),
('Heo', 'ShowMaker', 'Su', 'Mid Lane', 'Korea', 1, 'DWG'),
('Him', 'GimGoon', 'Han-saem', 'Top Lane', 'Korea', 1, 'FPX'),
('Hu', 'iBoy', 'Xian-Zhao', 'Bot Lane Carry', 'China', 1, 'EDG'),
('Hu', 'Natural', 'Jia-Le', 'Top Lane', 'China', 1, 'DMO'),
('Hu', 'SwordArt', 'Shuo-Chieh', 'Bot Lane Support', 'China', 1, 'SN'),
('Hu', 'Y1han', 'Zhi-Wei', 'Jungle', 'China', 0, 'OMG'),
('Hu', 'Yuuki', 'Hao-Ming', 'Mid Lane', 'China', 1, 'LGD'),
('Huang', 'Aliez', 'Hao', 'Top Lane', 'China', 0, 'V5'),
('Huang', 'Maple', 'Yi-Tang', 'Mid Lane', 'Taiwan', 1, 'SN'),
('Huang', 'Twila', 'Ting-Wei', 'Mid Lane', 'China', 1, 'DMO'),
('Hung', 'Karsa', 'Hao-Hsuan', 'Jungle', 'Taiwan', 1, 'RNG'),
('Hwang', 'Kingen', 'Seong-hoon', 'Top Lane', 'Korea', 1, 'KT'),
('Jack', 'Xmithie', 'Puchero', 'Jungle', 'Philippines', 1, 'TL'),
('Jakub', 'Jactroll', 'Skurzynski', 'Bot Lane Support', 'Poland', 1, 'VIT'),
('Jang', 'Ghost', 'Yong-jun', 'Bot Lane Carry', 'Korea', 1, 'SB'),
('Jang', 'Nuguri', 'Ha-gwon', 'Top Lane', 'Korea', 1, 'DWG'),
('Janik', 'Jenax', 'Bartels', 'Mid Lane', 'Germany', 1, 'SK'),
('Jason', 'WildTurtle', 'Tran', 'Bot Lane Carry', 'Canada', 1, 'FLY'),
('Jeon', 'Zenit', 'Tae-gwon', 'Bot Lane Carry', 'Korea', 0, 'KT'),
('Jeong', 'Chovy', 'Ji-hoon', 'Mid Lane', 'Korea', 1, 'GRF'),
('Jeong', 'Kabbie', 'Sang-hyeon', 'Bot Lane Support', 'Korea', 0, 'GRF'),
('Jesper', 'Jeskla', 'Klarin Stromberg', 'Bot Lane Carry', 'Sweden', 1, 'XL'),
('Jesper', 'Zven', 'Svenninsen', 'Bot Lane Carry', 'Denmark', 1, 'TSM'),
('Jian', 'Uzi', 'Zi-Hao', 'Bot Lane Carry', 'China', 1, 'RNG'),
('Jiang', 'beishang', 'Zhi-Peng', 'Jungle', 'China', 1, 'WE'),
('Jiang', 'Jiangqiao', 'Jia-Feng', 'Top Lane', 'China', 0, 'RW'),
('Jin', 'Mystic', 'Seong-jun', 'Bot Lane Carry', 'Korea', 1, 'WE'),
('Jo', 'CoreJJ', 'Yong-in', 'Bot Lane Support', 'Korea', 1, 'TL'),
('Jonas', 'Kold', 'Andersen', 'Jungle', 'Denmark', 1, 'OG'),
('Jonas', 'Memento', 'Elmarghichi', 'Jungle', 'Sweden', 0, 'S04'),
('Jonathan', 'Grig', 'Armao', 'Jungle', 'USA', 0, 'TSM'),
('Joran', 'Special', 'Scheffer', 'Mid Lane', 'Netherlands', 0, 'XL'),
('Joshua', 'Dardoch', 'Hartnett', 'Jungle', 'USA', 0, 'OPT'),
('Juan', 'Contractz', 'Garcia', 'Jungle', 'USA', 1, 'GGS'),
('Juan', 'JayJ', 'Guibert', 'Bot Lane Support', 'Canada', 0, 'FLY'),
('Jung', 'Impact', 'Eon-yeong', 'Top Lane', 'Korea', 1, 'TL'),
('Jus', 'Crownshot', 'Marusic', 'Bot Lane Carry', 'Slovenia', 1, 'SK'),
('Kacper', 'Inspired', 'Sloma', 'Jungle', 'Poland', 1, 'RGE'),
('Kang', 'ADD', 'Geon-mo', 'Top Lane', 'Korea', 1, 'BLG'),
('Kang', 'Haru', 'Min-seung', 'Jungle', 'Korea', 0, 'SKT'),
('Kang', 'Tempt', 'Myung-gu', 'Mid Lane', 'Korea', 1, 'HLE'),
('Kang', 'TheShy', 'Seung-lok', 'Top Lane', 'Korea', 1, 'IG'),
('Kasper', 'Kobbe', 'Kobberup', 'Bot Lane Carry', 'Denmark', 1, 'SPY'),
('Kevin', 'FallenBandit', 'Wu', 'Top Lane', 'USA', 0, 'CLG'),
('Kevin', 'Hauntzer', 'Yarnell', 'Top Lane', 'USA', 1, 'GGS'),
('Ki', 'Expect', 'Dae-han', 'Top Lane', 'Korea', 1, 'XL'),
('Kim', 'Aiming', 'Ha-ram', 'Bot Lane Carry', 'Korea', 1, 'AF'),
('Kim', 'Asper', 'Tae-gi', 'Bot Lane Support', 'Korea', 0, 'GEN'),
('Kim', 'bonO', 'Gi-beom', 'Jungle', 'Korea', 1, 'HLE'),
('Kim', 'Canyon', 'Geon-bu', 'Jungle', 'Korea', 1, 'DWG'),
('Kim', 'Clid', 'Tae-min', 'Jungle', 'Korea', 1, 'SKT'),
('Kim', 'Crazy', 'Jae-hee', 'Top Lane', 'Korea', 0, 'SKT'),
('Kim', 'Crush', 'Jun-seo', 'Jungle', 'Korea', 0, 'SB'),
('Kim', 'Deft', 'Hyuk-kyu', 'Bot Lane Carry', 'Korea', 1, 'KZ'),
('Kim', 'Doinb', 'Tae-sang', 'Mid Lane', 'Korea', 1, 'FPX'),
('Kim', 'Dove', 'Jae-yeon', 'Mid Lane', 'Korea', 1, 'SB'),
('Kim', 'Fenix', 'Jae-hun', 'Mid Lane', 'Korea', 1, 'FOX'),
('Kim', 'Gori', 'Tae-woo', 'Mid Lane', 'Korea', 0, 'SKT'),
('Kim', 'Kellin', 'Hyeong-gyu', 'Bot Lane Support', 'Korea', 0, 'JAG'),
('Kim', 'key', 'Han-gi', 'Bot Lane Support', 'Korea', 1, 'HLE'),
('Kim', 'Khan', 'Dong-ha', 'Top Lane', 'Korea', 1, 'SKT'),
('Kim', 'Kiin', 'Gi-in', 'Top Lane', 'Korea', 1, 'AF'),
('Kim', 'Lava', 'Tae-hoon', 'Mid Lane', 'Korea', 0, 'HLE'),
('Kim', 'Life', 'Jeong-min', 'Bot Lane Support', 'Korea', 1, 'GEN'),
('Kim', 'Malrang', 'Geun-seong', 'Jungle', 'Korea', 1, 'JAG'),
('Kim', 'Moojin', 'Moo-jin', 'Jungle', 'Korea', 0, 'HLE'),
('Kim', 'Olleh', 'Joo-sung', 'Bot Lane Support', 'Korea', 0, 'GGS'),
('Kim', 'OnFleek', 'Jang-gyeom', 'Jungle', 'Korea', 1, 'SB'),
('Kim', 'Poss', 'Min-cheol', 'Top Lane', 'Korea', 1, 'WE'),
('Kim', 'PraY', 'Jong-in', 'Bot Lane Carry', 'Korea', 1, 'KT'),
('Kim', 'Profit', 'Jun-hyung', 'Top Lane', 'Korea', 0, 'RGE'),
('Kim', 'Rascal', 'Kwang-hee', 'Top Lane', 'Korea', 1, 'KZ'),
('Kim', 'Roach', 'Kang-hui', 'Top Lane', 'Korea', 0, 'GEN'),
('Kim', 'Ruin', 'Hyeong-min', 'Top Lane', 'Korea', 1, 'CLG'),
('Kim', 'Seize', 'Chan-hee', 'Jungle', 'Korea', 0, 'JAG'),
('Kim', 'SoHwan', 'Jun-yeong', 'Top Lane', 'Korea', 1, 'HLE'),
('Kim', 'Ssumday', 'Chan-ho', 'Top Lane', 'Korea', 0, '100'),
('Kim', 'SSUN', 'Tae-yang', 'Mid Lane', 'Korea', 0, 'AF'),
('Kim', 'Trick', 'Gang-yun', 'Jungle', 'Korea', 1, 'S04'),
('Kim', 'Wadid', 'Bae-in', 'Bot Lane Support', 'Korea', 1, 'FLY'),
('Kirean', 'Allorim', 'Logue', 'Top Lane', 'USA', 0, 'OPT'),
('Lawrence', 'Lost', 'Hui', 'Bot Lane Carry', 'Australia', 0, 'FOX'),
('Le', 'SofM', 'Quang Duy', 'Jungle', 'Vietnam', 1, 'LNG'),
('Lee', 'Aries', 'Chae-hawn', 'Bot Lane Carry', 'Korea', 0, 'DWG'),
('Lee', 'Bambi', 'Gyu-bin', 'Bot Lane Carry', 'Korea', 0, 'JAG'),
('Lee', 'Brook', 'Jang-hoon', 'Top Lane', 'Korea', 0, 'AF'),
('Lee', 'Crown', 'Min-ho', 'Mid Lane', 'Korea', 1, 'OPT'),
('Lee', 'CuVee', 'Seong-jin', 'Top Lane', 'Korea', 1, 'GEN'),
('Lee', 'Dread', 'Jin-hyeok', 'Jungle', 'Korea', 1, 'AF'),
('Lee', 'Duke', 'Ho-seong', 'Top Lane', 'Korea', 0, 'IG'),
('Lee', 'Effort', 'Sang-ho', 'Bot Lane Support', 'Korea', 1, 'SKT'),
('Lee', 'Faker', 'Sang-hyeok', 'Mid Lane', 'Korea', 1, 'SKT'),
('Lee', 'Flame', 'Ho-jong', 'Top Lane', 'Korea', 0, 'DWG'),
('Lee', 'Grace', 'Chan-ju', 'Mid Lane', 'Korea', 1, 'JAG'),
('Lee', 'IgNar', 'Dong-geun', 'Bot Lane Support', 'Korea', 1, 'S04'),
('Lee', 'Kuro', 'Seo-haeng', 'Mid Lane', 'Korea', 1, 'BLG'),
('Lee', 'Kuzan', 'Seong-hyeok', 'Mid Lane', 'Korea', 0, 'GEN'),
('Lee', 'LokeN', 'Dong-wook', 'Bot Lane Carry', 'Korea', 1, 'TES'),
('Lee', 'Mowgli', 'Jae-ha', 'Jungle', 'Korea', 1, 'VIT'),
('Lee', 'Rich', 'Jae-won', 'Mid Lane', 'Korea', 0, 'GEN'),
('Lee', 'Scout', 'Ye-chan', 'Mid Lane', 'Korea', 1, 'EDG'),
('Lee', 'Spirit', 'Da-yoon', 'Jungle', 'Korea', 0, 'AF'),
('Lee', 'TaNa', 'Sang-wook', 'Top Lane', 'Korea', 0, 'JAG'),
('Lee', 'Tarzan', 'Seung-yong', 'Jungle', 'Korea', 1, 'GRF'),
('Lei', 'Corn', 'Wen', 'Mid Lane', 'China', 0, 'VG'),
('Li', 'Aix', 'Yang', 'Jungle', 'China', 1, 'VG'),
('Li', 'Chelly', 'Yu-Zhou', 'Bot Lane Support', 'China', 1, 'OMG'),
('Li', 'Flandre', 'Xuan-Jun', 'Top Lane', 'China', 1, 'LNG'),
('Li', 'Max', 'Xiao-Qiang', 'Bot Lane Support', 'China', 1, 'V5'),
('Li', 'Mole', 'Hao-Yan', 'Mid Lane', 'China', 1, 'V5'),
('Li', 'Xiaohu', 'Yuan-Hao', 'Mid Lane', 'China', 1, 'RNG'),
('Li', 'XinMo', 'Qian-Xi', 'Bot Lane Support', 'China', 1, 'BLG'),
('Liang', 'RD', 'Ten-Li', 'Bot Lane Support', 'Taiwan', 0, 'LGD'),
('Lim', 'Jinoo', 'Jin-woo', 'Top Lane', 'Korea', 1, 'EDG'),
('Lin', 'Lwx', 'Wei-Xiang', 'Bot Lane Carry', 'China', 1, 'FPX'),
('Ling', 'Mark', 'Xu', 'Bot Lane Support', 'China', 1, 'DMO'),
('Liu', 'Crisp', 'Qing-SOng', 'Bot Lane Support', 'China', 1, 'FPX'),
('Liu', 'Five', 'Shi-Yu', 'Bot Lane Support', 'China', 0, 'OMG'),
('Liu', 'Hudle', 'Yan-Zhu', 'Bot Lane Support', 'China', 0, 'OMG'),
('Liu', 'Killua', 'Dan-Yang', 'Bot Lane Support', 'China', 0, 'RW'),
('Lou', 'Missing', 'Yun-Feng', 'Bot Lane Support', 'China', 1, 'WE'),
('Lu', 'Asura', 'Qi', 'Bot Lane Carry', 'China', 1, 'LNG'),
('Lucas', 'Cabochard', 'Simon-Meslet', 'Top Lane', 'France', 1, 'VIT'),
('Lucas', 'Saken', 'Fayard', 'Mid Lane', 'France', 0, 'VIT'),
('Lucas', 'Santorin', 'Tao Kilmer Larsen', 'Jungle', 'Denmark', 1, 'FLY'),
('Luka', 'Perkz', 'Perkovic', 'Bot Lane Carry', 'Croatia', 1, 'G2'),
('Mads', 'Broxah', 'Brock-Pedersen', 'Jungle', 'Denmark', 1, 'FNC'),
('Magnus', 'Maxi', 'Kristnesen', 'Mid Lane', 'Denmark', 0, 'FLY'),
('Marc', 'Caedrel', 'Robert Lamont', 'Jungle', 'United Kingdom', 1, 'XL'),
('Marcel', 'Scarlet', 'Wiederhofer', 'Mid Lane', 'Austria', 0, 'OPT'),
('Marcin', 'Jankos', 'Jankowski', 'Jungle', 'Poland', 1, 'G2'),
('Marek', 'Humanoid', 'Brazda', 'Mid Lane', 'Czech Republic', 1, 'SPY'),
('Martin', 'HeaQ', 'Kordmaa', 'Bot Lane Carry', 'Estonia', 0, 'RGE'),
('Martin', 'Rekkles', 'Larsson', 'Bot Lane Carry', 'Sweden', 1, 'FNC'),
('Martin', 'Wunder', 'Hansen', 'Top Lane', 'Denmark', 1, 'G2'),
('Matthew', 'Akaadian', 'Higginbotham', 'Jungle', 'USA', 0, 'TSM'),
('Matthew', 'Deftly', 'Chen', 'Bot Lane Carry', 'USA', 0, 'C9'),
('Matus', 'Neon', 'Jakubcik', 'Bot Lane Carry', 'Croatia', 1, 'MSF'),
('Maurice', 'Amazing', 'Stuckenschneider', 'Jungle', 'Germany', 1, '100'),
('Max', 'Soligo', 'Soong', 'Mid Lane', 'USA', 0, '100'),
('Mei', 'ZWuJi', 'Hong-Hui', 'Bot Lane Carry', 'China', 1, 'RW'),
('Michael', 'MikeYeung', 'Yeung', 'Jungle', 'USA', 1, 'FOX'),
('Mihael', 'Mikyx', 'Mehle', 'Bot Lane Support', 'Slovenia', 1, 'G2'),
('Ming', 'Clearlove', 'Kai', 'Jungle', 'China', 1, 'EDG'),
('Mingyi', 'Spica', 'Lu', 'Jungle', 'China', 1, 'TSM'),
('Moon', 'Cuzz', 'Woo-chan', 'Jungle', 'Korea', 1, 'KZ'),
('Moon', 'Route', 'Geom-su', 'Bot Lane Carry', 'Korea', 1, 'JAG'),
('Nam', 'Ben', 'Dong-hyun', 'Bot Lane Support', 'Korea', 1, 'TES'),
('Nam', 'Lira', 'Tae-yoo', 'Jungle', 'Korea', 1, 'CG'),
('Nicholas', 'Hakuho', 'Surgent', 'Bot Lane Support', 'USA', 1, 'FOX'),
('Nicolaj', 'Jensen', 'Jensen', 'Mid Lane', 'Denmark', 1, 'TL'),
('Niship', 'Dhokla', 'Doshi', 'Top Lane', 'USA', 1, 'OPT'),
('No', 'SnowFlower', 'Hoi-jong', 'Bot Lane Support', 'Korea', 1, 'KT'),
('Noh', 'Arrow', 'Dong-hyeon', 'Bot Lane Carry', 'Korea', 1, 'OPT'),
('Nubar', 'Maxlore', 'Sarafian', 'Jungle', 'United Kingdom', 0, 'MSF'),
('Omran', 'V1per', 'Shoura', 'Top Lane', 'Syria', 1, 'FLY'),
('Osama', 'Auto', 'Alkhalaileh', 'Bot Lane Carry', 'USA', 0, 'CLG'),
('Oskar', 'Selfmade', 'Boderek', 'Jungle', 'Poland', 1, 'SK'),
('Oskar', 'Vander', 'Bogdan', 'Bot Lane Support', 'Poland', 1, 'RGE'),
('Park', 'Nova', 'Chan-ho', 'Bot Lane Support', 'Korea', 1, 'JAG'),
('Park', 'Ruler', 'Jae-hyuk', 'Bot Lane Carry', 'Korea', 1, 'GEN'),
('Park', 'Senan', 'Hee-seok', 'Bot Lane Support', 'Korea', 1, 'AF'),
('Park', 'Summit', 'Woo-tae', 'Top Lane', 'Korea', 1, 'SB'),
('Park', 'Teddy', 'Jin-seong', 'Bot Lane Carry', 'Korea', 1, 'SKT'),
('Park', 'Thal', 'Kwon-hyuk', 'Top Lane', 'Korea', 0, 'HLE'),
('Park', 'TusiN', 'Jong-ik', 'Bot Lane Support', 'Korea', 1, 'KZ'),
('Park', 'Viper', 'Do-hyeon', 'Bot Lane Carry', 'Korea', 1, 'GRF'),
('Patrik', 'Patrik', 'Jiru', 'Bot Lane Carry', 'Czech Republic', 1, 'OG'),
('Patryk', 'Mystiques', 'Piorkowski', 'Bot Lane Support', 'Poland', 1, 'XL'),
('Pawel', 'Woolite', 'Pruski', 'Bot Lane Carry', 'Poland', 1, 'RGE'),
('Peter', 'Doublelift', 'Peng', 'Bot Lane Carry', 'USA', 1, 'TL'),
('Petter', 'Hjarnan', 'Freyschuss', 'Bot Lane Carry', 'Sweden', 0, 'XL'),
('Philippe', 'Vulcan', 'Laflamme', 'Bot Lane Support', 'Canada', 1, 'CG'),
('Rasmus', 'Caps', 'Winther', 'Mid Lane', 'Denmark', 1, 'G2'),
('Raymond', 'kaSing', 'Tsang', 'Bot Lane Support', 'United Kingdom', 0, 'XL'),
('Raymond', 'Wiggly', 'Griffin', 'Jungle', 'USA', 1, 'CLG'),
('Robert', 'Blabber', 'Huang', 'Jungle', 'USA', 0, 'C9'),
('Rosendo', 'Send0o', 'Fuentes', 'Top Lane', 'Spain', 0, 'XL'),
('Ryu', 'Hoit', 'Ho-seong', 'Bot Lane Support', 'Korea', 0, 'DWG'),
('Seo', 'Kanavi', 'Jin-hyeok', 'Jungle', 'Korea', 0, 'JDG'),
('Seo', 'SSol', 'Jin-sol', 'Bot Lane Carry', 'Korea', 0, 'AF'),
('Sergen', 'Brokenblade', 'Celik', 'Top Lane', 'Germany', 1, 'TSM'),
('Shi', 'Ming', 'Sen-Ming', 'Bot Lane Support', 'China', 1, 'RNG'),
('Shin', 'Hollow', 'Yong-jin', 'Bot Lane Carry', 'Korea', 0, 'SB'),
('Sin', 'Nuclear', 'Jeong-hyeon', 'Bot Lane Carry', 'Korea', 1, 'DWG'),
('Son', 'Jelly', 'Ho-gyeong', 'Bot Lane Support', 'Korea', 0, 'AF'),
('Son', 'Lehends', 'Si-woo', 'Bot Lane Support', 'Korea', 1, 'GRF'),
('Son', 'Mickey', 'Young-min', 'Mid Lane', 'Korea', 1, 'XL'),
('Son', 'Punch', 'Min-hyuk', 'Jungle', 'Korea', 0, 'DWG'),
('Son', 'Ucal', 'Woo-hyeon', 'Mid Lane', 'Korea', 1, 'AF'),
('Song', 'Fly', 'Yong-jun', 'Mid Lane', 'Korea', 1, 'GEN'),
('Song', 'Rookie', 'Eui-jin', 'Mid Lane', 'Korea', 1, 'IG'),
('Song', 'Smeb', 'Kyung-ho', 'Top Lane', 'Korea', 0, 'KT'),
('Soren', 'Bjergsen', 'Bjerg', 'Mid Lane', 'Denmark', 1, 'TSM'),
('Steven', 'Hans Sama', 'Liv', 'Bot Lane Carry', 'France', 0, 'MSF'),
('Su', 'xiye', 'Han-Wei', 'Mid Lane', 'China', 1, 'WE'),
('Sung', 'Flawless', 'Yeon-jun', 'Jungle', 'Korea', 1, 'JDG'),
('Tamas', 'Vizicsacsi', 'Kiss', 'Top Lane', 'Hungary', 1, 'SPY'),
('Tanner', 'Damonte', 'Damonte', 'Mid Lane', 'USA', 1, 'CG'),
('Tao', 'Windy', 'Xiang', 'Mid Lane', 'China', 1, 'V5'),
('Terry', 'Big', 'Chuong', 'Bot Lane Support', 'USA', 1, 'OPT'),
('Thomas', 'Kirei', 'Yuen', 'Jungle', 'Netherlands', 1, 'MSF'),
('Tian', 'HuaTian', 'Mai', 'Mid Lane', 'China', 1, 'RW'),
('Tian', 'Meiko', 'Ye', 'Bot Lane Support', 'China', 1, 'EDG'),
('Tim', 'Nemesis', 'Lipovsek', 'Mid Lane', 'Slovenia', 1, 'FNC'),
('Toan', 'Asta', 'Tran', 'Bot Lane Carry', 'Vietnam', 0, 'OPT'),
('Toni', 'Sacre', 'Sabalic', 'Top Lane', 'Croatia', 1, 'SK'),
('Tore', 'Noreskeren', 'Hoel Eilertsen', 'Bot Lane Support', 'Norway', 1, 'SPY'),
('Trevor', 'Stixxay', 'Hayes', 'Bot Lane Carry', 'USA', 1, 'CLG'),
('Tristan', 'PowerOfEvil', 'Schrage', 'Mid Lane', 'Germany', 1, 'CLG'),
('Tristan', 'Zeyzal', 'Stidam', 'Bot Lane Support', 'USA', 1, 'C9'),
('Tu', 'Ben4', 'Xin-Cheng', 'Jungle', 'China', 1, 'V5'),
('Victor', 'FBI', 'Huang', 'Bot Lane Carry', 'Australia', 1, 'GGS'),
('Vincent', 'Biofrost', 'Wang', 'Bot Lane Support', 'Canada', 1, 'CLG'),
('Wang', 'BaoLan', 'Liu-Yi', 'Bot Lane Support', 'China', 1, 'IG'),
('Wang', 'WeiYan', 'Xiang', 'Jungle', 'China', 0, 'RW'),
('Wang', 'Xiaopeng', 'Peng', 'Jungle', 'China', 1, 'DMO'),
('Wang', 'y4', 'Nong-Mo', 'Bot Lane Carry', 'China', 1, 'V5'),
('Wei', 'Weiwei', 'Bo-Han', 'Jungle', 'China', 1, 'SN'),
('William', 'Meteos', 'Hartman', 'Jungle', 'USA', 1, 'OPT'),
('Wu', 'SouthWind', 'Hao-Shun', 'Bot Lane Support', 'China', 1, 'VG'),
('Xia', 'Chelizi', 'Han-Xi', 'Top Lane', 'China', 0, 'VG'),
('Xia', 'Huanggai', 'Long-Yang', 'Bot Lane Support', 'China', 1, 'RW'),
('Xiang', 'Angel', 'Tao', 'Mid Lane', 'China', 1, 'SN'),
('Xie', 'Eimy', 'Dan', 'Jungle', 'China', 0, 'LGD'),
('Xie', 'Icon', 'Tian-Yu', 'Mid Lane', 'China', 1, 'OMG'),
('Xie', 'Jinjiao', 'Jin-Shan', 'Bot Lane Carry', 'China', 1, 'BLG'),
('Xie', 'Langx', 'Zhen-Ying', 'Top Lane', 'China', 1, 'RNG'),
('Xiong', 'Xx', 'Yu-Long', 'Jungle', 'China', 1, 'TES'),
('Yang', 'H4cker', 'Zhi-Hao', 'Jungle', 'China', 0, 'SN'),
('Yang', 'kRYST4L', 'Fan', 'Bot Lane Carry', 'China', 0, 'OMG'),
('Yasin', 'Nisqy', 'Dincer', 'Mid Lane', 'Belgium', 1, 'C9'),
('Yoo', 'Naehyun', 'Nae-hyun', 'Mid Lane', 'Korea', 1, 'KZ'),
('Yoo', 'Ryu', 'Sang-wook', 'Mid Lane', 'Korea', 1, '100'),
('Yoon', 'Justice', 'Seok-joon', 'Mid Lane', 'Korea', 0, 'SB'),
('Yoon', 'Seonghwan', 'Seong-hwan', 'Jungle', 'Korea', 0, 'GEN'),
('Yu', 'Biubiu', 'Lei-Xin', 'Top Lane', 'China', 0, 'SN'),
('Yu', 'JackeyLove', 'Wen-Bo', 'Bot Lane Carry', 'China', 1, 'IG'),
('Zachary', 'Sneaky', 'Scuderi', 'Bot Lane Carry', 'USA', 1, 'C9'),
('Zaqueri', 'Aphromoo', 'Black', 'Bot Lane Support', 'USA', 1, '100'),
('Zdravets', 'Hylissang', 'lliev Galabov', 'Bot Lane Support', 'Bulgaria', 1, 'FNC'),
('Zeng', 'Guoguo', 'Jun-Li', 'Mid Lane', 'China', 0, 'OMG'),
('Zeng', 'Meteor', 'Guo-Hao', 'Jungle', 'China', 1, 'BLG'),
('Zeng', 'Yagao', 'Qi', 'Mid Lane', 'China', 1, 'JDG'),
('Zeng', 'Youdang', 'Xian-Xin', 'Jungle', 'China', 0, 'VG'),
('Zhang', 'BadeMan', 'Yu-Nong', 'Jungle', 'China', 1, 'LGD'),
('Zhang', 'HwQ', 'Tao', 'Mid Lane', 'China', 0, 'RW'),
('Zhang', 'Zoom', 'Xing-Ran', 'Top Lane', 'China', 1, 'JDG'),
('Zhao', 'Jiejie', 'Li-Jie', 'Jungle', 'China', 0, 'EDG'),
('Zhao', 'Penguin', 'Shuai', 'Jungle', 'China', 0, 'OMG'),
('Zhuo', 'Knight9', 'Ding', 'Mid Lane', 'China', 1, 'TES'),
('Ziqing', 'Kumo', 'Zhao', 'Top Lane', 'USA', 0, 'C9'),
('Zuo', 'LvMao', 'Ming-Hao', 'Bot Lane Support', 'China', 1, 'JDG');

--
-- Triggers `Player`
--
DELIMITER $$
CREATE TRIGGER `CheckValidRole` BEFORE INSERT ON `Player` FOR EACH ROW BEGIN
	if new.Role != "Top Lane" and new.Role != "Jungle" and new.Role != "Mid Lane" and new.Role != "Bot Lane Carry" and new.Role != "Bot Lane Support"
	THEN
    	 SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Must insert a valid role';
    end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `CheckValidTeam` AFTER INSERT ON `Player` FOR EACH ROW BEGIN
	if new.TeamID not in (select T.TeamID from Teams T, Player P where P.TeamID = T.TeamID) THEN
    	signal sqlstate '45000'
        set MESSAGE_TEXT = 'Cannot insert this player into a nonexistent team';
    end if;



END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Regions`
--

CREATE TABLE `Regions` (
  `LeagueID` varchar(3) NOT NULL,
  `Format` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Regions`
--

INSERT INTO `Regions` (`LeagueID`, `Format`) VALUES
('LCK', 'Double Round Robin Best of 3'),
('LCS', 'Double Round Robin Best of 1'),
('LEC', 'Double Round Robin Best of 1'),
('LPL', 'Single Round Robin Best of 3');

-- --------------------------------------------------------

--
-- Table structure for table `Teams`
--

CREATE TABLE `Teams` (
  `TeamID` varchar(3) NOT NULL,
  `TeamName` varchar(30) NOT NULL,
  `Wins` int(2) NOT NULL,
  `Losses` int(2) NOT NULL,
  `League` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Teams`
--

INSERT INTO `Teams` (`TeamID`, `TeamName`, `Wins`, `Losses`, `League`) VALUES
('100', '100 Thieves', 0, 4, 'LCS'),
('AF', 'Afreeca Frecs', 10, 7, 'LCK'),
('BLG', 'Bilibili Gaming', 11, 4, 'LPL'),
('C9', 'Cloud 9', 3, 1, 'LCS'),
('CG', 'Clutch Gaming', 2, 2, 'LCS'),
('CLG', 'Counter Logic Gaming', 2, 2, 'LCS'),
('DMO', 'Dominus eSports', 6, 8, 'LPL'),
('DWG', 'Damwon Gaming', 11, 5, 'LCK'),
('EDG', 'Edward Gaming', 9, 6, 'LPL'),
('FLY', 'Flyquest', 1, 3, 'LCS'),
('FNC', 'Fnatic', 1, 1, 'LEC'),
('FOX', 'Echo Fox', 1, 3, 'LCS'),
('FPX', 'FunPlus Phoenix', 12, 1, 'LPL'),
('G2', 'G2 eSports', 3, 0, 'LEC'),
('GEN', 'GENG', 10, 7, 'LCK'),
('GGS', 'Golden Guardians', 3, 1, 'LCS'),
('GRF', 'Griffin', 11, 5, 'LCK'),
('HLE', 'Hanwha Life eSports', 5, 11, 'LCK'),
('IG', 'Invictus Gaming', 8, 6, 'LPL'),
('JAG', 'Jin Air Greenwings', 0, 17, 'LCK'),
('JDG', 'JD Gaming', 6, 8, 'LPL'),
('KT', 'KT Rolster', 5, 11, 'LCK'),
('KZ', 'Kingzone DragonX', 9, 8, 'LCK'),
('LGD', 'LGD Gaming', 3, 11, 'LPL'),
('LNG', 'LNG eSports', 7, 7, 'LPL'),
('MSF', 'Misfits Gaming', 1, 0, 'LEC'),
('OG', 'Origen', 1, 1, 'LEC'),
('OMG', 'Oh My God', 2, 12, 'LPL'),
('OPT', 'Optic Gaming', 4, 0, 'LCS'),
('RGE', 'Rogue', 0, 1, 'LEC'),
('RNG', 'Royal Never Give Up', 11, 3, 'LPL'),
('RW', 'Rogue Warriors', 5, 9, 'LPL'),
('S04', 'FC Schalke 04', 1, 0, 'LEC'),
('SB', 'Sandbox Gaming', 11, 5, 'LCK'),
('SK', 'SK Gaming', 0, 1, 'LEC'),
('SKT', 'SK Telecom T1', 10, 6, 'LCK'),
('SN', 'Suning', 8, 6, 'LPL'),
('SPY', 'Splyce', 0, 1, 'LEC'),
('TES', 'TOP eSports', 11, 2, 'LPL'),
('TL', 'Team Liquid', 2, 2, 'LCS'),
('TSM', 'Team Solo Mid', 2, 2, 'LCS'),
('V5', 'Victory 5', 5, 9, 'LPL'),
('VG', 'Vici Gaming', 1, 13, 'LPL'),
('VIT', 'Team Vitality', 0, 1, 'LEC'),
('WE', 'Team WE', 7, 7, 'LPL'),
('XL', 'Excel eSports', 0, 1, 'LEC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Account`
--
ALTER TABLE `Account`
  ADD PRIMARY KEY (`Username`);

--
-- Indexes for table `Champion`
--
ALTER TABLE `Champion`
  ADD PRIMARY KEY (`ChampionName`);

--
-- Indexes for table `Matches`
--
ALTER TABLE `Matches`
  ADD PRIMARY KEY (`YT_URL`),
  ADD KEY `Team1_lbfk_3` (`Team1`),
  ADD KEY `Team2_lbfk_3` (`Team2`);

--
-- Indexes for table `MatchInfo`
--
ALTER TABLE `MatchInfo`
  ADD PRIMARY KEY (`MatchID`),
  ADD KEY `PickT1_1` (`PickT1_1`,`PickT1_2`,`PickT1_3`,`PickT1_4`,`PickT1_5`,`BanT1_1`,`BanT1_2`,`BanT1_3`,`BanT1_4`,`BanT1_5`,`PickT2_1`,`PickT2_2`,`PickT2_3`,`PickT2_4`,`PickT2_5`,`BanT2_1`,`BanT2_2`,`BanT2_3`,`BanT2_4`,`BanT2_5`),
  ADD KEY `T1_pick2` (`PickT1_2`),
  ADD KEY `T1_pick3` (`PickT1_3`),
  ADD KEY `T1_pick4` (`PickT1_4`),
  ADD KEY `T1_pick5` (`PickT1_5`),
  ADD KEY `T1_ban1` (`BanT1_1`),
  ADD KEY `T1_ban2` (`BanT1_2`),
  ADD KEY `T1_ban3` (`BanT1_3`),
  ADD KEY `T1_ban4` (`BanT1_4`),
  ADD KEY `T1_ban5` (`BanT1_5`),
  ADD KEY `T2_pick1` (`PickT2_1`),
  ADD KEY `T2_pick2` (`PickT2_2`),
  ADD KEY `T2_pick3` (`PickT2_3`),
  ADD KEY `T2_pick4` (`PickT2_4`),
  ADD KEY `T2_pick5` (`PickT2_5`),
  ADD KEY `T2_ban1` (`BanT2_1`),
  ADD KEY `T2_ban2` (`BanT2_2`),
  ADD KEY `T2_ban3` (`BanT2_3`),
  ADD KEY `T2_ban4` (`BanT2_4`),
  ADD KEY `T2_ban5` (`BanT2_5`);

--
-- Indexes for table `Player`
--
ALTER TABLE `Player`
  ADD PRIMARY KEY (`FirstName`,`IGN`,`LastName`),
  ADD KEY `Team_lbfk_2` (`TeamID`);

--
-- Indexes for table `Regions`
--
ALTER TABLE `Regions`
  ADD PRIMARY KEY (`LeagueID`);

--
-- Indexes for table `Teams`
--
ALTER TABLE `Teams`
  ADD PRIMARY KEY (`TeamID`,`TeamName`),
  ADD KEY `Region_lbfk_1` (`League`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Matches`
--
ALTER TABLE `Matches`
  ADD CONSTRAINT `Team1_lbfk_3` FOREIGN KEY (`Team1`) REFERENCES `Teams` (`TeamID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Team2_lbfk_3` FOREIGN KEY (`Team2`) REFERENCES `Teams` (`TeamID`) ON UPDATE CASCADE;

--
-- Constraints for table `MatchInfo`
--
ALTER TABLE `MatchInfo`
  ADD CONSTRAINT `T1_ban1` FOREIGN KEY (`BanT1_1`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_ban2` FOREIGN KEY (`BanT1_2`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_ban3` FOREIGN KEY (`BanT1_3`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_ban4` FOREIGN KEY (`BanT1_4`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_ban5` FOREIGN KEY (`BanT1_5`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_pick1` FOREIGN KEY (`PickT1_1`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_pick2` FOREIGN KEY (`PickT1_2`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_pick3` FOREIGN KEY (`PickT1_3`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_pick4` FOREIGN KEY (`PickT1_4`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T1_pick5` FOREIGN KEY (`PickT1_5`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_ban1` FOREIGN KEY (`BanT2_1`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_ban2` FOREIGN KEY (`BanT2_2`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_ban3` FOREIGN KEY (`BanT2_3`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_ban4` FOREIGN KEY (`BanT2_4`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_ban5` FOREIGN KEY (`BanT2_5`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_pick1` FOREIGN KEY (`PickT2_1`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_pick2` FOREIGN KEY (`PickT2_2`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_pick3` FOREIGN KEY (`PickT2_3`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_pick4` FOREIGN KEY (`PickT2_4`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `T2_pick5` FOREIGN KEY (`PickT2_5`) REFERENCES `Champion` (`ChampionName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `TeamID_lbfk_1` FOREIGN KEY (`MatchID`) REFERENCES `Matches` (`YT_URL`) ON UPDATE CASCADE;

--
-- Constraints for table `Player`
--
ALTER TABLE `Player`
  ADD CONSTRAINT `Team_lbfk_2` FOREIGN KEY (`TeamID`) REFERENCES `Teams` (`TeamID`) ON UPDATE CASCADE;

--
-- Constraints for table `Teams`
--
ALTER TABLE `Teams`
  ADD CONSTRAINT `Region_lbfk_1` FOREIGN KEY (`League`) REFERENCES `Regions` (`LeagueID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
