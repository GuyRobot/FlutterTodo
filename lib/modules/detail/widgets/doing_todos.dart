import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/modules/home/controller.dart';

class DoingTodos extends StatelessWidget {
  final HomeController controller = Get.find();

  DoingTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => (controller.doneTodos.isEmpty && controller.doingTodos.isEmpty)
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/task.png",
                      fit: BoxFit.cover,
                      width: 65.0.wp,
                    ),
                    SizedBox(
                      height: 4.0.hp,
                    ),
                    Text(
                      "Add Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0.hp),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...controller.doingTodos.map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.0.wp, vertical: 1.0.hp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element["done"],
                                onChanged: (checked) {
                                  controller.doneTodo(element);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 2.0.wp,
                            ),
                            Text(
                              element["title"],
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (controller.doingTodos.isNotEmpty)
                      Divider(
                        thickness: 2,
                        color: Colors.grey[200]!,
                      )
                  ],
                ),
              ),
      ),
    );
  }
}
