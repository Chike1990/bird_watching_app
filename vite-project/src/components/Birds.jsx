import { useState, useEffect } from 'react';
import axios from 'axios';

const Birds = () => {
    const [birds, setBirds] = useState([]);

    useEffect(() => {
        const fetchBirds = async () => {
            try {
                const response = await axios.get('http://localhost:3000/birds');
                console.log(response)
                setBirds(response.data);
            } catch (error) {
                console.log(error)
            }
        };

        fetchBirds();
    }, []);

    return (
        <div>
            <h1>Birds of the sky</h1>
            <ul>
                {birds.map((bird) => (
                    <li key={bird.birdid}>
                        <h2>Species: {bird.species.Name}</h2>
                        <p>location: {bird.observation.Location}</p>
                        <p>Notes: {bird.observation.Notes} </p>
                        <p>Observation_date: {bird.observation.Observation_date}</p>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default Birds;
