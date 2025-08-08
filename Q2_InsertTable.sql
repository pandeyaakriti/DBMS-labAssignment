USE HospitalDB;

DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    gender CHAR(1)
);

INSERT INTO Patients (name, age, gender)
VALUES ('Aakriti', 19, 'F'),
       ('Pandey', 30, 'F');
