/*
 Project BUAN 6320
*/

/* DROP statements to clean up objects from previous run */
-- Drop Triggers
DROP TRIGGER IF EXISTS assign_bill_id_trigger ON Billing;
DROP TRIGGER IF EXISTS assign_test_id_trigger ON Lab_Tests;
DROP TRIGGER IF EXISTS assign_record_id_trigger ON MedicalRecord;
DROP TRIGGER IF EXISTS assign_appointment_id_trigger ON Appointment;
DROP TRIGGER IF EXISTS assign_doctor_id ON Doctor;
DROP TRIGGER IF EXISTS assign_patient_id_trigger ON Patients;

-- Drop Functions
DROP FUNCTION IF EXISTS assign_patient_id();
DROP FUNCTION IF EXISTS assign_doctor_id();
DROP FUNCTION IF EXISTS assign_appointment_id();
DROP FUNCTION IF EXISTS assign_record_id();
DROP FUNCTION IF EXISTS assign_test_id();
DROP FUNCTION IF EXISTS assign_bill_id();

-- Drop Sequences
DROP SEQUENCE IF EXISTS patient_id_seq;
DROP SEQUENCE IF EXISTS doctor_id_seq;
DROP SEQUENCE IF EXISTS appointment_id_seq;
DROP SEQUENCE IF EXISTS record_id_seq;
DROP SEQUENCE IF EXISTS test_id_seq;
DROP SEQUENCE IF EXISTS bill_id_sequen;

----Drop Views
DROP VIEW IF EXISTS PatientAppointmentsView;
DROP VIEW IF EXISTS DoctorAppointmentsView;
DROP VIEW IF EXISTS BillingSummaryView;
DROP VIEW IF EXISTS LabTestDetailsView;

--Drop Indices
-- Drop indices for Patients
DROP INDEX IF EXISTS idx_patients_name;
DROP INDEX IF EXISTS idx_patients_name_dob;

-- Drop indices for Doctor
DROP INDEX IF EXISTS idx_doctor_specialty;
DROP INDEX IF EXISTS idx_doctor_department_specialty;

-- Drop indices for Appointment
DROP INDEX IF EXISTS idx_appointment_patient_id;
DROP INDEX IF EXISTS idx_appointment_doctor_id;
DROP INDEX IF EXISTS idx_appointment_date;

-- Drop indices for Billing
DROP INDEX IF EXISTS idx_billing_patient_id;
DROP INDEX IF EXISTS idx_billing_appointment_id;
DROP INDEX IF EXISTS idx_billing_payment_status;

-- Drop indices for MedicalRecord
DROP INDEX IF EXISTS idx_medicalrecord_patient_id;
DROP INDEX IF EXISTS idx_medicalrecord_appointment_id;
DROP INDEX IF EXISTS idx_medicalrecord_doctor_id;

-- Drop indices for Lab_Tests
DROP INDEX IF EXISTS idx_labtests_record_id;
DROP INDEX IF EXISTS idx_labtests_test_date;

--Drop Tables
-- Drop Lab_Tests table
DROP TABLE IF EXISTS Lab_Tests;

-- Drop MedicalRecord table
DROP TABLE IF EXISTS MedicalRecord;

-- Drop Billing table
DROP TABLE IF EXISTS Billing;

-- Drop Appointment table
DROP TABLE IF EXISTS Appointment;

-- Drop Doctor table
DROP TABLE IF EXISTS Doctor;

-- Drop Patients table
DROP TABLE IF EXISTS Patients;

--Drop Schema
DROP SCHEMA IF EXISTS hospital_management CASCADE;

--Create Schema
CREATE SCHEMA hospital_management;
set search_path to hospital_management;

/* Create tables based on entities */
--Create Table Patients
CREATE TABLE Patients (
    PatientID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL
);

--Create Table Doctor
CREATE TABLE Doctor (
    DoctorID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(100) NOT NULL
);

--Create Table Appointment
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT REFERENCES Patients(PatientID),
    DoctorID INT REFERENCES Doctor(DoctorID)
);

--Create Table MedicalRecord
CREATE TABLE MedicalRecord (
    RecordID INT PRIMARY KEY,
    PatientID INT REFERENCES Patients(PatientID),
    AppointmentID INT REFERENCES Appointment(AppointmentID)
);

--Create Table Lab_tests
CREATE TABLE Lab_Tests (
    TestID INT PRIMARY KEY,
    RecordID INT REFERENCES MedicalRecord(RecordID),
    TestName VARCHAR(100)
);

--Create Table Billing
CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    PatientID INT REFERENCES Patients(PatientID),
    AppointmentID INT REFERENCES Appointment(AppointmentID)
);

/* Alter Tables by adding Columns */
ALTER TABLE Billing
ADD TotalAmount NUMERIC(10, 2),
ADD Date DATE,
ADD PaymentStatus VARCHAR(20),
ADD InsuranceDetails TEXT;

ALTER TABLE Lab_Tests
ADD TestDate DATE NOT NULL,
ADD Result TEXT NOT NULL,
ADD DoctorNotes TEXT;

ALTER TABLE MedicalRecord
ADD DoctorID INT REFERENCES Doctor(DoctorID),
ADD Notes TEXT,
ADD Treatment TEXT NOT NULL;

ALTER TABLE Appointment
ADD Date DATE NOT NULL,
ADD AppointmentReason TEXT,
ADD Status VARCHAR(20) NOT NULL;

ALTER TABLE Doctor
ADD Specialty VARCHAR(100),
ADD Experience INT NOT NULL,
ADD ContactInfo VARCHAR(255);

ALTER TABLE Patients
ADD Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
ADD ContactInfo VARCHAR(255),
ADD Address VARCHAR(255),
ADD MedicalHistory TEXT;

/* Create Indices */
-- Indices for Patients
CREATE INDEX idx_patients_name ON Patients (Name);
CREATE INDEX idx_patients_name_dob ON Patients (Name, DateOfBirth);

-- Indices for Doctor
CREATE INDEX idx_doctor_specialty ON Doctor (Specialty);
CREATE INDEX idx_doctor_department_specialty ON Doctor (Department, Specialty);

-- Indices for Appointment
CREATE INDEX idx_appointment_patient_id ON Appointment (PatientID);
CREATE INDEX idx_appointment_doctor_id ON Appointment (DoctorID);
CREATE INDEX idx_appointment_date ON Appointment (Date);

-- Indices for Billing
CREATE INDEX idx_billing_patient_id ON Billing (PatientID);
CREATE INDEX idx_billing_appointment_id ON Billing (AppointmentID);
CREATE INDEX idx_billing_payment_status ON Billing (PaymentStatus);

-- Indices for MedicalRecord
CREATE INDEX idx_medicalrecord_patient_id ON MedicalRecord (PatientID);
CREATE INDEX idx_medicalrecord_appointment_id ON MedicalRecord (AppointmentID);
CREATE INDEX idx_medicalrecord_doctor_id ON MedicalRecord (DoctorID);

-- Indices for Lab_Tests
CREATE INDEX idx_labtests_record_id ON Lab_Tests (RecordID);
CREATE INDEX idx_labtests_test_date ON Lab_Tests (TestDate);

---Create Views
----Business Purpose: This view provides a consolidated view of all patients and their corresponding appointment details. 
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

	
----Business Purpose: This view offers a detailed summary of appointments managed by each doctor, along with their specialties and experience.
CREATE OR REPLACE VIEW DoctorAppointmentsView AS
SELECT 
    d.DoctorID,
    d.Name AS DoctorName,
    d.Specialty,
    d.Experience,
    a.AppointmentID,
    a.Date AS AppointmentDate,
    a.AppointmentReason,
    a.Status
FROM 
    Doctor d
JOIN 
    Appointment a ON d.DoctorID = a.DoctorID;
	
--Business Purpose: This view consolidates patient billing information linked to their appointments.	
CREATE OR REPLACE VIEW BillingSummaryView AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    a.AppointmentID,
    b.BillID,
    b.TotalAmount,
    b.Date AS BillingDate,
    b.PaymentStatus,
    b.InsuranceDetails
FROM 
    Patients p
JOIN 
    Appointment a ON p.PatientID = a.PatientID
JOIN 
    Billing b ON a.AppointmentID = b.AppointmentID;

--Business Purpose: This view provides an overview of lab tests conducted for each patient, linked to their medical records.
CREATE OR REPLACE VIEW LabTestDetailsView AS
SELECT 
    m.RecordID,
    p.PatientID,
    p.Name AS PatientName,
    l.TestID,
    l.TestName,
    l.TestDate,
    l.Result,
    l.DoctorNotes
FROM 
    MedicalRecord m
JOIN 
    Patients p ON m.PatientID = p.PatientID
JOIN 
    Lab_Tests l ON m.RecordID = l.RecordID;
	
/* Create Sequences */
CREATE SEQUENCE patient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 
CREATE SEQUENCE doctor_id_seq     
	START WITH 100    
	INCREMENT BY 1 
	NO MINVALUE     
	NO MAXVALUE 
	CACHE 1;

CREATE SEQUENCE appointment_id_seq
	START WITH 1000
	INCREMENT BY 1;

CREATE SEQUENCE record_id_seq
    START WITH 3000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE test_id_seq
    START WITH 7000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE bill_id_sequen
    START WITH 5000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


/* Create Functions */
-- Automatically assigns unique PatientID during record insertion in Patients table.
CREATE OR REPLACE FUNCTION assign_patient_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.PatientID := nextval('patient_id_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Automatically assigns unique DoctorID during record insertion in Doctor table.
CREATE OR REPLACE FUNCTION assign_doctor_id()
RETURNS TRIGGER AS $$
BEGIN    
	NEW.DoctorID := nextval('doctor_id_seq');     
	RETURN NEW;
END; 
$$ LANGUAGE plpgsql;
 
-- Automatically assigns unique AppointmentID during record insertion in Appointment table.
CREATE OR REPLACE FUNCTION assign_appointment_id()
RETURNS TRIGGER AS $$
BEGIN
	NEW.AppointmentID := nextval('appointment_id_seq');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Automatically assigns unique RecordID during record insertion in MedicalRecord table.
CREATE OR REPLACE FUNCTION assign_record_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.RecordID := nextval('record_id_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Automatically assigns unique TestID during record insertion in Lab_Tests table.
CREATE OR REPLACE FUNCTION assign_test_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.TestID := nextval('test_id_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Automatically assigns unique BillID during record insertion in Billing table.
CREATE OR REPLACE FUNCTION assign_bill_id()
RETURNS TRIGGER AS $$
BEGIN
    NEW.BillID := nextval('bill_id_sequen');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* Create Triggers */
-- Ensures BillID is auto-generated for new records in the Billing table.
CREATE TRIGGER assign_bill_id_trigger
BEFORE INSERT ON Billing
FOR EACH ROW
EXECUTE FUNCTION assign_bill_id();

-- Ensures TestID is auto-generated for new records in the Lab_Tests table.
CREATE TRIGGER assign_test_id_trigger
BEFORE INSERT ON Lab_Tests
FOR EACH ROW
EXECUTE FUNCTION assign_test_id();

-- Ensures RecordID is auto-generated for new records in the MedicalRecord table.
CREATE TRIGGER assign_record_id_trigger
BEFORE INSERT ON MedicalRecord
FOR EACH ROW
EXECUTE FUNCTION assign_record_id();

-- Ensures AppointmentID is auto-generated for new records in the Appointment table.
CREATE TRIGGER assign_appointment_id_trigger
BEFORE INSERT ON Appointment
FOR EACH ROW
EXECUTE FUNCTION assign_appointment_id();

-- Ensures DoctorID is auto-generated for new records in the Doctor table.
CREATE TRIGGER assign_doctor_id 
BEFORE INSERT ON Doctor 
FOR EACH ROW 
EXECUTE PROCEDURE assign_doctor_id();

-- Ensures PatientID is auto-generated for new records in the Patients table.
CREATE TRIGGER assign_patient_id_trigger
BEFORE INSERT ON Patients
FOR EACH ROW
EXECUTE FUNCTION assign_patient_id();		




