// const express = require('express');
// const router = express.Router();
// const mongoose = require('mongoose');
// const User = require('../models/user');
// const bcrypt = require('bcryptjs');


// router.post('/register', async (req, res) => {
//     try {
//       const { name, email, password, cnic, phoneNumber } = req.body;
  
//       const hashedPassword = await bcrypt.hash(password, 10);
  
//       const user = new User({
//         name,
//         email,
//         password: hashedPassword,
//         cnic,
//         phoneNumber,
//       });
  
//       await user.save();
//       res.status(201).send('User registered successfully');
//     } catch (error) {
//       console.error(error);
//       res.status(500).send('Internal Server Error');
//     }
//   });
  
//   router.post('/login', async (req, res) => {
//     try {
//       const { email, password } = req.body;
  
//       const user = await User.findOne({ email });
  
//       if (!user) {
//         return res.status(404).send('User not found');
//       }
  
//       const passwordMatch = await bcrypt.compare(password, user.password);
  
//       if (!passwordMatch) {
//         return res.status(401).send('Invalid password');
//       }
  
//       // Return a specific message for a successful login
//       return res.status(200).send('Login successful. Welcome, ' + user.name);
//     } catch (error) {
//       console.error(error);
//       res.status(500).send('Internal Server Error');
//     }
//   });
  
//   module.exports = router;


const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const User = require('../models/user');
const bcrypt = require('bcryptjs');

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

    // Return a specific message for a successful login
    return res.status(200).send('Login successful. Welcome, ' + user.name);
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
});

module.exports = router;
