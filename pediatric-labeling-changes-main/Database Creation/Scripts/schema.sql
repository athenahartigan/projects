-- Athena Hartigan
-- Due Date: 11/9/2024
-- This is schema for a database for the FDA pediatric drug labels
-- Co-Author: Bard

--I thought about making a connecting table for the legistlation type since BPCA + PREA is technically 2 different types of legislation but they also use BPCA Only and PREA Only. I could remove the only but am thinking they probably did it this way to be more clear and explicit (more emphasis that it is only 1)
CREATE TABLE Application (
    FDAAppId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (FDAAppId >= 0),
    FDAAppNum TEXT,
    Notes TEXT,
    LabelLink TEXT,
    IndicationStudied TEXT,
    TheraCategory TEXT,
    LabelDate DATE,
    LabelSummary TEXT
);

--the numbers do not add up correctly to derive Patients analyzed or enrolled same with num countries and country names
--I thought about doing FDAAppNum as a foreign key but there are sometime more than 1 fda app number per row

-- I thought about making PatientsAnalyzed <= PatientsEnrolled as a possible constraint but this fails in the dataset (maybe extra people volunteered (that hadn't intitially enrolled but ended up getting analyzed) so this may or may not be a valid constraint
CREATE TABLE Cohort (
    FDAAppId INT,
    StudyId NUMERIC(10, 2) CHECK (StudyId >= 0),    
    PatientsEnrolled INT CHECK (PatientsEnrolled >= 0),
    PatientsAnalyzed INT CHECK (PatientsAnalyzed >= 0),
    NumCenters INT CHECK (NumCenters >= 0),
    NumCountries INT CHECK (NumCountries >= 0), 
    ApprovalDate DATE,
    AgesId INT,
    PRIMARY KEY (FDAAppId, StudyId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (AgesId) REFERENCES Ages(AgesId)
);

CREATE TABLE LegislationType (
    LegislationTypeId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (LegislationTypeId >= 0),
    LegislationType TEXT
);

CREATE TABLE Legislation_App (
    LegislationTypeId INT,
    FDAAppId INT,
    PRIMARY KEY (LegislationTypeId, FDAAppId),
    FOREIGN KEY (LegislationTypeId) REFERENCES legislationType(LegislationTypeId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

--standard varies by company
CREATE TABLE Race_Name (
    RaceId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (RaceId >= 0),
    RaceName TEXT
);

CREATE TABLE Race (
    FDAAppId INT,
    StudyId NUMERIC(10, 2),
    RaceId INT,
    RaceCount INT CHECK (RaceCount >= 0),
    PRIMARY KEY (FDAAppId, StudyId, RaceId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (StudyId) REFERENCES Cohort(StudyId),
    FOREIGN KEY (RaceId) REFERENCES Race_Name(RaceId)
);

--Standard varies by company
CREATE TABLE Ethnicity_Name (
    EthnicityId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (EthnicityId >= 0),
    EthnicityName TEXT
);

CREATE TABLE Ethnicity (
    FDAAppId INT,
    StudyId NUMERIC(10, 2),    
    EthnicityId INT,
    EthnicityCount INT CHECK (EthnicityCount >= 0),
    PRIMARY KEY (FDAAppId, StudyId, EthnicityId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (StudyId) REFERENCES Cohort(StudyId),
    FOREIGN KEY (EthnicityId) REFERENCES Ethnicity_Name(EthnicityId) 
);

CREATE TABLE Ages (
    AgeId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (AgeId >= 0),
    AgeStudied TEXT
);

CREATE TABLE StudyType (
    StudyTypeId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (StudyTypeId >= 0),
    StudyType TEXT
);

CREATE TABLE StudyDesign (
    StudyDesignId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (StudyDesignId >= 0),
    StudyDesign TEXT
);

CREATE TABLE Cohort_Study_Type (
    FDAAppId INT,
    StudyId NUMERIC(10, 2),
    StudyTypeId INT,
    PRIMARY KEY(FDAAppId, StudyId, StudyTypeId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (StudyId) REFERENCES Cohort(StudyId),
    FOREIGN KEY (StudyTypeId) REFERENCES Study_Type(StudyTypeId)
);

CREATE TABLE Cohort_Study_Design (
    FDAAppId INT,
    StudyId NUMERIC(10, 2),
    StudyDesignId INT,
    PRIMARY KEY(FDAAppId, StudyId, StudyDesignId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (StudyId) REFERENCES Cohort(StudyId),
    FOREIGN KEY (StudyDesignId) REFERENCES Study_Design(StudyDesignId)
);

CREATE TABLE GenericName (
    GenericNameId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (GenericNameId >= 0),
    GenericName Text
);

CREATE TABLE TradeName (
    TradeNameId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (TradeNameId >= 0),
    TradeName Text
);

CREATE TABLE Generic_Trade (
    TradeNameId INT,
    GenericNameId INT,
    PRIMARY KEY (TradeNameId, GenericNameID),
    FOREIGN KEY (TradeNameId) REFERENCES TradeName(TradeNameId),
    FOREIGN KEY (GenericNameID) REFERENCES GenericName(GenericNameID)
);

CREATE TABLE SMILES (
    SmilesId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (SmilesId >= 0),
    SmilesName VARCHAR(255)
);

CREATE TABLE GenericName_Smiles (
    GenericNameId INT,
    SmilesId INT,
    PRIMARY KEY (GenericNameId, SmilesId),
    FOREIGN KEY (GenericNameId) REFERENCES GenericName(GenericNameId),
    FOREIGN KEY (SmilesId) REFERENCES SMILES(SmilesId)
);

CREATE TABLE Drug_App (
    GenericNameId INT,
    FDAAppId INT,
    PRIMARY KEY(GenericNameId, FDAAppId),
    FOREIGN KEY (GenericNameId) REFERENCES GenericName(GenericNameId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE Dose (
    DoseId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (DoseId >= 0),
    DoseForm TEXT
);

CREATE TABLE Dose_App (
    DoseId INT,
    FDAAppId INT,
    PRIMARY KEY(DoseId, FDAAppId),
    FOREIGN KEY (DoseId) REFERENCES Dose(DoseId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE Route (
    RouteId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (RouteId >= 0),
    RouteAdmin TEXT
);

CREATE TABLE Route_App (
    RouteId INT,
    FDAAppId INT,
    PRIMARY KEY(RouteId, FDAAppId),
    FOREIGN KEY (RouteId) REFERENCES Route(RouteId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE Country (
    CountryId VARCHAR(2) PRIMARY KEY,
    CountryName TEXT
);

CREATE TABLE Country_App (
    CountryId VARCHAR(2),
    FDAAppId INT,
    PRIMARY KEY(CountryId, FDAAppId),
    FOREIGN KEY (CountryId) REFERENCES Country(CountryId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE Neonates (
    NeonateId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (NeonateId >= 0),
    StudiedNeonates BOOLEAN,
    IndicatedNeonates BOOLEAN
);

CREATE TABLE Neonate_App (
    NeonateId INT,
    FDAAppId INT,
    PRIMARY KEY(NeonateId, FDAAppId),
    FOREIGN KEY (NeonateId) REFERENCES Neonates(NeonateId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE Indication (
    IndicationId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (IndicationId >= 0),
    Indication TEXT
);

CREATE TABLE Indication_App (
    IndicationId INT,
    FDAAppId INT,
    PRIMARY KEY(IndicationId, FDAAppId),
    FOREIGN KEY (IndicationId) REFERENCES Indication(IndicationId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId)
);

CREATE TABLE PharmaClass (
    PharmaClassId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (PharmaClassId >= 0),
    PharmaClass TEXT
);

CREATE TABLE Pharma_App (
    FDAAppId INT,
    PharmaClassId INT,
    PRIMARY KEY (FDAAppId, PharmaClassId),
    FOREIGN KEY (FDAAppId) REFERENCES Application(FDAAppId),
    FOREIGN KEY (PharmaClassId) REFERENCES PharmaClass(PharmaClassId)
);

CREATE TABLE MolecularDescriptors (
    DescriptorId INTEGER PRIMARY KEY AUTOINCREMENT CHECK (DescriptorId >= 0),
    SmilesId INT,
    DescriptorName TEXT,
    DescriptorValue REAL,
    FOREIGN KEY (SmilesId) REFERENCES SMILES(SmilesId)
);











CREATE INDEX "ApplicationIndex" ON "Application"("FDAAppId", "FDAAppNum");
CREATE INDEX "CohortIndex" ON "Cohort"("FDAAppId", "StudyId");
CREATE INDEX "LegislationIndex" ON "Legislation_App"("LegislationTypeId", "FDAAppId");
CREATE INDEX "RaceIndex" ON "Race"("FDAAppId", "StudyId", "RaceId");
CREATE INDEX "EthnicityIndex" ON "Ethnicity"("FDAAppId", "StudyId", "EthnicityId");

CREATE VIEW SafeDrugs AS
SELECT "FDAAppId"
FROM "Cohort_Study_Type"
WHERE "StudyTypeId" IN (SELECT "StudyTypeId" FROM "StudyType" WHERE "StudyType" = 'Safety');

CREATE VIEW EffectiveDrugs AS
SELECT "FDAAppId"
FROM "Cohort_Study_Type"
WHERE "StudyTypeId" IN (SELECT "StudyTypeId" FROM "StudyType" WHERE "StudyType" = 'Efficacy');

CREATE VIEW StudyData AS
SELECT "Application"."FDAAppNum", "Cohort"."ApprovalDate", "TradeName"."TradeName", "GenericName"."GenericName", 
       "LegislationType"."LegislationType", "Indication"."Indication", "Application"."IndicationStudied", 
       "Application"."LabelSummary", "Application"."TheraCategory", "Dose"."DoseForm", "Route"."RouteAdmin", 
       "PharmaClass"."PharmaClass", "Neonates"."StudiedNeonates", "Neonates"."IndicatedNeonates", 
       "Application"."LabelLink", "Cohort"."StudyId", "Ages"."AgeStudied", "StudyType"."StudyType", 
       "StudyDesign"."StudyDesign", "Cohort"."PatientsEnrolled", "Cohort"."PatientsAnalyzed", "Cohort"."NumCenters", 
       "Cohort"."NumCountries", "Ethnicity"."EthnicityCount" AS "HispanicLatino", "Ethnicity"."EthnicityCount" AS "NonHispanicLatino", 
       "Ethnicity"."EthnicityCount" AS "UnknownEthnicity", "Race"."RaceCount" AS "Asian", "Race"."RaceCount" AS "Black", 
       "Race"."RaceCount" AS "White", "Race"."RaceCount" AS "NativeHawaiianPacificIslander", "Race"."RaceCount" AS "AmericanIndianAlaskaNative", 
       "Race"."RaceCount" AS "OtherRace", "Race"."RaceCount" AS "UnknownRace", "Country"."CountryName", "Application"."Notes"
FROM "Application"
JOIN "Cohort" ON "Application"."FDAAppId" = "Cohort"."FDAAppId"
JOIN "Legislation_App" ON "Application"."FDAAppId" = "Legislation_App"."FDAAppId"
JOIN "LegislationType" ON "Legislation_App"."LegislationTypeId" = "LegislationType"."LegislationTypeId"
JOIN "Indication_App" ON "Application"."FDAAppId" = "Indication_App"."FDAAppId"
JOIN "Indication" ON "Indication_App"."IndicationId" = "Indication"."IndicationId"
JOIN "Dose_App" ON "Application"."FDAAppId" = "Dose_App"."FDAAppId"
JOIN "Dose" ON "Dose_App"."DoseId" = "Dose"."DoseId"
JOIN "Route_App" ON "Application"."FDAAppId" = "Route_App"."FDAAppId"
JOIN "Route" ON "Route_App"."RouteId" = "Route"."RouteId"
JOIN "Pharma_App" ON "Application"."FDAAppId" = "Pharma_App"."FDAAppId"
JOIN "PharmaClass" ON "Pharma_App"."PharmaClassId" = "PharmaClass"."PharmaClassId"
JOIN "Neonate_App" ON "Application"."FDAAppId" = "Neonate_App"."FDAAppId"
JOIN "Neonates" ON "Neonate_App"."NeonateId" = "Neonates"."NeonateId"
JOIN "Cohort_Study_Type" ON "Application"."FDAAppId" = "Cohort_Study_Type"."FDAAppId"
JOIN "StudyType" ON "Cohort_Study_Type"."StudyTypeId" = "StudyType"."StudyTypeId"
JOIN "Cohort_Study_Design" ON "Application"."FDAAppId" = "Cohort_Study_Design"."FDAAppId"
JOIN "StudyDesign" ON "Cohort_Study_Design"."StudyDesignId" = "StudyDesign"."StudyDesignId"
JOIN "Generic_Trade" ON "Application"."FDAAppId" = "Generic_Trade"."GenericNameID"
JOIN "GenericName" ON "Generic_Trade"."GenericNameID" = "GenericName"."GenericNameID"
JOIN "TradeName" ON "Generic_Trade"."TradeNameID" = "TradeName"."TradeNameID"
JOIN "GenericName_Smiles" ON "GenericName"."GenericNameID" = "GenericName_Smiles"."GenericNameId"
JOIN "SMILES" ON "GenericName_Smiles"."SmilesId" = "SMILES"."SmilesId"
JOIN "Race" ON "Application"."FDAAppId" = "Race"."FDAAppId"
JOIN "Race_Name" ON "Race"."RaceId" = "Race_Name"."RaceId"
JOIN "Ethnicity" ON "Application"."FDAAppId" = "Ethnicity"."FDAAppId"
JOIN "Ethnicity_Name" ON "Ethnicity"."EthnicityId" = "Ethnicity_Name"."EthnicityId"
JOIN "Country_App" ON "Application"."FDAAppId" = "Country_App"."FDAAppId"
JOIN "Country" ON "Country_App"."CountryId" = "Country"."CountryId";

CREATE VIEW LabelingChanges AS
SELECT "Application"."FDAAppNum", "Application"."LabelDate", "TradeName"."TradeName", "GenericName"."GenericName", 
       "LegislationType"."LegislationType", "Indication"."Indication", "Application"."IndicationStudied", 
       "Application"."LabelSummary", "Application"."TheraCategory", "Dose"."DoseForm", "Route"."RouteAdmin", 
       "Neonates"."StudiedNeonates", "Neonates"."IndicatedNeonates"
FROM "Application"
JOIN "Cohort" ON "Application"."FDAAppId" = "Cohort"."FDAAppId"
JOIN "Legislation_App" ON "Application"."FDAAppId" = "Legislation_App"."FDAAppId"
JOIN "LegislationType" ON "Legislation_App"."LegislationTypeId" = "LegislationType"."LegislationTypeId"
JOIN "Indication_App" ON "Application"."FDAAppId" = "Indication_App"."FDAAppId"
JOIN "Indication" ON "Indication_App"."IndicationId" = "Indication"."IndicationId"
JOIN "Dose_App" ON "Application"."FDAAppId" = "Dose_App"."FDAAppId"
JOIN "Dose" ON "Dose_App"."DoseId" = "Dose"."DoseId"
JOIN "Route_App" ON "Application"."FDAAppId" = "Route_App"."FDAAppId"
JOIN "Route" ON "Route_App"."RouteId" = "Route"."RouteId"
JOIN "Pharma_App" ON "Application"."FDAAppId" = "Pharma_App"."FDAAppId"
JOIN "PharmaClass" ON "Pharma_App"."PharmaClassId" = "PharmaClass"."PharmaClassId"
JOIN "Neonate_App" ON "Application"."FDAAppId" = "Neonate_App"."FDAAppId"
JOIN "Neonates" ON "Neonate_App"."NeonateId" = "Neonates"."NeonateId"
JOIN "Cohort_Study_Type" ON "Application"."FDAAppId" = "Cohort_Study_Type"."FDAAppId"
JOIN "StudyType" ON "Cohort_Study_Type"."StudyTypeId" = "StudyType"."StudyTypeId"
JOIN "Cohort_Study_Design" ON "Application"."FDAAppId" = "Cohort_Study_Design"."FDAAppId"
JOIN "StudyDesign" ON "Cohort_Study_Design"."StudyDesignId" = "StudyDesign"."StudyDesignId"
JOIN "Generic_Trade" ON "Application"."FDAAppId" = "Generic_Trade"."GenericNameID"
JOIN "GenericName" ON "Generic_Trade"."GenericNameID" = "GenericName"."GenericNameID"
JOIN "TradeName" ON "Generic_Trade"."TradeNameID" = "TradeName"."TradeNameID"
JOIN "GenericName_Smiles" ON "GenericName"."GenericNameID" = "GenericName_Smiles"."GenericNameId"
JOIN "SMILES" ON "GenericName_Smiles"."SmilesId" = "SMILES"."SmilesId"
JOIN "Race" ON "Application"."FDAAppId" = "Race"."FDAAppId"
JOIN "Race_Name" ON "Race"."RaceId" = "Race_Name"."RaceId"
JOIN "Ethnicity" ON "Application"."FDAAppId" = "Ethnicity"."FDAAppId"
JOIN "Ethnicity_Name" ON "Ethnicity"."EthnicityId" = "Ethnicity_Name"."EthnicityId"
JOIN "Country_App" ON "Application"."FDAAppId" = "Country_App"."FDAAppId"
JOIN "Country" ON "Country_App"."CountryId" = "Country"."CountryId";

--Race view

CREATE VIEW RaceDemographics AS
SELECT 
    RaceAsian.FDAAppId,
    RaceAsian.StudyId,
    RaceAsian.RaceCount AS Asian, 
    RaceBlack.RaceCount AS Black, 
    RaceWhite.RaceCount AS White, 
    RaceNativeHawaiianPacificIslander.RaceCount AS NativeHawaiianPacificIslander, 
    RaceAmericanIndianAlaskaNative.RaceCount AS AmericanIndianAlaskaNative, 
    RaceOtherRace.RaceCount AS OtherRace, 
    RaceUnknown.RaceCount AS UnknownRace
FROM 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'Asian')
    ) AS RaceAsian
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'Black')
    ) AS RaceBlack
    ON RaceAsian.FDAAppId = RaceBlack.FDAAppId AND RaceAsian.StudyId = RaceBlack.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'White')
    ) AS RaceWhite
    ON RaceAsian.FDAAppId = RaceWhite.FDAAppId AND RaceAsian.StudyId = RaceWhite.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'Native Hawaiian/Pacific Islander')
    ) AS RaceNativeHawaiianPacificIslander
    ON RaceAsian.FDAAppId = RaceNativeHawaiianPacificIslander.FDAAppId AND RaceAsian.StudyId = RaceNativeHawaiianPacificIslander.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'American Indian/Alaska Native')
    ) AS RaceAmericanIndianAlaskaNative
    ON RaceAsian.FDAAppId = RaceAmericanIndianAlaskaNative.FDAAppId AND RaceAsian.StudyId = RaceAmericanIndianAlaskaNative.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'Other Race')
    ) AS RaceOtherRace
    ON RaceAsian.FDAAppId = RaceOtherRace.FDAAppId AND RaceAsian.StudyId = RaceOtherRace.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, RaceCount
    FROM Race 
    WHERE RaceId = (
        SELECT RaceId 
        FROM Race_Name 
        WHERE RaceName = 'Unknown Race')
    ) AS RaceUnknown
    ON RaceAsian.FDAAppId = RaceUnknown.FDAAppId AND RaceAsian.StudyId = RaceUnknown.StudyId;

-- Ethnicity view
CREATE VIEW EthnicityDemographics AS
SELECT 
    EthnicityHispanicLatino.FDAAppId,
    EthnicityHispanicLatino.StudyId,
    EthnicityHispanicLatino.EthnicityCount AS HispanicLatino, 
    EthnicityNonHispanicLatino.EthnicityCount AS NonHispanicLatino, 
    EthnicityUnknownEthnicity.EthnicityCount AS UnknownEthnicity
FROM 
    (SELECT FDAAppId, StudyId, EthnicityCount
    FROM Ethnicity 
    WHERE EthnicityId = (
        SELECT EthnicityId 
        FROM Ethnicity_Name 
        WHERE EthnicityName = 'Hispanic/Latino')
    ) AS EthnicityHispanicLatino
LEFT JOIN 
    (SELECT FDAAppId, StudyId, EthnicityCount
    FROM Ethnicity 
    WHERE EthnicityId = (
        SELECT EthnicityId 
        FROM Ethnicity_Name 
        WHERE EthnicityName = 'Non Hispanic/Non Latino')
    ) AS EthnicityNonHispanicLatino
    ON EthnicityHispanicLatino.FDAAppId = EthnicityNonHispanicLatino.FDAAppId AND EthnicityHispanicLatino.StudyId = EthnicityNonHispanicLatino.StudyId
LEFT JOIN 
    (SELECT FDAAppId, StudyId, EthnicityCount
    FROM Ethnicity 
    WHERE EthnicityId = (
        SELECT EthnicityId 
        FROM Ethnicity_Name 
        WHERE EthnicityName = 'Unknown Ethnicity')
    ) AS EthnicityUnknownEthnicity
    ON EthnicityHispanicLatino.FDAAppId = EthnicityUnknownEthnicity.FDAAppId AND EthnicityHispanicLatino.StudyId = EthnicityUnknownEthnicity.StudyId;

--View for getting te drug SMILES
CREATE VIEW "DrugSMILES" AS 
SELECT "GenericName", "SmilesName"
FROM "GenericName" JOIN "GenericName_Smiles" ON "GenericName"."GenericNameId" = "GenericName_Smiles"."GenericNameId" 
JOIN "SMILES" ON "GenericName_Smiles"."SmilesId" = "SMILES"."SmilesId";

--View for getting the drug descriptors
CREATE VIEW DrugDescriptors AS
SELECT 
    GenericName.GenericName,
    SMILES.SmilesName,
    MolecularDescriptors.DescriptorName,
    MolecularDescriptors.DescriptorValue
FROM 
    GenericName
JOIN 
    GenericName_Smiles ON GenericName.GenericNameId = GenericName_Smiles.GenericNameId
JOIN 
    SMILES ON GenericName_Smiles.SmilesId = SMILES.SmilesId
JOIN 
    MolecularDescriptors ON SMILES.SmilesId = MolecularDescriptors.SmilesId;