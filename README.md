# Event Management System - Quick Setup Guide

This project consists of two main parts:

1. **Backend**: Node.js API running on Firebase Cloud Functions.
2. **Frontend**: Flutter application consuming the API.

Follow the steps below to run both the Node.js API and Flutter application quickly.

---

## Table of Contents

1. [Node.js API Setup](#nodejs-api-setup)
   - [Run Node.js API](#run-nodejs-api)
2. [Flutter App Setup](#flutter-app-setup)
   - [Configure API URL](#configure-api-url)
   - [Run Flutter App](#run-flutter-app)
3. [Conclusion](#conclusion)

---

## Node.js API Setup

### 1. Clone the Repository

```bash
git clone https://github.com/srsc4780/Event-Management.git
cd event-management-api
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Run Node.js API

1. Run the following command to start the Node.js server on **port 5000**:

   ```bash
   npm run dev
   ```

   This will start your API on `http://localhost:5000`. Make sure to configure your firewall or network settings if running on a specific IP address.

2. The API will be available at: <your ip4 adress>:5000
   - to know your ip4 address on windows
   ```bash
   ipconfig
   ```
   - or mac/linux
   ```bash
    ifconfig
   ```

---

## Flutter App Setup

### 1. Configure API URL

1. Open the Flutter project directory:

   ```bash
   cd event-management-app
   ```

2. In your Flutter project, navigate to `lib/data/network/api/api_provider.dart`.

3. Set the `baseUrl` variable to the URL of your API (make sure to match the IP address of your Node.js server):

   ```dart
   class ApiProvider {
     static const String baseUrl = 'http://192.168.0.155:5000/api';
     // Other code...
   }
   ```

4. Ensure the IP address in the `baseUrl` matches the one you used to run the Node.js API.

### 2. Install Flutter Dependencies

Before running the Flutter app, make sure to install all the necessary dependencies:

```bash
flutter pub get
```

### 3. Run Flutter App

1. Make sure your device is connected or the emulator is running.
2. Run the following command to start the app:

   ```bash
   flutter run
   ```
