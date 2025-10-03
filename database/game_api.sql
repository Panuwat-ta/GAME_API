-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2025 at 05:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `game_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `id` int(10) UNSIGNED NOT NULL,
  `game_code` varchar(32) NOT NULL,
  `title` varchar(150) NOT NULL,
  `developer` varchar(100) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `platform` varchar(100) NOT NULL,
  `release_year` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL CHECK (`price` >= 0),
  `stock` int(11) NOT NULL DEFAULT 0 CHECK (`stock` >= 0),
  `rating` decimal(3,1) DEFAULT NULL CHECK (`rating` >= 0 and `rating` <= 10),
  `multiplayer` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `game_code`, `title`, `developer`, `publisher`, `genre`, `platform`, `release_year`, `price`, `stock`, `rating`, `multiplayer`, `description`, `created_at`, `updated_at`) VALUES
(1, 'ELDEN-001', 'Elden Ring', 'FromSoftware', 'Bandai Namco', 'Action RPG', 'PC, PS5, Xbox', 2022, 1690.00, 120, 9.5, 1, 'เกม Action RPG โลกเปิดสุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:38:01'),
(2, 'GOW-RAG', 'God of War Ragnarök', 'Santa Monica Studio', 'Sony', 'Action-Adventure', 'PS5, PS4', 2022, 2190.00, 35, 9.3, 0, 'ผจญภัยของ Kratos และ Atreus', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(3, 'HADES-02', 'Hades II', 'Supergiant Games', 'Supergiant Games', 'Roguelike', 'PC', 2024, 890.00, 100, 9.0, 0, 'Roguelike สุดมันส์ภาคต่อ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(4, 'BG3-001', 'Baldurs Gate 3', 'Larian Studios', 'Larian Studios', 'RPG', 'PC, PS5', 2023, 1690.00, 60, 9.6, 1, 'RPG ตัวเลือกเยอะมาก', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(5, 'CYBER-77', 'Cyberpunk 2077', 'CD Projekt Red', 'CD Projekt', 'Action RPG', 'PC, PS5, Xbox', 2020, 1490.00, 45, 8.5, 0, 'เกมโลกไซเบอร์พังค์สุดล้ำ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(6, 'RDR2-01', 'Red Dead Redemption 2', 'Rockstar Games', 'Rockstar Games', 'Action-Adventure', 'PC, PS4, Xbox', 2018, 1390.00, 40, 9.7, 1, 'เกมคาวบอยโลกเปิดสุดอลังการ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(7, 'HOLLOW-K', 'Hollow Knight', 'Team Cherry', 'Team Cherry', 'Metroidvania', 'PC, Switch', 2017, 490.00, 150, 9.2, 0, 'Metroidvania สุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(8, 'STARDEW-V', 'Stardew Valley', 'ConcernedApe', 'ConcernedApe', 'Simulation', 'PC, Switch, Mobile', 2016, 390.00, 200, 9.1, 1, 'เกมทำฟาร์มสุดชิล', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(9, 'ZELDA-TOK', 'The Legend of Zelda: Tears of the Kingdom', 'Nintendo', 'Nintendo', 'Action-Adventure', 'Switch', 2023, 2290.00, 30, 9.8, 0, 'ผจญภัยของ Link ภาคใหม่', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(10, 'PERSONA-5R', 'Persona 5 Royal', 'Atlus', 'Atlus', 'JRPG', 'PC, PS5, Switch', 2019, 1790.00, 55, 9.4, 0, 'JRPG สุดมันส์จากญี่ปุ่น', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(11, 'WITCHER-3', 'The Witcher 3: Wild Hunt', 'CD Projekt Red', 'CD Projekt', 'Action RPG', 'PC, PS5, Xbox', 2015, 990.00, 70, 9.8, 0, 'RPG โลกเปิดระดับตำนาน', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(12, 'MINECRAFT', 'Minecraft', 'Mojang', 'Microsoft', 'Sandbox', 'PC, Mobile, Console', 2011, 790.00, 300, 9.0, 1, 'เกมสร้างโลกแบบไม่จำกัด', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(13, 'SEKIRO-01', 'Sekiro: Shadows Die Twice', 'FromSoftware', 'Activision', 'Action-Adventure', 'PC, PS4, Xbox', 2019, 1490.00, 45, 9.3, 0, 'เกมนินจาสุดโหด', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(14, 'DISCO-ELY', 'Disco Elysium', 'ZA/UM', 'ZA/UM', 'RPG', 'PC, PS5, Switch', 2019, 990.00, 80, 9.4, 0, 'RPG เน้นบทสนทนาและการตัดสินใจ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(15, 'HADES-01', 'Hades', 'Supergiant Games', 'Supergiant Games', 'Roguelike', 'PC, Switch', 2020, 690.00, 120, 9.2, 0, 'Roguelike ภาคแรกสุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(16, 'CELESTE-01', 'Celeste', 'Maddy Makes Games', 'Maddy Makes Games', 'Platformer', 'PC, Switch', 2018, 490.00, 150, 9.0, 0, 'Platformer ท้าทายและมีเนื้อเรื่องดี', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(17, 'UNDERTALE', 'Undertale', 'Toby Fox', 'Toby Fox', 'RPG', 'PC, Switch, PS4', 2015, 390.00, 180, 9.1, 0, 'RPG สุดแปลกและน่ารัก', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(18, 'PORTAL-2', 'Portal 2', 'Valve', 'Valve', 'Puzzle', 'PC, PS3, Xbox 360', 2011, 390.00, 100, 9.5, 1, 'เกมปริศนาสุดอัจฉริยะ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(19, 'SKYRIM-SE', 'The Elder Scrolls V: Skyrim', 'Bethesda', 'Bethesda', 'RPG', 'PC, PS5, Xbox', 2011, 990.00, 85, 9.2, 0, 'RPG โลกเปิดแฟนตาซีคลาสสิก', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(20, 'TERRARIA', 'Terraria', 'Re-Logic', 'Re-Logic', 'Sandbox', 'PC, Mobile, Console', 2011, 290.00, 250, 8.9, 1, 'Sandbox 2D สุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(21, 'OUTER-WIL', 'Outer Wilds', 'Mobius Digital', 'Annapurna', 'Adventure', 'PC, PS4, Xbox', 2019, 790.00, 90, 9.3, 0, 'เกมสำรวจอวกาศสุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(22, 'SUBNAUTIC', 'Subnautica', 'Unknown Worlds', 'Unknown Worlds', 'Survival', 'PC, PS4, Xbox', 2018, 890.00, 75, 8.8, 0, 'Survival ใต้น้ำสุดระทึก', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(23, 'DEAD-CEL', 'Dead Cells', 'Motion Twin', 'Motion Twin', 'Roguelike', 'PC, Switch, PS4', 2018, 690.00, 110, 8.9, 0, 'Roguelike แอคชั่นสุดเร็ว', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(24, 'DARKSOULS-3', 'Dark Souls III', 'FromSoftware', 'Bandai Namco', 'Action RPG', 'PC, PS4, Xbox', 2016, 1290.00, 60, 9.1, 1, 'Action RPG สุดโหดภาค 3', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(25, 'CUPHEAD-01', 'Cuphead', 'Studio MDHR', 'Studio MDHR', 'Run and Gun', 'PC, Xbox, Switch', 2017, 590.00, 130, 8.8, 1, 'เกมยิงสุดท้าทายสไตล์การ์ตูนโบราณ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(26, 'SIFU-001', 'Sifu', 'Sloclap', 'Sloclap', 'Action', 'PC, PS5', 2022, 1190.00, 70, 8.5, 0, 'เกมต่อสู้กังฟูสุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(27, 'CONTROL-01', 'Control', 'Remedy Entertainment', '505 Games', 'Action-Adventure', 'PC, PS5, Xbox', 2019, 990.00, 65, 8.7, 0, 'เกมแอคชั่นเหนือธรรมชาติ', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(28, 'KATANA-Z', 'Katana ZERO', 'Askiisoft', 'Devolver Digital', 'Action', 'PC, Switch', 2019, 490.00, 140, 8.8, 0, 'เกมแอคชั่น 2D สุดเร็ว', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(29, 'ENTER-GUN', 'Enter the Gungeon', 'Dodge Roll', 'Devolver Digital', 'Roguelike', 'PC, Switch, PS4', 2016, 490.00, 120, 8.6, 1, 'Roguelike ยิงปืนสุดมันส์', '2025-10-03 03:01:21', '2025-10-03 03:01:21'),
(30, 'RISK-RAIN2', 'Risk of Rain 2', 'Hopoo Games', 'Gearbox', 'Roguelike', 'PC, PS4, Xbox, Switch', 2020, 790.00, 95, 8.9, 1, 'Roguelike 3D มัลติเพลเยอร์', '2025-10-03 03:01:21', '2025-10-03 03:01:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `game_code` (`game_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
