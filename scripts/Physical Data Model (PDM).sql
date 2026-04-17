


-- Dim_Person (SCD2)
CREATE MULTISET TABLE Dim_Person (
    Person_SK INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Person_ID VARCHAR(50) NOT NULL,
    Person_Name VARCHAR(150),
    Record_Start_Date DATE FORMAT 'YYYY-MM-DD' DEFAULT CURRENT_DATE,
    Record_End_Date DATE FORMAT 'YYYY-MM-DD' DEFAULT '9999-12-31',
    Is_Current BYTEINT DEFAULT 1
) UNIQUE PRIMARY INDEX (Person_SK);

-- Dim_Account (SCD2)
CREATE MULTISET TABLE Dim_Account (
    Account_SK INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Account_No VARCHAR(50) NOT NULL,
    Account_Type VARCHAR(50),
    Account_Status VARCHAR(50),
    Record_Start_Date DATE FORMAT 'YYYY-MM-DD' DEFAULT CURRENT_DATE,
    Record_End_Date DATE FORMAT 'YYYY-MM-DD' DEFAULT '9999-12-31',
    Is_Current BYTEINT DEFAULT 1
) UNIQUE PRIMARY INDEX (Account_SK);

-- Dim_Identification
CREATE MULTISET TABLE Dim_Identification (
    Iden_SK INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    Person_SK INTEGER NOT NULL,
    ID_Type VARCHAR(25),
    ID_Value VARCHAR(100),
    Issue_Date DATE FORMAT 'YYYY-MM-DD' 
) UNIQUE PRIMARY INDEX (Iden_SK);

-- Fact_Account_Ownership (Factless Fact --> is caled Factless Fact because it does not have any measures)
CREATE MULTISET TABLE Fact_Account_Ownership (
    Account_SK INTEGER NOT NULL,
    Person_SK INTEGER NOT NULL,
    Ownership_Date DATE FORMAT 'YYYY-MM-DD'
) PRIMARY INDEX (Account_SK, Person_SK); 
