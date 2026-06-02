## Trigger - Päästik

### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).


```sql
CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupäev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud INSERT käsk',  --toiming
concat('linn: ', inserted.linnanimi, ' rahvaarv: ', inserted.rahvaarv) --andmed lisatud
FROM inserted;
```
<img width="678" height="570" alt="{22693839-85D2-4A8C-9314-947B6A986CA2}" src="https://github.com/user-attachments/assets/0c782fd7-8fc2-45b0-b361-db1fe832f3ed" />



<img width="767" height="379" alt="{C8903B76-19AD-4069-80C7-338E5F085F4B}" src="https://github.com/user-attachments/assets/39f4bf5c-b096-4310-95ea-1f2422c60d6d" />

<img width="695" height="550" alt="{A4D808BB-E506-4B31-8AEB-53951D6AE099}" src="https://github.com/user-attachments/assets/29e6c293-a370-40cf-9469-1a4aa0d87a29" />

```sql
DELETE FROM LINNAD WHERE linnID=2;

select * from linnad;
select * from logi;

CREATE TRIGGER linnaLisaKustuta
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
	INSERT INTO logi(kuupäev, kasutaja, toiming, andmed)

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
	'on tehtud INSERT käsk',  --toiming
	concat('linn: ', inserted.linnanimi, ' rahvaarv', inserted.rahvaarv) --andmed lisatud
	FROM inserted

	UNION ALL

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
	'on tehtud DELETE käsk',  --toiming
	concat('linn: ', deleted.linnanimi, ' rahvaarv', deleted.rahvaarv) --andmed lisatud
	FROM deleted;
END;
```
<img width="849" height="741" alt="{04B911CF-83A6-4880-8E22-668C869F8E48}" src="https://github.com/user-attachments/assets/7640392d-3eb4-43f6-80f6-25a42c4c14a0" />

<img width="620" height="491" alt="{F8EE9E5D-4920-4846-9229-6FBA80ED01AF}" src="https://github.com/user-attachments/assets/807da879-36dd-4762-9cb8-2861d6f6bbfb" />

```sql
--Update trigger
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kuupäev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud UPDATE käsk',  --toiming
concat('eelmised andmed -linn: ', deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv,
' uued andmed - linn: ', inserted.linnanimi, ', rahvaarv - ', inserted.rahvaarv) --andmed lisatud
FROM deleted INNER JOIN inserted
ON deleted.LinnID=inserted.linnID;


select * from linnad;
select * from logi;

Update linnad SET rahvaarv=25000 where linnanimi='Haapsalu'
```

<img width="722" height="414" alt="{990A7D74-7C7D-4CE8-B64B-7821F914BB8C}" src="https://github.com/user-attachments/assets/89c72601-4bb0-456a-aa5b-8e6d8b2f2fb9" />

## Kontrollime teine kasutaja

<img width="713" height="338" alt="{8E972502-AEB0-4EFB-B71E-0ABE4DA2F8C4}" src="https://github.com/user-attachments/assets/35ca784e-92e3-4dff-bf4d-a5c4550433ce" />




