/*
 Project BUAN 6320
*/

/* Populate all tables */
-----Patients Table
INSERT INTO Patients (Name, DateOfBirth, Gender, ContactInfo, Address, MedicalHistory)
VALUES
  ('John Doe', '1985-01-15', 'M', 'johndoe@example.com', '123 Main St', 'Allergic to peanuts'),
  ('Jane Smith', '1990-07-22', 'F', 'janesmith@example.com', '456 Oak St', 'No known allergies'),
  ('Michael Johnson', '1978-11-09', 'M', 'michaeljohnson@example.com', '789 Elm St', 'High blood pressure'),
  ('Emily Brown', '1992-03-12', 'F', 'emilybrown@example.com', '101 Pine St', 'Asthma'),
  ('David Lee', '1988-09-25', 'M', 'davidlee@example.com', '222 Cedar St', 'Diabetes'),
  ('Sarah Kim', '1995-05-18', 'F', 'sarahkim@example.com', '333 Maple St', 'Migraines'),
  ('Christopher Wilson', '1981-11-07', 'M', 'christopherwilson@example.com', '444 Oak St', 'Heart condition'),
  ('Olivia Taylor', '1993-02-20', 'F', 'oliviataylor@example.com', '555 Pine St', 'Food allergies'),
  ('Ethan Hernandez', '1987-08-10', 'M', 'ethanhernandez@example.com', '666 Cedar St', 'Broken arm (past injury)'),
  ('Sophia Martinez', '1994-04-05', 'F', 'sophiamartinez@example.com', '777 Maple St', 'Seasonal allergies'),
  ('Alex Turner', '1986-01-06', 'M', 'alexturner@example.com', '1001 Maple Ave', 'Vision problems'),
  ('Riley Johnson', '1992-04-12', 'F', 'rileyjohnson@example.com', '2002 Oak St', 'Skin allergies'),
  ('Noah Lee', '1989-07-19', 'M', 'noahlee@example.com', '3003 Pine Dr', 'Anxiety'),
  ('Ava Williams', '1995-10-25', 'F', 'avawilliams@example.com', '4004 Cedar Ln', 'Depression'),
  ('Liam Brown', '1987-02-02', 'M', 'liambrown@example.com', '5005 Elm St', 'High cholesterol'),
  ('Mia Davis', '1993-05-08', 'F', 'miadavis@example.com', '6006 Birch Rd', 'Migraines'),
  ('Ethan Miller', '1984-08-14', 'M', 'ethanmiller@example.com', '7007 Willow Cr', 'Back pain'),
  ('Olivia Nelson', '1991-11-20', 'F', 'olivianelson@example.com', '8008 Maple Ave', 'Seasonal allergies'),
  ('Jacob Martinez', '1982-03-26', 'M', 'jacobmartinez@example.com', '9009 Oak St', 'Sleep apnea'),
  ('Sophia Taylor', '1996-06-01', 'F', 'sophiataylor@example.com', '1010 Pine Dr', 'No known issues'),
  ('Benjamin Carter', '1988-07-12', 'M', 'benjamincarter@example.com', '1111 Elm St', 'Food allergies'),
  ('Charlotte Lee', '1994-10-23', 'F', 'charlottelee@example.com', '2222 Pine Ave', 'Anxiety'),
  ('Daniel Johnson', '1985-01-29', 'M', 'danieljohnson@example.com', '3333 Oak Ln', 'High blood pressure'),
  ('Eleanor Davis', '1991-04-04', 'F', 'eleanordavis@example.com', '4444 Maple Rd', 'Depression'),
  ('Finnley Wilson', '1987-07-10', 'M', 'finnleywilson@example.com', '5555 Cedar Dr', 'Migraines'),
  ('Grace Thomas', '1993-10-16', 'F', 'gracethomas@example.com', '6666 Birch Ct', 'Asthma'),
  ('Henry Martinez', '1989-01-22', 'M', 'henrymartinez@example.com', '7777 Willow Ln', 'Vision problems'),
  ('Isabella Harris', '1995-04-28', 'F', 'isabellaharris@example.com', '8888 Elm St', 'Skin allergies'),
  ('Jackson Smith', '1986-07-03', 'M', 'jacksonsmith@example.com', '9999 Pine Ave', 'Sleep apnea'),
  ('Katherine Miller', '1992-10-09', 'F', 'katherinemiller@example.com', '1010 Oak Ln', 'No known issues');
 
---Display all records from Patients Table
select * from patients;

----Doctor Table
INSERT INTO Doctor (Name, Department, Specialty, Experience, ContactInfo)
VALUES
  ('Dr. John Smith', 'Cardiology', 'Cardiologist', 15, 'johnsmith@example.com'),
  ('Dr. Jane Doe', 'Pediatrics', 'Pediatrician', 10, 'janedoe@example.com'),
  ('Dr. Michael Johnson', 'Internal Medicine', 'Internal Medicine Specialist', 20, 'michaeljohnson@example.com'),
  ('Dr. Emily Brown', 'Dermatology', 'Dermatologist', 8, 'emilybrown@example.com'),
  ('Dr. David Lee', 'Orthopedics', 'Orthopedic Surgeon', 12, 'davidlee@example.com'),
  ('Dr. Sarah Kim', 'Neurology', 'Neurologist', 18, 'sarahkim@example.com'),
  ('Dr. Christopher Wilson', 'Gastroenterology', 'Gastroenterologist', 14, 'christopherwilson@example.com'),
  ('Dr. Olivia Taylor', 'Obstetrics and Gynecology', 'Obstetrician-Gynecologist', 16, 'oliviataylor@example.com'),
  ('Dr. Ethan Hernandez', 'Psychiatry', 'Psychiatrist', 12, 'ethanhernandez@example.com'),
  ('Dr. Sophia Martinez', 'Family Medicine', 'Family Physician', 10, 'sophiamartinez@example.com');	

---Display all records from Doctor Table 
select * from doctor;

-------Appointment table
INSERT INTO Appointment (PatientID, DoctorID, Date, AppointmentReason, Status)
VALUES 
	(1, 101, '2023-11-30', 'Annual Checkup', 'Scheduled'),
	(2, 102, '2023-12-02', 'Follow-up Consultation', 'Scheduled'),
	(3, 103, '2023-12-05', 'Urgent Care', 'Scheduled'),
	(4, 101, '2023-12-07', 'Prescription Refill', 'Scheduled'),
	(5, 102, '2023-12-10', 'Routine Checkup', 'Scheduled'),
	(6, 103, '2023-12-12', 'Follow-up Consultation', 'Scheduled'),
	(7, 101, '2023-12-15', 'Annual Checkup', 'Scheduled'),
	(8, 102, '2023-12-17', 'Urgent Care', 'Scheduled'),
	(9, 103, '2023-12-20', 'Routine Checkup', 'Scheduled'),
	(10, 101, '2023-12-22', 'Prescription Refill', 'Scheduled');

---Display all records from Appointment Table
select * from Appointment;

----MedicalRecord Table
INSERT INTO MedicalRecord (PatientID, AppointmentID, DoctorID, Notes, Treatment)
VALUES
    (1, 1000, 101, 'Annual checkup performed. No issues.', 'Routine physical exam'),
    (2, 1001, 102, 'Follow-up consultation for ongoing condition.', 'Medication adjusted'),
    (3, 1002, 103, 'Presented with fever and cough.', 'Prescribed antibiotics'),
    (4, 1003, 101, 'Requested refill for regular medication.', 'Medication refilled'),
    (5, 1004, 102, 'Routine checkup completed.', 'Blood tests ordered'),
    (6, 1005, 103, 'Patient reported back pain.', 'Prescribed physiotherapy'),
    (7, 1006, 104, 'Skin rash diagnosed.', 'Prescribed ointment'),
    (8, 1007, 105, 'Complained of frequent headaches.', 'MRI scan recommended'),
    (9, 1008, 106, 'Routine dental checkup.', 'Teeth cleaned'),
    (10, 1009, 107, 'Vision issues reported.', 'Prescribed glasses.');

---Display all records from MedicalRecord Table
select * from MedicalRecord;

----Lab_tests Table
INSERT INTO Lab_Tests (RecordID, TestName, TestDate, Result, DoctorNotes)
VALUES
    (3000, 'Blood Test', '2023-11-30', 'Normal', 'All parameters within range'),
    (3001, 'X-Ray', '2023-12-02', 'Clear', 'No abnormalities detected'),
    (3002, 'COVID-19 Test', '2023-12-05', 'Negative', 'No infection'),
    (3003, 'Urine Test', '2023-12-07', 'Normal', 'Healthy kidney function'),
    (3004, 'Lipid Profile', '2023-12-10', 'High cholesterol', 'Dietary changes recommended'),
    (3005, 'MRI Scan', '2023-12-15', 'Normal', 'No abnormalities'),
    (3006, 'CT Scan', '2023-12-20', 'Abnormal mass', 'Oncology referral needed'),
    (3007, 'Allergy Test', '2023-12-25', 'Positive for dust allergy', 'Avoid exposure to dust'),
    (3008, 'ECG', '2023-12-30', 'Irregular rhythm', 'Cardiology follow-up advised'),
    (3009, 'Thyroid Function Test', '2024-01-05', 'Normal', 'No further action required');

---Display all records from Lab_Tests Table
select * from Lab_Tests;

-----Billing Table
INSERT INTO Billing (PatientID, AppointmentID, TotalAmount, Date, PaymentStatus, InsuranceDetails)
VALUES
    (1, 1000, 150.00, '2023-11-30', 'Paid', 'Blue Cross Insurance'),
    (2, 1001, 200.00, '2023-12-02', 'Pending', 'UnitedHealth Insurance'),
    (3, 1002, 300.00, '2023-12-05', 'Paid', 'Aetna Insurance'),
    (4, 1003, 50.00, '2023-12-07', 'Pending', 'Blue Cross Insurance'),
    (5, 1004, 100.00, '2023-12-10', 'Paid', 'UnitedHealth Insurance'),
    (6, 1005, 250.00, '2023-12-12', 'Paid', 'Medicare'),
    (7, 1006, 175.00, '2023-12-15', 'Pending', 'Cigna Insurance'),
    (8, 1007, 400.00, '2023-12-17', 'Paid', 'Kaiser Permanente'),
    (9, 1008, 300.00, '2023-12-20', 'Pending', 'Humana'),
    (10, 1009, 120.00, '2023-12-22', 'Paid', 'Aetna Insurance');

---Display all records from Billing Table
SELECT * FROM Billing;

----Lab_tests Table second set of insertions
INSERT INTO Lab_Tests (RecordID, TestName, TestDate, Result, DoctorNotes)
VALUES
    -- Lab tests for MedicalRecord with RecordID = 3000
    (3000, 'Blood Test', '2023-11-30', 'Normal', 'No abnormalities detected'),
    (3000, 'Lipid Profile', '2023-12-01', 'High cholesterol', 'Dietary changes recommended'),

    -- Lab tests for MedicalRecord with RecordID = 3001
    (3001, 'X-Ray', '2023-12-02', 'Clear', 'No abnormalities detected'),
    (3001, 'ECG', '2023-12-03', 'Irregular rhythm', 'Follow-up with cardiologist recommended'),

    -- Lab tests for MedicalRecord with RecordID = 3002
    (3002, 'COVID-19 Test', '2023-12-05', 'Negative', 'No infection detected'),
    (3002, 'Blood Sugar Test', '2023-12-05', 'Elevated', 'Possible pre-diabetic condition'),

    -- Lab tests for MedicalRecord with RecordID = 3003
    (3003, 'Urine Test', '2023-12-07', 'Normal', 'No abnormalities'),
    (3003, 'Allergy Test', '2023-12-08', 'Positive for pollen allergy', 'Avoid pollen exposure'),

    -- Lab tests for MedicalRecord with RecordID = 3004
    (3004, 'MRI Scan', '2023-12-10', 'Normal', 'No issues detected'),
    (3004, 'Thyroid Function Test', '2023-12-11', 'Normal', 'No further action required');

---Display all records from Lab_Tests Table
select * from lab_tests;

----Medical Records second set of insertions
INSERT INTO MedicalRecord (PatientID, AppointmentID, DoctorID, Notes, Treatment)
VALUES
    -- Records associated with DoctorID = 101
    (1, 1000, 101, 'Annual checkup. Patient is in good health.', 'Routine physical exam'),
    (2, 1001, 101, 'Follow-up consultation. Blood pressure stabilized.', 'Prescription for blood pressure control'),

    -- Records associated with DoctorID = 102
    (3, 1002, 102, 'Patient presented with fever and cough.', 'Prescribed antibiotics for infection'),
    (4, 1003, 102, 'Routine follow-up. Symptoms improving.', 'Continued medication for infection'),

    -- Records associated with DoctorID = 103
    (5, 1004, 103, 'Patient reported back pain after injury.', 'Recommended physiotherapy sessions'),
    (6, 1005, 103, 'Check-up after physiotherapy. Pain reduced.', 'Advised continuation of exercises'),

    -- Records associated with DoctorID = 104
    (7, 1006, 104, 'Patient presented with skin rash.', 'Prescribed antihistamine ointment'),
    (8, 1007, 104, 'Follow-up for skin rash. Symptoms resolved.', 'No further treatment required'),

    -- Records associated with DoctorID = 105
    (9, 1008, 105, 'Patient reported persistent headaches.', 'Ordered MRI scan for further evaluation'),
    (10, 1009, 105, 'MRI results normal. Advised stress management.', 'No medical intervention required');

---Display all records from MedicalRecord Table
select * from MedicalRecord;

------Appointment table second set of insertions
INSERT INTO Appointment (PatientID, DoctorID, Date, AppointmentReason, Status)
VALUES
    -- Appointments for DoctorID = 101
    (1, 101, '2023-11-30', 'Routine checkup', 'Completed'),
    (2, 101, '2023-12-02', 'Follow-up consultation', 'Scheduled'),

    -- Appointments for DoctorID = 102
    (3, 102, '2023-12-03', 'Fever and cough', 'Completed'),
    (4, 102, '2023-12-05', 'Routine follow-up', 'Scheduled'),

    -- Appointments for DoctorID = 103
    (5, 103, '2023-12-06', 'Back pain consultation', 'Completed'),
    (6, 103, '2023-12-08', 'Physiotherapy follow-up', 'Scheduled'),

    -- Appointments for DoctorID = 104
    (7, 104, '2023-12-10', 'Skin rash treatment', 'Completed'),
    (8, 104, '2023-12-12', 'Dermatology follow-up', 'Scheduled'),

    -- Appointments for DoctorID = 105
    (9, 105, '2023-12-14', 'Headache diagnosis', 'Completed'),
    (10, 105, '2023-12-16', 'MRI scan review', 'Scheduled');

---Display all records from Appointment Table
select * from Appointment;

COMMIT;