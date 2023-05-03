import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final HomeController controller = Get.find();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                      controller.editController.clear();
                      controller.setTask(null);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() == true) {
                        if (controller.task.value == null) {
                          EasyLoading.showError(
                              "Please chose task for adding todos");
                        } else {
                          final success = controller.addTodo(
                              controller.task.value!,
                              controller.editController.text);
                          if (success) {
                            EasyLoading.showSuccess("Succeed add todo item");
                            Get.back();
                            controller.setTask(null);
                            controller.editController.clear();
                          } else {
                            EasyLoading.showError(
                                "Fail to add todo item! Duplicated");
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Task",
                    style: TextStyle(
                        fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: controller.editController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter todo item";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 3.0.hp,
                  ),
                  Text(
                    "Add to",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0.sp,
                    ),
                  ),
                  ...controller.tasks.map(
                    (task) => Obx(
                      () => InkWell(
                        onTap: () {
                          controller.setTask(task);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.5.hp, bottom: 1.5.hp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    IconData(task.icon,
                                        fontFamily: "MaterialIcons"),
                                    color: HexColor.fromHex(task.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    task.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.task.value == task)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
