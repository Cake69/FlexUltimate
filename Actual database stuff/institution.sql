-- --------------------------------------------------------
-- Vært:                         127.0.0.1
-- Server-version:               10.6.4-MariaDB - mariadb.org binary distribution
-- ServerOS:                     Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for tabel flex_ultimate.institution
CREATE TABLE IF NOT EXISTS `institution` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `navn` varchar(120) COLLATE utf8mb4_danish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_danish_ci;

-- Dumping data for table flex_ultimate.institution: ~3 rows (tilnærmelsesvis)
DELETE FROM `institution`;
/*!40000 ALTER TABLE `institution` DISABLE KEYS */;
INSERT INTO `institution` (`id`, `navn`) VALUES
	(1, 'Test_institution1'),
	(2, 'Test_institution2'),
	(3, 'Test_institution3');
/*!40000 ALTER TABLE `institution` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
