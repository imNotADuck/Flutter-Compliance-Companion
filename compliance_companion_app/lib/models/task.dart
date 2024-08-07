// lib/models/task.dart

import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { all, pending, inProgress, completed }

class Task {
  String id;
  String title;
  DateTime dueDate;
  String description;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.description,
    required this.status,
  });

  ///Helpers help mapping data
  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data?['title'],
      dueDate: (data?['dueDate'] != null)
          ? (data?['dueDate'] as Timestamp).toDate()
          : DateTime.now(),
      description: data?['description'] ?? '',
      status: _stringToTaskStatus(data?['status'] ?? 'pending'),
    );
  }

  ///Helpers help mapping data
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate,
      'description': description,
      'status': _taskStatusToString(status),
    };
  }

  static TaskStatus _stringToTaskStatus(String status) {
    switch (status) {
      case 'completed':
        return TaskStatus.completed;
      case 'inProgress':
        return TaskStatus.inProgress;
      default:
        return TaskStatus.pending;
    }
  }

  static String _taskStatusToString(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.inProgress:
        return 'inProgress';
      default:
        return 'pending';
    }
  }
}

extension TaskStatusExtension on TaskStatus {
  String get name {
    switch (this) {
      case TaskStatus.all:
        return 'all';
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.completed:
        return 'completed';
      default:
        return '';
    }
  }

  String get helper {
    switch (this) {
      case TaskStatus.all:
        return 'All tasks to be completed';
      case TaskStatus.pending:
        return 'Pending tasks';
      case TaskStatus.inProgress:
        return 'Tasks in progress';
      case TaskStatus.completed:
        return 'Only completed tasks';
      default:
        return '';
    }
  }
}
