const { admin, db } = require("../config/firebase");
const { firebase } = require("../config/authFirebase");

// Register a new user
exports.register = async ({ email, password, name }) => {
  try {
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: name,
    });

    // Add user profile to Firestore
    await db.collection("users").doc(userRecord.uid).set({
      name,
      email,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      uid: userRecord.uid,
      email: userRecord.email,
      name: userRecord.displayName,
    };
  } catch (error) {
    throw new Error(error.message);
  }
};

exports.login = async ({ email, password }) => {
  try {
    const userCredential = await firebase
      .auth()
      .signInWithEmailAndPassword(email, password);
    const user = userCredential.user;

    // console.log(user);
    

    // Get the ID token
    const idToken = await user.getIdToken();

    // Extract user details
    const userDetails = {
      email: user.email,
      name: user.displayName,
      token: idToken,
    };

    return userDetails;
  } catch (error) {
    // console.log(error.code);

    let errorMessage;
    switch (error.code) {
      case "auth/invalid-email":
        errorMessage = "The email address is not valid.";
        break;
      case "auth/user-disabled":
        errorMessage =
          "The user corresponding to the given email has been disabled.";
        break;
      case "auth/user-not-found":
        errorMessage = "There is no user corresponding to the given email.";
        break;
      case "auth/wrong-password":
        errorMessage =
          "The password is invalid or the user does not have a password.";
        break;
      case "auth/network-request-failed":
        errorMessage =
          "A network error occurred. Please check your internet connection and try again.";
        break;
      case "auth/invalid-credential":
        errorMessage = "The credential is malformed or has expired.";
        break;
      default:
        errorMessage = error.message;
    }

    throw new Error(errorMessage);
  }
};
