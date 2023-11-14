import 'package:get/get.dart';
import 'logic.dart';

class CjeckInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CheckInLogic>(CheckInLogic());
  }
}
