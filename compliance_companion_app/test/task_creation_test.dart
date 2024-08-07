import 'package:compliance_companion_app/models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Task creation should initialize with given name and completion status', () {
    final task = Task(id: '1', title: 'Test', description: '', dueDate: DateTime.now(), status: TaskStatus.completed);
    expect(task.title, 'Test');
    expect(task.status, TaskStatus.completed);
  });
}
