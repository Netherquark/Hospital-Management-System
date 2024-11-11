const express = require('express');
const mysql = require('mysql2');
// const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Middleware for parsing JSON requests
app.use(express.json());
app.use(express.static('public'));

// Create a connection to the database
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',  // Replace with your MySQL username
    password: '12345678', // Replace with your MySQL password
    database: 'HMS' // Use the Hospital Management System database
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL Database!');
});

// Authenticate Doctor
app.post('/authenticate-doctor', (req, res) => {
    const { doc_id, password } = req.body;  // Expecting doc_id and password in the request body
    
    const query = 'SELECT Password FROM HMS.Doctor WHERE Doctor_ID = ?';
    
    db.query(query, [doc_id], (err, results) => {
        if (err) {
            console.error('Error during authentication:', err);
            return res.status(500).json({ message: 'Error authenticating doctor' });
        }
        
        if (results.length === 0) {
            // No matching doctor found for the provided Doctor_ID
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        
        const storedPassword = results[0].Password;
        
        if (password === storedPassword) {
            // Password matches
            res.status(200).json({ message: 'Login successful' });
        } else {
            // Password does not match
            res.status(401).json({ message: 'Invalid credentials' });
        }
    });
});

app.post('/authenticate-patient', (req, res) => {
    const { patient_id, password } = req.body;  // Expecting patient_id and password in the request body
    
    const query = 'SELECT Password FROM HMS.Patient WHERE Patient_ID = ?';
    
    db.query(query, [patient_id], (err, results) => {
        if (err) {
            console.error('Error during patient authentication:', err);
            return res.status(500).json({ message: 'Error authenticating patient' });
        }
        
        if (results.length === 0) {
            // No matching patient found for the provided Patient_ID
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        
        const storedPassword = results[0].Password;
        
        if (password === storedPassword) {
            // Password matches
            res.status(200).json({ message: 'Patient login successful' });
        } else {
            // Password does not match
            res.status(401).json({ message: 'Invalid credentials' });
        }
    });
});

app.post('/authenticate-admin', (req, res) => {
    const { username, password } = req.body;  // Expecting username and password in the request body
    
    const adminUsername = 'admin';
    const adminPassword = 'admin';
    
    if (username === adminUsername && password === adminPassword) {
        // Admin credentials are correct
        res.status(200).json({ message: 'Admin login successful' });
    } else {
        // Admin credentials do not match
        res.status(401).json({ message: 'Invalid credentials' });
    }
});


// Register Patient
app.post('/register-patient', (req, res) => {
    const {
        patient_id, first_name, last_name, dob, gender,
        address, phone_number, email, emergency_contact,
        insurance_details, medical_history
    } = req.body;

    const query = `INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_of_Birth, Gender, Address, Phone_Number, Email, Emergency_Contact, Insurance_Details, Medical_History) 
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    
    db.query(query, [patient_id, first_name, last_name, dob, gender, address, phone_number, email, emergency_contact, insurance_details, medical_history], (err, results) => {
        if (err) {
            console.error('Error registering patient:', err);
            res.status(500).send('Error registering patient');
        } else {
            res.json({ message: 'Patient registered successfully!' });
        }
    });
});

// Schedule Appointment
app.post('/schedule-appointment', (req, res) => {
    const {
        appointment_id, patient_id, doctor_id,
        appointment_date, appointment_time, reason_of_visit
    } = req.body;

    const checkQuery = `SELECT COUNT(*) AS conflict FROM Appointment WHERE Doctor_ID = ? AND Appointment_Date = ? AND Appointment_Time = ?`;
    db.query(checkQuery, [doctor_id, appointment_date, appointment_time], (err, results) => {
        if (err) {
            console.error('Error checking appointment conflict:', err);
            return res.status(500).send('Error checking appointment conflict');
        }

        if (results[0].conflict > 0) {
            return res.status(409).send('Appointment conflict detected');
        }

        const insertQuery = `INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date, Appointment_Time, Status, Reason_of_Visit) 
                             VALUES (?, ?, ?, ?, ?, 'Scheduled', ?)`;
        
        db.query(insertQuery, [appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_of_visit], (err, results) => {
            if (err) {
                console.error('Error scheduling appointment:', err);
                res.status(500).send('Error scheduling appointment');
            } else {
                res.json({ message: 'Appointment scheduled successfully!' });
            }
        });
    });
});


// Cancel Patient Appointment
app.post('/cancel-appointment', (req, res) => {
    const { appointment_id } = req.body;

    const query = `CALL CancelPatientAppointment(?)`;
    db.query(query, [appointment_id], (err, results) => {
        if (err) {
            console.error('Error canceling appointment:', err);
            res.status(500).send('Error canceling appointment');
        } else {
            res.json({ message: 'Appointment canceled successfully!' });
        }
    });
});

// Patient Appointment History
app.post('/appointment-history', (req, res) => {
    const { patient_id, start_date, end_date } = req.body;

    // SQL query to fetch the appointment data
    const query = `
        SELECT 
            Appointment_ID,
            Patient_ID,
            Doctor_ID,
            Appointment_Date,
            Appointment_Time,
            Status,
            Reason_of_Visit
        FROM HMS.Appointment
        WHERE Patient_ID = 34
        ORDER BY Appointment_Date DESC;
    `;

    // Query the database
    db.query(query, [patient_id, start_date, end_date], (err, results) => {
        if (err) {
            console.error('Error fetching appointment history:', err);
            res.status(500).send('Error fetching appointment history');
        } else {
            // Return the results as JSON
            res.json(results.length ? results : { message: 'No appointments found' });
        }
    });
});


// Remove Existing Doctor
app.post('/remove-doctor', (req, res) => {
    const { doc_id } = req.body;

    const query = `CALL RemoveExistingDoctor(?)`;
    db.query(query, [doc_id], (err, results) => {
        if (err) {
            console.error('Error removing doctor:', err);
            res.status(500).send('Error removing doctor');
        } else {
            res.json({ message: 'Doctor removed successfully!' });
        }
    });
});

// Change Doctor Passwords
app.post('/change-password', (req, res) => {
    const { doc_id, old_pass, new_pass } = req.body;

    const query = `CALL ChangeDoctorPasswords(?, ?, ?)`;
    db.query(query, [doc_id, old_pass, new_pass], (err, results) => {
        if (err) {
            console.error('Error changing password:', err);
            res.status(500).send('Error changing password');
        } else {
            res.json({ message: 'Password updated successfully!' });
        }
    });
});

// Daily Total Revenue 
app.get('/daily-revenue', (req, res) => {
    const query = `CALL DailyTotalRevenue()`;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching revenue:', err);
            res.status(500).send('Error fetching revenue');
        } else {
            res.json(results[0] || { message: 'No revenue data found' });
        }
    });
});

// Monthly Appointment by Department
app.get('/monthly-appointments', (req, res) => {
    const query = `CALL MonthlyAppointmentsByDepartment()`;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching appointments:', err);
            res.status(500).send('Error fetching appointments');
        } else {
            res.json(results[0] || { message: 'No appointment data found' });
        }
    });
});

// Admin Overview
app.get('/admin-overview', (req, res) => {
    const query = `SELECT * FROM Admin_HospitalOverview`;  // Querying the Admin_HospitalOverview view
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching admin overview:', err);
            res.status(500).send('Error fetching admin overview');
        } else {
            res.json(results || { message: 'No data found' });
        }
    });
});

// Get Upcoming Appointments
app.get('/upcoming-appointments', (req, res) => {
    const { startDate } = req.query; // Assuming the date is passed as a query parameter

    if (!startDate) {
        return res.status(400).json({ message: 'Start date is required' });
    }

    const query = `CALL GetUpcoming10AppointmentsFromDate(?)`;

    db.query(query, [startDate], (err, results) => {
        if (err) {
            console.error('Error fetching upcoming appointments:', err);
            return res.status(500).json({ message: 'Error fetching upcoming appointments' });
        }

        // The result set is typically returned as an array of arrays, so we access results[0]
        res.json(results[0] || { message: 'No upcoming appointments found' });
    });
});

// Get Monthly Revenue by Department
app.get('/monthly-revenue', (req, res) => {
    const { revenueMonth, revenueYear } = req.query;

    if (!revenueMonth || !revenueYear) {
        return res.status(400).json({ message: 'Both revenueMonth and revenueYear are required' });
    }

    const query = `
        SELECT 
            dep.Department_Name,
            SUM(b.Total_Amount) AS Total_Revenue
        FROM 
            Billing b
        JOIN 
            Appointment a ON b.Appointment_ID = a.Appointment_ID
        JOIN 
            Doctor d ON a.Doctor_ID = d.Doctor_ID
        JOIN 
            Department dep ON d.Department_ID = dep.Department_ID
        WHERE 
            MONTH(b.Billing_Date) = ?
            AND YEAR(b.Billing_Date) = ?
        GROUP BY 
            dep.Department_Name
        ORDER BY 
            Total_Revenue DESC;
    `;

    db.query(query, [revenueMonth, revenueYear], (err, results) => {
        if (err) {
            console.error('Error fetching monthly revenue:', err);
            return res.status(500).json({ message: 'Error fetching monthly revenue' });
        }

        res.json(results.length > 0 ? results : { message: 'No revenue data found for the specified month and year' });
    });
});

app.get('/create-admin-hospitaloverview-view', (req, res) => {
    const createViewQuery = `
        CREATE OR REPLACE VIEW Admin_HospitalOverview AS
        SELECT 
            p.Patient_ID,
            CONCAT(p.First_Name, ' ', p.Last_Name) AS Patient_Name,
            p.Date_of_Birth,
            p.Gender,
            p.Phone_Number,
            p.Email,
            
            a.Appointment_ID,
            a.Appointment_Date,
            a.Appointment_Time,
            a.Status AS Appointment_Status,
            a.Reason_of_Visit,

            CONCAT(d.First_Name, ' ', d.Last_Name) AS Doctor_Name,
            d.Specialization AS Doctor_Specialization,
            d.Contact_Number AS Doctor_Contact,
            d.Experience AS Doctor_Experience,

            b.Billing_ID,
            b.Total_Amount AS Billing_Total,
            b.Payment_Method,
            b.Billing_Date,
            b.Payment_Status

        FROM 
            Patient p
        LEFT JOIN 
            Appointment a ON p.Patient_ID = a.Patient_ID
        LEFT JOIN 
            Doctor d ON a.Doctor_ID = d.Doctor_ID
        LEFT JOIN 
            Billing b ON a.Appointment_ID = b.Appointment_ID
        ORDER BY 
            a.Appointment_Date DESC, a.Appointment_Time DESC;
    `;

    db.query(createViewQuery, (err, result) => {
        if (err) {
            console.error('Error creating view:', err);
            return res.status(500).json({ message: 'Error creating view', error: err });
        }

        res.json({ message: 'View Admin_HospitalOverview created successfully', result });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
