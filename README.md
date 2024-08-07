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
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)

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
   
