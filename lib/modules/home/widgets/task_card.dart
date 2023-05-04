import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/data/models/task.dart';
import 'package:task_todo/modules/detail/view.dart';
import 'package:task_todo/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardSize = (Get.width - 12.0.wp) / 2;
    final color = HexColor.fromHex(task.color);
    return InkWell(
      onTap: () {
        homeController.setTask(task);
        homeController.refreshTodos(task);
        Get.to(() => const TaskDetail());
      },
      child: Container(
        width: cardSize,
        height: cardSize,
        margin: EdgeInsets.all(4.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 8,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: task.isTodosEmpty() ? 1 : task.numTodos(),
              currentStep: task.isTodosEmpty() ? 0 : task.numTodosDone(),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(.5), color],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: "MaterialIcons"),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title.capitalize.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Text(
                    "${task.todos?.length ?? 0} Task",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
