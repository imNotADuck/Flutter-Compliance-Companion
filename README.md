# Flutter Compliance Companion

Welcome to the Flutter Compliance Companion! This project is a task manager app designed to help users track and manage their regulatory compliance tasks. The app uses Firebase for data storage and AWS Amplify for authentication.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Configuration](#firebase-configuration)
  - [AWS Configuration](#aws-configuration)
- [Running the App](#running-the-app)
- [Challenges Encountered](#challenges-encountered)
- [Unfamiliar Area](#unfamiliar-area)

<a id="features"></a>
## Features
- View and manage compliance tasks
- Mark tasks as complete
- Authentication with AWS Amplify
- Data storage with Firebase Firestore

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase account
- AWS account
- Android Studio or Visual Studio Code
- Android emulator

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/imNotADuck/Flutter-Compliance-Companion.git
   cd Flutter-Compliance-Companion/compliance_companion_app

2. **Install dependencies:**
   ```bash
   flutter pub get


### Firebase Configuration

1. **Create a Firebase project:**
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Click on "Add project" and follow the steps.

2. **Add Android app to the Firebase project:**
   - In the Firebase Console, go to "Project Overview".
   - Click on the Android icon to add an Android app.
   - Register the app with your app's package name (e.g., com.example.flutter_compliance_companion).
   - Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.

3. **Enable Firestore and Authentication:**
   - In the Firebase Console, go to "Firestore Database" and click "Create Database".
   - Go to "Authentication" and enable Email/Password sign-in method.

### AWS Configuration

1. **Set up AWS Amplify:**
   - Install the Amplify CLI:
     ```bash
     npm install -g @aws-amplify/cli
     ```
   - Configure Amplify:
     ```bash
     amplify configure
     ```
   - Initialize Amplify in your project:
     ```bash
     amplify init
     ```

2. **Add Authentication:**
   ```bash
   amplify add auth
- Follow the prompts to configure authentication.

3. Push the changes to AWS:
   ```bash
   amplify add auth

### Running the App

  Run the app on an Android emulator
  ```bash
  flutter run
  ```

## Challenges Encountered

- **AWS Cognito Policy Settings:** Despite following the documentation closely, configuring the right policy settings for AWS Cognito was challenging.
- **AWS and Firebase Integration:** Integrating AWS with Firebase Storage was cumbersome. It would have been more efficient to use Flutter Auth from the start.
- **Manual User ID Handling:** Manually extracting the authenticated user ID from Amplify Auth and using it with Firebase services was a complex process that took considerable time.
- **Platform Targeting:** The project is currently targeted on Android emulators due to time constraints for setting up on iOS.

<a id="unfamiliar-area"></a>
Approach to Adding Notification Features to the To-Do App

Objective: Implement a notification system that alerts users one day before a to-do item's deadline.

1\. Local Notifications Approach

Overview: This approach uses the device itself to schedule and send notifications without relying on a backend server.

Steps:

Use Local Notifications Library: Integrate a local notifications library like flutter_local_notifications into your Flutter app.

Schedule Notifications: When a user creates a to-do item, schedule a local notification to be triggered one day before the deadline.

Handle Background Tasks: Use a background task library like workmanager to periodically check for upcoming deadlines and schedule notifications accordingly.

Pros:

Offline Capability: Works even if the user is offline.

Simplicity: Easier to implement and manage within the app itself.

Cons:

Limited Reliability: Notifications might not be as reliable due to device limitations or app state (e.g., killed by the OS).

No Cross-Device Sync: Notifications are limited to the device where the to-do was created.

2\. Cloud Notifications Approach

Overview: This approach leverages cloud services to schedule and send notifications, ensuring they are delivered reliably even if the app is not running.

Steps:

Store To-Do Items: Save to-do items in a database like Firebase Firestore.

Use Cloud Functions: Implement Firebase Cloud Functions to monitor the database and schedule notifications to be sent one day before deadlines.

Send Notifications via FCM: Use Firebase Cloud Messaging (FCM) to deliver push notifications to the user's device.

Pros:

High Reliability: Notifications are more reliable and can be sent even if the app is not running.

Cross-Device Sync: Works across all devices where the user is logged in.

Cons:

Complexity: More complex to set up and maintain, requiring knowledge of both client-side and server-side technologies.

Dependency on Network: Requires a network connection to receive notifications.

