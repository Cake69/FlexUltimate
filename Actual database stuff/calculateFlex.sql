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

-- Dumping structure for funktion flex_ultimate.calculateFlex
DELIMITER //
CREATE FUNCTION `calculateFlex`(brugerIdIn bigint(20)) RETURNS time
BEGIN
    
    DROP TEMPORARY TABLE IF EXISTS newTable;
    
    CREATE TEMPORARY TABLE newTable
    SELECT sec_to_time(time_to_sec(useTime(brugerIdIn, dato)) + IF(adminTid is not null, time_to_sec(adminTid), 0)) as `Tid`
    FROM dagstatus
    WHERE brugerid = brugerIdIn;
    
    set @tid = null;
    
    SELECT sec_to_time(sum(time_to_sec(Tid))) INTO @tid FROM newTable;
    
    DROP TEMPORARY TABLE IF EXISTS newTable;

RETURN @tid;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
