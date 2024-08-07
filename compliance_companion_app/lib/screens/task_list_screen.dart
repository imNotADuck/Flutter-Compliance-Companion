import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:compliance_companion_app/auth/auth_manager.dart';
import 'package:compliance_companion_app/data/firestore_db.dart';
import 'package:compliance_companion_app/data/storage_manager.dart';
import 'package:compliance_companion_app/screens/task_detail_screen.dart';
import 'package:compliance_companion_app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/task_list.dart';

/// A screen that displays a list of tasks.
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState(){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Manager'),
      ),
      body: const Column(
        children: [
          ToolBar(),
          Expanded(
            child: TaskList(),
          ),
          SignOutButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(taskId: null),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
