import 'package:get/get.dart';
import 'logic.dart';

class CheckInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CheckInLogic>(CheckInLogic());
  }
}
