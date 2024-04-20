import 'package:get/get.dart';
import '../choose_player/logic.dart';

class ChoosePlayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChoosePlayerLogic>(ChoosePlayerLogic());
  }
}
