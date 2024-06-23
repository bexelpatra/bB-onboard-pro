// Example using Node.js and Express
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); // Import cors package
const { provePassportClaim } = require('./cairoLogic'); // Implement Cairo logic here

const app = express();
const port = 3001;

app.use(bodyParser.json());

// Use CORS middleware
app.use(cors());

app.post('/api/verify-passport', async (req, res) => {
  const { dob, current_year, threshold_age, nationality } = req.body;

  try {
    // Call Cairo logic to generate proof based on input data
    const proof = await provePassportClaim(dob, current_year, threshold_age, nationality);

    // Send the proof back to the frontend
    res.json({ proof });
  } catch (error) {
    console.error('Error generating proof:', error);
    res.status(500).json({ error: 'Error generating proof' });
  }
});

app.listen(port, () => {
  console.log(`Backend server is running on http://localhost:${port}`);
});
