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

-- Dumping structure for funktion flex_ultimate.getStatusId
DELIMITER //
CREATE FUNCTION `getStatusId`(brugerIdIn bigint(20), dateIn date) RETURNS int(11)
BEGIN

	set @statusId = null;
    set @teamId = null;
    
SELECT teamid INTO @teamId FROM brugerteam WHERE brugerid = brugeridIn LIMIT 1;
    
SELECT 
    status
INTO @statusId FROM
    brugertid
WHERE
    til > dateIn AND fra < dateIn
        AND brugerid = brugerIdIn
LIMIT 1;

IF @statusId IS NULL THEN

	SELECT 
		status
	INTO @statusId FROM
		teamstid
	WHERE
		til > dateIn AND fra < dateIn
			AND teamid = @teamId
	LIMIT 1;

END IF;

IF @statusId IS NULL THEN

 set @statusId = 2;

END IF;

RETURN 1;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
