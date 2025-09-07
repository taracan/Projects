# Health Care Management System  

## Project Overview  
The Health Care Management System is a database-driven solution designed to manage core healthcare operations. It enables:  
- Patient registration and records management  
- Doctor information management  
- Appointment scheduling and tracking  
- Medical records and lab test integration  
- Billing with insurance support  

This project was developed as part of **BUAN 6320 – Database Foundations for Business Analytics**.  

---

## Features  
- **Patients Module**: Store demographics, contact info, and medical history.  
- **Doctors Module**: Track specialties, departments, and experience.  
- **Appointments Module**: Book, update, and track appointment status.  
- **Medical Records Module**: Maintain treatment notes, diagnoses, and prescriptions.  
- **Lab Tests Module**: Record and monitor lab test details with results and doctor notes.  
- **Billing Module**: Generate bills with payment and insurance details.  

---

## Database Design  

### Entities  
- **Patients**: PatientID, Name, DOB, Gender, Contact Info, Address, Medical History  
- **Doctor**: DoctorID, Name, Specialty, Department, Experience, Contact Info  
- **Appointment**: AppointmentID, PatientID, DoctorID, Date, Reason, Status  
- **MedicalRecord**: RecordID, PatientID, AppointmentID, DoctorID, Notes, Treatment  
- **Lab_Tests**: TestID, RecordID, TestName, TestDate, Result, DoctorNotes  
- **Billing**: BillID, PatientID, AppointmentID, TotalAmount, Date, PaymentStatus, InsuranceDetails  
- **PatientInsurance**: PatientID, InsuranceDetails  

### Relationships and Cardinality  
- A patient can have multiple appointments (1:M).  
- A doctor can attend multiple appointments (1:M).  
- Each appointment generates a medical record (1:1).  
- Each medical record can have multiple lab tests (1:M).  
- Each appointment generates one billing record (1:1).  

---

## Normalization  
The database schema is normalized up to **Third Normal Form (3NF)** to:  
- Remove redundancy  
- Ensure data integrity  
- Improve query performance  

---

## Technical Implementation  
- **DDL (Data Definition Language)**: Tables, constraints, keys, indices, views  
- **DML (Data Manipulation Language)**: Insert, update, delete operations with rollback support  
- **Queries**:  
  - Select and filter data  
  - Joins across multiple tables  
  - Aggregations with GROUP BY and HAVING  
  - Subqueries and DISTINCT selections  
  - Views for simplified reporting  

---

## Contributors  
- Don Thoppil Jain  
- Sushma Bukkapuram  
- Tara Canugovi  
- Mounika Kolle  
- Venkata Lakshmi Ishwarya Tatavarthi  

---

## Conclusion  
This project delivers a robust healthcare database system for efficient management of patients, doctors, appointments, billing, and lab records. It provides a foundation for building advanced healthcare applications while ensuring data integrity, privacy, and scalability.  
