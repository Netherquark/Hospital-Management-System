## Dependencies
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install --lts
node -v
npm -v
npm install -g react-devtools

not sure if you can use Vite/Bootstrap/MySQL2 that's already in the repo, let's see.

## Steps to get started
1. Clone this repo
2. cd appropriately and then:
   - **Terminal 1:**
     ```
     node server.js
     ```
   - **Terminal 2:**
     ```bash
     npm run dev
     ```

## Steps to Replicate

### Front-end

1. Create a new Vite project with React template:
   ```bash
   npm create vite@latest hms-website --template react
   ```

2. Change directory to the project folder:
   ```bash
   cd hms-website
   ```

3. Install project dependencies:
   ```bash
   npm install
   ```

4. Install Bootstrap:
   ```bash
   npm install bootstrap
   ```

5. Add Bootstrap CSS to your project. Open `hms-website/src/main.jsx` and add the following line:
   ```javascript
   import 'bootstrap/dist/css/bootstrap.min.css';
   ```

### Back-end

1. Navigate back to the root directory:
   ```bash
   cd ..
   ```

2. Create a new server directory and change to it:
   ```bash
   mkdir server
   cd server
   ```

3. Initialize a new Node.js project:
   ```bash
   npm init -y
   ```

4. Install required packages:
   ```bash
   npm install express mysql2
   ```

5. Create a server file and add the following code to `server/server.js`:
   ```javascript
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
   ```

### Reference Code for MySQL Connection

Add the following code for MySQL connection in your server file:
```javascript
const mysql = require('mysql2');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'your_database'
});

db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL Database!');
});
```

### To Run the Application

- **Terminal 1:** Start your server.
- **Terminal 2:** Run the front-end:
  ```bash
  npm run dev
  ```
