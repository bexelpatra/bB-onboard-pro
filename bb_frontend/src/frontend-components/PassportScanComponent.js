// Example PassportScanComponent.js
import React, { useState } from 'react';
import axios from 'axios';

const PassportScanComponent = () => {
  const [dob, setDob] = useState('');
  const [currentYear, setCurrentYear] = useState('');
  const [thresholdAge, setThresholdAge] = useState('');
  const [nationality, setNationality] = useState('');
  const [proof, setProof] = useState('');

  const handleScan = async () => {
    try {
      // Simulate scanning by setting input values
      const response = await axios.post('http://localhost:3001/api/verify-passport', {
        dob,
        current_year: currentYear,
        threshold_age: thresholdAge,
        nationality
      });
      setProof(response.data.proof);
    } catch (error) {
      console.error('Error verifying passport:', error);
      // Handle error
    }
  };

  return (
    <div>
      <h2>Passport Scan and Verification</h2>
      <label>Date of Birth:</label>
      <input type="text" value={dob} onChange={(e) => setDob(e.target.value)} /><br />
      <label>Current Year:</label>
      <input type="text" value={currentYear} onChange={(e) => setCurrentYear(e.target.value)} /><br />
      <label>Threshold Age:</label>
      <input type="text" value={thresholdAge} onChange={(e) => setThresholdAge(e.target.value)} /><br />
      <label>Nationality:</label>
      <input type="text" value={nationality} onChange={(e) => setNationality(e.target.value)} /><br />
      <button onClick={handleScan}>Verify Passport</button><br />
      <p>Proof: {proof}</p>
    </div>
  );
};

export default PassportScanComponent;
