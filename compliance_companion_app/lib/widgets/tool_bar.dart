// lib/widgets/tool_bar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';


/// Some keys used for testing
final addTodoKey = UniqueKey();
final pendingFilterKey = UniqueKey();
final inProgressFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

/// A toolbar widget that allows users to filter tasks by their status.
class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final selectedStatus = taskProvider.filterStatus;

    Color? textColorFor(TaskStatus value) {
          return selectedStatus == value ? Colors.blue : Colors.black;
        }

    return Material(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tooltip(
            key: allFilterKey,
            message: TaskStatus.all.helper,
            child: TextButton(
              onPressed: () =>
                  taskProvider.setFilterStatus(TaskStatus.all),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    WidgetStateProperty.all(textColorFor(TaskStatus.all)),
              ),
              child: Text(TaskStatus.all.name),
            ),
          ),
          Tooltip(
            key: pendingFilterKey,
            message: TaskStatus.pending.helper,
            child: TextButton(
              onPressed: () =>
                  taskProvider.setFilterStatus(TaskStatus.pending),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    WidgetStateProperty.all(textColorFor(TaskStatus.pending)),
              ),
              child: Text(TaskStatus.pending.name),
            ),
          ),
          Tooltip(
            key: inProgressFilterKey,
            message: TaskStatus.inProgress.helper,
            child: TextButton(
              onPressed: () => taskProvider.setFilterStatus(TaskStatus.inProgress),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: WidgetStateProperty.all(textColorFor(TaskStatus.inProgress)),
              ),
              child: Text(TaskStatus.inProgress.name),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: TaskStatus.completed.helper,
            child: TextButton(
              onPressed: () => taskProvider.setFilterStatus(TaskStatus.completed),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: WidgetStateProperty.all(textColorFor(TaskStatus.completed)),
              ),
              child: Text(TaskStatus.completed.name),
            ),
          ),
        ]
      ),
    );
  }
}
