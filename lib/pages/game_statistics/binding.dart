import 'package:get/get.dart';
import 'logic.dart';

class GameStatisticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GameStatisticsLogic>(GameStatisticsLogic());
  }
}
