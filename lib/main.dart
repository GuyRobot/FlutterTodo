import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_todo/data/services/storage/service.dart';
import 'package:task_todo/modules/home/binding.dart';

import 'modules/home/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Todo',
      home: const HomePage(),
      initialBinding: HomeBinding(),
    );
  }
}
