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

-- Dumping structure for tabel flex_ultimate.afdelingadmin
CREATE TABLE IF NOT EXISTS `afdelingadmin` (
  `afdelingid` bigint(20) NOT NULL,
  `brugerid` bigint(20) NOT NULL,
  PRIMARY KEY (`afdelingid`,`brugerid`),
  KEY `brugerid` (`brugerid`),
  CONSTRAINT `afdelingadmin_ibfk_1` FOREIGN KEY (`afdelingid`) REFERENCES `afdeling` (`id`),
  CONSTRAINT `afdelingadmin_ibfk_2` FOREIGN KEY (`brugerid`) REFERENCES `brugere` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_danish_ci;

-- Dumping data for table flex_ultimate.afdelingadmin: ~0 rows (tilnærmelsesvis)
DELETE FROM `afdelingadmin`;
/*!40000 ALTER TABLE `afdelingadmin` DISABLE KEYS */;
/*!40000 ALTER TABLE `afdelingadmin` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
