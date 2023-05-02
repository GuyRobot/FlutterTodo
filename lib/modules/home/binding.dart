import 'package:get/get.dart';
import 'package:task_todo/data/providers/task/provider.dart';
import 'package:task_todo/data/services/storage/repository.dart';
import 'package:task_todo/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
