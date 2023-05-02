import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_todo/core/values/keys.dart';

class StorageService extends GetxService {
  late GetStorage storage;

  Future<StorageService> init() async {
    storage = GetStorage();
    await storage.writeIfNull(taskKey, []);
    return this;
  }

  T read<T>(String key) {
    return storage.read(key);
  }

  write(String key, dynamic value) async {
    return storage.write(key, value);
  }
}
