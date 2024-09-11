
const { admin } = require('../config/firebase');
const { handleResponse } = require('../utils/responseHandler');

exports.isAuthenticated = async (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];    
    if (!token) {
        return handleResponse(res, 401, 'Unauthorized');
    }

    try {
        const decodedToken = await admin.auth().verifyIdToken(token);
        req.user = decodedToken;
        next();
    } catch (error) {      
        handleResponse(res, 401, 'Invalid Token');
    }
};
