import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/core/values/colors.dart';
import 'package:task_todo/data/models/task.dart';
import 'package:task_todo/modules/home/controller.dart';
import 'package:task_todo/widgets/icons.dart';
import 'package:collection/collection.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    final squareSize = Get.width - 12.0.wp;
    return Container(
      width: squareSize / 2,
      height: squareSize / 2,
      margin: EdgeInsets.all(4.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: "Task Type",
            content: Form(
              key: homeController.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Column(
                  children: [
                    TextFormField(
                      controller: homeController.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter task title";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .mapIndexed(
                              (index, element) => Obx(() {
                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  label: element,
                                  selected:
                                      homeController.chipIndex.value == index,
                                  onSelected: (selected) {
                                    homeController
                                        .setChipIndex(selected ? index : 0);
                                  },
                                );
                              }),
                            )
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        minimumSize: const Size(160, 48),
                      ),
                      onPressed: () {
                        if (homeController.formKey.currentState?.validate() ==
                            true) {
                          final task = Task(
                              title: homeController.editController.text,
                              color: icons[homeController.chipIndex.value]
                                  .color!
                                  .toHex(),
                              icon: icons[homeController.chipIndex.value]
                                  .icon!
                                  .codePoint);
                          homeController.addTask(task)
                              ? EasyLoading.showSuccess("Create task succeed")
                              : EasyLoading.showError("Failed to create task");
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
          );
          homeController.editController.clear();
          homeController.setChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 8.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
