import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/data/models/task.dart';
import 'package:task_todo/modules/home/controller.dart';
import 'package:task_todo/modules/home/widgets/add_card.dart';
import 'package:task_todo/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My List",
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  AddCard(),
                  ...controller.tasks
                      .map(
                        (element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () {
                              controller.setDeleting(true);
                            },
                            onDragCompleted: () {
                              controller.setDeleting(false);
                            },
                            onDraggableCanceled: (_, __) {
                              controller.setDeleting(false);
                            },
                            onDragEnd: (_) {
                              controller.setDeleting(false);
                            },
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(
                                task: element,
                              ),
                            ),
                            child: TaskCard(task: element)),
                      )
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Deleted task: ${task.title}");
        },
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            onPressed: () {},
            backgroundColor:
                controller.deleting.value ? Colors.red : Colors.blue,
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
