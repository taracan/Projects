/*
 Project BUAN 6320
*/
set search_path to hospital_management;
/* 14 SQL Queries */
--Query 1: Select all columns and all rows from one table (5 points)
SELECT * 
FROM Patients;

----Query 2: Select five columns and all rows from one table (5 points)
SELECT Name, DateOfBirth, Gender, ContactInfo, Address 
FROM Patients;



--Query 3: Select all columns from all rows from one view (5 points)

-----creating a view--------
CREATE OR REPLACE VIEW PatientAppointmentsView AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    p.DateOfBirth,
    a.AppointmentID,
    a.Date AS AppointmentDate,
    a.AppointmentReason,
    a.Status
FROM 
    Patients p
JOIN 
    Appointment a ON p.PatientID = a.PatientID;

------------displaying it-------
SELECT * 
FROM PatientAppointmentsView;


--Query 4: Using a join on 2 tables, select all columns and all rows from the tables without the use of a Cartesian product (5 points)
SELECT * 
FROM Appointment a
JOIN Patients p ON a.PatientID = p.PatientID;

--Query 5: Select and order data retrieved from one table (5 points)

SELECT Name, DateOfBirth 
FROM Patients
ORDER BY DateOfBirth ASC;

--Query 6: Using a join on 3 tables, select 5 columns from the 3 tables. Use syntax that would limit the output to 3 rows (5 points)
SELECT p.Name AS PatientName, d.Name AS DoctorName, a.Date AS AppointmentDate, a.AppointmentReason, a.Status
FROM Patients p
JOIN Appointment a ON p.PatientID = a.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID
LIMIT 3;

--Query 7: Select distinct rows using joins on 3 tables (5 points)
SELECT DISTINCT p.Name AS PatientName, d.Name AS DoctorName, a.AppointmentReason
FROM Patients p
JOIN Appointment a ON p.PatientID = a.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;


--Query 8: Use GROUP BY and HAVING in a select statement using one or more tables (5 points)
SELECT a.DoctorID, COUNT(a.AppointmentID) AS TotalAppointments
FROM Appointment a
GROUP BY a.DoctorID
HAVING COUNT(a.AppointmentID) > 2;

--Query 9: Use IN clause to select data from one or more tables (5 points)
SELECT Name, DateOfBirth 
FROM Patients
WHERE PatientID IN (SELECT PatientID FROM Appointment WHERE Status = 'Completed');

--Query 10: Select length of one column from one table (use LENGTH function) (5 points)
SELECT Name, LENGTH(Name) AS NameLength 
FROM Patients;

--Query 11: Delete one record from one table. Use select statements to demonstrate the table contents before and after the DELETE statement. 
--Make sure you use ROLLBACK afterwards so that the data will not be physically removed (5 points)

SELECT * FROM patients;

BEGIN;
DELETE FROM patients
WHERE patientid = 23;  
SELECT * FROM patients;

ROLLBACK;
SELECT * FROM patients;

--Query 12: Update one record from one table. Use select statements to demonstrate the table contents before and after the UPDATE statement. 
--Make sure you use ROLLBACK afterwards so that the data will not be physically removed (5 points)

-- Select records before update
SELECT * 
FROM Patients;

BEGIN;
-- Update a record
UPDATE Patients
SET ContactInfo = 'updated_email2@example.com'
WHERE PatientID = 4;

-- Select records after update
SELECT * 
FROM Patients;

-- Rollback to undo the update
ROLLBACK;
SELECT * FROM patients;

--Query 13: Advanced Query 1---This query combines joins and a subquery to calculate total appointments and revenue for each doctor, sorted by revenue.

SELECT d.Name AS DoctorName, 
       subquery.TotalAppointments, 
       subquery.TotalRevenue
FROM Doctor d
JOIN (
    -- Subquery to calculate total appointments and revenue for each doctor
    SELECT a.DoctorID, 
           COUNT(a.AppointmentID) AS TotalAppointments, 
           SUM(b.TotalAmount) AS TotalRevenue
    FROM Appointment a
    JOIN Billing b ON a.AppointmentID = b.AppointmentID
    GROUP BY a.DoctorID
) subquery ON d.DoctorID = subquery.DoctorID
ORDER BY subquery.TotalRevenue DESC;


--Query 14:-Advanced Query 2--This query combines joins, a subquery, and filtering logic to extract patients who have completed all their payments and are not associated with any pending payment status in the billing system

SELECT DISTINCT p.Name AS PatientName
FROM Patients p
JOIN MedicalRecord m ON p.PatientID = m.PatientID
JOIN Lab_Tests l ON m.RecordID = l.RecordID
WHERE p.PatientID NOT IN (
    SELECT b.PatientID 
    FROM Billing b
    WHERE b.PaymentStatus = 'Pending'
);


