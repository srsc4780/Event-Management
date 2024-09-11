require('dotenv').config(); // Load environment variables from .env file
require('./config/firebase'); // Ensure Firebase is initialized before using it
const express = require('express');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const helmet = require('helmet');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const eventRoutes = require('./routes/eventRoutes');
const authRoutes = require('./routes/authRoutes');
const apiRoutes = require('./routes/apiRoutes');
const errorMiddleware = require('./middlewares/errorMiddleware');

const app = express();

// Middleware
app.use(morgan('combined')); // Use 'combined' for production logs
app.use(helmet()); // Secure HTTP headers
app.use(compression()); // Gzip responses
app.use(bodyParser.json());

// Rate Limiting
const apiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
    message: 'Too many requests from this IP, please try again later.'
});

app.use('/api/', apiLimiter);

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/events", eventRoutes);
app.use("/api", apiRoutes);

app.use("/", (req, res) => {
  res.send("Welcome to the Event Manager API");
});
// Error Handling Middleware
app.use(errorMiddleware);

// Start the server
const PORT = process.env.PORT || 3000;
const server = app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

// Graceful Shutdown
const gracefulShutdown = () => {
    console.log('Received kill signal, shutting down gracefully.');

    server.close(() => {
        console.log('Closed out remaining connections.');
        process.exit(0);
    });

    // Force close server after 10 seconds
    setTimeout(() => {
        console.error('Forcing shutdown.');
        process.exit(1);
    }, 10000);
};

process.on('SIGTERM', gracefulShutdown);
process.on('SIGINT', gracefulShutdown);
