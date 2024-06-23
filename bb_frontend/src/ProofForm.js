// src/components/ProofForm.js
import React, { useState } from 'react';
import axios from 'axios';

const ProofForm = () => {
  const [dob, setDob] = useState('');
  const [nationality, setNationality] = useState('');
  const [proofResult, setProofResult] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      const response = await axios.post('/api/verify-proof', {
        dob,
        nationality
      });
      setProofResult(response.data.valid ? 'Valid proof!' : 'Invalid proof.');
    } catch (error) {
      console.error('Error verifying proof:', error);
      setProofResult('Error verifying proof.');
    }
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>Date of Birth:</label>
        <input type="text" value={dob} onChange={(e) => setDob(e.target.value)} />

        <label>Nationality:</label>
        <input type="text" value={nationality} onChange={(e) => setNationality(e.target.value)} />

        <button type="submit">Verify Proof</button>
      </form>

      {proofResult && <p>{proofResult}</p>}
    </div>
  );
};

export default ProofForm;
