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
  final tabIndex = 0.obs;

  HomeController({
    required this.taskRepository,
  });

  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void setTaskIndex(int index) {
    tabIndex.value = index;
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
    doingTodos.add({"title": text, "done": false});
    doingTodos.refresh();
    return true;
  }

  void refreshTodos(Task task) {
    doneTodos.clear();
    doingTodos.clear();
    task.todos?.forEach((element) {
      if (element["done"] == true) {
        doneTodos.add(element);
      } else {
        doingTodos.add(element);
      }
    });
  }

  void doneTodo(dynamic element) {
    final idx =
        doingTodos.indexWhere((todo) => todo["title"] == element["title"]);
    doingTodos.removeAt(idx);
    doneTodos.add({"title": element["title"], "done": true});
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic element) {
    final idx =
        doneTodos.indexWhere((todo) => todo["title"] == element["title"]);
    doneTodos.removeAt(idx);
    doneTodos.refresh();
  }

  void updateTodos() {
    final todos = [...doneTodos, ...doingTodos];
    final Task newTask = task.value!.copyWith(todos: todos);
    final taskIdx = tasks.indexOf(newTask);
    tasks[taskIdx] = newTask;
    task.value = newTask;

    task.refresh();
  }

  Map<String, int> tasksInfo() {
    int total = 0;
    int done = 0;
    for (var element in tasks) {
      element.todos?.forEach((todo) {
        total++;
        if (todo["done"] == true) {
          done++;
        }
      });
    }

    return {"total": total, "done": done};
  }
}
