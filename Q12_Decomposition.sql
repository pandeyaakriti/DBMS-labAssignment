USE HospitalDB;

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Doctor2 (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Appointment2 (
    appt_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor2(doctor_id)
);
