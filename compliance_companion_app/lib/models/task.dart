// lib/models/task.dart

enum TaskStatus { all, pending, inProgress, completed }

class Task {
  int id;
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
}

extension TaskStatusExtension on TaskStatus {
  String get name {
    switch (this) {
      case TaskStatus.all:
        return 'All';
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
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
