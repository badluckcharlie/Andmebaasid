## SQL protseduur - 
store procedure - salvestatud protseduurid - sama mis on funktsioonid programeerimises, mingi tegevus, mis on salvestatud andmebaasi ja mida saab automaatsel teha (INSERT, UPDATE, SELECT, DELETE).

```sql
--protseduur mis lisab andmeid tabelisse ja kohe kuvab neid. (INSERT, SELECT)
CREATE Procedure lisaKategooria
--parameetrid @...
@uusKategooria varchar(30)
AS
BEGIN
--kirjedus
	INSERT INTO categories(category_name)
	VALUES (@uusKategooria);
	SELECT * FROM categories;
END;

--kutse
EXEC lisaKategooria 'Auto';
```
<img width="1652" height="959" alt="image" src="https://github.com/user-attachments/assets/1cf2e035-acfe-4767-8f4f-3f0d2f23bca1" />

<img width="285" height="131" alt="{E91E16F2-34CE-44B4-B40B-26B0811E6DD7}" src="https://github.com/user-attachments/assets/cec0fde9-354d-487b-87a0-95176a57f2e0" />

```sql
--protseduur, mis kustutab kategooria id järgi
CREATE procedure kustutaKategooria
@kustutaID int
AS
BEGIN
	SELECT * FROM categories;
	DELETE FROM categories WHERE category_id=@kustutaID;
	SELECT * FROM categories;
END;

--kutse
EXEC kustutaKategooria 1
```
<img width="1493" height="1012" alt="image" src="https://github.com/user-attachments/assets/4e1744e0-1762-4c86-a58e-a054fb5dede6" />

<img width="273" height="246" alt="{93A8288A-D867-433A-A3CD-21959892AFB7}" src="https://github.com/user-attachments/assets/529e4b77-a455-4824-9659-a005298bf5bc" />

```sql
--protseduur mis kuvab kategooriad sisestatud esimese tähe järgi
CREATE procedure otsing1taht
@taht char(1)
AS
BEGIN
	SELECT * FROM categories
	WHERE category_name LIKE @taht + '%'; --% - teised sümbolid
END;

--kutse
EXEC otsing1taht 'A';
```
<img width="1599" height="1090" alt="image" src="https://github.com/user-attachments/assets/822251dc-5dce-4d41-9b0a-b49ee67f9e60" />

<img width="304" height="88" alt="{D0E64F0A-79B4-40D7-9BA4-C95F1587B55B}" src="https://github.com/user-attachments/assets/bd91be62-cddd-448f-8aa5-c9d5fe8a9051" />

```sql
--protseduur, mis kuvab tooded, kus on hind suurem kui sisestatud hind
CREATE procedure suuremHind
@hind int
AS
BEGIN
	SELECT * FROM products
	WHERE list_price > @hind;
END;

--kutse 
EXEC suuremHind 400;
```
<img width="265" height="109" alt="{BE22CFB6-6CE2-4787-AC21-2661B76D8482}" src="https://github.com/user-attachments/assets/d1b5512d-c48c-4da9-a787-6524c62c1796" />
<img width="469" height="129" alt="{85099C03-DA9F-40E0-88F5-C1F7E672175B}" src="https://github.com/user-attachments/assets/d4a5cf69-d112-40e3-9d4c-56292e89cd8e" />

```sql
--Dünaamiline SQL protseduuris (ALTER TABLE) - universaalne protseduur, mis töötab üks kõik millese tabeliga
--Protseduur veeru lisamiseks või kustutamiseks 
--muudab struktuuri (veeru lisamine ADD, veeru kustutamine DROP)
CREATE PROCEDURE muudatus
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;

--kutse lisamiseks
exec muudatus 'add', 'categories', 'testVeerg', 'int'

select * from categories

--kutse kustutamiseks
exec muudatus 'drop', 'categories', 'testVeerg', 'int'
```
<img width="286" height="171" alt="{9FE9963C-E803-41AB-9E3E-AC55FBC866A9}" src="https://github.com/user-attachments/assets/3f968905-7b00-466c-aa5d-254828711783" />
<img width="279" height="131" alt="{8884C860-E07B-4DEF-8592-63AEC45B9D09}" src="https://github.com/user-attachments/assets/6f0a075f-0a39-440d-bf6e-f814d14dec05" />
<img width="285" height="152" alt="{76302BF9-1C21-44FD-83C0-125013C493AF}" src="https://github.com/user-attachments/assets/5c280134-c571-4574-8014-b0860c585f18" />
