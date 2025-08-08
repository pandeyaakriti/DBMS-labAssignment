USE HospitalDB;

DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts (
    AccNo INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance INT
);
INSERT INTO Accounts VALUES
(1, 'Alice', 1000),
(2, 'Bob', 1000);


START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 100 WHERE AccNo = 1;
-- Locks row 1

START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 100 WHERE AccNo = 2;
-- Locks row 2

UPDATE Accounts SET Balance = Balance - 100 WHERE AccNo = 2;
-- Waits for Session B

UPDATE Accounts SET Balance = Balance - 100 WHERE AccNo = 1;
-- Waits for Session A

