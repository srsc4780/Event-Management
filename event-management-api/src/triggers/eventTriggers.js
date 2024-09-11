const functions = require('firebase-functions');
const { admin } = require('../config/firebase');

exports.updateTimestamp = functions.firestore
  .document('events/{eventId}')
  .onWrite((change, context) => {
    if (!change.after.exists) return null;  // Handle document deletion
    const eventRef = change.after.ref;
    return eventRef.update({ updatedAt: admin.firestore.FieldValue.serverTimestamp() });
  });
