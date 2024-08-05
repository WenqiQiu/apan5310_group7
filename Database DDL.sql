-- Create Address Table
CREATE TABLE Address (
    AddressID SERIAL PRIMARY KEY,
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(20),
    Country VARCHAR(100)
);

-- Create Office Table
CREATE TABLE Office (
    OfficeID SERIAL PRIMARY KEY,
    AddressID INT,
    Name VARCHAR(100),
    Phone VARCHAR(20),
    CONSTRAINT FK_Office_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create Employee Table
CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Role VARCHAR(50),
    Salary DECIMAL(15, 2),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- Create WorksAt Table
CREATE TABLE WorksAt (
    EmployeeID INT,
    OfficeID INT,
    PRIMARY KEY (EmployeeID, OfficeID),
    CONSTRAINT FK_WorksAt_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT FK_WorksAt_Office FOREIGN KEY (OfficeID) REFERENCES Office(OfficeID)
);

-- Create CostItem Table
CREATE TABLE CostItem (
    CostItemID SERIAL PRIMARY KEY,
    CostItem VARCHAR(100)
);

-- Create Cost Table
CREATE TABLE Cost (
    CostID SERIAL PRIMARY KEY,
    CostItemID INT,
    Description TEXT,
    Amount DECIMAL(15, 2),
    Date DATE,
    CONSTRAINT FK_Cost_CostItem FOREIGN KEY (CostItemID) REFERENCES CostItem(CostItemID)
);

-- Create Owner Table
CREATE TABLE Owner (
    OwnerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    AddressID INT,
    CONSTRAINT FK_Owner_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create Property Table
CREATE TABLE Property (
    PropertyID SERIAL PRIMARY KEY,
    Availability VARCHAR(10),
    ListingType VARCHAR(20),
    UnitType VARCHAR(20),
    SalePrice DECIMAL(15, 2),
    LeasePricePerYear DECIMAL(15, 2),
    BuildingYear INT,
    DateAdded DATE,
    AddressID INT,
    CONSTRAINT FK_Property_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create Owns Table
CREATE TABLE Owns (
    OwnerID INT,
    PropertyID INT,
    PRIMARY KEY (OwnerID, PropertyID),
    CONSTRAINT FK_Owns_Owner FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID),
    CONSTRAINT FK_Owns_Property FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

-- Create Client Table
CREATE TABLE Client (
    ClientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DesiredTransactionType VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    AddressID INT,
    CONSTRAINT FK_Client_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Create ClientPropertyPreferences Table
CREATE TABLE ClientPropertyPreferences (
    ClientID INT,
    PreferredPropertyType VARCHAR(50),
    Budget DECIMAL(15, 2),
    PRIMARY KEY (ClientID, PreferredPropertyType),
    CONSTRAINT FK_ClientPropertyPreferences_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

-- Create Appointment Table
CREATE TABLE Appointment (
    AppointmentID SERIAL PRIMARY KEY,
    ClientID INT,
    PropertyID INT,
    AgentID INT,
    AppointmentMadeDate DATE,
    VisitDate DATE,
    CONSTRAINT FK_Appointment_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT FK_Appointment_Property FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    CONSTRAINT FK_Appointment_Agent FOREIGN KEY (AgentID) REFERENCES Employee(EmployeeID)
);

-- Create Transaction Table
CREATE TABLE Transaction (
    TransactionID SERIAL PRIMARY KEY,
    AgentID INT,
    TransactionDate DATE,
    CONSTRAINT FK_Transaction_Agent FOREIGN KEY (AgentID) REFERENCES Employee(EmployeeID)
);

-- Create Contract Table
CREATE TABLE Contract (
    ContractID SERIAL PRIMARY KEY,
    TransactionID INT,
    ClientID INT,
    PropertyID INT,
    StartDate DATE,
    EndDate DATE,
    ContractType VARCHAR(20),
    Amount DECIMAL(15, 2),
    ContractStatus VARCHAR(20),
    RenewalOption TEXT,
    DepositAmount DECIMAL(15, 2),
    MonthlyRent DECIMAL(15, 2),
    TerminationClause TEXT,
    SignedDate DATE,
    WitnessName VARCHAR(100),
    SpecialTerms VARCHAR(255),
    CONSTRAINT FK_Contract_Transaction FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID),
    CONSTRAINT FK_Contract_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT FK_Contract_Property FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);

-- Create Feedback Table
CREATE TABLE Feedback (
    FeedbackID SERIAL PRIMARY KEY,
    ClientID INT,
    AgentID INT,
    Rating INT,
    Feedback TEXT,
    InteractionType VARCHAR(20),
    FeedbackDate DATE,
    CONSTRAINT FK_Feedback_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    CONSTRAINT FK_Feedback_Agent FOREIGN KEY (AgentID) REFERENCES Employee(EmployeeID)
);
