CREATE DEFINER=`root`@`localhost` PROCEDURE `flexBip`(kortnr VARCHAR(32))
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
        set @statusid = 1;
    ELSE
        insert into log (brugerid,start) values (@brugerid, now());
        -- set status mødt;
        set @statusid = 2;
    END IF;
    
    -- set status
    insert into dagstatus (brugerid, dato,statusid) values (@brugerid, DATE(NOW()), @statusid) on duplicate key update statusid = @statusid, brugerid=VALUES(brugerid), dato = DATE(NOW());
END
