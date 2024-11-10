DELIMITER //

CREATE PROCEDURE AuthenticateDoctor(IN doc_id INT, IN entered_pass VARCHAR(64))
BEGIN
    DECLARE stored_hash VARCHAR(64);

    -- Retrieve the stored hashed password for the given doctor ID
    SELECT Password INTO stored_hash
    FROM Doctor
    WHERE Doctor_ID = doc_id;

    -- Compare the entered password (hashed) with the stored hashed password
    IF stored_hash = SHA2(entered_pass, 256) THEN
        -- Passwords match, login successful
        SELECT 'Login successful' AS message;
    ELSE
        -- Passwords don't match, login failed
        SELECT 'Invalid credentials' AS message;
    END IF;
END //

DELIMITER ;



-- Adding Patient Procedure
DELIMITER //
CREATE PROCEDURE RegisterPatient(
    IN patient_id INT, IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN dob DATE, 
    IN gender VARCHAR(10), IN address TEXT, IN phone_number VARCHAR(15), IN email VARCHAR(50), 
    IN emergency_contact VARCHAR(15), IN insurance_details TEXT, IN medical_history TEXT
)
BEGIN
    START TRANSACTION;
    INSERT INTO Patient 
        (Patient_ID, First_Name, Last_Name, Date_of_Birth, Gender, Address, Phone_Number, Email, Emergency_Contact, Insurance_Details, Medical_History)
    VALUES 
        (patient_id, first_name, last_name, dob, gender, address, phone_number, email, emergency_contact, insurance_details, medical_history);
    COMMIT;
END //
DELIMITER ;

-- Booking Appointment Procedure
DELIMITER //
CREATE PROCEDURE ScheduleAppointment(
    IN appointment_id INT, IN patient_id INT, IN doctor_id INT, IN appointment_date DATE, 
    IN appointment_time TIME, IN reason_of_visit TEXT
)
BEGIN
    DECLARE conflict INT DEFAULT 0;

    -- Check for time conflicts
    SELECT COUNT(*) INTO conflict 
    FROM Appointment 
    WHERE Doctor_ID = doctor_id AND Appointment_Date = appointment_date AND Appointment_Time = appointment_time;

    -- If no conflict, proceed
    IF conflict = 0 THEN
        START TRANSACTION;
        INSERT INTO Appointment 
            (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status, Reason_of_Visit)
        VALUES 
            (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, 'Scheduled', reason_of_visit);
        COMMIT;
    ELSE
        ROLLBACK;
        -- An error message can be generated in the backend if needed
    END IF;
END //
DELIMITER ;

-- Cancelling Appointment Procedure
DELIMITER //
CREATE PROCEDURE CancelPatientAppointment(IN appointment_id INT)
BEGIN
    UPDATE Appointment
    SET Status = 'Cancelled'
    WHERE Appointment_ID = appointment_id AND Status != 'Completed';
END //
DELIMITER ;

-- Checking Appointment History Procedure
DELIMITER //
CREATE PROCEDURE PatientAppointmentHistory(IN patient_id INT, IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT * 
    FROM Appointment
    WHERE Patient_ID = patient_id AND Appointment_Date BETWEEN start_date AND end_date
    ORDER BY Appointment_Date DESC;
END //
DELIMITER ;

-- Removing Existing Doctor 
DELIMITER //
CREATE PROCEDURE RemoveExistingDoctor(IN doc_id INT)
BEGIN
    -- Remove related billing records
    DELETE FROM Billing
    WHERE Appointment_ID IN (SELECT Appointment_ID FROM Appointment WHERE Doctor_ID = doc_id);

    -- Remove appointments for the doctor
    DELETE FROM Appointment
    WHERE Doctor_ID = doc_id;

    -- Remove the doctor
    DELETE FROM Doctor
    WHERE Doctor_ID = doc_id;

    COMMIT;
END //

DELIMITER ;

-- Changing Doctor Password
DELIMITER //

CREATE PROCEDURE ChangeDoctorPasswords(
    IN doc_id INT,
    IN old_pass VARCHAR(64),
    IN new_pass VARCHAR(64)
)
BEGIN
    DECLARE stored_hash VARCHAR(64);
    DECLARE doctor_exists INT DEFAULT 0;

    -- Check if doctor exists
    SELECT COUNT(*) INTO doctor_exists
    FROM Doctor
    WHERE Doctor_ID = doc_id;

    IF doctor_exists = 0 THEN
        -- Doctor not found, exit procedure
        SELECT 'Doctor ID not found' AS message;
    ELSE
        -- Retrieve the stored hashed password
        SELECT Password INTO stored_hash
        FROM Doctor
        WHERE Doctor_ID = doc_id;

        -- Compare entered old password with stored hashed password
        IF stored_hash = SHA2(old_pass, 256) THEN
            -- Update password if the old password matches
            UPDATE Doctor
            SET Password = SHA2(new_pass, 256)
            WHERE Doctor_ID = doc_id;
            SELECT 'Password changed successfully' AS message;
        ELSE
            -- Old password is incorrect
            SELECT 'Old password is incorrect' AS message;
        END IF;
    END IF;
END //

DELIMITER ;

-- Daily Total Revenue  
DELIMITER //

CREATE PROCEDURE DailyTotalRevenue()
BEGIN
    SELECT 
        Billing_Date AS RevenueDate,
        SUM(Total_Amount) AS TotalRevenue
    FROM 
        Billing
    GROUP BY 
        RevenueDate
    ORDER BY 
        RevenueDate DESC;
END //

-- Monthly Appointment of each department  
DELIMITER ;
CREATE PROCEDURE MonthlyAppointmentsByDepartment()
BEGIN
    SELECT 
        d.Department_Name AS Department,
        DATE_FORMAT(a.Appointment_Date, '%Y-%m') AS Month,
        COUNT(a.Appointment_ID) AS TotalAppointments
    FROM 
        Appointment a
    JOIN 
        Doctor doc ON a.Doctor_ID = doc.Doctor_ID
    JOIN 
        Department d ON doc.Department_ID = d.Department_ID
    GROUP BY 
        d.Department_Name, Month
    ORDER BY 
        Month DESC, Department;
END //

-- Functions for retrieving appointment history for patients 
DELIMITER //

CREATE PROCEDURE GetPatientAppointmentHistory(IN p_PatientID INT)
BEGIN
    SELECT 
        a.Appointment_ID,
        a.Appointment_Date,
        a.Appointment_Time,
        a.Status,
        a.Reason_of_Visit,
        CONCAT(d.First_Name, ' ', d.Last_Name) AS Doctor_Name,
        d.Specialization AS Doctor_Specialization,
        d.Contact_Number AS Doctor_Contact
    FROM 
        Appointment a
    INNER JOIN 
        Doctor d ON a.Doctor_ID = d.Doctor_ID
    WHERE 
        a.Patient_ID = p_PatientID
    ORDER BY 
        a.Appointment_Date DESC, a.Appointment_Time DESC;
END //

DELIMITER ;
