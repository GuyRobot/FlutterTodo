import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_todo/data/services/storage/repository.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;

  HomeController({
    required this.taskRepository,
  });

  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  void setChipIndex(int value) {
    chipIndex.value = value;
  }

  void setDeleting(bool value) {
    deleting.value = value;
  }

  void setTask(Task? task) {
    this.task.value = task;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) return false;
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool addTodo(Task task, String text) {
    final todos = task.todos ?? [];
    if (todos.any((element) => element['title'] == text)) {
      return false;
    }
    todos.add({"title": text, "done": false});
    final idx = tasks.indexOf(task);
    tasks[idx] = task.copyWith(todos: todos);
    tasks.refresh();
    return true;
  }
}
