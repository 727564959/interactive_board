import 'package:get/get.dart';

import 'logic.dart';

class WinnerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WinnerLogic>(WinnerLogic());
  }
}
