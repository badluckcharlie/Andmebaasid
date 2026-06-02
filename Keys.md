
[Põhimõisted](README.md) | [Kasutajad](Kasutaja.md) | [Trigerid](Triger.md) | [Protseduurid](procedure.md) | [võtmed](Keys.md) | [Arvestatud veerud](CalculatedColumns.md) | [Funktsioonid](StringOperatorsandFunctions.md) | [Alter Table](Tund2Alter.md) | [XAMPP - Trigerid ja kasutajad](TrigerXXAMP.md)

# Andmebaasi võtmed (Keys)

## Sissejuhatus

See fail selgitab erinevaid võtmetüüpe relatsioonilistes andmebaasides koos praktiliste SQL-näidete ja ekraanipiltidega.

## 1. Primary Key (Primaarvõti)

**Definitsioon:**  
Primary Key (primaarvõti) on veerg (või veergude kogum), mis identifitseerib igat rida tabelis unikaalselt. See ei või sisaldada NULL väärtusi ja peab olema iga kirje jaoks kordumatu.

**Milleks kasutatakse:**  
Kirjete unikaalsuse tagamiseks, kiireks otsimiseks ja seoste loomiseks teiste tabelitega.

**Erinevus teistest võtmetest:**  
Erinevalt Foreign Key-st on see unikaalne ega saa olla NULL. Erinevalt Unique Key-st võib tabelis olla ainult uks Primary Key ja seda kasutatakse peamise identifikaatorina.

### Praktiline naide (SQL)

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

<img width="492" height="352" alt="{29CFC28A-6C74-40F5-9A58-FC99FB856C0B}" src="https://github.com/user-attachments/assets/b0880628-bcb1-4331-a6e2-5db627021a4b" />


## Foreign Key (võõrvõti)
Definitsioon:
Foreign Key (võorvõti) on veerg või veergude kogum uhes tabelis, mis viitab teise tabeli PRIMARY KEY-le või UNIQUE KEY-le. See tagab andmete viitelise terviklikkuse.

**Milleks kasutatakse:**
Seoste loomiseks tabelite vahel (uks-mitmele, mitu-mitmele) ja toimingute takistamiseks, mis võiksid neid seoseid rikkuda.

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
    registreerimise_kuupaev DATE,
    FOREIGN KEY (kursuse_id) REFERENCES kursused(kursuse_id)
);

INSERT INTO kursused (kursuse_id, kursuse_nimi) VALUES (101, 'SQL alused');
INSERT INTO registreerimised (registreerimise_id, tudengi_id, kursuse_id, registreerimise_kuupaev)
VALUES (1, 1, 101, '2025-05-26');

SELECT * FROM registreerimised;
```

<img width="527" height="225" alt="{BB14D320-C578-4B24-8075-1F0B02760BFC}" src="https://github.com/user-attachments/assets/80c63b10-492a-405b-9b42-d842273ace43" />


## Unique Key (Unikaalne võti)
Definitsioon:
Unique Key (unikaalne võti) on piirang, mis tagab, et koik väärtused veerus või veergude ruhmas on erinevad (unikaalsed). Erinevalt PRIMARY KEY-st võib lubada uhte NULL väärtust.

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

-- järgmine INSERT pohjustab vea, kuna UNIQUE piirang rikutakse
-- INSERT INTO tudengid_unique (tudengi_id, eesnimi, email)
-- VALUES (2, 'Kati', 'jaan@example.com');
```

<img width="416" height="139" alt="{17773CE4-3C5F-486B-8A62-9987A316AA03}" src="https://github.com/user-attachments/assets/918de088-9c75-40c2-ad44-1d77ba57d4c9" />


## Simple Key (Lihtne võti)
Definitsioon:
Simple Key (lihtne võti) on võti, mis koosneb ainult uhest veerust. See võib olla Primary Key, Foreign Key või Unique Key, kuid alati ainult uhest valjast.

**Milleks kasutatakse:**
Kirjete lihtsaks identifitseerimiseks, kui uhest atribuudist piisab koigi ridade eristamiseks.

**Erinevus teistest võtmetest:**
Peamine erinevus on see, et see kasutab ainult uhte veergu, samas kui Composite ja Compound Key kasutavad mitut veergu.
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

<img width="427" height="324" alt="{B8484089-631D-4342-9E46-5E3D026E63E0}" src="https://github.com/user-attachments/assets/d229716f-2016-426e-bb0e-ab02a788ecdf" />


## Composite Key (Liitvõti)
Definitsioon:
Composite Key (liitvõti) on võti, mis koosneb kahest või enamast veerust. Koos tagavad need veerud rea unikaalsuse.

Milleks kasutatakse:
Kui ukski veerg eraldi ei suuda rida unikaalselt identifitseerida, aga veergude kombinatsioon suudab. Sageli kasutatakse "mitu-mitmele" seose tabelites.

Erinevus teistest võtmetest:
Erinevalt Simple Key-st kasutab mitut veergu. Erinevalt Compound Key-st ei sisalda tavaliselt võõrvõtmeid (kuigi piir on hagune).

```sql
CREATE TABLE hinded (
    tudengi_id INT,
    kursuse_id INT,
    hinne CHAR(2),
    PRIMARY KEY (tudengi_id, kursuse_id)  -- Composite Key
);

INSERT INTO hinded (tudengi_id, kursuse_id, hinne)
VALUES (1, 101, 'A');

-- järgmine INSERT pohjustab vea, kuna (1, 101) on juba olemas
-- INSERT INTO hinded (tudengi_id, kursuse_id, hinne)
-- VALUES (1, 101, 'B');
```

<img width="442" height="180" alt="{7E90777F-A389-4BAA-A453-726077955E53}" src="https://github.com/user-attachments/assets/311f0096-d9ba-4d82-8941-4723a71efe2c" />


## Compound Key (Liitvõti – teine termin)
Definitsioon:
Compound Key (liitvõti) – kasutatakse sageli Composite Key sunonuumina, kuid mones allikas tahendab see, et vahemalt uks veergudest on võõrvõti (Foreign Key).

Milleks kasutatakse:
Unikaalse identifitseerimise loomiseks seosetabelites, kus iga veerg viitab teiste tabelite primaarvõtmetele.

Erinevus teistest võtmetest:
Tehniliselt väga sarnane Composite Key-ga, kuid rohk on sellel, et koostisosad on tavaliselt FOREIGN KEY-d.

```sql
CREATE TABLE tellimused (
    tellimuse_id INT PRIMARY KEY,
    tellimuse_kuupaev DATE
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

<img width="494" height="119" alt="{1C494D1E-C643-474F-BE3A-440D8AE4D2C5}" src="https://github.com/user-attachments/assets/d9008fbf-feaf-451e-9b55-31c5442e72a5" />

<img width="305" height="455" alt="{53E4A232-F3CA-414D-BC4B-E4CC3ECF9C78}" src="https://github.com/user-attachments/assets/1c4286a9-9827-4598-82cf-9890a10afbfb" />


## Superkey (Supervõti)
Definitsioon:
Superkey (supervõti) on ühe või mitme veeru kogum, mis identifitseerib rea unikaalselt. See võib sisaldada lisaveerge, mis pole unikaalsuse jaoks vajalikud.

Milleks kasutatakse:
See on teoreetiline moiste andmebaaside normaliseerimisel. Iga võti (Primary, Candidate) on supervõti, kuid mitte vastupidi.

Erinevus teistest võtmetest:
Superkey võib olla üleliigne. Naiteks {tudengi_id, perenimi} on supervõti, isegi kui perenimi pole unikaalsuse jaoks vajalik.

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

<img width="264" height="122" alt="{1916500B-517F-4167-95F5-5E8017F13C86}" src="https://github.com/user-attachments/assets/a0b805b8-98cc-49ce-a9f0-98957b044dd7" />


## Candidate Key (Kandidaatvõti)
Definitsioon:
Candidate Key (kandidaatvõti) on minimaalne supervõti – see tahendab veergude kogum, mis identifitseerib rea unikaalselt ja millest ei saa uhtegi veergu eemaldada ilma unikaalsust kaotamata.

Milleks kasutatakse:
Hulgast Candidate Key-dest valitakse uks PRIMARY KEY-ks ja ülejaanud saavad ALTERNATE KEY-deks.

Erinevus teistest võtmetest:
Erinevalt Superkey-st ei sisalda Candidate Key lisaveerge. Erinevalt Primary Key-st võib neid olla mitu ja ainult uhest saab Primary.

```sql
CREATE TABLE kasutajad (
    kasutaja_id INT PRIMARY KEY,      -- Candidate Key (valitud Primary-ks)
    kasutajanimi VARCHAR(50) UNIQUE,  -- Candidate Key (Alternate)
    email VARCHAR(100) UNIQUE,        -- Candidate Key (Alternate)
    taisnimi VARCHAR(100)
);

-- Candidate Keys: (kasutaja_id), (kasutajanimi), (email)
-- Primary Key: kasutaja_id
-- Alternate Keys: kasutajanimi, email
```

<img width="566" height="111" alt="{EC4BBFD1-470B-4EB0-979D-FE2FCC3629FD}" src="https://github.com/user-attachments/assets/d5d74228-9218-4db9-a7b8-dea026c37716" />


## Alternate Key (Alternatiivvõti)
Definitsioon:
Alternate Key (alternatiivvõti) on Candidate Key, mida ei valitud PRIMARY KEY-ks. Koik ülejaanud Candidate Key-d saavad Alternate Key-deks.

Milleks kasutatakse:
Alternatiivse unikaalse identifitseerimisviisi pakkumiseks (nt otsimine e-posti, mitte ID järgi).

Erinevus teistest võtmetest:
See on Candidate Key alamhulk. Erinevalt Primary Key-st võib neid olla mitu. Erinevalt Foreign Key-st ei viita see teisele tabelile.

```sql
CREATE TABLE kasutajad_alternate (
    kasutaja_id INT PRIMARY KEY,
    kasutajanimi VARCHAR(50) UNIQUE,   -- Alternate Key
    email VARCHAR(100) UNIQUE,         -- Alternate Key
    registreerimise_kuupaev DATE
);

-- Otsing Alternate Key järgi
SELECT * FROM kasutajad_alternate WHERE kasutajanimi = 'mari_tamm';
```

<img width="465" height="120" alt="{578DD86D-04F6-436F-91ED-4D525FC50CE4}" src="https://github.com/user-attachments/assets/6efa3ade-8dc3-41d9-af3f-e700009d69b8" />

<img width="321" height="418" alt="{310888B7-C34D-46B0-872D-886116C07733}" src="https://github.com/user-attachments/assets/d7d212a2-e646-4a4e-b2c2-d60ebe1c4737" />


## Allikad

 *Link:* https://www.guru99.com/dbms-keys.html
 
