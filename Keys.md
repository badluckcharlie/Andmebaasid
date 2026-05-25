# Andmebaasi võtmed (Keys)

## Sissejuhatus

See fail selgitab erinevaid võtmetüüpe relatsioonilistes andmebaasides koos praktiliste SQL-näidete ja ekraanipiltidega.

## 1. Primary Key (Primaarvõti)

**Definitsioon:**  
Primary Key (primaarvõti) on veerg (või veergude kogum), mis identifitseerib igat rida tabelis unikaalselt. See ei või sisaldada NULL väärtusi ja peab olema iga kirje jaoks kordumatu.

**Milleks kasutatakse:**  
Kirjete unikaalsuse tagamiseks, kiireks otsimiseks ja seoste loomiseks teiste tabelitega.

**Erinevus teistest võtmetest:**  
Erinevalt Foreign Key-st on see unikaalne ega saa olla NULL. Erinevalt Unique Key-st võib tabelis olla ainult üks Primary Key ja seda kasutatakse peamise identifikaatorina.

### Praktiline näide (SQL)

```sql
CREATE TABLE tudengid (
    tudengi_id INT PRIMARY KEY,
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO tudengid (tudengi_id, eesnimi, perenimi, email)
VALUES (1, 'Mari', 'Tamm', 'mari@example.com');

SELECT * FROM tudengid;
```
## Foreign Key (Võõrvõti)
Definitsioon:
Foreign Key (võõrvõti) on veerg või veergude kogum ühes tabelis, mis viitab teise tabeli PRIMARY KEY-le või UNIQUE KEY-le. See tagab andmete viitelise terviklikkuse.

**Milleks kasutatakse:**
Seoste loomiseks tabelite vahel (üks-mitmele, mitu-mitmele) ja toimingute takistamiseks, mis võiksid neid seoseid rikkuda.

**Erinevus teistest võtmetest:**
Erinevalt Primary Key-st võib Foreign Key sisaldada dubleerivaid ja NULL väärtusi. See viitab alati olemasolevale võtmele teises tabelis.

```sql
CREATE TABLE kursused (
    kursuse_id INT PRIMARY KEY,
    kursuse_nimi VARCHAR(100)
);

CREATE TABLE registreerimised (
    registreerimise_id INT PRIMARY KEY,
    tudengi_id INT,
    kursuse_id INT,
    registreerimise_kuupäev DATE,
    FOREIGN KEY (kursuse_id) REFERENCES kursused(kursuse_id)
);

INSERT INTO kursused (kursuse_id, kursuse_nimi) VALUES (101, 'SQL alused');
INSERT INTO registreerimised (registreerimise_id, tudengi_id, kursuse_id, registreerimise_kuupäev)
VALUES (1, 1, 101, '2025-05-26');

SELECT * FROM registreerimised;
```

## Unique Key (Unikaalne võti)
Definitsioon:
Unique Key (unikaalne võti) on piirang, mis tagab, et kõik väärtused veerus või veergude rühmas on erinevad (unikaalsed). Erinevalt PRIMARY KEY-st võib lubada ühte NULL väärtust.

**EMilleks kasutatakse:**E
Andmete dubleerimise vältimiseks veergudes, mis ei ole primaarvõtmed (nt e-post või isikukood).

**EErinevus teistest võtmetest:**E
Erinevalt Primary Key-st võib olla NULL ja tabelis võib olla mitu Unique Key-d. Erinevalt Foreign Key-st ei viita see teisele tabelile.
```sql
CREATE TABLE tudengid_unique (
    tudengi_id INT PRIMARY KEY,
    eesnimi VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

INSERT INTO tudengid_unique (tudengi_id, eesnimi, email)
VALUES (1, 'Jaan', 'jaan@example.com');

-- Järgmine INSERT põhjustab vea, kuna UNIQUE piirang rikutakse
-- INSERT INTO tudengid_unique (tudengi_id, eesnimi, email)
-- VALUES (2, 'Kati', 'jaan@example.com');
```

## Simple Key (Lihtne võti)
Definitsioon:
Simple Key (lihtne võti) on võti, mis koosneb ainult ühest veerust. See võib olla Primary Key, Foreign Key või Unique Key, kuid alati ainult ühest väljast.

**Milleks kasutatakse:**
Kirjete lihtsaks identifitseerimiseks, kui ühest atribuudist piisab kõigi ridade eristamiseks.

**Erinevus teistest võtmetest:**
Peamine erinevus on see, et see kasutab ainult ühte veergu, samas kui Composite ja Compound Key kasutavad mitut veergu.
```sql
CREATE TABLE tooted (
    toote_kood CHAR(10) PRIMARY KEY,  -- Simple Key
    toote_nimi VARCHAR(100),
    hind DECIMAL(10,2)
);

INSERT INTO tooted (toote_kood, toote_nimi, hind)
VALUES ('T001', 'Sülearvuti', 750.00);

SELECT * FROM tooted WHERE toote_kood = 'T001';
```

## Composite Key (Liitvõti)
Definitsioon:
Composite Key (liitvõti) on võti, mis koosneb kahest või enamast veerust. Koos tagavad need veerud rea unikaalsuse.

Milleks kasutatakse:
Kui ükski veerg eraldi ei suuda rida unikaalselt identifitseerida, aga veergude kombinatsioon suudab. Sageli kasutatakse "mitu-mitmele" seose tabelites.

Erinevus teistest võtmetest:
Erinevalt Simple Key-st kasutab mitut veergu. Erinevalt Compound Key-st ei sisalda tavaliselt võõrvõtmeid (kuigi piir on hägune).

```sql
CREATE TABLE hinded (
    tudengi_id INT,
    kursuse_id INT,
    hinne CHAR(2),
    PRIMARY KEY (tudengi_id, kursuse_id)  -- Composite Key
);

INSERT INTO hinded (tudengi_id, kursuse_id, hinne)
VALUES (1, 101, 'A');

-- Järgmine INSERT põhjustab vea, kuna (1, 101) on juba olemas
-- INSERT INTO hinded (tudengi_id, kursuse_id, hinne)
-- VALUES (1, 101, 'B');
```
## Compound Key (Liitvõti – teine termin)
Definitsioon:
Compound Key (liitvõti) – kasutatakse sageli Composite Key sünonüümina, kuid mõnes allikas tähendab see, et vähemalt üks veergudest on võõrvõti (Foreign Key).

Milleks kasutatakse:
Unikaalse identifitseerimise loomiseks seosetabelites, kus iga veerg viitab teiste tabelite primaarvõtmetele.

Erinevus teistest võtmetest:
Tehniliselt väga sarnane Composite Key-ga, kuid rõhk on sellel, et koostisosad on tavaliselt FOREIGN KEY-d.

```sql
CREATE TABLE tellimused (
    tellimuse_id INT PRIMARY KEY,
    tellimuse_kuupäev DATE
);

CREATE TABLE tellimuse_read (
    tellimuse_id INT,
    toote_id INT,
    kogus INT,
    PRIMARY KEY (tellimuse_id, toote_id),  -- Compound Key
    FOREIGN KEY (tellimuse_id) REFERENCES tellimused(tellimuse_id),
    FOREIGN KEY (toote_id) REFERENCES tooted(toote_kood)
);
```

## Superkey (Supervõti)
Definitsioon:
Superkey (supervõti) on ühe või mitme veeru kogum, mis identifitseerib rea unikaalselt. See võib sisaldada lisaveerge, mis pole unikaalsuse jaoks vajalikud.

Milleks kasutatakse:
See on teoreetiline mõiste andmebaaside normaliseerimisel. Iga võti (Primary, Candidate) on supervõti, kuid mitte vastupidi.

Erinevus teistest võtmetest:
Superkey võib olla üleliigne. Näiteks {tudengi_id, perenimi} on supervõti, isegi kui perenimi pole unikaalsuse jaoks vajalik.

```sql
CREATE TABLE tootajad (
    tootaja_id INT PRIMARY KEY,
    isikukood VARCHAR(20) UNIQUE,
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50)
);

-- tootaja_id on supervõti (minimaalne -> Candidate)
-- (tootaja_id, eesnimi) on samuti supervõti (üleliigne)
-- isikukood on supervõti
```

## Candidate Key (Kandidaatvõti)
Definitsioon:
Candidate Key (kandidaatvõti) on minimaalne supervõti – see tähendab veergude kogum, mis identifitseerib rea unikaalselt ja millest ei saa ühtegi veergu eemaldada ilma unikaalsust kaotamata.

Milleks kasutatakse:
Hulgast Candidate Key-dest valitakse üks PRIMARY KEY-ks ja ülejäänud saavad ALTERNATE KEY-deks.

Erinevus teistest võtmetest:
Erinevalt Superkey-st ei sisalda Candidate Key lisaveerge. Erinevalt Primary Key-st võib neid olla mitu ja ainult ühest saab Primary.

```sql
CREATE TABLE kasutajad (
    kasutaja_id INT PRIMARY KEY,      -- Candidate Key (valitud Primary-ks)
    kasutajanimi VARCHAR(50) UNIQUE,  -- Candidate Key (Alternate)
    email VARCHAR(100) UNIQUE,        -- Candidate Key (Alternate)
    täisnimi VARCHAR(100)
);

-- Candidate Keys: (kasutaja_id), (kasutajanimi), (email)
-- Primary Key: kasutaja_id
-- Alternate Keys: kasutajanimi, email
```

## Alternate Key (Alternatiivvõti)
Definitsioon:
Alternate Key (alternatiivvõti) on Candidate Key, mida ei valitud PRIMARY KEY-ks. Kõik ülejäänud Candidate Key-d saavad Alternate Key-deks.

Milleks kasutatakse:
Alternatiivse unikaalse identifitseerimisviisi pakkumiseks (nt otsimine e-posti, mitte ID järgi).

Erinevus teistest võtmetest:
See on Candidate Key alamhulk. Erinevalt Primary Key-st võib neid olla mitu. Erinevalt Foreign Key-st ei viita see teisele tabelile.

```sql
CREATE TABLE kasutajad_alternate (
    kasutaja_id INT PRIMARY KEY,
    kasutajanimi VARCHAR(50) UNIQUE,   -- Alternate Key
    email VARCHAR(100) UNIQUE,         -- Alternate Key
    registreerimise_kuupäev DATE
);

-- Otsing Alternate Key järgi
SELECT * FROM kasutajad_alternate WHERE kasutajanimi = 'mari_tamm';
```


## Allikad

 *Link:* https://www.guru99.com/dbms-keys.html
 
