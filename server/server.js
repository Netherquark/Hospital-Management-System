// Import MySQL package
const mysql = require('mysql2');

// Create a connection to the database
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',  // Replace with your MySQL username
    password: '12345678', // Replace with your MySQL password
    database: 'HMS' // Use the Hospital Management System database
});

// Connect to the database
db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL Database!');

    // Query to show all tables in the database
    db.query('SHOW TABLES', (err, results) => {
        if (err) throw err;

        console.log('Tables in HMS database:');
        results.forEach(row => {
            // Each row will have a table name under the key (table_name) depending on the MySQL version
            console.log(Object.values(row)[0]); 
        });

        // Close the database connection
        db.end((err) => {
            if (err) throw err;
            console.log('Connection closed.');
        });
    });
});
