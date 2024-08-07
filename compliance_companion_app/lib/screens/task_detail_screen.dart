import 'package:compliance_companion_app/data/firestore_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final String? taskId;
  final String userId;

  const TaskDetailScreen(
      {super.key, required this.userId, required this.taskId});

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
    if (widget.taskId != null) {
      ///Load existing task
      final task = Provider.of<TaskProvider>(context, listen: false)
          .getTaskById(widget.taskId!);
      nameController = TextEditingController(text: task.title);
      descriptionController = TextEditingController(text: task.description);
      dueDate = task.dueDate;
      status = task.status;
    } else {
      ///Load new task
      nameController = TextEditingController();
      descriptionController = TextEditingController();
      dueDate = DateTime.now();
      status = TaskStatus.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.taskId != null
            ? const Text('Task Details')
            : const Text('Add New Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final newTask = Task(
                id: widget.taskId ?? Uuid().v4(),
                title: nameController.text,
                description: descriptionController.text,
                dueDate: dueDate,
                status: status,
              );
              if (widget.taskId == null) {
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(newTask);
                FirestoreDb().addTask(
                  newTask.title,
                  newTask.description,
                  newTask.dueDate,
                  newTask.status.name,
                );
              } else {
                Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(newTask);
                FirestoreDb().updateTask(
                  widget.userId,
                  newTask.id,
                  newTask.title,
                  newTask.description,
                  newTask.dueDate,
                  newTask.status.name,
                );
              }
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
