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

-- Dumping structure for tabel flex_ultimate.brugere
CREATE TABLE IF NOT EXISTS `brugere` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `navn` varchar(120) COLLATE utf8mb4_danish_ci NOT NULL,
  `brugernavn` varchar(64) COLLATE utf8mb4_danish_ci NOT NULL,
  `kodeord` varchar(120) COLLATE utf8mb4_danish_ci NOT NULL,
  `kortnummer` varchar(32) COLLATE utf8mb4_danish_ci DEFAULT NULL,
  `institutionsid` bigint(20) NOT NULL,
  `oprettet` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `brugernavn` (`brugernavn`),
  KEY `institutionsid` (`institutionsid`),
  CONSTRAINT `brugere_ibfk_1` FOREIGN KEY (`institutionsid`) REFERENCES `institution` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_danish_ci;

-- Dumping data for table flex_ultimate.brugere: ~3 rows (tilnærmelsesvis)
DELETE FROM `brugere`;
/*!40000 ALTER TABLE `brugere` DISABLE KEYS */;
INSERT INTO `brugere` (`id`, `navn`, `brugernavn`, `kodeord`, `kortnummer`, `institutionsid`, `oprettet`) VALUES
	(1, 'Hans Jensen', 'ha', '1234', '123', 1, '2021-10-14 11:14:26'),
	(2, 'Hans Jensen', 'has', '1234', '1234', 1, '2021-10-14 11:14:26'),
	(3, 'Kent Andersen', 'ka', '1234', '12345', 1, '2021-10-14 11:14:26');
/*!40000 ALTER TABLE `brugere` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
