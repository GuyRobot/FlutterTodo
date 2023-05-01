import 'package:task_todo/data/providers/task/provider.dart';

import '../../models/task.dart';

class TaskRepository {
  final TaskProvider taskProvider;

  const TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTasks() => taskProvider.readTasks();

  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
