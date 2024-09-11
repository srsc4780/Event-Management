const admin = require('firebase-admin');
const db = admin.firestore();
const eventsCollection = db.collection('events');

// Create a new event in Firestore
exports.createEventInFirestore = async (eventData, userId) => {
    const newEvent = {
        ...eventData,
        organizerId: userId,  // Adding organizer ID for tracking purposes
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    const eventRef = await eventsCollection.add(newEvent);
    const createdEvent = await eventRef.get();
    return { id: createdEvent.id, ...createdEvent.data() };
};

// Get all events from Firestore
exports.getAllEventsFromFirestore = async () => {
    const eventsSnapshot = await eventsCollection.get();
    const events = [];
    eventsSnapshot.forEach(doc => events.push({ id: doc.id, ...doc.data() }));
    return events;
};

// Get a specific event by ID from Firestore
exports.getEventByIdFromFirestore = async (eventId) => {
    const eventRef = await eventsCollection.doc(eventId).get();
    if (!eventRef.exists) return null;
    return { id: eventRef.id, ...eventRef.data() };
};

// Update an event in Firestore
exports.updateEventInFirestore = async (eventId, eventData) => {
    const eventRef = eventsCollection.doc(eventId);
    const event = await eventRef.get();
    if (!event.exists) return null;

    const updatedEvent = {
        ...event.data(),
        ...eventData,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await eventRef.update(updatedEvent);
    return { id: eventId, ...updatedEvent };
};

// Delete an event from Firestore
exports.deleteEventFromFirestore = async (eventId) => {
    const eventRef = eventsCollection.doc(eventId);
    const event = await eventRef.get();
    if (!event.exists) return null;

    await eventRef.delete();
    return { id: eventId, message: 'Event deleted successfully' };
};

// Filter events by event type or date
exports.filterEventsInFirestore = async (eventType, startDate, endDate) => {
    let query = eventsCollection;

    // Filter by eventType if provided
    if (eventType) {
        query = query.where('eventType', '==', eventType);
    }

    // Use startAt and endAt for the date range filtering
    if (startDate && endDate) {
        // Define the start and end date strings (ensure end date is inclusive of the entire day)
        const startAt = `${startDate}T00:00:00`;
        const endAt = `${endDate}T23:59:59`;

        // Apply the date range filter using Firestore's startAt and endAt
        query = query.orderBy('date')
            .startAt(startAt)
            .endAt(endAt);
    } else if (startDate) {
        // Only startDate is provided
        const startAt = `${startDate}T00:00:00`;
        query = query.orderBy('date').startAt(startAt);
    } else if (endDate) {
        // Only endDate is provided
        const endAt = `${endDate}T23:59:59`;
        query = query.orderBy('date').endAt(endAt);
    }

    // Fetch and return the filtered events
    const filteredSnapshot = await query.get();
    const filteredEvents = filteredSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

    return filteredEvents;
};