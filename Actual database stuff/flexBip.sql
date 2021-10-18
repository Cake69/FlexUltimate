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

-- Dumping structure for procedure flex_ultimate.flexBip
DELIMITER //
CREATE PROCEDURE `flexBip`(kortnr VARCHAR(32))
BEGIN
select id into @brugerid from brugere where kortnummer = kortnr;
    
    -- get newest log id
    set @logid = 0;
    set @logslut = null;
    set @logstart = null;
    select log.id, log.slut, log.start into @logid, @logslut, @logstart from log where brugerid = @brugerid and dato = date(now()) order by id desc limit 1;
    -- select @logid, @logslut;
    
    -- get dagstatus is
    set @statusid = null;
    
    IF @logslut is null and @logstart is not null THEN
        update log set slut = TIME(NOW()) where id = @logid;
        -- set status gået
        set @statusid = 2;
    ELSE
        insert into log (brugerid,start) values (@brugerid, now());
        -- set status mødt;
        set @statusid = 3;
    END IF;
    
    -- set status
    insert into dagstatus (brugerid, dato, statusid) values (@brugerid, DATE(NOW()), @statusid) on duplicate key update statusid = @statusid, brugerid=VALUES(brugerid), dato = DATE(NOW());
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
