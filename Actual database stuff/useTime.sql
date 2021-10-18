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

-- Dumping structure for funktion flex_ultimate.useTime
DELIMITER //
CREATE FUNCTION `useTime`(brugerIdIn bigint(20), datoIn date) RETURNS time
BEGIN

#Deklære variabler, som senere bliver fyldt.
set @fri = null;
set @absent = null;
set @endTime = null;

#Fylder fri og absent, så vi har styr på, om de skal være der eller ikke.
#Dette bruger vi til hvilken tid vi skal give tilbage.
SELECT 
    fri, absent
INTO @fri, @absent FROM
    dagstatus d
JOIN
    `status` s ON s.id = d.statusid
WHERE
    brugerid = brugerIdIn
	AND dato = datoIn
LIMIT 1;

#Hvis ikke fri er sat, går vi ud fra, at personen ikke har fri.
if @fri is null then
	set @fri = 0;
end if;

#Hvis ikke absent er sat, går vi ud fra, at personen skal være der.
if @absent is null then
	set @absent = 0;
end if;

#Hvis personen er sat til at have fri, så skal vi ikke tage deres normale tid
#Samt vi skal se om deres fridag skal tages fra deres flex.
if @fri = 1 then
	if @absent = 1 then
		set @endTime = - getTime(brugerIdIn, datoIn);
	else
		SELECT sum(time_to_sec(logtime)) INTO @endTime FROM log WHERE dato = datoIn AND brugerid = brugerIdIn;
        
        if @endTime is null then
			set @endTime = 0;
		end if;
	end if;
end if;

#Hvis ikke de har fri, så skal deres tid tages fra den given dag.
if @endTime is null then
	
    set @inTime = 0;
    SELECT sum(time_to_sec(logtime)) INTO @inTime FROM log WHERE dato = datoIn AND brugerid = brugerIdIn;
    
    if @inTime is null then
		set @inTime = 0;
	end if;
    
    SELECT sum(time_to_sec(logtime)) INTO @lnTime FROM log WHERE dato = dato AND brugerid = brugerId;
	set @endTime = SEC_TO_TIME(@inTime - TIME_TO_SEC(getTime(brugerIdIn, datoIn)));

end if;

RETURN @endTime;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
