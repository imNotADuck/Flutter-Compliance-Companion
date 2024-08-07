import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compliance_companion_app/data/firestore_db.dart';
import 'package:compliance_companion_app/screens/task_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

/// A widget that displays a list of tasks.
class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: FirestoreDb().getTasksStream(userId),
        builder: (context, taskSnapshot) {
          if (taskSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!taskSnapshot.hasData || taskSnapshot.data!.isEmpty) {
            return const Center(
              child: Text('No task at the moment.'),
            );
          }

          if (taskSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          final loadedTasks = taskSnapshot.data!;
          ///Get backend task, no need for mock tasks
          Provider.of<TaskProvider>(context, listen: false).allTasks =
              loadedTasks;
          
          return Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return ListView.builder(
                itemCount: taskProvider.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.filteredTasks[index];
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
                      Provider.of<TaskProvider>(context, listen: false)
                          .deleteTask(task.id);
                      FirestoreDb().deleteTask(userId, task.id);
                    },
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(
                        'Due: ${DateFormat('dd-MM-yyyy').format(task.dueDate)} - ${task.status.name}',
                      ),
                      trailing: Checkbox(
                        value: task.status == TaskStatus.completed,
                        onChanged: (value) {
                          if (value != null) {
                            Provider.of<TaskProvider>(context, listen: false)
                                .toggleTaskStatus(index, value);
                            FirestoreDb()
                                .setTaskCompleted(userId, task.id, value);
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(
                              userId: userId,
                              taskId: task.id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
