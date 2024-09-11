const { 
    createEventInFirestore, 
    updateEventInFirestore, 
    deleteEventFromFirestore, 
    getAllEventsFromFirestore, 
    getEventByIdFromFirestore, 
    filterEventsInFirestore 
} = require('../services/eventService');
const { handleResponse } = require('../utils/responseHandler');
const { validationResult } = require('express-validator');

// Get all events
exports.getAllEvents = async (req, res, next) => {
    try {        
        const events = await getAllEventsFromFirestore();
        return handleResponse(res, 200, 'Events fetched successfully', events);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Get an event by ID
exports.getEventById = async (req, res, next) => {
    try {
        const event = await getEventByIdFromFirestore(req.params.id);
        if (!event) {
            return handleResponse(res, 404, 'Event not found');
        }
        return handleResponse(res, 200, 'Event fetched successfully', event);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Create a new event
exports.createEvent = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return handleResponse(res, 400, 'Validation failed', errors.array());
    }

    try {
        const event = await createEventInFirestore(req.body, req.user.uid);
        return handleResponse(res, 201, 'Event created successfully', event);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Update an existing event
exports.updateEvent = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return handleResponse(res, 400, 'Validation failed', errors.array());
    }

    try {
        const updatedEvent = await updateEventInFirestore(req.params.id, req.body);
        if (!updatedEvent) {
            return handleResponse(res, 404, 'Event not found');
        }
        return handleResponse(res, 200, 'Event updated successfully', updatedEvent);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Delete an event
exports.deleteEvent = async (req, res, next) => {
    try {
        const deletedEvent = await deleteEventFromFirestore(req.params.id);
        if (!deletedEvent) {
            return handleResponse(res, 404, 'Event not found');
        }
        return handleResponse(res, 200, 'Event deleted successfully');
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};

// Filter events by event type or date
exports.filterEvents = async (req, res, next) => {
    try {
        
        const { eventType, startDate, endDate } = req.body;                
        const filteredEvents = await filterEventsInFirestore(eventType, startDate, endDate);
        
        return handleResponse(res, 200, 'Filtered events fetched successfully', filteredEvents);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};
