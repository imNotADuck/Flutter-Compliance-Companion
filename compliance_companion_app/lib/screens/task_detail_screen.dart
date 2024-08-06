import 'package:compliance_companion_app/screens/task_status_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final int taskId;

  TaskDetailScreen({super.key, required this.taskId});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late DateTime dueDate;
  late TaskStatus status;

  @override
  void initState() {
    super.initState();
    final task = Provider.of<TaskProvider>(context, listen: false)
        .getTaskById(widget.taskId);
    nameController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    dueDate = task.dueDate;
    status = task.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updatedTask = Task(
                id: widget.taskId,
                title: nameController.text,
                description: descriptionController.text,
                dueDate: dueDate,
                status: status,
              );
              Provider.of<TaskProvider>(context, listen: false)
                  .updateTask(updatedTask);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ListTile(
              title:
                  Text('Due Date: ${DateFormat('dd-MM-yyyy').format(dueDate)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    dueDate = pickedDate;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Status: ${status.name}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                // final selectedStatus = await Navigator.push<TaskStatus>(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TaskStatusSelectionScreen(currentStatus: status),
                //   ),
                // );
                final selectedStatus = await Navigator.pushNamed(
                  context,
                  '/taskStatusSelection',
                  arguments: status,
                );
                if (selectedStatus != null) {
                  setState(() {
                    status = selectedStatus as TaskStatus;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
