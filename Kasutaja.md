
[Põhimõisted](README.md) | [Kasutajad](Kasutaja.md) | [Trigerid](Triger.md) | [Protseduurid](procedure.md) | [Võtmed](Keys.md) | [Arvestatud veerud](CalculatedColumns.md) | [Funktsioonid](StringOperatorsandFunctions.md) | [Alter Table](Tund2Alter.md) | [XAMPP - Trigerid ja kasutajad](TrigerXXAMP.md)


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


## Kasutaja õiguste kontroll
Logime sisse meie uue kasutajana
<img width="465" height="507" alt="{BE334670-79F0-4826-9829-275CEB866062}" src="https://github.com/user-attachments/assets/9c4b533e-bedb-4042-b2b7-155b41dad308" />

Vaatame mis meile lubatakse:
<img width="646" height="596" alt="{46334AFE-882C-4950-87EA-B8B978F2DF60}" src="https://github.com/user-attachments/assets/cabaf107-b141-44b6-917c-7767b6b6ca55" />

Nüüd mis on keelatud:
<img width="928" height="580" alt="{1FC7725B-D63E-48F6-8EF4-7335607E29DA}" src="https://github.com/user-attachments/assets/addf7f95-8dad-49b8-9dcd-7fe29b1aaa9b" />

Vaatame õigused läbi SQL päring:
<img width="555" height="499" alt="{6B6134DF-8768-4273-A904-9309CF5174A9}" src="https://github.com/user-attachments/assets/6bfd7388-f50e-45d1-badf-f4c8080d1334" />

Nüüd läbi UI
<img width="687" height="747" alt="{DDC496C9-9A5E-408B-A2CB-D6A7023CD94E}" src="https://github.com/user-attachments/assets/7860688b-dc82-4996-86dd-9cf3bcca7b83" />




