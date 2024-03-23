import 'package:get/get.dart';

import 'logic.dart';

class HonorBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HonorLogic>(HonorLogic());
  }
}
