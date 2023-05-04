import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/modules/detail/widgets/doing_todos.dart';
import 'package:task_todo/modules/detail/widgets/done_todos.dart';
import 'package:task_todo/modules/home/controller.dart';

class TaskDetail extends GetView<HomeController> {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = controller.task.value!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.all(2.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        controller.updateTodos();
                        controller.setTask(null);
                        controller.editController.clear();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: Row(
                      children: [
                        Icon(
                          IconData(task.icon, fontFamily: "MaterialIcons"),
                          color: HexColor.fromHex(task.color),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.0.hp, horizontal: 12.0.wp),
                    child: Obx(
                      () => Row(
                        children: [
                          Text(
                            "${controller.doingTodos.length + controller.doneTodos.length} Tasks",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 2.0.wp,
                          ),
                          Expanded(
                            child: StepProgressIndicator(
                              totalSteps: controller.doingTodos.isEmpty &&
                                      controller.doneTodos.isEmpty
                                  ? 1
                                  : controller.doingTodos.length +
                                      controller.doneTodos.length,
                              currentStep: controller.doneTodos.length,
                              size: 5,
                              padding: 0,
                              selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  task.getColor().withOpacity(0.5),
                                  task.getColor()
                                ],
                              ),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey[300]!, Colors.grey[300]!],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.editController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[200]!, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      prefixIcon: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey[400]!,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState?.validate() ==
                              true) {
                            final success = controller.addTodo(
                                task, controller.editController.text);
                            if (success) {
                              EasyLoading.showSuccess("Succeed add todo item");
                            } else {
                              EasyLoading.showError(
                                  "Failed to add todo item! Duplicated");
                            }
                            controller.editController.clear();
                          }
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter todo item";
                      }
                      return null;
                    },
                  ),
                  DoingTodos(),
                  DoneTodos()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
