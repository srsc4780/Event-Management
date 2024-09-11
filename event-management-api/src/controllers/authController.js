const { register, login } = require('../services/authService');
const { validationResult } = require('express-validator');
const { handleResponse } = require('../utils/responseHandler');

// Register a new user
exports.registerUser = async (req, res, next) => {    
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return handleResponse(res, 400, 'Validation failed', errors.array());
    }
    try {
        const user = await register(req.body);
        return handleResponse(res, 201, 'User registered successfully', user);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Login an existing user
exports.loginUser = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return handleResponse(res, 400, 'Validation failed', errors.array());
    }
  
    try {
      const token = await login(req.body);
      return handleResponse(res, 200, 'Login successful', token);
    } catch (error) {
      return handleResponse(res, 422, error.message);
    }
  };
  
