import 'package:get/get.dart';
import 'logic.dart';

class ChoosePlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChoosePlayerLogic>(ChoosePlayerLogic());
  }
}
