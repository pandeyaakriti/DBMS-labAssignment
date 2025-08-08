USE HospitalDB;

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    specialization VARCHAR(50)
);

CREATE TABLE Appointment (
    appt_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    patient_id INT,
    doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Bill (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(10,2),
    patient_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
