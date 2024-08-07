import 'package:compliance_companion_app/models/task.dart';
import 'package:compliance_companion_app/providers/task_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskProvider', () {
    TaskProvider taskProvider;

    setUp(() {
      taskProvider = TaskProvider();

      List<Task> _tasks = [
        Task(
            id: '1',
            title: 'Task 1',
            dueDate: DateTime.now().add(const Duration(days: 1)),
            status: TaskStatus.pending,
            description: 'Description 1'),
        Task(
            id: '2',
            title: 'Task 2',
            dueDate: DateTime.now().add(const Duration(days: 2)),
            status: TaskStatus.pending,
            description: 'Description 2'),
        Task(
            id: '3',
            title: 'Task 3',
            dueDate: DateTime.now().add(const Duration(days: 3)),
            status: TaskStatus.pending,
            description: 'Description 3'),
        Task(
            id: '4',
            title: 'Task 4',
            dueDate: DateTime.now().add(const Duration(days: 4)),
            status: TaskStatus.pending,
            description: 'Description 4'),
      ];

      taskProvider.allTasks = _tasks;
    });

    test('initial task list contains mock tasks', () {
      taskProvider = TaskProvider();
      expect(taskProvider.allTasks.length, 4);
    });

    test('getTaskById returns the correct task', () {
      taskProvider = TaskProvider();
      final task = taskProvider.getTaskById('1');
      expect(task.title, 'Task 1');
    });

    test('updateTask updates an existing task', () {
      taskProvider = TaskProvider();
      final updatedTask = Task(
          id: '1',
          title: 'Updated Task 1',
          dueDate: DateTime.now().add(const Duration(days: 1)),
          status: TaskStatus.pending,
          description: 'Updated Description 1');

      taskProvider.updateTask(updatedTask);

      final task = taskProvider.getTaskById('1');
      expect(task.title, 'Updated Task 1');
      expect(task.description, 'Updated Description 1');
    });

    test('toggleTaskStatus toggles the status of a task', () {
      taskProvider = TaskProvider();
      taskProvider.toggleTaskStatus(0, true);
      expect(taskProvider.filteredTasks[0].status, TaskStatus.completed);

      taskProvider.toggleTaskStatus(0, false);
      expect(taskProvider.filteredTasks[0].status, TaskStatus.pending);
    });

    test('addTask adds a new task', () {
      taskProvider = TaskProvider();
      final newTask = Task(
          id: '5',
          title: 'New Task',
          dueDate: DateTime.now().add(const Duration(days: 5)),
          status: TaskStatus.pending,
          description: 'New Description');

      taskProvider.addTask(newTask);
      expect(taskProvider.allTasks.length, 5);
      expect(taskProvider.getTaskById('5').title, 'New Task');
    });

    test('deleteTask removes a task by ID', () {
      taskProvider = TaskProvider();
      taskProvider.deleteTask('1');
      expect(taskProvider.allTasks.length, 3);
      expect(() => taskProvider.getTaskById('1'), throwsA(isA<StateError>()));
    });
  });
}
