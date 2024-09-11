const express = require('express');
const { dashboard } = require('../controllers/dashboardController');
const { isAuthenticated } = require('../middlewares/authMiddleware');

const router = express.Router();

// Get /dashboard
router.get('/dashboard', isAuthenticated, dashboard);

module.exports = router;
