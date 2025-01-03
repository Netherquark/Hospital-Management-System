-- Table: Patient
CREATE DATABASE HMS;

USE HMS;

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Gender VARCHAR(10),
    Address TEXT,
    Phone_Number VARCHAR(15),
    Email VARCHAR(50),
    Emergency_Contact VARCHAR(15),
    Insurance_Details TEXT,
    Medical_History TEXT
);

-- Table: Department
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Head_of_Department VARCHAR(50),
    Contact_No VARCHAR(15)
);

-- Table: Doctor
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Specialization VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email_ID VARCHAR(50),
    Work_Shift VARCHAR(20),
    Experience INT,
    Consulting_Fee DECIMAL(10, 2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

-- Table: Appointment
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status VARCHAR(20),
    Reason_of_Visit TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Table: Billing
CREATE TABLE Billing (
    Billing_ID INT PRIMARY KEY,
    Appointment_ID INT,
    Patient_ID INT,
    Total_Amount DECIMAL(10, 2),
    Payment_Method VARCHAR(50),
    Billing_Date DATE,
    Payment_Status VARCHAR(20),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- Table: Laboratory
CREATE TABLE Laboratory (
    Lab_Test_ID INT PRIMARY KEY,
    Patient_ID INT,
    Appointment_ID INT,
    Test_Type VARCHAR(100),
    Test_Date DATE,
    Test_Charges DECIMAL(10, 2),
    Test_Result TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- Table: Prescription
CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Appointment_ID INT,
    Doctor_ID INT,
    Patient_ID INT,
    Medicine_Details TEXT,
    Prescription_Date DATE,
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- USE HMS;  --HMS stands for Hospital Management System, the schema being used for this project.
show tables;
-- Alter the table Doctor
ALTER TABLE Doctor ADD Password VARCHAR(64);

-- Insertion of data in the tables
-- Inserting data in the patient table 

INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_of_Birth, Gender, Address, Phone_Number, Email, Emergency_Contact, Insurance_Details, Medical_History)
VALUES 
(1, 'John', 'Doe', '1985-03-12', 'Male', '123 Elm St, Springfield', '123-456-7890', 'john.doe@example.com', '987-654-3210', 'HealthPlus Insurance', 'Allergic to penicillin'),
(2, 'Jane', 'Smith', '1992-07-19', 'Female', '456 Oak Rd, Lincoln', '321-654-9870', 'jane.smith@example.com', '654-321-9876', 'MediCare', 'Asthma'),
(3, 'Sam', 'Brown', '2000-11-23', 'Non-binary', '789 Pine Ln, Shelbyville', '213-546-8790', 'sam.brown@example.com', '321-987-6543', 'BlueShield', 'Diabetes Type 1'),
(4, 'Michael', 'Johnson', '1975-02-01', 'Male', '111 Maple Dr, Springfield', '456-123-7890', 'michael.j@example.com', '789-123-4567', 'SunLife Health', 'Hypertension'),
(5, 'Emily', 'Davis', '1989-09-05', 'Female', '222 Birch Blvd, Springfield', '789-654-1234', 'emily.d@example.com', '123-456-7899', 'CareFirst', 'None'),
(6, 'Olivia', 'Williams', '1990-12-15', 'Female', '333 Cedar St, Greenfield', '555-123-4567', 'olivia.w@example.com', '222-333-4444', 'LifeShield Insurance', 'Peanut allergy'),
(7, 'Liam', 'Jones', '1988-05-25', 'Male', '444 Willow Ln, Brooksville', '555-234-5678', 'liam.j@example.com', '333-444-5555', 'BlueCare', 'History of hypertension'),
(8, 'Sophia', 'Martinez', '1972-08-09', 'Female', '555 Palm Ave, Weston', '555-345-6789', 'sophia.m@example.com', '444-555-6666', 'WellCare', 'Chronic back pain'),
(9, 'Noah', 'Garcia', '1965-01-30', 'Male', '666 Spruce Dr, Sunnyvale', '555-456-7890', 'noah.g@example.com', '555-666-7777', 'MedSafe', 'Heart disease'),
(10, 'Isabella', 'Rodriguez', '2003-04-18', 'Female', '777 Ash Ct, Fairview', '555-567-8901', 'isabella.r@example.com', '666-777-8888', 'CareNet', 'None'),
(11, 'Ethan', 'Clark', '1980-10-05', 'Male', '888 Sycamore St, Rivertown', '555-678-1234', 'ethan.c@example.com', '777-888-9990', 'HealthSecure', 'Chronic migraines'),
(12, 'Ava', 'Harris', '1995-03-16', 'Female', '999 Poplar Ln, Eastvale', '555-789-2345', 'ava.h@example.com', '888-999-0001', 'LifePlus', 'Scoliosis'),
(13, 'Mason', 'Scott', '1984-06-12', 'Male', '1010 Pineapple Ct, Ridgewood', '555-890-3456', 'mason.s@example.com', '999-000-1112', 'CareFirst Health', 'None'),
(14, 'Charlotte', 'Adams', '1976-11-29', 'Female', '1111 Coconut Blvd, Meadowbrook', '555-901-4567', 'charlotte.a@example.com', '000-111-2223', 'WellNet', 'Arthritis'),
(15, 'James', 'Baker', '1999-09-22', 'Male', '1212 Mango Rd, Hilltop', '555-123-5678', 'james.b@example.com', '111-222-3334', 'HealthWise', 'Sports injury history'),
(16, 'Mia', 'Mitchell', '2001-07-20', 'Female', '1313 Elm St, Clearbrook', '555-234-6789', 'mia.m@example.com', '222-333-4445', 'PrimeCare Health', 'None'),
(17, 'Lucas', 'Turner', '1989-02-14', 'Male', '1414 Maple Ave, Lakeside', '555-345-7890', 'lucas.t@example.com', '333-444-5556', 'Guardian Health', 'Asthma'),
(18, 'Ella', 'White', '1975-12-30', 'Female', '1515 Oak St, Newbury', '555-456-8901', 'ella.w@example.com', '444-555-6667', 'LifeSecure', 'Osteoarthritis'),
(19, 'Alexander', 'Perez', '1968-03-03', 'Male', '1616 Cedar Dr, Springwood', '555-567-9012', 'alexander.p@example.com', '555-666-7778', 'MedSave', 'Hypertension'),
(20, 'Amelia', 'Campbell', '1992-11-11', 'Female', '1717 Birch Ct, Elmwood', '555-678-0123', 'amelia.c@example.com', '666-777-8889', 'HealthSecure', 'History of anemia'),
(21, 'Daniel', 'Morris', '1982-04-25', 'Male', '1818 Willow Ave, Brookfield', '555-789-2345', 'daniel.m@example.com', '777-888-9999', 'MediPlan', 'History of high cholesterol'),
(22, 'Sofia', 'Hall', '1990-08-18', 'Female', '1919 Cypress St, Greenfield', '555-890-3456', 'sofia.h@example.com', '888-999-0000', 'PrimeCare Health', 'None'),
(23, 'Logan', 'Rodriguez', '1977-01-09', 'Male', '2020 Cherry Rd, Westwood', '555-901-4567', 'logan.r@example.com', '999-000-1111', 'HealthPlus', 'Heart disease'),
(24, 'Grace', 'Martinez', '2003-05-30', 'Female', '2121 Plum Dr, Fairview', '555-123-5678', 'grace.m@example.com', '000-111-2222', 'CareSecure', 'Seasonal allergies'),
(25, 'Henry', 'Lopez', '1965-12-15', 'Male', '2222 Apple Ct, Riverdale', '555-234-6789', 'henry.l@example.com', '111-222-3333', 'LifePlus', 'Diabetes'),
(26, 'Layla', 'Evans', '1988-09-07', 'Female', '2323 Peach Ln, Hillcrest', '555-345-7890', 'layla.e@example.com', '222-333-4444', 'WellHealth', 'Migraines'),
(27, 'Jack', 'Garcia', '1993-11-03', 'Male', '2424 Banana Blvd, Pinewood', '555-456-8901', 'jack.g@example.com', '333-444-5555', 'FamilySecure', 'None'),
(28, 'Victoria', 'Nelson', '1972-02-20', 'Female', '2525 Lime St, Lakeview', '555-567-9012', 'victoria.n@example.com', '444-555-6666', 'GuardianCare', 'Rheumatoid arthritis'),
(29, 'Samuel', 'Carter', '1985-06-14', 'Male', '2626 Orange Dr, Redwood', '555-678-0123', 'samuel.c@example.com', '555-666-7777', 'HealthNet', 'Asthma'),
(30, 'Zoe', 'Peterson', '1999-10-01', 'Female', '2727 Melon Rd, Willowtown', '555-789-1234', 'zoe.p@example.com', '666-777-8888', 'SafeGuard', 'None'),
(31, 'Olivia', 'Hall', '1990-02-05', 'Female', '1313 Cherry St, Farmtown', '555-234-5678', 'olivia.h@example.com', '222-333-4444', 'HealthGuard', 'Anxiety disorder'),
(32, 'Liam', 'Martinez', '1982-05-16', 'Male', '1414 Maple St, Hillcrest', '555-345-6789', 'liam.m@example.com', '333-444-5555', 'SecureHealth', 'Asthma'),
(33, 'Sophia', 'Garcia', '1988-09-28', 'Female', '1515 Elm St, Springville', '555-456-7890', 'sophia.g@example.com', '444-555-6666', 'CarePlus', 'Seasonal allergies'),
(34, 'Noah', 'Wilson', '1975-07-19', 'Male', '1616 Fir St, Lakeview', '555-567-8901', 'noah.w@example.com', '555-666-7777', 'Wellness First', 'Hypertension'),
(35, 'Emma', 'Anderson', '1992-11-30', 'Female', '1717 Cedar Ave, Greenfield', '555-678-9012', 'emma.a@example.com', '666-777-8888', 'TotalHealth', 'Depression'),
(36, 'Aiden', 'Roberts', '1985-01-10', 'Male', '1818 Oak St, Riverton', '555-789-0123', 'aiden.r@example.com', '777-888-9999', 'FamilyCare', 'Chronic back pain'),
(37, 'Isabella', 'Thompson', '1984-04-24', 'Female', '1919 Birch Ln, Eastfield', '555-890-1234', 'isabella.t@example.com', '888-999-0000', 'HealthNet', 'Migraine'),
(38, 'Lucas', 'Jackson', '1996-08-15', 'Male', '2020 Palm Ct, Westside', '555-901-2345', 'lucas.j@example.com', '999-000-1111', 'CareChoice', 'None'),
(39, 'Mia', 'White', '1993-06-09', 'Female', '2121 Walnut St, Southtown', '555-012-3456', 'mia.w@example.com', '000-111-2222', 'FirstHealth', 'Epilepsy'),
(40, 'Elijah', 'Lewis', '1981-10-03', 'Male', '2222 Pine St, Northfield', '555-123-4567', 'elijah.l@example.com', '111-222-3333', 'HealthyLife', 'Heart disease'),
(41, 'Amelia', 'Lee', '1978-12-14', 'Female', '2323 Spruce Ave, Cottontown', '555-234-5678', 'amelia.l@example.com', '222-333-4444', 'Medicare', 'Chronic kidney disease'),
(42, 'James', 'Hernandez', '1990-03-01', 'Male', '2424 Lark St, Clearview', '555-345-6789', 'james.h@example.com', '333-444-5555', 'HealthWise', 'Diabetes'),
(43, 'Charlotte', 'Martinez', '1989-05-20', 'Female', '2525 Robin Rd, Crestwood', '555-456-7890', 'charlotte.m@example.com', '444-555-6666', 'WellNet', 'Thyroid issues'),
(44, 'Logan', 'Allen', '1995-09-30', 'Male', '2626 Hawk St, Riverside', '555-567-8901', 'logan.a@example.com', '555-666-7777', 'SecureHealth', 'Obesity'),
(45, 'Avery', 'Young', '1994-11-12', 'Female', '2727 Falcon Ct, Woodside', '555-678-9012', 'avery.y@example.com', '666-777-8888', 'CareFirst', 'Chronic fatigue syndrome'),
(46, 'Ella', 'King', '1997-04-15', 'Female', '2828 Seagull Rd, Oceanview', '555-789-1234', 'ella.k@example.com', '222-444-8888', 'CareHealth', 'None'),
(47, 'Jackson', 'Wright', '1990-08-12', 'Male', '2929 Ocean Blvd, Shoreline', '555-890-2345', 'jackson.w@example.com', '333-555-9999', 'BestCare', 'Chronic fatigue'),
(48, 'Scarlett', 'Scott', '1983-03-21', 'Female', '3030 Bay St, Coral Springs', '555-901-3456', 'scarlett.s@example.com', '444-666-0000', 'TotalHealth', 'Seasonal allergies'),
(49, 'Alexander', 'Torres', '1995-09-04', 'Male', '3131 Vista St, Sandy Shores', '555-012-4567', 'alexander.t@example.com', '555-777-1111', 'HealthFirst', 'Anxiety'),
(50, 'Grace', 'Nguyen', '1987-11-27', 'Female', '3232 Creek St, Silverlake', '555-123-5678', 'grace.n@example.com', '666-888-2222', 'Medicare', 'Diabetes'),
(51, 'Sophia', 'Ramirez', '1990-05-14', 'Female', '222 Maple Rd, Greenfield', '555-111-1212', 'sophia.r@example.com', '555-888-1212', 'MediCare', 'Asthma'),
(52, 'Liam', 'Johnson', '1988-09-22', 'Male', '333 Oakwood Dr, Riverside', '555-222-2323', 'liam.j@example.com', '555-777-2323', 'HealthSafe', 'Seasonal allergies'),
(53, 'Mia', 'Bennett', '1992-11-11', 'Female', '444 Pine Ave, Meadowland', '555-333-3434', 'mia.b@example.com', '555-666-3434', 'SecureHealth', 'Diabetes type 1'),
(54, 'Lucas', 'Davis', '1985-08-05', 'Male', '555 Birch St, Stonebridge', '555-444-4545', 'lucas.d@example.com', '555-555-4545', 'WellCare', 'Chronic back pain'),
(55, 'Amelia', 'Wilson', '1979-03-19', 'Female', '666 Cedar Ln, Lakeview', '555-555-5656', 'amelia.w@example.com', '555-444-5656', 'HealthPlus', 'Hypertension'),
(56, 'Noah', 'Anderson', '1995-06-27', 'Male', '777 Willow Rd, Sunnyvale', '555-666-6767', 'noah.a@example.com', '555-333-6767', 'PrimeHealth', 'None'),
(57, 'Emma', 'Clarkson', '1981-12-30', 'Female', '888 Cherry Blvd, Springhill', '555-777-7878', 'emma.c@example.com', '555-222-7878', 'LifeSure', 'Rheumatoid arthritis'),
(58, 'William', 'Martinez', '1993-04-18', 'Male', '999 Spruce Ave, Highland', '555-888-8989', 'william.m@example.com', '555-111-8989', 'SafeGuard', 'Peptic ulcer'),
(59, 'Olivia', 'Rodriguez', '1987-07-09', 'Female', '111 Palm St, Seaview', '555-999-9090', 'olivia.r@example.com', '555-000-9090', 'CareSecure', 'Migraines'),
(60, 'Ethan', 'Brown', '1996-02-25', 'Male', '123 Cypress Blvd, Brookside', '555-000-1010', 'ethan.b@example.com', '555-999-1010', 'MediTrust', 'None');

-- Inserting data into the Department table

INSERT INTO Department (Department_ID, Department_Name, Head_of_Department, Contact_No)
VALUES
(1, 'Cardiology', 'Dr. Alan Green', '555-111-1234'),
(2, 'Orthopedics', 'Dr. Lisa White', '555-222-2345'),
(3, 'Pediatrics', 'Dr. Mark Black', '555-333-3456'),
(4, 'Neurology', 'Dr. Susan Brown', '555-444-4567'),
(5, 'Oncology', 'Dr. Tom Blue', '555-555-5678'),
(6, 'Dermatology', 'Dr. Sarah Grey', '555-666-6789'),
(7, 'Gastroenterology', 'Dr. Chris Tan', '555-777-7890'),
(8, 'Psychiatry', 'Dr. Anna Lee', '555-888-8901'),
(9, 'ENT', 'Dr. Kevin Huang', '555-999-9012'),
(10, 'Ophthalmology', 'Dr. Maria Gomez', '555-000-1234'),
(11, 'Urology', 'Dr. Linda Young', '555-111-2224'),
(12, 'Pulmonology', 'Dr. Peter King', '555-222-3335'),
(13, 'Radiology', 'Dr. Henry Smith', '555-333-4446'),
(14, 'Rheumatology', 'Dr. Nancy Black', '555-444-5557'),
(15, 'Endocrinology', 'Dr. Oliver Grey', '555-555-6668'),
(16, 'Orthopedics', 'Dr. Susan Grant', '555-777-1111');

-- Inserting data in the doctors table

INSERT INTO Doctor (Doctor_ID, First_Name, Last_Name, Specialization, Contact_Number, Email_ID, Work_Shift, Experience, Consulting_Fee, Department_ID)
VALUES
(1, 'Alan', 'Green', 'Cardiologist', '555-111-1122', 'alan.green@hospital.com', 'Day Shift', 15, 250.00, 1),
(2, 'Lisa', 'White', 'Orthopedic Surgeon', '555-222-2233', 'lisa.white@hospital.com', 'Night Shift', 10, 300.00, 2),
(3, 'Mark', 'Black', 'Pediatrician', '555-333-3344', 'mark.black@hospital.com', 'Day Shift', 8, 200.00, 3),
(4, 'Susan', 'Brown', 'Neurologist', '555-444-4455', 'susan.brown@hospital.com', 'Day Shift', 12, 350.00, 4),
(5, 'Tom', 'Blue', 'Oncologist', '555-555-5566', 'tom.blue@hospital.com', 'Night Shift', 18, 400.00, 5),
(6, 'Sarah', 'Grey', 'Dermatologist', '555-123-4568', 'sarah.grey@hospital.com', 'Night Shift', 9, 150.00, 6),
(7, 'Chris', 'Tan', 'Gastroenterologist', '555-234-5679', 'chris.tan@hospital.com', 'Day Shift', 7, 280.00, 7),
(8, 'Anna', 'Lee', 'Psychiatrist', '555-345-6780', 'anna.lee@hospital.com', 'Day Shift', 11, 300.00, 8),
(9, 'Kevin', 'Huang', 'ENT Specialist', '555-456-7891', 'kevin.huang@hospital.com', 'Day Shift', 5, 180.00, 9),
(10, 'Maria', 'Gomez', 'Ophthalmologist', '555-567-8902', 'maria.gomez@hospital.com', 'Night Shift', 13, 220.00, 10),
(11, 'Linda', 'Young', 'Urologist', '555-234-5670', 'linda.young@hospital.com', 'Night Shift', 14, 260.00, 11),
(12, 'Peter', 'King', 'Pulmonologist', '555-345-6781', 'peter.king@hospital.com', 'Day Shift', 16, 320.00, 12),
(13, 'Henry', 'Smith', 'Radiologist', '555-456-7892', 'henry.smith@hospital.com', 'Day Shift', 20, 280.00, 13),
(14, 'Nancy', 'Black', 'Rheumatologist', '555-567-8903', 'nancy.black@hospital.com', 'Night Shift', 18, 310.00, 14),
(15, 'Oliver', 'Grey', 'Endocrinologist', '555-678-9014', 'oliver.grey@hospital.com', 'Day Shift', 21, 350.00, 15),
(16, 'Susan', 'Grant', 'Orthopedic Surgeon', '555-111-7890', 'susan.grant@hospital.com', 'Night Shift', 15, 275.00, 16),
(17, 'David', 'Carter', 'Pediatrician', '555-222-3333', 'david.c@example.com', 'Day Shift', 10, 200.00, 1),
(18, 'Natalie', 'Perry', 'Dermatologist', '555-333-4444', 'natalie.p@example.com', 'Day Shift', 8, 250.00, 3),
(19, 'Michael', 'Foster', 'Psychiatrist', '555-444-5555', 'michael.f@example.com', 'Night Shift', 12, 300.00, 8),
(20, 'Hannah', 'Gray', 'Oncologist', '555-555-6666', 'hannah.g@example.com', 'Day Shift', 15, 400.00, 9),
(21, 'Julia', 'Harris', 'Pulmonologist', '555-123-4561', 'julia.h@example.com', 'Day Shift', 12, 300.00, 5),
(22, 'Mark', 'Lee', 'Orthopedic', '555-234-5672', 'mark.l@example.com', 'Night Shift', 14, 320.00, 8),
(23, 'Sara', 'Patel', 'Neurologist', '555-345-6783', 'sara.p@example.com', 'Day Shift', 18, 350.00, 9),
(24, 'Alex', 'Kim', 'Gastroenterologist', '555-456-7894', 'alex.k@example.com', 'Night Shift', 10, 280.00, 10);

-- Inserting data in the Appointment table
INSERT INTO Appointment(Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status, Reason_of_Visit)
VALUES
(1, 1, 1, '2024-11-01', '09:00:00', 'Completed', 'Regular check-up'),
(2, 2, 2, '2024-11-02', '10:30:00', 'Scheduled', 'Knee pain evaluation'),
(3, 3, 3, '2024-11-03', '11:15:00', 'Completed', 'Routine vaccination'),
(4, 4, 4, '2024-11-04', '14:00:00', 'Cancelled', 'Headache and dizziness'),
(5, 5, 5, '2024-11-05', '16:00:00', 'Scheduled', 'Breast cancer screening'),
(6, 6, 6, '2024-11-06', '09:30:00', 'Scheduled', 'Skin rash examination'),
(7, 7, 7, '2024-11-07', '11:00:00', 'Completed', 'Stomach pain evaluation'),
(8, 8, 8, '2024-11-08', '13:15:00', 'Completed', 'Anxiety and stress management'),
(9, 9, 9, '2024-11-09', '15:45:00', 'Scheduled', 'Hearing loss assessment'),
(10, 10, 10, '2024-11-10', '17:30:00', 'Completed', 'Vision check-up'),
(11, 11, 11, '2024-11-11', '08:45:00', 'Completed', 'Kidney stone treatment'),
(12, 12, 12, '2024-11-12', '10:00:00', 'Scheduled', 'Chronic cough evaluation'),
(13, 13, 13, '2024-11-13', '12:15:00', 'Completed', 'X-ray for chest pain'),
(14, 14, 14, '2024-11-14', '14:30:00', 'Scheduled', 'Arthritis pain management'),
(15, 15, 15, '2024-11-15', '16:45:00', 'Completed', 'Thyroid disorder assessment'),
(16, 16, 11, '2024-11-16', '09:00:00', 'Completed', 'Follow-up for kidney stone treatment'),
(17, 17, 12, '2024-11-17', '11:30:00', 'Scheduled', 'Asthma attack evaluation'),
(18, 18, 14, '2024-11-18', '13:45:00', 'Completed', 'Chronic arthritis check-up'),
(19, 19, 15, '2024-11-19', '16:15:00', 'Scheduled', 'Routine thyroid assessment'),
(20, 20, 16, '2024-11-20', '08:30:00', 'Completed', 'Knee pain evaluation'),
(21, 21, 15, '2024-11-21', '09:15:00', 'Completed', 'Cholesterol level monitoring'),
(22, 22, 11, '2024-11-22', '10:45:00', 'Scheduled', 'Routine check-up'),
(23, 23, 13, '2024-11-23', '12:30:00', 'Completed', 'Heart condition assessment'),
(24, 24, 12, '2024-11-24', '14:00:00', 'Scheduled', 'Allergy evaluation'),
(25, 25, 16, '2024-11-25', '16:30:00', 'Completed', 'Diabetes management'),
(26, 26, 11, '2024-11-26', '08:45:00', 'Completed', 'Migraine treatment follow-up'),
(27, 27, 14, '2024-11-27', '11:00:00', 'Scheduled', 'General health check-up'),
(28, 28, 14, '2024-11-28', '13:15:00', 'Completed', 'Joint pain management'),
(29, 29, 12, '2024-11-29', '15:45:00', 'Completed', 'Asthma control evaluation'),
(30, 30, 15, '2024-11-30', '17:00:00', 'Scheduled', 'Annual physical exam'),
(31, 31, 3, '2024-11-16', '09:00:00', 'Scheduled', 'Anxiety treatment consultation'), -- Doctor 3
(32, 32, 7, '2024-11-17', '10:30:00', 'Completed', 'Asthma control evaluation'), -- Doctor 7
(33, 33, 5, '2024-11-18', '12:00:00', 'Scheduled', 'Allergy testing'), -- Doctor 5
(34, 34, 1, '2024-11-19', '14:15:00', 'Completed', 'Check-up for hypertension'), -- Doctor 1
(35, 35, 12, '2024-11-20', '16:00:00', 'Scheduled', 'Consultation for depression'), -- Doctor 12
(36, 36, 2, '2024-11-21', '09:45:00', 'Completed', 'Back pain management'), -- Doctor 2
(37, 37, 14, '2024-11-22', '11:00:00', 'Scheduled', 'Migraine evaluation'), -- Doctor 14
(38, 38, 11, '2024-11-23', '13:30:00', 'Completed', 'Routine health check'), -- Doctor 11
(39, 39, 9, '2024-11-24', '15:00:00', 'Scheduled', 'Neurology follow-up'), -- Doctor 9
(40, 40, 8, '2024-11-25', '16:30:00', 'Completed', 'Cardiology assessment'), -- Doctor 8
(41, 41, 10, '2024-11-26', '09:00:00', 'Scheduled', 'Kidney function tests'), -- Doctor 10
(42, 42, 6, '2024-11-27', '10:30:00', 'Completed', 'Diabetes management review'), -- Doctor 6
(43, 43, 13, '2024-11-28', '12:00:00', 'Scheduled', 'Thyroid check-up'), -- Doctor 13
(44, 44, 4, '2024-11-29', '14:15:00', 'Completed', 'Weight management program'), -- Doctor 4
(45, 45, 15, '2024-11-30', '16:00:00', 'Scheduled', 'Fatigue assessment'), -- Doctor 15
(46, 46, 3, '2024-11-01', '10:00:00', 'Scheduled', 'Routine check-up'), -- Doctor 3
(47, 47, 18, '2024-11-02', '11:30:00', 'Scheduled', 'Skin rash consultation'), -- Doctor 18
(48, 48, 15, '2024-11-03', '09:45:00', 'Scheduled', 'Allergy testing'), -- Doctor 15
(49, 49, 19, '2024-11-04', '14:00:00', 'Scheduled', 'Anxiety therapy'), -- Doctor 19
(50, 50, 12, '2024-11-05', '09:30:00', 'Scheduled', 'Diabetes management'), -- Doctor 12
(51, 31, 1, '2024-11-01', '12:00:00', 'Scheduled', 'Anxiety follow-up'), -- Doctor 1 for Patient 31
(52, 32, 7, '2024-11-02', '13:00:00', 'Scheduled', 'Asthma review'), -- Doctor 7 for Patient 32
(53, 34, 4, '2024-11-03', '15:30:00', 'Scheduled', 'Weight management follow-up'), -- Doctor 4 for Patient 34
(54, 35, 6, '2024-11-04', '09:00:00', 'Scheduled', 'Depression management check'), -- Doctor 6 for Patient 35
(55, 42, 17, '2024-11-05', '11:15:00', 'Scheduled', 'Pediatric assessment for Jackson'), -- Doctor 17 for Patient 42
(56, 51, 21, '2024-11-10', '09:00:00', 'Scheduled', 'Asthma management'),             -- Doctor 21
(57, 52, 22, '2024-11-11', '10:30:00', 'Scheduled', 'Allergy testing'),                -- Doctor 22
(58, 53, 23, '2024-11-12', '11:00:00', 'Scheduled', 'Diabetes monitoring'),            -- Doctor 23
(59, 54, 15, '2024-11-13', '14:30:00', 'Scheduled', 'Back pain consultation'),         -- Doctor 15
(60, 55, 16, '2024-11-14', '15:45:00', 'Scheduled', 'Blood pressure check'),           -- Doctor 16
(61, 56, 17, '2024-11-15', '08:30:00', 'Scheduled', 'Routine check-up'),               -- Doctor 17
(62, 57, 13, '2024-11-16', '13:00:00', 'Scheduled', 'Arthritis pain management'),      -- Doctor 13
(63, 58, 12, '2024-11-17', '09:15:00', 'Scheduled', 'Ulcer treatment'),                -- Doctor 12
(64, 59, 11, '2024-11-18', '10:45:00', 'Scheduled', 'Migraine assessment'),            -- Doctor 11
(65, 60, 14, '2024-11-19', '11:30:00', 'Scheduled', 'General check-up'),  
(66, 31, 1, '2024-11-20', '12:00:00', 'Scheduled', 'Anxiety follow-up'),               -- Doctor 1 for Patient 31
(67, 32, 7, '2024-11-21', '13:30:00', 'Scheduled', 'Asthma review'),                   -- Doctor 7 for Patient 32
(68, 34, 4, '2024-11-22', '15:00:00', 'Scheduled', 'Weight management follow-up'),     -- Doctor 4 for Patient 34
(69, 35, 6, '2024-11-23', '09:30:00', 'Scheduled', 'Depression management check'),     -- Doctor 6 for Patient 35
(70, 42, 17, '2024-11-24', '11:45:00', 'Scheduled', 'Pediatric assessment for Jackson'); 

-- Inserting data in the Billing table
INSERT INTO Billing (Billing_ID, Appointment_ID, Patient_ID, Total_Amount, Payment_Method, Billing_Date, Payment_Status)
VALUES
(1, 1, 1, 250.00, 'Credit Card', '2024-11-01', 'Paid'),
(2, 2, 2, 300.00, 'Cash', '2024-11-02', 'Unpaid'),
(3, 3, 3, 200.00, 'Insurance', '2024-11-03', 'Paid'),
(4, 4, 4, 350.00, 'Credit Card', '2024-11-04', 'Refunded'),
(5, 5, 5, 400.00, 'Credit Card', '2024-11-05', 'Pending'),
(6, 6, 6, 150.00, 'Insurance', '2024-11-06', 'Pending'),
(7, 7, 7, 280.00, 'Debit Card', '2024-11-07', 'Paid'),
(8, 8, 8, 300.00, 'Cash', '2024-11-08', 'Paid'),
(9, 9, 9, 180.00, 'Credit Card', '2024-11-09', 'Pending'),
(10, 10, 10, 220.00, 'Insurance', '2024-11-10', 'Unpaid'),
(11, 11, 11, 260.00, 'Credit Card', '2024-11-11', 'Paid'),
(12, 12, 12, 320.00, 'Cash', '2024-11-12', 'Pending'),
(13, 13, 13, 280.00, 'Insurance', '2024-11-13', 'Paid'),
(14, 14, 14, 310.00, 'Debit Card', '2024-11-14', 'Unpaid'),
(15, 15, 15, 350.00, 'Credit Card', '2024-11-15', 'Paid'),
(16, 16, 16, 260.00, 'Debit Card', '2024-11-16', 'Paid'),
(17, 17, 17, 320.00, 'Insurance', '2024-11-17', 'Pending'),
(18, 18, 18, 310.00, 'Cash', '2024-11-18', 'Paid'),
(19, 19, 19, 350.00, 'Credit Card', '2024-11-19', 'Paid'),
(20, 20, 20, 275.00, 'Insurance', '2024-11-20', 'Unpaid'),
(21, 21, 21, 350.00, 'Insurance', '2024-11-21', 'Paid'),
(22, 22, 22, 260.00, 'Credit Card', '2024-11-22', 'Pending'),
(23, 23, 23, 280.00, 'Cash', '2024-11-23', 'Paid'),
(24, 24, 24, 320.00, 'Debit Card', '2024-11-24', 'Unpaid'),
(25, 25, 25, 275.00, 'Insurance', '2024-11-25', 'Paid'),
(26, 26, 26, 260.00, 'Credit Card', '2024-11-26', 'Paid'),
(27, 27, 27, 310.00, 'Cash', '2024-11-27', 'Pending'),
(28, 28, 28, 310.00, 'Insurance', '2024-11-28', 'Paid'),
(29, 29, 29, 320.00, 'Debit Card', '2024-11-29', 'Paid'),
(30, 30, 30, 350.00, 'Credit Card', '2024-11-30', 'Unpaid'),
(31, 31, 31, 270.00, 'Insurance', '2024-11-16', 'Pending'),
(32, 32, 32, 320.00, 'Credit Card', '2024-11-17', 'Paid'),
(33, 33, 33, 280.00, 'Cash', '2024-11-18', 'Unpaid'),
(34, 34, 34, 310.00, 'Debit Card', '2024-11-19', 'Paid'),
(35, 35, 35, 350.00, 'Credit Card', '2024-11-20', 'Pending'),
(36, 36, 36, 270.00, 'Insurance', '2024-11-21', 'Paid'),
(37, 37, 37, 290.00, 'Cash', '2024-11-22', 'Unpaid'),
(38, 38, 38, 300.00, 'Credit Card', '2024-11-23', 'Paid'),
(39, 39, 39, 330.00, 'Debit Card', '2024-11-24', 'Pending'),
(40, 40, 40, 360.00, 'Insurance', '2024-11-25', 'Paid'),
(41, 41, 41, 280.00, 'Cash', '2024-11-26', 'Unpaid'),
(42, 42, 42, 320.00, 'Credit Card', '2024-11-27', 'Paid'),
(43, 43, 43, 310.00, 'Debit Card', '2024-11-28', 'Pending'),
(44, 44, 44, 300.00, 'Insurance', '2024-11-29', 'Paid'),
(45, 45, 45, 350.00, 'Cash', '2024-11-30', 'Unpaid'),
(46, 46, 46, 150.00, 'Insurance', '2024-11-01', 'Pending'),  -- Billing for Patient 46
(47, 47, 47, 300.00, 'Credit Card', '2024-11-02', 'Paid'),    -- Billing for Patient 47
(48, 48, 48, 200.00, 'Cash', '2024-11-03', 'Unpaid'),         -- Billing for Patient 48
(49, 49, 49, 250.00, 'Insurance', '2024-11-04', 'Paid'),     -- Billing for Patient 49
(50, 50, 50, 350.00, 'Credit Card', '2024-11-05', 'Pending'), -- Billing for Patient 50
(51, 51, 31, 100.00, 'Insurance', '2024-11-01', 'Paid'),     -- Billing for Patient 31
(52, 52, 32, 150.00, 'Debit Card', '2024-11-02', 'Pending'),  -- Billing for Patient 32
(53, 53, 34, 200.00, 'Credit Card', '2024-11-03', 'Paid'),    -- Billing for Patient 34
(54, 54, 35, 120.00, 'Cash', '2024-11-04', 'Unpaid'),         -- Billing for Patient 35
(55, 56, 51, 150.00, 'Insurance', '2024-11-10', 'Pending'),  -- Billing for Patient 51
(56, 57, 52, 180.00, 'Credit Card', '2024-11-11', 'Paid'),   -- Billing for Patient 52
(57, 58, 53, 200.00, 'Cash', '2024-11-12', 'Unpaid'),        -- Billing for Patient 53
(58, 59, 54, 250.00, 'Debit Card', '2024-11-13', 'Pending'), -- Billing for Patient 54
(59, 60, 55, 300.00, 'Insurance', '2024-11-14', 'Paid'),     -- Billing for Patient 55
(60, 61, 56, 120.00, 'Credit Card', '2024-11-15', 'Paid'),   -- Billing for Patient 56
(61, 62, 57, 350.00, 'Insurance', '2024-11-16', 'Pending'),  -- Billing for Patient 57
(62, 63, 58, 275.00, 'Cash', '2024-11-17', 'Paid'),          -- Billing for Patient 58
(63, 64, 59, 220.00, 'Debit Card', '2024-11-18', 'Unpaid'),  -- Billing for Patient 59
(64, 65, 60, 150.00, 'Credit Card', '2024-11-19', 'Paid'),   -- Billing for Patient 60
(65, 66, 31, 100.00, 'Insurance', '2024-11-20', 'Paid'),     -- Billing for Patient 31
(66, 67, 32, 150.00, 'Debit Card', '2024-11-21', 'Pending'), -- Billing for Patient 32
(67, 68, 34, 200.00, 'Credit Card', '2024-11-22', 'Paid'),   -- Billing for Patient 34
(68, 69, 35, 120.00, 'Cash', '2024-11-23', 'Unpaid'),        -- Billing for Patient 35
(69, 70, 42, 250.00, 'Insurance', '2024-11-24', 'Paid');   

-- Insertion of data in the Laboratory table
INSERT INTO Laboratory (Lab_Test_ID, Patient_ID, Appointment_ID, Test_Type, Test_Date, Test_Charges, Test_Result)
VALUES
(1, 1, 1, 'Blood Test', '2024-11-01', 50.00, 'Normal'),
(2, 2, 2, 'X-Ray', '2024-11-02', 75.00, 'Fracture detected'),
(3, 3, 3, 'Urine Test', '2024-11-03', 30.00, 'No abnormalities'),
(4, 4, 4, 'MRI', '2024-11-04', 500.00, 'Scan cancelled'),
(5, 5, 5, 'Biopsy', '2024-11-05', 450.00, 'Pending analysis'),
(6, 6, 6, 'Allergy Test', '2024-11-06', 60.00, 'Positive for pollen'),
(7, 7, 7, 'Endoscopy', '2024-11-07', 300.00, 'Gastritis detected'),
(8, 8, 8, 'Blood Test', '2024-11-08', 40.00, 'High cortisol levels'),
(9, 9, 9, 'Audiometry', '2024-11-09', 70.00, 'Mild hearing loss'),
(10, 10, 10, 'Eye Exam', '2024-11-10', 100.00, '20/40 vision'),
(11, 11, 11, 'Urine Test', '2024-11-11', 45.00, 'Calcium oxalate crystals found'),
(12, 12, 12, 'Lung Function Test', '2024-11-12', 80.00, 'Reduced lung capacity'),
(13, 13, 13, 'X-ray', '2024-11-13', 100.00, 'No fractures detected'),
(14, 14, 14, 'Blood Test', '2024-11-14', 55.00, 'High inflammatory markers'),
(15, 15, 15, 'Hormone Test', '2024-11-15', 75.00, 'Elevated TSH levels'),
(16, 16, 16, 'Urine Test', '2024-11-16', 45.00, 'Normal'),
(17, 17, 17, 'Lung Function Test', '2024-11-17', 80.00, 'Improved function with inhaler use'),
(18, 18, 18, 'Blood Test', '2024-11-18', 55.00, 'Elevated inflammatory markers'),
(19, 19, 19, 'Hormone Test', '2024-11-19', 75.00, 'Stable TSH levels'),
(20, 20, 20, 'X-ray', '2024-11-20', 100.00, 'Early signs of osteoarthritis'),
(21, 21, 21, 'Blood Test', '2024-11-21', 55.00, 'High LDL cholesterol'),
(22, 22, 22, 'Urine Test', '2024-11-22', 45.00, 'Normal'),
(23, 23, 23, 'Echocardiogram', '2024-11-23', 150.00, 'Mild arrhythmia'),
(24, 24, 24, 'Allergy Test', '2024-11-24', 90.00, 'Positive for pollen allergy'),
(25, 25, 25, 'Blood Glucose Test', '2024-11-25', 60.00, 'Stable glucose levels'),
(26, 26, 26, 'MRI Scan', '2024-11-26', 200.00, 'No abnormalities found'),
(27, 27, 27, 'X-ray', '2024-11-27', 100.00, 'Normal results'),
(28, 28, 28, 'Blood Test', '2024-11-28', 55.00, 'High inflammatory markers'),
(29, 29, 29, 'Pulmonary Function Test', '2024-11-29', 80.00, 'Moderate improvement with treatment'),
(30, 30, 30, 'Complete Blood Count', '2024-11-30', 70.00, 'All parameters normal'),
(31, 31, 31, 'Mental Health Assessment', '2024-11-16', 150.00, 'Anxiety diagnosed'),
(32, 32, 32, 'Pulmonary Function Test', '2024-11-17', 80.00, 'Asthma control adequate'),
(33, 33, 33, 'Allergy Skin Test', '2024-11-18', 100.00, 'Positive for pollen'),
(34, 34, 34, 'Blood Pressure Monitoring', '2024-11-19', 55.00, 'Hypertension confirmed'),
(35, 35, 35, 'Depression Screening', '2024-11-20', 75.00, 'Moderate depression'),
(36, 36, 36, 'Physical Examination', '2024-11-21', 120.00, 'Back pain issues noted'),
(37, 37, 37, 'Migraine Assessment', '2024-11-22', 60.00, 'Migraine triggers identified'),
(38, 38, 38, 'Routine Blood Test', '2024-11-23', 40.00, 'Normal results'),
(39, 39, 39, 'Neurological Evaluation', '2024-11-24', 150.00, 'Follow-up needed'),
(40, 40, 40, 'Cardiac Stress Test', '2024-11-25', 200.00, 'Stable condition'),
(41, 41, 41, 'Kidney Function Test', '2024-11-26', 90.00, 'Slightly impaired function'),
(42, 42, 42, 'HbA1c Test', '2024-11-27', 55.00, 'Poor glycemic control'),
(43, 43, 43, 'TSH Test', '2024-11-28', 45.00, 'Elevated TSH levels'),
(44, 44, 44, 'Weight Check', '2024-11-29', 30.00, 'Obesity confirmed'),
(45, 45, 45, 'Fatigue Assessment', '2024-11-30', 75.00, 'Causes to be explored'),
(46, 46, 46, 'Routine Blood Test', '2024-11-01', 50.00, 'Normal results'),     -- Lab test for Patient 46
(47, 47, 47, 'Skin Biopsy', '2024-11-02', 120.00, 'Benign lesion confirmed'),   -- Lab test for Patient 47
(48, 48, 48, 'Allergy Skin Test', '2024-11-03', 80.00, 'Positive for peanuts'),  -- Lab test for Patient 48
(49, 49, 49, 'Mental Health Assessment', '2024-11-04', 150.00, 'Anxiety diagnosed'),
(50, 31, 51, 'Follow-up Blood Test', '2024-11-01', 50.00, 'Stable results'),  -- Lab test for Patient 31
(51, 32, 52, 'Pulmonary Function Test', '2024-11-02', 80.00, 'Asthma control adequate'),
(52, 51, 56, 'Pulmonary Function Test', '2024-11-10', 80.00, 'Mild restriction'),           -- Lab test for Patient 51, Appointment 56
(53, 53, 66, 'Blood Sugar Test', '2024-11-12', 40.00, 'High glucose level detected'),       -- Lab test for Patient 53, Appointment 66
(54, 54, 69, 'X-ray', '2024-11-13', 120.00, 'No abnormalities found'),                      -- Lab test for Patient 54, Appointment 69
(55, 57, 55, 'Rheumatoid Factor Test', '2024-11-16', 70.00, 'Positive result'),             -- Lab test for Patient 57, Appointment 55
(56, 58, 70, 'H. Pylori Test', '2024-11-17', 50.00, 'Negative result');                     -- Lab test for Patient 58, Appointment 70

-- Insertion in the Prescription table
INSERT INTO Prescription (Prescription_ID, Appointment_ID, Doctor_ID, Patient_ID, Medicine_Details, Prescription_Date)
VALUES
(1, 1, 1, 1, 'Atorvastatin 20mg once daily', '2024-11-01'),
(2, 2, 2, 2, 'Ibuprofen 400mg as needed', '2024-11-02'),
(3, 3, 3, 3, 'Paracetamol 250mg for fever', '2024-11-03'),
(4, 4, 4, 4, 'Sumatriptan 50mg for migraine', '2024-11-04'),
(5, 5, 5, 5, 'Tamoxifen 20mg once daily', '2024-11-05'),
(6, 6, 6, 6, 'Hydrocortisone cream 2.5% for rash', '2024-11-06'),
(7, 7, 7, 7, 'Omeprazole 20mg for stomach pain', '2024-11-07'),
(8, 8, 8, 8, 'Sertraline 50mg for anxiety', '2024-11-08'),
(9, 9, 9, 9, 'Ear drops for ear infection', '2024-11-09'),
(10, 10, 10, 10, 'Prescription glasses for vision correction', '2024-11-10'),
(11, 11, 11, 11, 'Tamsulosin 0.4mg daily for kidney stones', '2024-11-11'),
(12, 12, 12, 12, 'Albuterol inhaler as needed for cough', '2024-11-12'),
(13, 13, 13, 13, 'Ibuprofen 400mg for chest pain', '2024-11-13'),
(14, 14, 14, 14, 'Methotrexate 15mg weekly for arthritis', '2024-11-14'),
(15, 15, 15, 15, 'Levothyroxine 75mcg daily for thyroid', '2024-11-15'),
(16, 16, 11, 16, 'Tamsulosin 0.4mg daily, continue hydration', '2024-11-16'),
(17, 17, 12, 17, 'Fluticasone inhaler, use twice daily', '2024-11-17'),
(18, 18, 14, 18, 'Ibuprofen 800mg for arthritis pain, as needed', '2024-11-18'),
(19, 19, 15, 19, 'Levothyroxine 75mcg daily, routine check-ups', '2024-11-19'),
(20, 20, 16, 20, 'Physical therapy and acetaminophen for knee pain', '2024-11-20'),
(21, 21, 15, 21, 'Atorvastatin 20mg daily for cholesterol', '2024-11-21'),
(22, 22, 11, 22, 'Multivitamins for general wellness', '2024-11-22'),
(23, 23, 13, 23, 'Aspirin 81mg daily for heart health', '2024-11-23'),
(24, 24, 12, 24, 'Cetirizine 10mg daily for allergies', '2024-11-24'),
(25, 25, 16, 25, 'Metformin 500mg twice daily for diabetes', '2024-11-25'),
(26, 26, 11, 26, 'Sumatriptan 50mg for migraines as needed', '2024-11-26'),
(27, 27, 14, 27, 'Vitamin D supplements', '2024-11-27'),
(28, 28, 14, 28, 'Methotrexate 15mg weekly for arthritis', '2024-11-28'),
(29, 29, 12, 29, 'Albuterol inhaler for asthma control', '2024-11-29'),
(30, 30, 15, 30, 'Daily multivitamin and lifestyle recommendations', '2024-11-30'),
(31, 46, 3, 31, 'Amoxicillin 500 mg, 1 capsule three times a day for 7 days', '2024-11-01'),  -- Prescription for Patient 31
(32, 46, 18, 32, 'Cetirizine 10 mg, 1 tablet once daily', '2024-11-02'),                   -- Prescription for Patient 32
(33, 46, 15, 34, 'Metformin 500 mg, 1 tablet twice daily', '2024-11-03'),                 -- Prescription for Patient 34
(34, 47, 19, 35, 'Fluoxetine 20 mg, 1 capsule daily', '2024-11-04'),                     -- Prescription for Patient 35
(35, 48, 12, 36, 'Ibuprofen 400 mg, 1 tablet every 6 hours as needed', '2024-11-05'),    -- Prescription for Patient 36
(36, 49, 10, 37, 'Simvastatin 20 mg, 1 tablet at bedtime', '2024-11-06'),                -- Prescription for Patient 37
(37, 50, 5, 38, 'Levothyroxine 75 mcg, 1 tablet every morning', '2024-11-07'),           -- Prescription for Patient 38
(38, 51, 8, 39, 'Albuterol Inhaler, 2 puffs every 4-6 hours as needed', '2024-11-08'),   -- Prescription for Patient 39
(39, 52, 4, 40, 'Omeprazole 20 mg, 1 tablet before breakfast', '2024-11-09'),            -- Prescription for Patient 40
(40, 53, 6, 41, 'Hydrochlorothiazide 25 mg, 1 tablet daily', '2024-11-10'),              -- Prescription for Patient 41
(41, 54, 2, 42, 'Lisinopril 10 mg, 1 tablet daily', '2024-11-11'),                       -- Prescription for Patient 42
(42, 55, 7, 43, 'Amlodipine 5 mg, 1 tablet daily', '2024-11-12'),                       -- Prescription for Patient 43
(43, 56, 1, 44, 'Bupropion 150 mg, 1 tablet daily', '2024-11-13'),                      -- Prescription for Patient 44
(44, 57, 16, 45, 'Mometasone Nasal Spray, 2 sprays in each nostril once daily', '2024-11-14'), -- Prescription for Patient 45
(45, 58, 13, 46, 'Clopidogrel 75 mg, 1 tablet daily', '2024-11-15'),    
(46, 46, 3, 46, 'Loratadine 10mg daily for allergies', '2024-11-01'),     -- Prescription for Patient 46
(47, 47, 18, 47, 'Hydrocortisone cream for skin rash', '2024-11-02'),     -- Prescription for Patient 47
(48, 48, 15, 48, 'Cetirizine 10mg for allergy relief', '2024-11-03'),    -- Prescription for Patient 48
(49, 49, 19, 49, 'Fluoxetine 20mg for anxiety', '2024-11-04'),           -- Prescription for Patient 49
(50, 51, 1, 31, 'Sertraline 50mg for anxiety', '2024-11-01'),   -- Prescription for Patient 31
(51, 52, 7, 32, 'Albuterol inhaler for asthma', '2024-11-02'),
(52, 56, 3, 51, 'Salbutamol Inhaler, 100 mcg, 2 puffs as needed', '2024-11-10'),  -- Prescription for Patient 51, Appointment 56, Doctor 3
(53, 66, 12, 53, 'Metformin, 500 mg, Twice daily', '2024-11-12'),              -- Prescription for Patient 53, Appointment 66, Doctor 12
(54, 69, 5, 54, 'Ibuprofen, 200 mg, Every 6 hours as needed', '2024-11-13'),   -- Prescription for Patient 54, Appointment 69, Doctor 5
(55, 55, 16, 57, 'Methotrexate, 7.5 mg, Once weekly', '2024-11-01'),          -- Prescription for Patient 57, Appointment 55, Doctor 16
(56, 70, 1, 58, 'Amoxicillin, 500 mg, Three times daily', '2024-11-17'); 


