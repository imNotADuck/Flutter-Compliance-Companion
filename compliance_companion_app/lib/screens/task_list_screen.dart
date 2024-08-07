import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:compliance_companion_app/auth/auth_manager.dart';
import 'package:compliance_companion_app/data/firestore_db.dart';
import 'package:compliance_companion_app/data/storage_manager.dart';
import 'package:compliance_companion_app/screens/task_detail_screen.dart';
import 'package:compliance_companion_app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/task_list.dart';

/// A screen that displays a list of tasks.
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    _createAuthenticatedUser();
    super.initState();
  }

  Future<bool> _createAuthenticatedUser() async {
    ///Get and save authenticated userId to local storage
    final uid = await AuthManager.getCurrentUserId();
    if (uid != null) {
      await StorageManager.storeUserId(uid);
      safePrint('uid saved to device: $uid');

      ///Add user to FirestoreDB
      await FirestoreDb().createUser(uid);
      return true;
    }

    return true;
  }

  Future<String?> getUserIdFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getUserIdFromPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('User ID not found'));
          } else {
            final userId = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tasks Manager'),
              ),
              body:  Column(
                children: [
                  const ToolBar(),
                  Expanded(
                    child: TaskList(userId: userId,),
                  ),
                  const SignOutButton(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(
                        userId: userId,
                        taskId: null,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        });
  }
}
