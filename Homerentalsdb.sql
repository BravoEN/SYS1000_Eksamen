DROP SCHEMA IF EXISTS homerentals;
CREATE SCHEMA homerentals;

USE homerentals;

-- Første omgang

CREATE TABLE Betalingsmetode
(
BetalingsmetodeID INT AUTO_INCREMENT,
Betalingsmetodenavn CHAR(16) NOT NULL,
CONSTRAINT BetalingsmetodePK PRIMARY KEY (BetalingsmetodeID)
);

CREATE TABLE Postkatalog
(
Postnr CHAR(4),
Poststed CHAR(20) NOT NULL,
CONSTRAINT PostkatalogPK PRIMARY KEY (Postnr)
);

CREATE TABLE Fasilitet
(
FasilitetID INT AUTO_INCREMENT,
Fasilitetsnavn CHAR(16) NOT NULL,
CONSTRAINT FasilitetPK PRIMARY KEY (FasilitetID)
);

CREATE TABLE Botype
(
BotypeID INT AUTO_INCREMENT,
Botype CHAR(20) NOT NULL,
CONSTRAINT BotypePK PRIMARY KEY (BotypeID)
);

CREATE TABLE Rolle
(
RolleID INT AUTO_INCREMENT,
Rollenavn CHAR(16) NOT NULL,
CONSTRAINT RollePK PRIMARY KEY (RolleID)
);

CREATE TABLE Sprak
(
SprakID INT AUTO_INCREMENT,
Spraknavn CHAR(16) NOT NULL,
CONSTRAINT SprakPK PRIMARY KEY (SprakID)
);

-- Andre omgang

CREATE TABLE Bruker
(
BrukerID CHAR(16),
Fornavn CHAR(16) NOT NULL,
Etternavn CHAR(16) NOT NULL,
Sprak CHAR(16),
Epost CHAR(16) NOT NULL UNIQUE,
Passord VARCHAR(25) NOT NULL UNIQUE,
Telefon CHAR(11) NOT NULL,
Gateadresse CHAR(25),
Postnr CHAR(4),
CONSTRAINT BrukerPK PRIMARY KEY (BrukerID),
CONSTRAINT BrukerFK FOREIGN KEY (Postnr) REFERENCES Postkatalog(Postnr)
);

-- Tredje omgang
CREATE TABLE Boenhet
(
BoenhetID INT AUTO_INCREMENT,
VertID CHAR(16) NOT NULL,
RegistrertDato DATE NOT NULL,
Gateadresse CHAR(25) NOT NULL,
Postnr CHAR(4) NOT NULL,
PrisPrNatt DECIMAL NOT NULL,
Beskrivelse TEXT,
Botype INT NOT NULL,
Soverom INT NOT NULL,
Seng INT NOT NULL,
Bad INT NOT NULL,
CONSTRAINT BoenhetPK PRIMARY KEY (BoenhetID),
CONSTRAINT BoenhetVertFK FOREIGN KEY (VertID) REFERENCES Bruker(BrukerID),
CONSTRAINT BoenhetPostnrFK FOREIGN KEY (Postnr) REFERENCES Postkatalog(Postnr),
CONSTRAINT BoenhetTypeFK FOREIGN KEY (Botype) REFERENCES Botype(BotypeID)
);

CREATE TABLE Brukerrolle
(
BrukerID CHAR(16),
RolleID INT,
CONSTRAINT BrukerrollePK PRIMARY KEY (BrukerID,RolleID),
CONSTRAINT BrukerrolleBrukerFK FOREIGN KEY (BrukerID) REFERENCES Bruker(BrukerID),
CONSTRAINT BrukerrolleRolleFK FOREIGN KEY (RolleID) REFERENCES Rolle(RolleID)
);

CREATE TABLE Brukersprak
(
BrukerID CHAR(16),
SprakID INT,
CONSTRAINT BrukersprakPK PRIMARY KEY (BrukerID,SprakID),
CONSTRAINT BrukersprakBrukerFK FOREIGN KEY (BrukerID) REFERENCES Bruker(BrukerID),
CONSTRAINT BrukersprakSprakFK FOREIGN KEY (SprakID) REFERENCES Sprak(SprakID)
);

CREATE TABLE Kortinfo
(
Kortnummer CHAR(16),
Kortnavn CHAR(20) NOT NULL,
BrukerID CHAR(16) NOT NULL,
Registreringsdato DATE NOT NULL,
UtlopsDato CHAR(4) NOT NULL,
BetalingsmetodeID INT NOT NULL,
CONSTRAINT KortinfoPK PRIMARY KEY (Kortnummer),
CONSTRAINT KortinfobrukerFK FOREIGN KEY (BrukerID) REFERENCES Bruker(BrukerID),
CONSTRAINT KortinfoMetodeFK FOREIGN KEY (BetalingsmetodeID) REFERENCES Betalingsmetode(BetalingsmetodeID)
);

CREATE TABLE Melding
(
Gjest CHAR(16),
BoenhetID INT,
Tid TIMESTAMP,
SendtAv CHAR(16),
Melding TEXT,
CONSTRAINT MeldingPK Primary key (Gjest,BoenhetID,Tid),
CONSTRAINT MeldinggjestFK FOREIGN KEY (Gjest) REFERENCES Bruker(BrukerID),
CONSTRAINT MeldingvertFK FOREIGN KEY (BoenhetID) REFERENCES Boenhet(BoenhetID)
);

CREATE TABLE Favoritt
(
GjestID CHAR(16),
BoenhetID INT,
CONSTRAINT FavorittPK PRIMARY KEY (GjestID,BoenhetID),
CONSTRAINT FavorittgjestFK FOREIGN KEY (GjestID) REFERENCES Bruker(BrukerID),
CONSTRAINT FavorittvertFK FOREIGN KEY (BoenhetID) REFERENCES Boenhet(BoenhetID)
);

CREATE TABLE FasilitetIBoenhet
(
FasilitetID INT,
BoenhetID INT,
CONSTRAINT FasilitetIBoenhetPK PRIMARY KEY (FasilitetID,BoenhetID),
CONSTRAINT FasilitetIBoenhetFasilitetFK FOREIGN KEY (FasilitetID) REFERENCES Fasilitet(FasilitetID),
CONSTRAINT FasilitetIBoenhetBoenhetFK FOREIGN KEY (BoenhetID) REFERENCES Boenhet(BoenhetID)
);

CREATE TABLE Soknad
(
Gjest CHAR(16),
BoenhetID INT,
Startdato DATE,
Sluttdato DATE NOT NULL,
Oppholdstatus BOOL,
Totalpris DECIMAL NOT NULL,
CONSTRAINT SoknadPK PRIMARY KEY (Gjest,BoenhetID,Startdato),
CONSTRAINT SoknadgjestFK FOREIGN KEY (Gjest) REFERENCES Bruker(BrukerID),
CONSTRAINT SoknadboenhetFK FOREIGN KEY (BoenhetID) REFERENCES Boenhet(BoenhetID)
);

CREATE TABLE Bilde
(
BildeID INT AUTO_INCREMENT,
BoenhetID INT NOT NULL,
Bildefil TEXT NOT NULL,
Rekkefolge CHAR(2) NOT NULL,
Beskrivelse CHAR(40),
CONSTRAINT BildePK PRIMARY KEY (BildeID),
CONSTRAINT BildeboenhetFK FOREIGN KEY (BoenhetID) REFERENCES Boenhet(BoenhetID) 
);

CREATE TABLE Betaling
(
BetalingsID INT AUTO_INCREMENT,
Betalingsstatus SMALLINT NOT NULL,
BetalingsmetodeID INT,
Betalingsdato DATE,
Totalpris DECIMAL NOT NULL,
Gebyr DECIMAL NOT NULL,
Kortnummer CHAR(16),
CONSTRAINT BetalingPK PRIMARY KEY (BetalingsID),
CONSTRAINT BetalingFK FOREIGN KEY (BetalingsmetodeID) REFERENCES Betalingsmetode(BetalingsmetodeID),
CONSTRAINT BetalingKort FOREIGN KEY (Kortnummer) REFERENCES Kortinfo(Kortnummer)
);

-- Femte runde
CREATE TABLE Opphold
(
Gjest CHAR(16) NOT NULL,
BoenhetID INT,
Startdato DATE,
Sluttdato DATE NOT NULL,
Totalpris DECIMAL NOT NULL,
Betalingsstatus SMALLINT,
CONSTRAINT OppholdPK PRIMARY KEY (BoenhetID,Startdato),
CONSTRAINT OppholdGjestFK FOREIGN KEY (Gjest,BoenhetID,Startdato) REFERENCES Soknad(Gjest,BoenhetID,Startdato)
);

-- Sjette runde
CREATE TABLE Annmeldelse
(
BrukerID CHAR(16),
BoenhetID INT,
Startdato DATE,
Sluttdato DATE NOT NULL,
Rangering SMALLINT,
Kommentar TEXT,
CONSTRAINT AnnmeldelsePK PRIMARY KEY (BrukerID,BoenhetID,Startdato),
CONSTRAINT AnnmeldelsebrukerFK FOREIGN KEY (BrukerID) REFERENCES Bruker(BrukerID),
CONSTRAINT AnnmeldelseBoenhetFK FOREIGN KEY (BoenhetID,Startdato) REFERENCES Opphold(BoenhetID,Startdato)
); 
