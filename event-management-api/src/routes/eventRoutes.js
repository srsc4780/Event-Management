const express = require('express');
const { 
    getAllEvents, 
    getEventById, 
    createEvent, 
    updateEvent, 
    deleteEvent, 
    filterEvents 
} = require('../controllers/eventController');
const { isAuthenticated } = require('../middlewares/authMiddleware');
const { eventValidator } = require('../utils/validators');
const router = express.Router();

// Public Routes
// GET /api/events - Get all events
router.get('/', isAuthenticated, getAllEvents);

// GET /api/events/:id - Get a specific event by ID
router.get('/:id/details', isAuthenticated, getEventById);

// POST /api/events/filter - Filter events by event type or date
router.post('/filter', isAuthenticated, filterEvents);

// POST /api/events - Create a new event (Requires authentication)
router.post('/', isAuthenticated, eventValidator, createEvent);

// PUT /api/events/:id - Update an event by ID (Requires authentication)
router.put('/:id', isAuthenticated, eventValidator, updateEvent);

// DELETE /api/events/:id - Delete an event by ID (Requires authentication)
router.delete('/:id', isAuthenticated, deleteEvent);

module.exports = router;
