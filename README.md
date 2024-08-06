# Compliance Companion App

## Project Overview

The **Compliance Companion App** is a task manager application built with Flutter. It helps users track and manage their regulatory compliance tasks efficiently. The app provides features to create, view, and manage tasks, ensuring users stay on top of their compliance requirements.

### Features

- **Task Management**: Create, view, and update tasks.
- **Task Status**: Mark tasks as complete / pending / in progress.
- **User Authentication**: Secure login and registration (integrated with AWS Cognito).
- **Notification**: Use of Firebase Cloud Messaging for sending a reminder notification when a task is due soon.

## Setup Instructions

### Prerequisites

- Flutter SDK installed on your machine.
- An active Firebase project.
- AWS account (if using AWS services).

### Firebase Setup

1. **Create a Firebase Project**
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Click on "Add Project" and follow the setup wizard.

2. **Add Firebase to Your Flutter App**
   - Navigate to the Firebase Console and select your project.
   - Click on the Android/iOS icon to add a new app to your project.
   - Follow the instructions to download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file and place it in your project's directory:
     - For Android: `android/app/`
     - For iOS: `ios/Runner/`

3. **Configure Firebase in Your Flutter App**
   - Add the Firebase SDK to your Flutter project:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: latest_version
       firebase_messaging: latest_version
     ```
   - Initialize Firebase in your app:
     ```dart
     import 'package:firebase_core/firebase_core.dart';

     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(MyApp());
     }
     ```

### AWS Setup (if applicable)

1. **Create an AWS Account**
   - Sign up for an AWS account at [AWS Management Console](https://aws.amazon.com/).

2. **Set Up AWS Services**
   - Depending on your app’s requirements, set up the necessary AWS services (e.g., S3 for storage, Lambda for backend functions).

3. **Configure AWS SDK**
   - Add the AWS SDK dependencies to your Flutter project:
     ```yaml
     dependencies:
       amplify_flutter: latest_version
       amplify_auth_cognito: latest_version
     ```
   - Initialize and configure AWS Amplify:
     ```dart
     import 'package:amplify_flutter/amplify.dart';
     import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
     import 'amplifyconfiguration.dart';

     void main() async {
     WidgetsFlutterBinding.ensureInitialized();

     Amplify.addPlugin(AmplifyAuthCognito());
     await Amplify.configure(amplifyconfig);

     runApp(MyApp());
}


## How to Run the App

1. **Clone the Repository**
   ```bash
   git clone https://github.com/imNotADuck/compliance-companion-app.git

2. **Navigate to the Project Directory
   ```bash
   cd compliance-companion-app

3. **Install Dependencies
   ```bash
   flutter pub get

4. **Run the App
   ```bash
   flutter run

## Additional Notes

- Ensure all Firebase and AWS configurations are correctly set up before running the app.
- For detailed Firebase setup instructions, refer to the [Firebase documentation](https://firebase.google.com/docs/flutter/setup).
- For AWS configuration, consult the [AWS SDK for Flutter documentation](https://aws.amazon.com/flutter/).

Feel free to contribute to the project or open issues if you encounter any problems.


