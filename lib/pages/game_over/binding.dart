import 'package:get/get.dart';
import 'logic.dart';

class GameOverBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GameOverLogic>(GameOverLogic());
  }
}
