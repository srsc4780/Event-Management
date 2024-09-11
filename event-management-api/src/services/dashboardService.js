const { firestore } = require('firebase-admin');

// Get total events, upcoming events, past events, and total users from Firestore
exports.dashboard = async () => {
    const eventsCollection = firestore().collection('events');
    const usersCollection = firestore().collection('users');

    const eventsSnapshot = await eventsCollection.get();
    const usersSnapshot = await usersCollection.get();

    const totalEvents = eventsSnapshot.size;
    const totalUsers = usersSnapshot.size;

    let upcomingEventsCount = 0;
    let leftEventsCount = 0;

    const currentTime = new Date();

    // Loop through all events and categorize them
    eventsSnapshot.forEach(doc => {
        const eventData = doc.data();
        const eventDate = eventData.date ? new Date(eventData.date) : null;

        if (eventDate) {
            // Count upcoming and past events based on the current date
            if (eventDate >= currentTime) {
                upcomingEventsCount++;
            } else {
                leftEventsCount++;
            }
        }
    });

    return {
        totalEvents,
        upcomingEventsCount,
        leftEventsCount,
        totalUsers
    };
};
