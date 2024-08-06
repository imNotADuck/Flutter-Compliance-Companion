// lib/main.dart

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:compliance_companion_app/models/task.dart';
import 'package:compliance_companion_app/screens/task_status_selection_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/task_provider.dart';
import './screens/task_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'amplifyconfiguration.dart';
import 'firebase_options.dart';
import 'screens/task_detail_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  safePrint("Handling a background message: ${message.messageId}");
}

void _firebaseMessagingSetups() async {
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: true);

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
  }

  final fcmToken = await FirebaseMessaging.instance.getToken();
  safePrint("token valid: ${fcmToken}");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    safePrint('Got a message whilst in the foreground!');
    safePrint('Message data: ${message.data}');

    if (message.notification != null) {
      safePrint(
          'Message also contained a notification: ${message.notification}');
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Firebase setups
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _firebaseMessagingSetups();

  ///Amplify setups
  _configureAmplify();

  runApp(
    // Wrap the app in a ChangeNotifierProvider to provide the TaskProvider to the widget tree.
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

///Amplify setups
Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        title: 'Compliance Companion App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => const TaskListScreen(),
              );
            case '/taskDetail':
              final taskId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) => TaskDetailScreen(taskId: taskId),
              );
            case '/taskStatusSelection':
              final currentStatus = settings.arguments as TaskStatus;
              return MaterialPageRoute(
                builder: (context) =>
                    TaskStatusSelectionScreen(currentStatus: currentStatus),
              );
            default:
              return null;
          }
        },
        // home: const TaskListScreen(),
      ),
    );
  }
}
