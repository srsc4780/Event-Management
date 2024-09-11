const express = require('express');
const { registerUser, loginUser } = require('../controllers/authController');
const { registerValidator, loginValidator } = require('../utils/validators');

const router = express.Router();

// POST /auth/register
router.post('/register', registerValidator, registerUser);

// POST /auth/login
router.post('/login', loginValidator, loginUser);

module.exports = router;
