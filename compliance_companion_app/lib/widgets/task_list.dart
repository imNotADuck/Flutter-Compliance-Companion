import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../screens/task_detail_screen.dart';

/// A widget that displays a list of tasks.
class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.filteredTasks.length,
          itemBuilder: (ctx, index) {
            final task = taskProvider.filteredTasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(
                'Due: ${DateFormat('dd-MM-yyyy').format(task.dueDate)} - ${task.status.toString().split('.').last}',
              ),
              trailing: Checkbox(
                value: task.status == TaskStatus.completed,
                onChanged: (value) {
                  if (value != null) {
                    taskProvider.toggleTaskStatus(index, value);
                  }
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/taskDetail',
                  arguments: task.id,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TaskDetailScreen(taskId: task.id),
                //   ),
                // );
              },
            );
          },
        );
      },
    );
  }
}
