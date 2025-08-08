USE HospitalDB;

START TRANSACTION;
INSERT INTO Patients (name, age, gender) VALUES ('Aaku Rollback', 25, 'F');
ROLLBACK;

START TRANSACTION;
INSERT INTO Patients (name, age, gender) VALUES ('Pandey Commit', 32, 'M');
COMMIT;
