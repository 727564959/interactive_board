import 'package:get/get.dart';
import 'logic.dart';

class InitializeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InitializeLogic>(InitializeLogic());
  }
}
