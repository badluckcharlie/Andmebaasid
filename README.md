## SISUKORD
- [Põhimõisted](#põhimõisted)
- [Piiragnud](#piiragnud)
- [Andmetüübid](#andmetüübid)
# Andmebaasid
Andmebaasid, SQL, konspektid
## Andmebaasid
andmebaaside haldusega seotud sql kood ja konspektid

## Põhimõisted
- Andmebaassihalhudsüsteemid - tarkvara, millega abil saab luaa andmebaas (mariaDB - XAMMP, SQL Server - SQL Server Management studio) (Server name (localdb)\MSSQLLocalDB )
- Andmebaas - Struktureeritud andmete kogum
- Tabel - olem - сущности
- Veerg = väli - поле
- Rida = kirje - запись
- Primaarne võti - Primary key (PK) - первичный ключ, veeg, unikaalse identifikatooriga (tavaliselt nimetakse ID)
- Välisvõti (võõrvõti) - foreign key - FK - вторичный ключ, veerg, mis loob seose teise tabeli primaarne võtmega
## SQL - Structured Querry Language, Struktureeritud päringu keel, структурированный язык запросов
Päring - запрос
<img width="442" height="366" alt="{96391BAB-FED9-4912-9311-44A37EB02D22}" src="https://github.com/user-attachments/assets/dab296ef-bfb3-4b3f-8ddc-ee908f6234e9" />
1. DDL - Data Definition Language
2. DML - Data Manipulation Language

## Piiragnud - Constraint
1. PRIMARY KEY
2. NOT NULL
3. CHECK - Valik
4. UNIQUE
5. FOREIGN KEY
## Andmetüübid
```
1. int, smallint, decimal (5,2) - numbrilised (Только когда с числами будут мат. операции)
2. varchar(30), char (5), TEXT/sümbolised
3. date, time, datetime - kuupäeva
4. boolean, bit, bool - loogilised
```
## Tabelivahelised seosed
- Üks-ühele (Nt naine-mees)
- Üks-mitmele (Nt naine-lapsed)
- Mitme-mitmele (Õpilased-Tunnid)
