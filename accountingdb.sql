PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE Accounts   (id          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         Iban        TEXT    NOT NULL,
                         BankId      INTEGER NOT NULL,
                         CurrencyId  INTEGER NOT NULL,
                         FOREIGN KEY (BankId)     REFERENCES Banks (id),
                         FOREIGN KEY (CurrencyId) REFERENCES Currencies (id),
                         UNIQUE(id));
INSERT INTO Accounts VALUES(1,'FR76928836647839290734',2,1);
CREATE TABLE Currencies (id          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         LongName    TEXT,
                         Symbol      TEXT NOT NULL,
                         Code        TEXT NOT NULL,
                         UNIQUE(id),
                         UNIQUE(Symbol));
INSERT INTO Currencies VALUES(1,'Euro','€','EUR');
INSERT INTO Currencies VALUES(2,'Dollar','$','USD');
INSERT INTO Currencies VALUES(3,'Pound','£','GBP');
INSERT INTO Currencies VALUES(4,'Franc Suisse','CHF','CHF');
INSERT INTO Currencies VALUES(5,'Bath thaïlandais','฿','THB');
CREATE TABLE Banks      (id          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         LongName    TEXT,
                         Code        TEXT NOT NULL,
                         Bic         TEXT NOT NULL,
                         UNIQUE(id),
                         UNIQUE(Bic));
INSERT INTO Banks VALUES(1,'Crédit du Nord','CdN','NORDFRPP');
INSERT INTO Banks VALUES(2,'Crédit Agricole','CA','AGRIFRPP');
INSERT INTO Banks VALUES(3,'Crédit Lyonnais','CL','CRLYFRPP');
INSERT INTO Banks VALUES(4,'HSBC','HSBC','CCFRFRPP');
INSERT INTO Banks VALUES(5,'Société Générale','SG','SOGEFRPP');
INSERT INTO Banks VALUES(6,'Crédit mutuel','CMU','CRMUFRPP');
CREATE TABLE Statements (id                      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         ElectronicSeqNr         TEXT,
                         CreationDateTime        TEXT DEFAULT 0 NOT NULL,
                         AccountId               INTEGER NOT NULL,
                         BalanceId               INTEGER NOT NULL,
                         FOREIGN KEY (AccountId) REFERENCES Accounts (id),
                         FOREIGN KEY (BalanceId) REFERENCES Balances (id),
                         UNIQUE(id));
INSERT INTO Statements VALUES(1,'226','2022-09-08 21:30:43',3,1);
CREATE TABLE Balances   (id                          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         TypeCodeId                  INTEGER NOT NULL,
                         ProprietaryType             TEXT,
                         SubTypeCodeId               INTEGER NOT NULL,
                         Ammount                     REAL NOT NULL,
                         CreditDebit                 TEXT NOT NULL,
                         DateTime                    TEXT DEFAULT 0 NOT NULL,
                         NumberOfEntries             INTEGER NOT NULL,
                         SumOfEntries                REAL NOT NULL,
                         FOREIGN KEY (TypeCodeId)    REFERENCES BalanceTypeCodes (id),
                         FOREIGN KEY (SubTypeCodeId) REFERENCES BalanceTypeCodes (id),
                         UNIQUE(id));
INSERT INTO Balances VALUES(1,2,'HGDF',3,25432.759999999998399,'credit','0',0,0.0);
CREATE TABLE BalanceTypeCodes   (id                          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                                 Code                        TEXT NOT NULL,
                                 Description                 TEXT,
                                 UNIQUE(id));
INSERT INTO BalanceTypeCodes VALUES(1,'OPBD','Opening Booked');
INSERT INTO BalanceTypeCodes VALUES(2,'CLBD','Closing Booked');
INSERT INTO BalanceTypeCodes VALUES(3,'INFO','Information');
INSERT INTO BalanceTypeCodes VALUES(4,'CLAV','Closing Available');
INSERT INTO BalanceTypeCodes VALUES(5,'FWAV','Forward Available');
INSERT INTO BalanceTypeCodes VALUES(6,'ITAV','Interim Available');
INSERT INTO BalanceTypeCodes VALUES(7,'ITBD','Interim Booked');
INSERT INTO BalanceTypeCodes VALUES(8,'Proprietary','...');
INSERT INTO BalanceTypeCodes VALUES(9,'INTM','Intermediate');
CREATE TABLE Entries    (id                          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         EntryRef                    TEXT,
                         Ammount                     REAL DEFAULT 0 NOT NULL,
 		         CreditDebit                 TEXT DEFAULT 'credit' NOT NULL,
 		         CurrencyId                  INTEGER NOT NULL,
 		         ReversalIndicator           BOOLEAN DEFAULT 0 NOT NULL,
                         StatusCodeId                INTEGER NOT NULL,
                         BookingDateTime             TEXT DEFAULT 0 NOT NULL,
                         ValueDateTime               TEXT DEFAULT 0 NOT NULL,
                         FOREIGN KEY (CurrencyId)    REFERENCES Currencies (id),
                         FOREIGN KEY (StatusCodeId)  REFERENCES StatusCodes (id),
                         UNIQUE(id));
CREATE TABLE StatusCodes(id                          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                         Code                        TEXT NOT NULL,
                         Description                 TEXT,
                         UNIQUE(id));
INSERT INTO StatusCodes VALUES(1,'BOOK','Opening Booked');
INSERT INTO StatusCodes VALUES(2,'PDNG','Closing Booked');
INSERT INTO StatusCodes VALUES(3,'INFO','Information');
CREATE UNIQUE INDEX "AccountsIdx" ON "Accounts" (
  "id",
  "Iban"
);
CREATE UNIQUE INDEX "StatementsAccountsIdx" ON "Statements" (
  "id",
  "AccountId"
);
CREATE UNIQUE INDEX "StatementsBalanceIdx" ON "Statements" (
  "id",
  "BalanceId"
);
CREATE UNIQUE INDEX "EntriesCreditDebitIdx" ON "Entries" (
  "id",
  "CreditDebit"
);
CREATE UNIQUE INDEX "EntriesBookingDateTimeIdx" ON "Entries" (
  "id",
  "BookingDateTime"
);
CREATE UNIQUE INDEX "EntriesValueDateTimeIdx" ON "Entries" (
  "id",
  "ValueDateTime"
);
COMMIT;
