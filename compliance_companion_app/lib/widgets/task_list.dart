import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

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
            // return ListTile(
            //   title: Text(task.title),
            //   subtitle: Text(
            //     'Due: ${DateFormat('dd-MM-yyyy').format(task.dueDate)} - ${task.status.toString().split('.').last}',
            //   ),
            //   trailing: Checkbox(
            //     value: task.status == TaskStatus.completed,
            //     onChanged: (value) {
            //       if (value != null) {
            //         taskProvider.toggleTaskStatus(index, value);
            //       }
            //     },
            //   ),
            //   onTap: () {
            //     Navigator.pushNamed(
            //       context,
            //       '/taskDetail',
            //       arguments: task.id,
            //     );
            //   },
            // );
            return Dismissible(
              key: ValueKey(task.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Color.fromARGB(255, 56, 20, 113),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                taskProvider.deleteTask(task.id);
              },
              child: ListTile(
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
                },
              ),
            );
          },
        );
      },
    );
  }
}
