const { dashboard } = require('../services/dashboardService');
const { handleResponse } = require('../utils/responseHandler');

// dashboard
exports.dashboard = async (req, res, next) => {
    try {
        const data = await dashboard(req.body);
        return handleResponse(res, 201, 'Dashboard fetched successfully', data);
    } catch (error) {
       return handleResponse(res, 422, error.message);
    }
};
