USE HospitalDB;

-- INNER JOIN
SELECT p.name, a.date, d.name AS doctor
FROM Appointment a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id;

-- LEFT JOIN
SELECT p.name, b.amount
FROM Patients p
LEFT JOIN Bill b ON p.patient_id = b.patient_id;
