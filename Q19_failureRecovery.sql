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

-- Deduct 500 from Alice
UPDATE Accounts SET Balance = Balance - 500 WHERE AccNo = 1;

-- Simulate system failure
-- For example: Database service crash or intentional rollback
-- (No COMMIT executed)

SELECT * FROM Accounts;


START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 500 WHERE AccNo = 1;
UPDATE Accounts SET Balance = Balance + 500 WHERE AccNo = 2;

COMMIT;