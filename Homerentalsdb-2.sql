USE homerentals;
-- Insert into Postkatalog
INSERT INTO Postkatalog (Postnr, Poststed) VALUES
('0460', 'Oslo'),
('5003', 'Bergen'),
('7012', 'Trondheim'),
('4020', 'Stavanger'),
('3045', 'Drammen');

-- Insert into Fasilitet
INSERT INTO Fasilitet (Fasilitetsnavn) VALUES
('Wi-Fi'),
('Parkering'),
('Kjøkken'),
('Hengekøye'),
('Peis'),
('Balkong');

-- Insert into Botype
INSERT INTO Botype (Botype) VALUES
('Leilighet'),
('Hus'),
('Hytte'),
('Bobil');

-- Insert into Rolle
INSERT INTO Rolle (Rollenavn) VALUES
('Gjest'),
('Vert'),
('Admin');

-- Insert into Sprak
INSERT INTO Sprak (Spraknavn) VALUES
('Norsk'),
('Engelsk'),
('Svensk'),
('Tysk');

-- Insert into Betalingsmetode
INSERT INTO Betalingsmetode (Betalingsmetodenavn) VALUES
('Visa'),
('Mastercard'),
('PayPal'),
('Bankoverføring');

-- Insert into Bruker
INSERT INTO Bruker (BrukerID, Fornavn, Etternavn, Sprak, Epost, Passord, Telefon, Gateadresse, Postnr) VALUES
('user1', 'Ola', 'Nordmann', 'Norsk', 'ola@example.com', 'pass123', '12345678', 'Storgata 1', '0460'),
('user2', 'Kari', 'Hansen', 'Engelsk', 'kari@example.com', 'pass456', '87654321', 'Bergensveien 2', '5003'),
('user3', 'Per', 'Olsen', 'Svensk', 'per@example.com', 'pass789', '11223344', 'Trondheimsgate 3', '7012'),
('user4', 'Anne', 'Larsen', 'Tysk', 'anne@example.com', 'passabc', '44332211', 'Stavangervei 4', '4020'),
('user5', 'Lars', 'Johansen', 'Norsk', 'lars@example.com', 'passdef', '55667788', 'Drammensgata 5', '3045');

-- Insert into Brukerrolle
INSERT INTO Brukerrolle (BrukerID, RolleID) VALUES
('user1', 2),  -- Vert
('user2', 2),  -- Vert
('user3', 1),  -- Gjest
('user4', 1),  -- Gjest
('user5', 1);  -- Gjest

-- Insert into Brukersprak
INSERT INTO Brukersprak (BrukerID, SprakID) VALUES
('user1', 2),  -- Ola snakker engelsk
('user3', 1),  -- Per snakker norsk
('user4', 2);  -- Anne snakker engelsk

-- Insert into Kortinfo
INSERT INTO Kortinfo (Kortnavn, BrukerID, Registreringsdato, Kortnummer, UtlopsDato, BetalingsmetodeID) VALUES
('OlasVisa', 'user1', '2023-01-15', '4111111111111111', '1225', 1),
('KarisMC', 'user2', '2023-02-20', '5500000000000004', '0624', 2);

-- Insert into Boenhet
INSERT INTO Boenhet (VertID, RegistrertDato, Gateadresse, Postnr, PrisPrNatt, Beskrivelse, Botype, Soverom, Seng, Bad) VALUES
('user1', '2023-01-10', 'Fjordveien 10', '0460', 800.00, 'Leilighet i Oslo sentrum', 1, 1, 2, 1),
('user2', '2023-02-15', 'Bergensgata 5', '5003', 1200.00, 'Hytte med fjordutsikt', 3, 2, 4, 1),
('user1', '2023-03-20', 'Hovedgaten 3', '0460', 1500.00, 'Moderne hus i Oslo', 2, 3, 4, 2),
('user2', '2023-04-25', 'Strandveien 7', '5003', 2000.00, 'Luksus bobil', 4, 3, 5, 2);

-- Insert into FasilitetIBoenhet
INSERT INTO FasilitetIBoenhet (FasilitetID, BoenhetID) VALUES
(1, 1), (3, 1),  -- Oslo leilighet har Wi-Fi og kjøkken
(2, 2), (4, 2),  -- Bergen hytte har parkering og hengekøye
(1, 3), (5, 3),  -- Oslo hus har Wi-Fi og peis
(2, 4), (6, 4);  -- Bobil har parkering og balkong

-- Insert into Soknad
INSERT INTO Soknad (Gjest, BoenhetID, Startdato, Sluttdato, Oppholdstatus, Totalpris) VALUES
('user3', 1, '2023-06-01', '2023-06-07', TRUE, 4800.00),
('user4', 2, '2023-07-15', '2023-07-20', TRUE, 6000.00),
('user5', 3, '2023-08-10', '2023-08-12', FALSE, 3000.00);

-- Insert into Opphold
INSERT INTO Opphold (Gjest, BoenhetID, Startdato, Sluttdato, Totalpris, Betalingsstatus) VALUES
('user3', 1, '2023-06-01', '2023-06-07', 4800.00, 1),
('user4', 2, '2023-07-15', '2023-07-20', 6000.00, 1);

-- Insert into Anmeldelse
INSERT INTO Annmeldelse (BrukerID, BoenhetID, Startdato, Sluttdato, Rangering, Kommentar) VALUES
('user3', 1, '2023-06-01', '2023-06-07', 5, 'Utmerket opplevelse!'),
('user4', 2, '2023-07-15', '2023-07-20', 4, 'Flott beliggenhet');

-- Insert into Bilde
INSERT INTO Bilde (BoenhetID, Bildefil, Rekkefolge, Beskrivelse) VALUES
(1, 'leilighet1.jpg', '1', 'Stue med moderne design'),
(1, 'leilighet2.jpg', '2', 'Kjøkkenutstyr'),
(2, 'hytte1.jpg', '1', 'Utsikt fra terrassen'),
(3, 'hus1.jpg', '1', 'Hovedsoverom'),
(4, 'bobil1.jpg', '1', 'Interiør');

-- Insert into Melding
INSERT INTO Melding (Gjest, BoenhetID, Tid, SendtAv, Melding) VALUES
('user3', 1, '2023-05-25 10:00:00','user3', 'Er parkering tilgjengelig?'),
('user3', 1, '2023-05-25 11:00:00','user1', 'Ja, gratis parkering i garasje');

-- Insert into Favoritt
INSERT INTO Favoritt (GjestID, BoenhetID) VALUES
('user3', 1),
('user4', 2),
('user5', 3);

-- Insert into Betaling
INSERT INTO Betaling (Betalingsstatus, BetalingsmetodeID, Betalingsdato, Totalpris, Gebyr, Kortnavn) VALUES
(1, 1, '2023-05-28', 4800.00, 100.00, 'OlasVisa'),
(1, 3, '2023-07-10', 6000.00, 0.00, NULL);