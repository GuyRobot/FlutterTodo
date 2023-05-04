import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/modules/home/controller.dart';

class DoneTodos extends StatelessWidget {
  final HomeController controller = Get.find();

  DoneTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.doneTodos.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Completed (${controller.doneTodos.length})",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  ...controller.doneTodos
                      .map(
                        (element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            controller.deleteDoneTodo(element);
                          },
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.0.wp),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.0.hp, horizontal: 2.0.wp),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.done,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  element["title"],
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            )
          : Container(),
    );
  }
}
