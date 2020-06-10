set schema PETAR_NIKO_PROTECTED;

CREATE TABLE Staff
(
    sID    int         NOT NULL,
    Salary int         NOT NULL,
    Name   VARCHAR(32) NOT NULL,
    DOB    int         NOT NULL,
    Gender CHAR(1)     NOT NULL,
    bBIC   int         NOT NULL,
    PRIMARY KEY (sID)
);

CREATE TABLE Branches
(
    bBIC    int         NOT NULL,
    City    VARCHAR(64) NOT NULL,
    Country VARCHAR(32) NOT NULL,
    Address VARCHAR(64) NOT NULL,
    Phone   VARCHAR(15) NOT NULL,
    PRIMARY KEY (bBIC)
);

CREATE TABLE Customers
(
    cID  int         NOT NULL,
    Name VARCHAR(32) NOT NULL,
    sID  int         NOT NULL,
    bBIC int         NOT NULL,
    PRIMARY KEY (cID)
);

CREATE TABLE Cars
(
    cVIN      CHAR(17)    NOT NULL,
    Make      VARCHAR(30) NOT NULL,
    Model     VARCHAR(30) NOT NULL,
    RegNumber VARCHAR(10) NOT NULL,
    YearManuf int         NOT NULL,
    BHP       int         NOT NULL,
    Color     int         NOT NULL,
    bBIC      int         NOT NULL,
    PRIMARY KEY (cVIN, RegNumber),
    CHECK (YearManuf <= 1589414400)
);

CREATE TABLE CatA
(
    cVIN        CHAR(17)    NOT NULL,
    Compression int         NOT NULL,
    bBIC        int         NOT NULL,
    RegNumber   VARCHAR(10) NOT NULL
);

CREATE TABLE CatB
(
    cVIN      CHAR(17)    NOT NULL,
    SeatCount int         NOT NULL,
    bBIC      int         NOT NULL,
    RegNumber VARCHAR(10) NOT NULL
);

CREATE TABLE CatC
(
    cVIN      CHAR(17)    NOT NULL,
    CargoHold int         NOT NULL,
    bBIC      int         NOT NULL,
    RegNumber VARCHAR(10) NOT NULL
);

CREATE TABLE Rents
(
    cID       int         NOT NULL,
    cVIN      CHAR(17)    NOT NULL,
    RegNumber VARCHAR(10) NOT NULL,
    Duration  int         NOT NULL,
    Deposit   int         NOT NULL,
    StartDate int         NOT NULL,
    EndDate   int         NOT NULL,
    Rate      int         NOT NULL,
    CHECK (StartDate < EndDate),
    CHECK (Duration = EndDate - StartDate),
    CHECK (Deposit > Rate)
);

ALTER TABLE Staff
    ADD CONSTRAINT Staff_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE Customers
    ADD CONSTRAINT Customers_sID FOREIGN KEY (sID) REFERENCES Staff (sID);
ALTER TABLE Customers
    ADD CONSTRAINT Customers_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE Cars
    ADD CONSTRAINT Cars_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE CatA
    ADD CONSTRAINT CatA_cVIN FOREIGN KEY (cVIN, RegNumber) REFERENCES Cars (cVIN, RegNumber);
ALTER TABLE CatA
    ADD CONSTRAINT CatA_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE CatB
    ADD CONSTRAINT CatB_cVIN FOREIGN KEY (cVIN, RegNumber) REFERENCES Cars (cVIN, RegNumber);
ALTER TABLE CatB
    ADD CONSTRAINT CatB_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE CatC
    ADD CONSTRAINT CatC_cVIN FOREIGN KEY (cVIN, RegNumber) REFERENCES Cars (cVIN, RegNumber);
ALTER TABLE CatC
    ADD CONSTRAINT CatC_bBIC FOREIGN KEY (bBIC) REFERENCES Branches (bBIC);
ALTER TABLE Rents
    ADD CONSTRAINT Rents_cID FOREIGN KEY (cID) REFERENCES Customers (cID);
ALTER TABLE Rents
    ADD CONSTRAINT Rents_cVIN FOREIGN KEY (cVIN, RegNumber) REFERENCES Cars (cVIN, RegNumber);
