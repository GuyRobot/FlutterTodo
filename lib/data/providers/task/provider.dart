import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_todo/core/values/keys.dart';
import 'package:task_todo/data/services/storage/service.dart';

import '../../models/task.dart';

class TaskProvider {
  final StorageService storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    final tasks = <Task>[];

    jsonDecode(storageService.read(taskKey).toString())
        .forEach((item) => tasks.add(Task.fromJson(item)));

    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    storageService.write(taskKey, jsonEncode(tasks));
  }
}
