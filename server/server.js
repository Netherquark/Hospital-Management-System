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
    password: 'asche%2365', // Replace with your MySQL password
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


// Register Patient
app.post('/register-patient', (req, res) => {
    const {
        patient_id, first_name, last_name, dob, gender,
        address, phone_number, email, emergency_contact,
        insurance_details, medical_history
    } = req.body;

    const query = `CALL RegisterPatient(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
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

    const query = `CALL ScheduleAppointment(?, ?, ?, ?, ?, ?)`;
    db.query(query, [appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_of_visit], (err, results) => {
        if (err) {
            console.error('Error scheduling appointment:', err);
            res.status(500).send('Error scheduling appointment');
        } else {
            res.json({ message: 'Appointment scheduled successfully!' });
        }
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

    const query = `CALL PatientAppointmentHistory(?, ?, ?)`;
    db.query(query, [patient_id, start_date, end_date], (err, results) => {
        if (err) {
            console.error('Error fetching appointment history:', err);
            res.status(500).send('Error fetching appointment history');
        } else {
            res.json(results[0] || { message: 'No appointments found' });
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

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
