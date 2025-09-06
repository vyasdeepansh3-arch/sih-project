// server.js - Backend for PM Internship Recommender

const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;
const DB_FILE = 'internships.db';

// --- Middleware ---
app.use(cors());
app.use(express.json());

// --- Database Setup ---
const db = new sqlite3.Database(DB_FILE, (err) => {
    if (err) {
        console.error("Error connecting to database:", err.message);
    } else {
        console.log('Connected to the SQLite database.');
        const sqlScript = fs.readFileSync(path.join(__dirname, 'database.sql'), 'utf8');
        db.exec(sqlScript, (err) => {
            if (err) {
                console.error("Error setting up database:", err.message);
            } else {
                console.log("Database tables created and populated successfully.");
            }
        });
    }
});

// --- Recommendation Logic ---
function getRecommendations(profile, allInternships) {
    const scoredInternships = allInternships.map(internship => {
        let score = 0;
        const requiredEducation = JSON.parse(internship.required_education);
        const requiredSkills = JSON.parse(internship.required_skills);

        if (profile.location && (internship.location.toLowerCase().includes(profile.location) || internship.location === 'Any')) score += 50;
        profile.skills.forEach(skill => { if (requiredSkills.includes(skill)) score += 20; });
        profile.interests.forEach(interest => { if (internship.sector === interest) score += 30; });
        if (requiredEducation.includes(profile.education)) score += 10; else score = 0;

        return { ...internship, score };
    });

    return scoredInternships
        .filter(internship => internship.score > 0)
        .sort((a, b) => b.score - a.score)
        .slice(0, 5);
}

// --- API Endpoints ---

// Endpoint for getting a list of recommendations
app.post('/recommendations', (req, res) => {
    const userProfile = req.body;
    if (!userProfile || !userProfile.education) {
        return res.status(400).json({ error: 'Invalid user profile data provided.' });
    }

    const sql = `SELECT * FROM internships`;
    db.all(sql, [], (err, rows) => {
        if (err) {
            console.error("Error fetching from database:", err.message);
            return res.status(500).json({ error: 'Failed to retrieve data from database.' });
        }
        const recommendations = getRecommendations(userProfile, rows);
        res.json(recommendations);
    });
});

// NEW: Endpoint for getting details of a single internship
app.get('/internship/:id', (req, res) => {
    const { id } = req.params;
    const sql = `SELECT * FROM internships WHERE id = ?`;

    db.get(sql, [id], (err, row) => {
        if (err) {
            console.error("Error fetching internship details:", err.message);
            return res.status(500).json({ error: 'Database error.' });
        }
        if (row) {
            // Parse JSON fields before sending
            row.required_education = JSON.parse(row.required_education);
            row.required_skills = JSON.parse(row.required_skills);
            res.json(row);
        } else {
            res.status(404).json({ error: 'Internship not found.' });
        }
    });
});

// --- Start Server ---
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

