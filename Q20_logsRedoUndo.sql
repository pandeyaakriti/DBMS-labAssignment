USE HospitalDB;

-- Drop and recreate the table
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (
    AccNo INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance INT
);

-- Insert initial data
INSERT INTO Accounts VALUES
(11, 'Arjun', 1000),
(21, 'Basu', 1000);

-- Transaction T1 (would be incomplete due to system crash)
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 200 WHERE AccNo = 11;
-- System crash occurs before COMMIT - transaction would be rolled back
ROLLBACK; -- Simulating the rollback that would happen after crash recovery

-- Check balances after T1 rollback
SELECT * FROM Accounts;

-- Transaction T2 (completes successfully)
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 200 WHERE AccNo = 11;
COMMIT;
-- Crash occurs immediately after commit - transaction is already committed

-- Check final balances
SELECT * FROM Accounts;

-- The transaction log entries would look like this (not executable SQL):
-- <START T1>
-- <T1, UPDATE, Accounts(11), old=1000, new=800>
-- <ABORT T1> (due to system crash)
-- 
-- <START T2>
-- <T2, UPDATE, Accounts(11), old=1000, new=800>
-- <COMMIT T2>