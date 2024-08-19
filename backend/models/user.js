const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  cnic: { type: String },
  phoneNumber: { type: String },
  role: { type: String, enum: ['guest', 'owner'], default: 'guest' }
});

const User = mongoose.model('User', userSchema);

module.exports = User;
