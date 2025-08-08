USE HospitalDB;

-- Drop the table if it already exists
DROP TABLE IF EXISTS Accounts;

-- Create fresh table
CREATE TABLE Accounts (
    AccNo INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance INT
);

-- Insert initial data
INSERT INTO Accounts VALUES
(1, 'Alvu', 1000);

-- ===== Without concurrency control =====
START TRANSACTION;
SELECT Balance FROM Accounts WHERE AccNo = 1;
-- Reads Balance = 1000

UPDATE Accounts SET Balance = Balance - 300 WHERE AccNo = 1;
-- Tentative balance = 700
-- Do not commit yet (simulate waiting)

-- In another session (simulation):
START TRANSACTION;
SELECT Balance FROM Accounts WHERE AccNo = 1;
-- Reads Balance = 1000 (old value, no lock)
UPDATE Accounts SET Balance = Balance - 200 WHERE AccNo = 1;
COMMIT;

-- Commit first transaction
COMMIT;


-- With concurrency control (locking) 
START TRANSACTION;
SELECT Balance FROM Accounts WHERE AccNo = 1 FOR UPDATE;
UPDATE Accounts SET Balance = Balance - 300 WHERE AccNo = 1;
-- Holds lock until commit

-- In another session (simulation):
START TRANSACTION;
SELECT Balance FROM Accounts WHERE AccNo = 1 FOR UPDATE;
-- This will wait until first transaction commits

COMMIT;

-- Now reads updated balance
UPDATE Accounts SET Balance = Balance - 200 WHERE AccNo = 1;
COMMIT;


