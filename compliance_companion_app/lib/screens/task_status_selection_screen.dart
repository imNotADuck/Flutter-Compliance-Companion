import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskStatusSelectionScreen extends StatelessWidget {
  final TaskStatus currentStatus;

  TaskStatusSelectionScreen({required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Task Status'),
      ),
      body: ListView(
        children: TaskStatus.values.where((status) => status != TaskStatus.all).map((status) {
          return ListTile(
            title: Text(status.name),
            onTap: () {
              Navigator.pop(context, status);
            },
            selected: status == currentStatus,
          );
        }).toList(),
      ),
    );
  }
}
