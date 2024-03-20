import 'package:get/get.dart';

import 'logic.dart';

class SetAvatarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SetAvatarLogic>(SetAvatarLogic());
  }
}
