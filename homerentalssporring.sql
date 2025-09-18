USE homerentals;

-- Viser alle boenheter
SELECT *
FROM Boenhet;

SELECT Rangering
FROM Annmeldelse;

SELECT *
FROM Bilde
WHERE Boenhet=1;
-- Søker på fasiliteter
SELECT Boenhet.*
FROM Boenhet, FasilitetIBoenhet, Fasilitet
WHERE Fasilitet.Fasilitetsnavn='Parkering' 
	AND Fasilitet.FasilitetID=FasilitetIBoenhet.FasilitetID 
	AND FasilitetIBoenhet.BoenhetID=Boenhet.BoenhetID;

-- Søker på pris
SELECT *
FROM Boenhet
WHERE PrisPrNatt < 1300;

-- Viser alle søknader til en gjest
SELECT *
FROM Soknad
WHERE Gjest='user3';

-- Viser alle søknader til en utleier
SELECT Soknad.*
FROM Soknad, Boenhet
WHERE Boenhet.BoenhetID=Soknad.BoenhetID AND Boenhet.VertID='user1';

-- Viser alle oppholdene til en gjest
SELECT *
FROM Opphold
WHERE Gjest='user3';

-- Viser alle oppholdene til en vert
SELECT Opphold.*
FROM Opphold, Boenhet
WHERE Boenhet.BoenhetID=Opphold.BoenhetID AND Boenhet.VertID='user1';

-- Legge inn en anmeldelse
INSERT INTO Anmeldelse VALUES
('user2', 1, '2023-06-01', '2023-06-08', 3,'Bra');

SELECT * 
FROM Anmeldelse;
-- Viser anmeldelser til en boenhet
SELECT *
FROM Anmeldelse
WHERE Anmeldelse.BoenhetID=1;

-- opprette en søknad
INSERT INTO Soknad VALUES
('user2', 4, '2024-06-01', '2024-06-08', TRUE, 5600.00);

-- svare på en søknad
UPDATE Soknad
SET Oppholdstatus = TRUE
WHERE BoenhetID = 1 AND Gjest = 'User2';

INSERT INTO Opphold VALUES
('user2', 4, '2024-06-01', '2023-06-08', 5600.00, 1);

-- Sende en melding
INSERT INTO Melding VALUES	-- Sende melding
('user2', 2, '2023-05-25 10:00:00','Vert', 'Er parkering tilgjengelig?');

-- Vise alle meldinger med en person
SELECT * 		-- Se melding som gjest
FROM Melding
WHERE Melding.Gjest='User3';

SELECT Melding.*		-- Se melding som utleier
FROM Melding, Boenhet
WHERE Boenhet.VertID='User1' AND Boenhet.BoenhetID=Melding.BoenhetID;

-- Viser fasiliteter til en boenhet
SELECT Fasilitet.Fasilitetsnavn
FROM Boenhet, FasilitetIBoenhet, Fasilitet
WHERE Boenhet.BoenhetID=FasilitetIboenhet.BoenhetID
	AND FasilitetIBoenhet.FasilitetID=Fasilitet.FasilitetID
    AND Boenhet.BoenhetID=1;

-- Legg til bruker
INSERT INTO Bruker VALUES
('user6', 'Ole', 'Nordmann', 'Norsk', 'ole@example.com', 'pass12345', '12365478', 'Storgata 3', '0460');

-- Legge til boenhet
INSERT INTO Boenhet (VertID, RegistrertDato, Gateadresse, Postnr, PrisPrNatt, Beskrivelse, Botype) VALUES
('user6', '2025-01-10', 'Fjordveien 13', '0460', 900.00, 'Leilighet i Oslo sentrum', 1);

-- Slette Boenhet
DELETE FROM FasilitetIBoenhet
WHERE BoenhetID=1;
DELETE FROM Favoritt
WHERE BoenhetID=1;
DELETE FROM Annmeldelse
WHERE BoenhetID=1;
DELETE FROM Bilde
WHERE BoenhetID=1;
DELETE FROM Melding
WHERE BoenhetID=1;
DELETE FROM Opphold
WHERE BoenhetID=1;
DELETE FROM Soknad
WHERE BoenhetID=1;
DELETE FROM Boenhet
WHERE BoenhetID=1;

-- Slette Bruker
-- Sletter også alle boenheter til brukeren om de finnes
DELETE FROM BrukerRolle
WHERE BrukerID='User1';
DELETE FROM BrukerSprak
WHERE BrukerID='User1';
DELETE FROM Betaling
WHERE Kortnavn='User1'.Kortnavn;
DELETE FROM Kortinfo
WHERE BrukerID='User1';
DELETE FROM Favoritt
WHERE BrukerID='User1';
DELETE FROM Bruker
WHERE BrukerID='User1';

-- Legge til som favoritt
INSERT INTO Favoritt VALUES
('user2', 1);

-- Se alle sine boenheter
SELECT *
FROM Boenhet
WHERE VertID='User2';

-- Se informasjon om sin bruker -- Feil
SELECT Bruker.*, Rolle.Rollenavn, Sprak.Spraknavn
FROM Bruker, Brukerrolle,Rolle, Kortinfo, Brukersprak, Sprak
WHERE Bruker.BrukerID='User3'
	AND Brukerrolle.BrukerID=Bruker.BrukerID
    AND Brukerrolle.RolleID=Rolle.RolleID
    AND Brukersprak.BrukerID=Bruker.BrukerID
    AND Brukersprak.SprakID=Sprak.SprakID;
    
SELECT *
FROM Kortinfo
WHERE BrukerID='User1';

-- Registrere seg som vert
INSERT INTO BrukerRolle VALUES
('user3', 2);

-- Trekke Søknad
-- Viser liste over sendte søknader
-- Systemet sjekker om søknaden har blitt godtatt
DELETE FROM Soknad
WHERE Gjest='User1' AND BoenhetID=3 AND Startdato='2023-06-01';

-- Endring av opphold
INSERT INTO Soknad VALUES
('user3', 1, '2023-07-01', '2023-07-07', TRUE, 4800.00);

UPDATE Opphold
SET Startdato='2023-07-01' AND Sluttdato='2023-07-07'
WHERE Gjest='User1' AND BoenhetID=3 AND Startdato='2023-06-01';

UPDATE Soknad
SET Oppholdstatus=False
WHERE Gjest='User1' AND BoenhetID=3 AND Startdato='2023-06-01';

-- Kansellering av opphold, gjort av bruker (Vert kan ikke kansellere uten grunn)
SELECT *
FROM Opphold
WHERE BoenhetID=1
AND Gjest='User3'; -- 1 er ett eksempel og kan bli byttet ut

DELETE FROM Opphold
WHERE BoenhetID=1
AND Startdato='2023-01-01'
AND Gjest='User3'; -- 1 er ett eksempel og kan bli byttet ut

-- Gjøre boenhet utilgjengelig
SELECT *
FROM Opphold
WHERE BoenhetID=1; -- 1 er ett eksempel og kan bli byttet ut

INSERT INTO Opphold VALUES(Gjest,BoenhetID,Startdato,Sluttdato,Totalpris,Betalingsstatus);


-- Slette anmeldelser
SELECT *
FROM Anmeldelse
WHERE BrukerID='User2'
AND BoenhetID=1
AND Startdato=2023-01-01; -- 1 er ett eksempel og kan bli byttet ut

DELETE FROM Anmeldelse
WHERE BrukerID='User2'
AND BoenhetID=1
AND Startdato=2023-01-01; -- 1 er ett eksempel og kan bli byttet ut

-- Endre brukerinformasjon
SELECT *
FROM Bruker
WHERE BrukerID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT *
FROM BrukerSprak
WHERE BrukerID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT *
FROM Kortinfo
WHERE BrukerID=1; -- 1 er ett eksempel og kan bli byttet ut

UPDATE Bruker
SET Fornavn=NyFornavn
AND Etternavn=NyEtternavn
AND Epost=NyEpost
AND Telefon=NyTelefon
AND Gateadresse=NyGateadresse
AND PostNr=NyPostNr
WHERE BrukerID=1; -- 1 er ett eksempel og kan bli byttet ut

UPDATE Bruker
SET Passord=NyPassord
WHERE BrukerID=1;-- 1 er ett eksempel og kan bli byttet ut

DELETE FROM Brukersprak
WHERE BrukerID=1; -- 1 er ett eksempel og kan bli byttet ut

INSERT INTO Brukersprak VALUES(BrukerID,SprakID);

UPDATE Kortinfo
SET Kortnavn=NyKortnavn
AND Kortnummer=NyKortnummer
AND Utlopsdato=NyUtlopsdato
WHERE Kortnavn=1; -- 1 er ett eksempel og kan bli byttet ut

DELETE FROM Kortinfo
WHERE Kortnavn=1; -- 1 er ett eksempel og kan bli byttet ut

INSERT INTO Kortinfo VALUES(Kortnavn, BrukerID, Registrertdato, Kortnummer, Utlopsdato, BetalingsmetodeID);

-- Endre boenhetinformasjon
SELECT *
FROM Boenhet
WHERE BoenhetID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT *
FROM FasilitetIBoenhet
WHERE BoenhetID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT Fasilitetsnavn
FROM Fasilitet
WHERE FasilitetID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT Botype
FROM Botype
WHERE BotypeID=1; -- 1 er ett eksempel og kan bli byttet ut

SELECT *
FROM Bilde
WHERE BoenhetID=1; -- 1 er ett eksempel og kan bli byttet ut

UPDATE Boenhet
SET Gateadresse=NyGateadresse
AND PostNr=NyPostNr
AND PrisPrNatt=NyPrisPrNatt
AND Beskrivelse=NyBeskrivelse
AND BotypeID=NyBotypeID
WHERE BoenhetID=1; -- 1 er ett eksempel og kan bli byttet ut

UPDATE Bilde
SET Bildefil=NyBildefil
AND Beskrivelse=NyBeskrivelse
WHERE BildeID=1; -- 1 er ett eksempel og kan bli byttet ut

DELETE FROM FasilitetIBoenhet
WHERE FasilitetID=1; -- 1 er ett eksempel og kan bli byttet ut

DELETE FROM Bilde
WHERE BildeID=1; -- 1 er ett eksempel og kan bli byttet ut

INSERT INTO FasilitetIBoenhet VALUES(FasilitetID,BoenhetID);

INSERT INTO Bilde VALUES(NyBildeID,BoenhetID,Bildefil,Beskrivelse);

