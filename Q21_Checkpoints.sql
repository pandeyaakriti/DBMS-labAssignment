USE HospitalDB;

-- Drop and recreate the table
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (
    AccNo INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance INT
);

INSERT INTO Accounts VALUES
(1, 'Aakriti', 1000),
(2, 'Pandey', 1000),
(3, 'Legend', 500);

-- Show initial state
SELECT 'Initial State' AS Status, AccNo, HolderName, Balance FROM Accounts;

-- Transaction T1 (complete transaction)
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 100 WHERE AccNo = 1;
UPDATE Accounts SET Balance = Balance - 50 WHERE AccNo = 2;
COMMIT;

-- Show state after T1
SELECT 'After T1' AS Status, AccNo, HolderName, Balance FROM Accounts;

-- Transaction T2 (incomplete - no COMMIT yet)
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 200 WHERE AccNo = 3;
-- Note: T2 is not committed yet, so changes are not permanent

-- Force a checkpoint (flush logs to disk)
FLUSH LOGS;

-- Alternative checkpoint commands for other databases:
-- For SQL Server: CHECKPOINT;
-- For PostgreSQL: CHECKPOINT;

-- Show current state (T2 changes visible in current session but not committed)
SELECT 'After T2 (uncommitted)' AS Status, AccNo, HolderName, Balance FROM Accounts;

-- To see the actual committed state, we need to rollback T2 and check
ROLLBACK;
SELECT 'After T2 Rollback' AS Status, AccNo, HolderName, Balance FROM Accounts;

-- If we want to commit T2:
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 200 WHERE AccNo = 3;
COMMIT;

-- Final state
SELECT 'Final State (T2 committed)' AS Status, AccNo, HolderName, Balance FROM Accounts;

/*
Transaction Log would contain these entries (not executable SQL):

<START T1>
<T1, UPDATE, Accounts(1), old=1000, new=1100>
<T1, UPDATE, Accounts(2), old=1000, new=950>
<COMMIT T1>

<START T2>
<T2, UPDATE, Accounts(3), old=500, new=700>

<CHECKPOINT>
-- Checkpoint forces all committed changes to be written to disk
-- T1 changes are now safely stored on disk
-- T2 is still uncommitted, so it would be rolled back on system restart

<COMMIT T2> -- (if T2 is eventually committed)
*/