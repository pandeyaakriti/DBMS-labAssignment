USE HospitalDB;

START TRANSACTION;
INSERT INTO Patients (name, age, gender) VALUES ('Test Patient', 50, 'M');
ROLLBACK;

START TRANSACTION;
INSERT INTO Patients (name, age, gender) VALUES ('Mary Jane', 29, 'F');
COMMIT;
