import 'package:get/get.dart';
import 'logic.dart';

class GamingRankBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GamingRankLogic>(GamingRankLogic());
  }
}
