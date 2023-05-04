import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/core/utils/extensions.dart';
import 'package:task_todo/modules/home/controller.dart';

import '../../core/values/colors.dart';

class Report extends GetView<HomeController> {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksInfo = controller.tasksInfo();
    final total = tasksInfo["total"] ?? 0;
    final doneTasks = tasksInfo["done"] ?? 0;
    final int liveTasks = (total - doneTasks);
    final percent = doneTasks * 100.0 ~/ total;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.0.wp,
            vertical: 4.0.wp,
          ),
          child: ListView(
            children: [
              Text(
                "My Report",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.sp,
                ),
              ),
              SizedBox(
                height: 1.0.hp,
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(
                  DateTime.now(),
                ),
                style: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0.hp),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.grey[200]!,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.red, liveTasks, "Live Tasks"),
                  _buildStatus(Colors.green, doneTasks, "Completed"),
                  _buildStatus(Colors.blue, total, "Created"),
                ],
              ),
              SizedBox(
                height: 16.0.hp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 68.0.wp,
                  height: 68.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: total,
                    currentStep: doneTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${percent.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.hp,
                        ),
                        Text(
                          "Efficiently",
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 1.0.hp),
          width: 2.5.wp,
          height: 2.5.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 0.5.wp,
            ),
          ),
        ),
        SizedBox(
          width: 2.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$number",
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.0.hp,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 10.0.sp,
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    );
  }
}
