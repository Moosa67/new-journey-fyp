const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Replace 'your-secret-key' with a strong and secure secret key
const JWT_SECRET = 'MySecretKey@#2023$YourApp';
const authenticateToken = (req, res, next) => {
    const token = req.header('Authorization');

    if (!token) {
        return res.status(401).send('Access denied. Token not provided.');
    }

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) {
            console.error('Error decoding token:', err);
            return res.status(403).send('Invalid token.');
        }

        console.log('Decoded Token:', decoded);

        req.user = decoded;
        next();
    });

};

router.post('/register', async (req, res) => {
    try {
        const { name, email, password, cnic, phoneNumber, role } = req.body;

        const hashedPassword = await bcrypt.hash(password, 10);

        // Ensure that the role provided is either 'guest' or 'owner'
        if (!['guest', 'owner'].includes(role)) {
            return res.status(400).send('Invalid role');
        }

        const user = new User({
            name,
            email,
            password: hashedPassword,
            cnic,
            phoneNumber,
            role,
        });

        await user.save();
        res.status(201).send('User registered successfully');
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });

        if (!user) {
            return res.status(404).send('User not found');
        }

        const passwordMatch = await bcrypt.compare(password, user.password);

        if (!passwordMatch) {
            return res.status(401).send('Invalid password');

        }
        // Generate a JWT token
        const token = jwt.sign({ userId: user._id, role: user.role }, JWT_SECRET, { expiresIn: '1h' });
        console.log('JWT Secret Key:', JWT_SECRET);

        // Return the token and user details for a successful login
        return res.status(200).json({
            message: 'Login successful',
            token: token,
            user: {
                name: user.name,
                email: user.email,
                role: user.role,
            },
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});
router.get('/details', authenticateToken, async (req, res) => {
    try {
        const authenticatedUser = req.user;

        console.log('Authenticated User:', authenticatedUser);

        // Retrieve the user details from the authenticated user
        const user = await User.findById(authenticatedUser.userId);

        console.log('User Details:', user);

        if (!user) {
            return res.status(404).send('User not found');
        }

        // You can now use user to access all user details
        return res.status(200).json({
            name: user.name,
            email: user.email,
            cnic: user.cnic,
            phoneNumber: user.phoneNumber,
            role: user.role,
        
            // Add other user details you want to include
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
