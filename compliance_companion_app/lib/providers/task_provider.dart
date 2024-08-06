// lib/providers/task_provider.dart

import 'package:flutter/material.dart';
import '../models/task.dart';

/// A provider class for managing and notifying changes in the list of tasks.
class TaskProvider with ChangeNotifier {
  // A list of tasks to be managed by the provider.
  final List<Task> _tasks = [
    Task(
      id: 1,
      title: 'Task 1',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.pending,
      description: 'Description 1'
    ),
    Task(
      id: 2,
      title: 'Task 2',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      status: TaskStatus.pending,
      description: 'Description 2'
    ),
    Task(
      id: 3,
      title: 'Task 3',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      status: TaskStatus.pending,
      description: 'Description 3'
    ),
    Task(
      id: 4,
      title: 'Task 4',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      status: TaskStatus.pending,
      description: 'Description 4'
    ),
  ];

  // A variable to store the current filter status of tasks.
  TaskStatus _filterStatus = TaskStatus.all;

  /// Getter to retrieve all tasks.
  List<Task> get allTasks => _tasks;

  /// Method to get a task by its ID.
  Task getTaskById(int id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  /// Method to update an existing task and notify listeners about the change.
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);

    // If task found, update task and notify listeners.
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  /// Getter to retrieve tasks based on the current filter status.
  List<Task> get filteredTasks {
    switch (_filterStatus) {
      case TaskStatus.pending:
        return _tasks.where((task) => task.status == TaskStatus.pending).toList();
      case TaskStatus.inProgress:
        return _tasks.where((task) => task.status == TaskStatus.inProgress).toList();
      case TaskStatus.completed:
        return _tasks.where((task) => task.status == TaskStatus.completed).toList();
      case TaskStatus.all:
        return _tasks;
    }
  }

  /// Getter to retrieve the current filter status.
  TaskStatus get filterStatus => _filterStatus;

  /// Method to toggle the status of a task and notify listeners about the change.
  void toggleTaskStatus(int index, bool value) {
    filteredTasks[index].status = value ? TaskStatus.completed : TaskStatus.pending;
    notifyListeners();
  }

  /// Method to set a new filter status and notify listeners about the change.
  void setFilterStatus(TaskStatus status) {
    _filterStatus = status;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
