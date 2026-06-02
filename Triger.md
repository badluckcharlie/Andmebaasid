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

