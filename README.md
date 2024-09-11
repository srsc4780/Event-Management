# Event Management System - Quick Setup Guide

This project consists of two main parts:

1. **Backend**: Node.js API running on Firebase Cloud Functions.
2. **Frontend**: Flutter application consuming the API.

This guide will help you quickly set up and run both the **Node.js API** and **Flutter** application.

---

## Table of Contents

1. [Node.js API Setup](#nodejs-api-setup)
   - [Run Node.js API](#run-nodejs-api)
2. [Flutter App Setup](#flutter-app-setup)
   - [Configure API URL](#configure-api-url)
   - [Run Flutter App](#run-flutter-app)
3. [Requirements](#requirements)
4. [Conclusion](#conclusion)

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

   This will start your API on `http://localhost:5000`. Ensure that your firewall or network settings allow access on this port if using a specific IP address.

2. Retrieve your machine's local IPv4 address for network access:

   - For **Windows**:
     ```bash
     ipconfig
     ```
   - For **macOS/Linux**:
     ```bash
     ifconfig
     ```

3. Use the IP address to access the API from your Flutter app or another device on the network, e.g., `http://192.168.0.155:5000/api`.

---

## Flutter App Setup

### 1. Configure API URL

1. Navigate to the Flutter project directory:

   ```bash
   cd ../event-management-app
   ```

2. Open the file `lib/data/network/api/api_provider.dart`.

3. Update the `baseUrl` variable to match the IP address of your Node.js server (from step 2 in Node.js API Setup):

   ```dart
   class ApiProvider {
     static const String baseUrl = 'http://192.168.0.155:5000/api';
     // Other code...
   }
   ```

4. Make sure the IP address is consistent with your Node.js API's network configuration.

### 2. Install Flutter Dependencies

Run the following command to install all necessary Flutter packages:

```bash
flutter pub get
```

### 3. Run Flutter App

1. Ensure that your device (physical or emulator) is connected and ready.
2. Run the app with the following command:

   ```bash
   flutter run
   ```

---

## Requirements

Make sure you are using the correct versions of **Node.js** and **Flutter** to avoid compatibility issues:

- **Node.js version**: Up to `18.x`
- **Flutter version**: `3.24.1`

Check your Node.js version with:

```bash
node -v
```

Check your Flutter version with:

```bash
flutter --version
```

If you need to install or update Flutter, you can follow the [official installation guide](https://flutter.dev/docs/get-started/install).

---

## Conclusion

After following this guide, you should be able to run both the **Node.js API** and **Flutter app** in a seamless environment. Make sure both the Node.js API and Flutter app are on the same network to avoid connection issues.
