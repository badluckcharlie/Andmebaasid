
[Põhimõisted](README.md) | [Kasutajad](Kasutaja.md) | [Trigerid](Triger.md) | [Protseduurid](procedure.md) | [Võtmed](Keys.md) | [Arvestatud veerud](CalculatedColumns.md) | [Funktsioonid](StringOperatorsandFunctions.md) | [Alter Table](Tund2Alter.md) | [XAMPP - Trigerid ja kasutajad](TrigerXXAMP.md)

## SQL Protseduur
Store procedure - ssavlestatud protseduurid - sama mis on funktsioonid programmerimises, mingi tegevus, mis on salvestatud andmebaasi, ja mida saab automaatselt teha (INSERT, UPDATE, SELECT, UPDATE).
--protseduur mis lisab andmeid tabelisse ja kohe kuvad neid. (INSERT, SELECT)
CREATE PROCEDURE lisaKategooria
--parameetrid @...
@uusKategooria varchar(30)
AS
BEGIN
--Kirjeldus
	INSERT INTO categories(category_name)
	VALUES ('@uuskategooria');
	SELECT * FROM categories;
END;

<img width="236" height="380" alt="{9E0BA8B8-12B1-40B2-A40F-0D0D21E16AAF}" src="https://github.com/user-attachments/assets/631550a0-9de9-4306-a0ad-0fa49f8b3482" />

--protseduur, mis kustutab kategooria 
CREATE PROCEDURE kustutaKategooria
@kustutaId int
AS
BEGIN
	SELECT * FROM categories;
	DELETE FROM	categories WHERE category_id=@kustutaId;
    SELECT * FROM categories
END
--kutse
EXEC kustutaKategooria 6

<img width="466" height="410" alt="{70A63F6B-B4AA-4AA6-85EF-C25670AB9E49}" src="https://github.com/user-attachments/assets/a8e241eb-942f-4ae7-a7db-71557c894372" />

--protseduur mis kuvab kategooriad sisestatud esimese tähe järgi
CREATE PROCEDURE otsing1taht
@taht char(1)
AS
BEGIN
	SELECT * FROM categories
	WHERE category_name LIKE @taht + '%'; --% teised sümboolid
END

EXEC otsing1taht 'A';

<img width="513" height="317" alt="{5347EE78-1716-4E2E-99D7-3F72CE04C5D4}" src="https://github.com/user-attachments/assets/4b4a0034-4dd5-43e7-9f61-d22adbd21dba" />



