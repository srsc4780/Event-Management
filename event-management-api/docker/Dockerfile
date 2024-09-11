# Stage 1: Build Stage
FROM node:22-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Production Stage
FROM node:22-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/src ./src
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/.env ./

# Expose the application port
EXPOSE 5000

# Start the application
CMD ["node", "src/app.js"]
