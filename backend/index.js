const express = require('express');
const { Pool } = require('pg');
require('dotenv').config();
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;


app.use(cors())


const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.get('/birds', async (req, res) => {
  try {
    const result = await pool.query(`SELECT 
    Birds.Id AS BirdID,
    json_build_object(
        'Name', Species.Name
    ) AS Species,
    json_build_object(
        'Location', Observations.Location,
        'Observation_date', Observations.Observation_date,
        'Notes', Observations.Notes
    ) AS Observation
FROM
    Birds
LEFT JOIN 
    Observations ON Birds.Id = Observations.Bird_id
JOIN 
    Species ON Birds.Specie_id = Species.Id;
`);
    res.json(result.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Something went wrong');
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
