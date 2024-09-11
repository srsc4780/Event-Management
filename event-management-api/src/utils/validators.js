// utils/validators.js

const { check, validationResult } = require('express-validator');
const { handleResponse } = require('./responseHandler');

// Validator for user registration
exports.registerValidator = [
    check('email').isEmail().withMessage('Must be a valid email'),
    check('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
    check('name').not().isEmpty().withMessage('Name is required'),
    (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return handleResponse(res, 400, 'Validation failed', errors.array());
        }
        next();
    }
];

// Validator for user login
exports.loginValidator = [
    check('email').isEmail().withMessage('Must be a valid email'),
    check('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
    (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return handleResponse(res, 400, 'Validation failed', errors.array());
        }
        next();
    }
];

// Validator for creating or updating an event
exports.eventValidator = [
    check('title').not().isEmpty().withMessage('Title is required'),
    check('description').not().isEmpty().withMessage('Description is required'),
    check('date').isISO8601().withMessage('A valid date is required'),
    check('location').not().isEmpty().withMessage('Location is required'),
    check('eventType').not().isEmpty().withMessage('Event type is required'),
    check('organizer').not().isEmpty().withMessage('Organizer name is required'),
    (req, res, next) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return handleResponse(res, 400, 'Validation failed', errors.array());
        }
        next();
    }
];
