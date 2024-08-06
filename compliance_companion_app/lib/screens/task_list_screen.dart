import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:compliance_companion_app/screens/task_detail_screen.dart';
import 'package:compliance_companion_app/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/task_list.dart';

/// A screen that displays a list of tasks.
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

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
