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

-- Dumping structure for funktion flex_ultimate.getTime
DELIMITER //
CREATE FUNCTION `getTime`(brugerId bigint(20), dato date) RETURNS time
BEGIN

set @tid = null;
set @dato = date_sub(dato, interval 1 day);

set @fri = null;
set @absent = null;
SELECT
	fri, absent
INTO @fri, @absent FROM
	dagstatus d
JOIN `status` s
	ON s.id = d.statusid
WHERE
	brugerid = brugerId
    AND dato = DAYOFWEEK(@dato)
limit 1;

if @fri = 1 then

	set @tid = 0;

end if;

if @tid is null then

SELECT 
    tid
INTO @tid FROM
    brugertid
WHERE
    fra <= dato
    AND til >= dato
	AND dag + 0 = DAYOFWEEK(@dato)
    AND brugerid = brugerId
order by id desc
limit 1;

end if;

if @tid is null then

SELECT 
    tid
INTO @tid FROM
    teamstid
WHERE
    fra <= dato 
    AND til >= dato
	AND dag + 0 = DAYOFWEEK(@dato)
order by id desc
limit 1;

end if;

RETURN @tid;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
