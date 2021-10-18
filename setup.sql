-- ███████╗ ██╗      ███████╗ ██╗  ██╗    ██╗   ██╗ ██╗   ████████╗ ██╗ ███╗   ███╗  █████╗  ████████╗ ███████╗
-- ██╔════╝ ██║      ██╔════╝ ╚██╗██╔╝    ██║   ██║ ██║   ╚══██╔══╝ ██║ ████╗ ████║ ██╔══██╗ ╚══██╔══╝ ██╔════╝
-- █████╗   ██║      █████╗    ╚███╔╝     ██║   ██║ ██║      ██║    ██║ ██╔████╔██║ ███████║    ██║    █████╗  
-- ██╔══╝   ██║      ██╔══╝    ██╔██╗     ██║   ██║ ██║      ██║    ██║ ██║╚██╔╝██║ ██╔══██║    ██║    ██╔══╝  
-- ██║      ███████╗ ███████╗ ██╔╝ ██╗    ╚██████╔╝ ███████╗ ██║    ██║ ██║ ╚═╝ ██║ ██║  ██║    ██║    ███████╗
-- ╚═╝      ╚══════╝ ╚══════╝ ╚═╝  ╚═╝     ╚═════╝  ╚══════╝ ╚═╝    ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝    ╚═╝    ╚══════╝
-- 
-- opsætnings af database til flex ultimate
-- 
-- del 0 variabler 
-- del 1 opret schema/database
-- del 2 opret tables
-- del 3 opret foreign key constrains
-- del 4 indsæt test data i tables
--

-- -------------------------------------------------
-- ------------------- variabler -------------------------------------------------------------------- del 0 -------------------------------------------------
-- -------------------------------------------------

set @testdata = true;

-- -------------------------------------------------
-- ---------- create flex schema/database ----------------------------------------------------------- del 1 -------------------------------------------------
-- -------------------------------------------------

DROP DATABASE IF EXISTS flex_ultimate;
CREATE SCHEMA `flex_ultimate` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_danish_ci ;
use flex_ultimate;

-- -------------------------------------------------
-- ----------------- Brugertablen ------------------------------------------------------------------- del 2 -------------------------------------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS brugere;
CREATE TABLE brugere(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    navn VARCHAR(120) NOT NULL,
    brugernavn VARCHAR(64) NOT NULL UNIQUE,
    kodeord VARCHAR(120) NOT NULL,
	kortnummer VARCHAR(32) DEFAULT NULL,
    institutionsid BIGINT NOT NULL,
    oprettet DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------------------------------
-- ------------------ super admin ------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS superadmin;
CREATE TABLE superadmin(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    brugerid BIGINT NOT NULL
);

-- -------------------------------------------------
-- ------------------ institution ------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS institution;
CREATE TABLE institution(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    navn VARCHAR(120) NOT NULL
);

-- --------------- institution admin ---------------

DROP TABLE IF EXISTS institutionadmin;
CREATE TABLE institutionadmin(
	institutionsid BIGINT NOT NULL,
    brugerid BIGINT NOT NULL,
    PRIMARY KEY(institutionsid, brugerid)
);

-- -------------------------------------------------
-- ------------------- afdeling --------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS afdeling;
CREATE TABLE afdeling(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    institutionsid BIGINT NOT NULL,
    navn VARCHAR(120) NOT NULL
);

-- ---------------- afdeling admin -----------------

DROP TABLE IF EXISTS afdelingadmin;
CREATE TABLE afdelingadmin(
	afdelingid BIGINT NOT NULL,
    brugerid BIGINT NOT NULL,
    PRIMARY KEY(afdelingid, brugerid)
);

-- -------------------------------------------------
-- --------------------- team ----------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS team;
CREATE TABLE team(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    afdelingid BIGINT NOT NULL,
    navn VARCHAR(120) NOT NULL
);

-- ------------------ team admin -------------------

DROP TABLE IF EXISTS teamadmin;
CREATE TABLE teamadmin(
	teamid BIGINT NOT NULL,
    brugerid BIGINT NOT NULL,
    PRIMARY KEY(teamid, brugerid)
);

-- ----------------- bruger team ------------------

DROP TABLE IF EXISTS brugerteam;
CREATE TABLE brugerteam(
	brugerid BIGINT NOT NULL,
    teamid BIGINT NOT NULL,
    PRIMARY KEY(brugerid, teamid)
);

-- -------------------------------------------------
-- ---------------------- log ----------------------
-- -------------------------------------------------

DROP TABLE IF EXISTS log;
CREATE TABLE log(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    brugerid BIGINT NOT NULL,
    dato DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    start TIME,
    slut TIME,
    logtime TIME GENERATED ALWAYS AS (TIMEDIFF(slut , start)) STORED
);

-- -------------------------------------------------
-- -------------------- status ---------------------
-- -------------------------------------------------

-- ----------------- dags status -------------------

DROP TABLE IF EXISTS dagstatus;
CREATE TABLE dagstatus(
	id int(11) NOT NULL AUTO_INCREMENT,
	brugerid BIGINT NOT NULL,
    dato DATE NOT NULL,
    statusid BIGINT NOT NULL,
    PRIMARY KEY (id),
	UNIQUE KEY `brugerid_UNIQUE` (`brugerid`,`dato`)
);


-- --------------------- status --------------------

DROP TABLE IF EXISTS status;
CREATE TABLE status(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    navn TINYTEXT NOT NULL,
    fri TINYINT(1) NOT NULL,
    absent TINYINT(1) NOT NULL
);


-- -------------------------------------------------
-- ---------------------- tid ----------------------
-- -------------------------------------------------

-- ------------------ team tid ---------------------

DROP TABLE IF EXISTS teamstid;
CREATE TABLE teamstid(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    teamid BIGINT NOT NULL,
    dag ENUM("mandag","tirsdag","onsdag","torsdag","fredag","lørdag","søndag") NOT NULL,
    tid TIME NOT NULL,
    status BIGINT NOT NULL,
    fra DATE NOT NULL,
    til DATE NOT NULL
);

-- ---------------- bruger tid ---------------------

DROP TABLE IF EXISTS brugertid;
CREATE TABLE brugertid(
	id BIGINT NOT NULL KEY AUTO_INCREMENT,
    brugerid BIGINT NOT NULL,
    dag ENUM("mandag","tirsdag","onsdag","torsdag","fredag","lørdag","søndag") NOT NULL,
    tid TIME NOT NULL,
    status BIGINT NOT NULL,
    fra DATE NOT NULL,
    til DATE NOT NULL
);

-- -------------------------------------------------
-- -------------- foreign constrains ---------------------------------------------------------------- del 3 -------------------------------------------------
-- -------------------------------------------------

-- ----------------- Brugertablen ------------------

ALTER TABLE brugere
ADD FOREIGN KEY (institutionsid) REFERENCES institution(id);

-- ------------------ super admin ------------------

ALTER TABLE superadmin
ADD FOREIGN KEY (brugerid) REFERENCES brugere(id);

-- --------------- institution admin ---------------

ALTER TABLE institutionadmin
ADD FOREIGN KEY (institutionsid) REFERENCES institution(id),
ADD FOREIGN KEY (brugerid) REFERENCES brugere(id);

-- ------------------- afdeling --------------------

ALTER TABLE afdeling
ADD FOREIGN KEY (institutionsid) REFERENCES institution(id);

-- ---------------- afdeling admin -----------------

ALTER TABLE afdelingadmin
ADD FOREIGN KEY (afdelingid) REFERENCES afdeling(id),
ADD FOREIGN KEY (brugerid) REFERENCES brugere(id);

-- --------------------- team ----------------------

ALTER TABLE team
ADD FOREIGN KEY(afdelingid) REFERENCES afdeling(id);

-- ------------------ team admin -------------------

ALTER TABLE teamadmin
ADD FOREIGN KEY(teamid) REFERENCES team(id),
ADD FOREIGN KEY(brugerid) REFERENCES brugere(id);

-- ----------------- bruger team ------------------

ALTER TABLE brugerteam
ADD FOREIGN KEY(teamid) REFERENCES team(id),
ADD FOREIGN KEY(brugerid) REFERENCES brugere(id);

-- ---------------------- log ----------------------

ALTER TABLE log
ADD FOREIGN KEY(brugerid) REFERENCES brugere(id);

-- ----------------- dags status -------------------

ALTER TABLE dagstatus
ADD FOREIGN KEY(brugerid) REFERENCES brugere(id),
ADD FOREIGN KEY(statusid) REFERENCES status(id);

-- ------------------ team tid ---------------------

ALTER TABLE teamstid
ADD FOREIGN KEY(teamid) REFERENCES team(id),
ADD FOREIGN KEY(status) REFERENCES status(id);

-- ---------------- bruger tid ---------------------

ALTER TABLE brugertid
ADD FOREIGN KEY(brugerid) REFERENCES brugere(id),
ADD FOREIGN KEY(status) REFERENCES status(id);

-- -------------------------------------------------
-- ------------------- test data -------------------------------------------------------------------- del 4 -------------------------------------------------
-- -------------------------------------------------
DELIMITER //

create procedure variabler_procedure() 
begin
  if ( @testdata) then
      insert into institution (navn) values ("Test_institution1"),("Test_institution2"),("Test_institution3"); 
      insert into afdeling (navn, institutionsid) values ("Test_afdeling1", 1),("Test_afdeling2", 2),("Test_afdeling3", 3); 
      insert into team (navn, afdelingid) values ("Test_team1", 1),("Test_team2", 2),("Test_team3", 3); 
      insert into status (navn, fri, absent) values ("Ikke mødt", 0, 1);
      insert into status (navn, fri, absent) values ("Gået", 0, 0);
      insert into status (navn, fri, absent) values ("Mødt", 1, 0);
      insert into teamstid (`teamid`, `dag`, `status`, `tid`, `fra`, `til`) values
		('1', 'mandag', '1', sec_to_time(3600), '1970-05-19', '2100-05-19'),
		('1', 'tirsdag', '1', sec_to_time(3600), '1970-05-19', '2100-05-19'),
		('1', 'onsdag', '1', sec_to_time(3600), '1970-05-19', '2100-05-19'),
		('1', 'torsdag', '1', sec_to_time(3600), '1970-05-19', '2100-05-19'),
		('1', 'fredag', '1', sec_to_time(1800), '1970-05-19', '2100-05-19'),
		('1', 'lørdag', '2', sec_to_time(0), '1970-05-19', '2100-05-19'),
		('1', 'søndag', '2', sec_to_time(0), '1970-05-19', '2100-05-19');
        insert into brugere (navn, brugernavn, kodeord, kortnummer, institutionsid) values ("Hans Jensen", "ha", "1234", "123", 1);
        insert into brugere (navn, brugernavn, kodeord, kortnummer, institutionsid) values ("Hans Jensen", "has", "1234", "1234", 1);
        insert into brugere (navn, brugernavn, kodeord, kortnummer, institutionsid) values ("Kent Andersen", "ka", "1234", "12345", 1);
        insert into brugerteam (brugerid, teamid) values (1, 1);
        insert into brugerteam (brugerid, teamid) values (2, 1);
        insert into brugerteam (brugerid, teamid) values (3, 1);
  end if;
end//

DELIMITER //

-- Execute the procedure
call variabler_procedure();

-- Drop the procedure
drop procedure variabler_procedure;
