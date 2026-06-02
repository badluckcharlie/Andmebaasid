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
concat('linn: ', inserted.linnanimi, 'rahvaarv', inserted.rahvaarv) --andmed lisatud
FROM inserted;
```
