USE Ivanov_pv24
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perekonnanimi varchar (30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), --piirang >0
aktiivne bit)
-- tabeli kuvamine
SELECT * FROM tootaja;

-- lisame andmed tabelisse
INSERT INTO tootaja(perekonnanimi,eesnimi,synniaeg)
VALUES ('Ivanov','Lexa','2250-4-4')

INSERT INTO tootaja
VALUES ('Toxa','Kirkov','2250-4-4','Koplimäe tn 123', 120, 1),

INSERT INTO tootaja
VALUES
('Voxa','Zhirkov','2220-1-1','Kreuzberg StraBe 123', 321, 1),
('Goxa','Binkov','2221-6-1','Novy Praha 31', 321, 1)

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
where tootajaID=1

SELECT * FROM tootaja;

--1. Uue veeru lisamine
ALTER TABLE tootaja ADD testVeerg int;
SELECT * from tootaja

--2. Veeru kustutamine
ALTER TABLE tootaja DROP COLUMN testVeerg;
SELECT * from tootaja

--3. andmetüübi muutmine veerus
ALTER TABLE tootaja ALTER COLUMN testVeerg varchar(5);
SELECT * from tootaja
--Stuktuuri Kontrollimiseks kasutame käsku:
sp_help tootaja;

--pirangute lisamine
CREATE TABLE ryhm(
ryhmId int not null,
ryhmnimi char(10));

--muudame tabeli ja lisame piirang - primary key
ALTER TABLE ryhm ADD CONSTRAINT pk_ryhm PRIMARY KEY (ryhmId);

INSERT INTO ryhm
VALUES (1, 'LOGITpv24');
SELECT * FROM ryhm

INSERT INTO ryhm
VALUES (2, 'LOGITpv25');
SELECT * FROM ryhm

--lisame piirang UNIQUE
ALTER TABLE ryhm ADD CONSTRAINT un_ryhm UNIQUE (ryhmnimi);

-- NOW THIS WONT WORK
INSERT INTO ryhm
VALUES (3, 'LOGITpv25');
SELECT * FROM ryhm

--lisame uus veerg
ALTER TABLE ryhm ADD ryhmajuhataja int;
--lisame piirang Foreign Key
ALTER TABLE ryhm ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmajuhataja) REFERENCES tootaja(tootajaId);
SELECT * FROM tootaja
SELECT * FROM ryhm
UPDATE ryhm SET ryhmajuhataja=2 WHERE ryhmnimi='LOGITpv24'
UPDATE ryhm SET ryhmajuhataja=3 WHERE ryhmnimi='LOGITpv25'
