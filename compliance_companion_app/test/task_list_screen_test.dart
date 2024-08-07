import 'package:compliance_companion_app/models/task.dart';
import 'package:compliance_companion_app/screens/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Task List Screen displays tasks', (WidgetTester tester) async {
    final tasks = [
      Task(id: '1', title: 'Task 1', description: '', dueDate: DateTime.now(), status: TaskStatus.pending),
      Task(id: '2', title: 'Task 2', description: '', dueDate: DateTime.now(), status: TaskStatus.inProgress),
    ];

    await tester.pumpWidget(const MaterialApp(
      home: TaskListScreen(),
    ));

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  });
}
