import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/data/models/task.dart';
import 'package:task_todo/modules/home/controller.dart';
import 'package:task_todo/modules/home/widgets/add_card.dart';
import 'package:task_todo/modules/home/widgets/add_dialog.dart';
import 'package:task_todo/modules/home/widgets/task_card.dart';
import 'package:task_todo/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
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
            Report(),
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
            onPressed: () {
              Get.to(AddDialog(), transition: Transition.upToDown);
            },
            backgroundColor:
                controller.deleting.value ? Colors.red : Colors.blue,
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.setTaskIndex(index);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.tabIndex.value,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Padding(
                  padding: EdgeInsets.only(right: 16.0.wp),
                  child: const Icon(Icons.apps),
                ),
              ),
              BottomNavigationBarItem(
                label: "Report",
                icon: Padding(
                  padding: EdgeInsets.only(left: 16.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
