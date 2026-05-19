## SQL Server - Kasutajate autentimine ja õiguste haldamine

**SQL serveris kasutatakse kahte peamist autentimise tüüpi:**
1. Windows Authentication
   > Kasutajanimi ja parool on seotud Windowsiga.
    <img width="463" height="510" alt="{9D74BDCF-88CA-4E5C-A0F4-89F83B7E6603}" src="https://github.com/user-attachments/assets/a6c457c1-63f5-46a5-b757-e9f3da00f314" />

2. SQL Server Authentification
   > Luuakse otse SQL serverisse.

Server menüüs saab määrata ülised õigused.
Tavaliselt piisab rollist: public
<img width="379" height="469" alt="{0AA6AB68-F505-493C-9400-3A43E357CB74}" src="https://github.com/user-attachments/assets/7113e14d-c1b0-4e65-80ed-fa6a4bbc124e" />
<img width="693" height="648" alt="{C69C2D15-BEA3-4C30-8CF5-B3B7FAFD986B}" src="https://github.com/user-attachments/assets/14134545-bcce-489c-acc4-531740c6531d" />
<img width="694" height="653" alt="{B4F96319-9E8B-4AA8-9737-28ECA2FE611C}" src="https://github.com/user-attachments/assets/d14fcda1-f2d8-4159-9991-bc976ea7189a" />

## LISAME ÕIGUSED Queriga

```sql 
--GRANT -õiguste määramine
--DENY -õiguste keelamine
-- anname kasutajale õigus vaadata tabelit, lisada andmeid (SELECT),
-- lisadda andmeid ning uuendada neid (INSERT/UPDATE)
GRANT SELECT ON opilane TO DirectorIvanov2;
GRANT INSERT ON opilane TO DirectorIvanov2;
GRANT UPDATE ON opilane TO DirectorIvanov2;

DENY DELETE ON opilane TO DirectorIvanov2;
```
