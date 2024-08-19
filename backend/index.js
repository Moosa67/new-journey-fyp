const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');
// const User = require('./routes/users');
const cors = require('cors');
const userRoute = require('./routes/users');
const hotelRoute = require('./routes/hotels');

const app = express();
const PORT = 3000;

// app.use(bodyParser.json());
app.use(express.json());
app.use(cors());

mongoose.connect('mongodb://localhost:27017/Newjourney', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

app.use('/user', userRoute);
app.use('/hotel', hotelRoute);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
