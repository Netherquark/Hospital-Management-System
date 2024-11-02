// Pre requisites:
// Install nodejs, mysql-server, mysql2

const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(express.json());

// Example route
app.get('/', (req, res) => {
    res.send('Hello from the server!');
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

// MySQL connection:
const mysql = require('mysql2/promise');

async function connectAndQuery() {
    try {
        const db = await mysql.createConnection({
            host: 'localhost', // Replace it with your host name
            user: 'root', // Replace it with the user name
            password: '12345678', // Replace it with your password 
            database: 'test' // Replace it with the actual database name
// All of the above creds were used to test if its working. Has to be changed during the actual run.            
        });
        console.log('Connected to MySQL Database!'); 


        await db.end(); // Closes the Database connection. Can be commented out if not needed
        console.log('Database connection closed.');
    } catch (error) {
        console.error('Database error:', error.message);
    }
}

connectAndQuery();
